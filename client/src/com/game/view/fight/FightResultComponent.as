package com.game.view.fight
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.DataList;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.FightModelStructure;
	import com.game.data.fight.structure.FightResult;
	import com.game.data.player.structure.RoleModel;
	import com.game.manager.LayerManager;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import flash.ui.Keyboard;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class FightResultComponent extends Component
	{
		private var _mainRoleModel:RoleModel;
		private var _data:Data = Data.instance;
		
		public function FightResultComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
		}
		
		private var _winImage:Image;
		private var _loseImage:Image;
		private var _money:TextField;
		private var _exp:TextField;
		private var _soul:TextField;
		private var _loseTF:TextField;
		public function initUI() : void
		{
			if (!_winImage) _winImage = searchOf("VictoryImage");
			if (!_loseImage) _loseImage = searchOf("FailImage");
			if (!_money) _money = searchOf("Tx_Money");
			_money.fontName = "宋体";
			_money.bold = true;
			if (!_exp) _exp = searchOf("Tx_Experience");
			_exp.fontName = "宋体";
			_exp.bold = true;
			if (!_soul) _soul = searchOf("Tx_FihgtSoul");
			_soul.fontName = "宋体";
			_soul.bold = true;
			if (!_loseTF) _loseTF = searchOf("Tx_Tip");
			
			_view.layer.setCenter(panel);
		}
		
		/**
		 * 显示结果 
		 * @param result
		 * 
		 */
		private var _callback:Function;
		private var _fightResult:FightResult;
		private var _monsterType:String;
		private var _curLevel:String;
		private var _difficult:int;
		private var _hasMoonCake:Boolean;
		public function showResult(result:FightResult, monsterType:String, lv:String, difficult:int, callback:Function, hasMoonCake:Boolean = false):void
		{
			_monsterType = monsterType;
			_curLevel = lv;
			_callback = callback;
			_fightResult = result;
			_difficult = difficult;
			_hasMoonCake = hasMoonCake;
			
			initUI();
			initEvent();
			initBeginEvent();
			if(_fightResult.result==V.WIN){
				LayerManager.instance.addKeyDowns(this.panel, onWin);
			}
			
			
			display();
			
			render();
		}
		
		private function render() : void
		{
			
			_winImage.visible = (_fightResult.result == V.WIN);
			_loseImage.visible = (_fightResult.result == V.LOSE);
			
			switch (_fightResult.result)
			{
				case V.WIN:
					checkTab("win");
					_loseTF.text = "";
					break;
				case V.LOSE:
					checkTab("lose");
					_loseTF.text = "战斗失败，退出当前关卡！";
					break;
			}
			
			_mainRoleModel = player.getRoleModel(V.MAIN_ROLE_NAME);
			
			var multiMoney:int = _fightResult.money + _view.double_level.checkDouble(_fightResult.money) + player.roleTitleInfo.checkMoneyTitle(_fightResult.money);// + _player.multiRewardInfo.getResult(_fightResult.money, 3);
			var multiSoul:int = _fightResult.soul + _view.double_level.checkDouble(_fightResult.soul);// + _player.multiRewardInfo.getResult(_fightResult.soul, 2);
			
			_money.text = "+" + multiMoney.toString();
			_exp.text = "+" + _fightResult.exp.toString();
			_soul.text = "+" + multiSoul.toString();
			
			// 结算战斗
			player.fight_soul += multiSoul;
			player.money += multiMoney;
		}
		
		private function addResultShow() : void
		{
			_view.map.fightCount++;
			_view.auto_fight.addContent("第" + _view.map.fightCount + "波\n");
			_view.auto_fight.addContent("获得金币" + _fightResult.money + "\n");
			_view.auto_fight.addContent("获得战魂" + _fightResult.soul + "\n");
			_view.auto_fight.addContent("获得经验" + _fightResult.exp + "\n\n");
		}
		
		// 当前标签页
		private function checkTab(name:String) : void
		{
			for each(var item:* in _uiLibrary)
			{
				if (item["layerName"] == "BackGround" || item["layerName"] == name)
				{
					if (item is DisplayObject) item.visible = true;
					if (item is Component) item["panel"].visible = true;
					
				}
				else
				{
					if (item is DisplayObject) item.visible = false;
					if (item is Component) item["panel"].visible = false;
				}
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "OkButton":
					switch (_fightResult.result)
					{
						case V.WIN:
							onWin();
							break;
						case V.LOSE:
							onLose();
							break;
					}
					this.panel.touchable = true;
					break;
				case "restartFigthBtn":
					reduceProp();
					this.panel.touchable = true;
					break;
			}
		}
		

		override protected function onClickBeginHandle(e:ViewEventBind) : void
		{
			this.panel.touchable = false;
		}
		
		private function reduceProp() : void
		{
			this.hide();
			_view.tip.interfaces(InterfaceTypes.Show,
				"是否愿意消耗10个雪山人参，重新挑战？（敌我双方都会满血）",
				function () : void
				{
					Starling.juggler.delayCall(resetFight, .01);
				},
				onLose, false);
		}
		
		/**
		 * 消耗雪山人参重新开始战斗
		 * 
		 */		
		private function resetFight() : void
		{
			var num:int = player.pack.getPropNumById(3);
			if(num < 10)
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"雪山人参不足，是否到商城购买？",
					gotoMall, onLose, false);
			}
			else
			{
				num -= 10;
				player.pack.setPropNum(num, 3);
				_view.fight.hide();
				player.recoverAllRole();
				_view.fight.interfaces(InterfaceTypes.REFRESH);
			}
		}
		
		/**
		 * 跳转到商城界面
		 * 
		 */		
		private function gotoMall() : void
		{
			_view.tip.hide();
			_view.shop.interfaces(InterfaceTypes.GET_MALL, "雪山人参", resetRender);
		}
		

		private function resetRender() : void
		{
			display();
			_view.tip.hide();
			_view.layer.setTipMaskHide();
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.interfaces(InterfaceTypes.LOCK);
		}
		
		
		/**
		 * 成功 
		 * 
		 */		
		private function onWin() : void
		{
			LayerManager.instance.removeKeyDowns();
			this.hide();
			
			_view.world.setSpeedInfo();
			// 升级
			_mainRoleModel.checkGrade(showSpeed, checkGetRole);
			
			_view.toolbar.interfaces(InterfaceTypes.CHECK_TASK);
			
			_view.weather.setSun();
		}
		
		private function showSpeed() : void
		{
			if(_mainRoleModel.model.lv == 15) _view.speed_change.interfaces(InterfaceTypes.Show, checkGetRole, 1.5);
			else if(_mainRoleModel.model.lv == 40) _view.speed_change.interfaces(InterfaceTypes.Show, checkGetRole, 2);
			else	checkGetRole();
		}
		
		// 角色
		private function checkGetRole() : void
		{
			if (_fightResult.sudueEnemy.length == 0)
			{
				after();
				return;
			}
			
			var roleModel:RoleModel = _fightResult.sudueEnemy.pop();
			_view.roleGain.gain(roleModel, checkGetRole);
			_view.toolbar.addRoleDeform();
			//添加新的角色到角色图鉴库
			_data.player.player.upgradeRole.addRole(roleModel.configData.name);
		}
		
		// boss after
		protected function after() : void
		{
			//1级向导
			if(_view.first_guide.isGuide)
				_view.first_guide.setFunc();
			
			_view.fight.hide();
			
			if(_monsterType==FightConfig.COMMON_MONSTER){
				_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
			}
			
			switch (_monsterType)
			{
				case FightConfig.ECS_MONSTER:
					_view.dialog.interfaces(
						InterfaceTypes.Show,
						"level",
						_curLevel,
						"elite_after",
						passGain);
					break;
				case FightConfig.BOSS_MONSTER:
					_view.dialog.interfaces(
						InterfaceTypes.Show,
						"level",
						_curLevel,
						"boss_after",
						passGain);
					break;
				case FightConfig.COMMON_MONSTER:
					_view.map.playSound();
					var type:String = ""
					if(_view.map.allowBlack) type = V.NIGHT_TYPE;
					else if(_view.map.allowRain) type = V.RAIN_TYPE;
					else if(_view.map.allowThunder) type = V.THUNDER_TYPE;
					else if(_view.map.allowWind) type = V.WIND_TYPE;
					else type = "";
					_view.weather_pass.pass(
						_curLevel,
						_difficult,
						type,
						function () : void
						{
							_view.weather_prop.pass(type, passGain);
						});
					break;
				default:
					_view.map.playSound();
					break;
					
			}
		}
		
		/**
		 * 获得月饼
		 * @param type
		 * 
		 */		
		private function getMoonCake() : void
		{
			Log.Trace("FightResult Have MoonCake:" + _hasMoonCake);
			if(_hasMoonCake)
				_view.moon_cake.pass(passGain);
			else
			{
				var rate:Number = DataList.littleList[10];
				rate = player.multiRewardInfo.checkRPEquipRate(rate);
				rate = _view.double_level.checkDoubleEquipRate(rate);
				rate = player.vipInfo.checkRPUp(rate);
				
				if(Math.random() <= rate)
					_view.activity_national_pass.pass(passGain);
				else
					passGain();
			}
		}
		
		// 过关获得
		protected function passGain() : void
		{
			//使用RP卡
			player.multiRewardInfo.getResult(0, 4);
			_view.toolbar.interfaces(InterfaceTypes.CHECK_EXP);
			player.multiRewardInfo.showTip();
			
			switch (_monsterType)
			{
				case FightConfig.ECS_MONSTER:
					passDialog();
					break;
				case FightConfig.BOSS_MONSTER:
					_view.passLV.pass(
						_curLevel,
						_difficult,
						passDialog);
					break;
			}
		}
		
		protected function passDialog() : void
		{
			switch (_monsterType)
			{
				case FightConfig.ECS_MONSTER:
					break;
				case FightConfig.BOSS_MONSTER:
					_view.dialog.interfaces(
						InterfaceTypes.Show,
						"level",
						_curLevel,
						"pass",
						function () : void
						{
							_view.map.close();
							Starling.juggler.delayCall(onPassGuide, .1);
						}
					);
					break;
			}
			
			if (_callback != null) 
			{					
				//_view.toolbar.interfaces(InterfaceTypes.REFRESH);
				_callback(_fightResult.result);
				_callback = null;
			}
			
			// 保存
			if(_monsterType == FightConfig.BOSS_MONSTER)
			{
				
				Log.Trace("普通关卡打完Boss结束保存");
				_view.controller.save.onCommonSave(false, 1);
				
				//1级向导
				if(_view.first_guide.isGuide)
					_view.first_guide.showRoleBtn();
				
				if(_curLevel == "1_2")
					_view.get_role_guide.getRoleGuide();
			}
			else _view.map.playSound();
		}
		
		/**
		 * 过关向导
		 * 
		 */		
		private function onPassGuide() : void
		{
			_view.guide.interfaces(InterfaceTypes.CHECK_GUIDE, "level", _curLevel, "pass", null);
		}
		
		/**
		 * 失败 
		 * 
		 */		
		private function onLose() : void
		{
			this.hide();
			
			//使用RP卡
			player.multiRewardInfo.getResult(0, 4);
			_view.toolbar.interfaces(InterfaceTypes.CHECK_EXP);
			player.multiRewardInfo.showTip();
			
			_view.fight.hide();
			_view.map.close();
			_view.world.interfaces();
			
			// 保存
			Log.Trace("普通关卡失败保存");
			_view.controller.save.onCommonSave(false);
			
			if (_callback != null) 
			{
				_callback(_fightResult.result);
				_callback = null;
			}
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new FightResultComponent(_configXML, _titleTxAtlas);
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			super.destroy();
		}
	}
}
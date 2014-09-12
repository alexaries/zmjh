package com.game.view.endless
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.fight.FightModelStructure;
	import com.game.data.fight.structure.FightResult;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class EndlessFightResultComponent extends Component
	{
		private var _mainRoleModel:RoleModel;
		private var _data:Data = Data.instance;
		
		public function EndlessFightResultComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
		}
		
		private var _money:TextField;
		private var _exp:TextField;
		private var _soul:TextField;
		public function initUI() : void
		{
			if (!_money) _money = searchOf("Tx_Money");
			_money.fontName = "宋体";
			_money.bold = true;
			if (!_exp) _exp = searchOf("Tx_Experience");
			_exp.fontName = "宋体";
			_exp.bold = true;
			if (!_soul) _soul = searchOf("Tx_FihgtSoul");
			_soul.fontName = "宋体";
			_soul.bold = true;
			
			_view.layer.setCenter(panel);
		}
		
		private var _curEndlessLv:int;
		private var _modelStructure:FightModelStructure;
		private var _fightResult:FightResult;
		private var _lastEndlessData:Object;
		private var _useProp:Boolean;
		private var _isOver:Boolean;
		public function endlessResult(result:FightResult, lv:int, modelStructure:FightModelStructure, useProp:Boolean = false) : void
		{
			_curEndlessLv = lv;
			_fightResult = result;
			_modelStructure = modelStructure;
			_useProp = useProp;
			
			initUI();
			initEvent();
			display();
			
			endlessRender();
		}
		
		private function endlessRender() : void
		{
			switch (_fightResult.result)
			{
				case V.WIN:
					checkTab("win");
					break;
				case V.LOSE:
					checkTab("lose");
					break;
			}
			
			if(!_view.endless_battle.isSpecial)
			{
				//有过关时间
				if(_view.endless_fight.useTime > 0 && _fightResult.result == V.WIN)
				{
					var result:Boolean = _view.endless_fight.stopTimeCount();
					if(result) _view.endless_battle.skipCommonBattle();
					else
					{
						if(!_useProp)
							_view.endless_battle.gotoNextBattle();
					}
				}
					//没有过关时间
				else
				{
					if(!_useProp)
						_view.endless_battle.gotoNextBattle();
				}
				
			}
			
			if(_fightResult.result == V.WIN)
			{
				if(_view.endless_battle.isSpecial)
					onSpecialReward();
				else
					onEndlessWin();
			}
			else
				onEndlessLose();
		}
		
		private function onSpecialReward() : void
		{
			this.hide();
			_view.endless_prop_box.interfaces(InterfaceTypes.Show, _view.endless_battle.curBoss, onEndlessWin);
		}
		
		private function onEndlessWin() : void
		{
			if(_view.endless_battle.checkOver())
			{
				_isOver = true;
				getAllExp();
				_view.prompEffect.play("您已成功通关所有副本！");
			}
			else
			{
				this.hide();
				_view.endless_battle.nextFight();
			}
		}
		
		private function getAllExp() : void
		{
			var endlessData:Object = new Object();
			endlessData = _data.db.interfaces(InterfaceTypes.GET_ENDLESS_BY_ID, _curEndlessLv);
			_curEndlessLv++;
			assignAll(endlessData);
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
					onCloseAll();
					break;
				case "restartFigthBtn":
					reduceProp();
					break;
			}
		}
		
		private function reduceProp() : void
		{
			_view.tip.interfaces(InterfaceTypes.Show,
				"是否愿意消耗10个雪山人参，重新挑战？（敌我双方都会满血）",
				function () : void
				{
					Starling.juggler.delayCall(resetFight, .1);
				},
				onEndlessLose,
				false);
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
					gotoMall, onEndlessLose, false);
			}
			else
			{
				num -= 10;
				player.pack.setPropNum(num, 3);
				this.hide();
				_view.fight.hide();
				player.recoverAllRole();
				_view.endless_fight.interfaces(InterfaceTypes.REFRESH);
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
			_view.tip.hide();
			_view.layer.setTipMaskHide();
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.interfaces(InterfaceTypes.LOCK);
		}
		
		private function onEndlessLose() : void
		{
			_view.endless_fight.stopTimeCount();
			
			var endlessData:Object = new Object();
			
			if(_curEndlessLv > 1)
			{
				if(_view.endless_battle.isSkip)
					endlessData = _data.db.interfaces(InterfaceTypes.GET_ENDLESS_BY_ID, (_curEndlessLv - 5));
				else
					endlessData = _data.db.interfaces(InterfaceTypes.GET_ENDLESS_BY_ID, (_curEndlessLv - 1));
				
				assignAll(endlessData);
			}
			else
			{
				_money.text = "+ 0";
				_exp.text = "+ 0";
				_soul.text = "+ 0";
			}
		}
		
		private function onCloseAll() : void
		{
			if(_lastEndlessData != null)
			{
				_modelStructure.assignOtherTypeExp(_lastEndlessData.exp);
				player.fight_soul += _lastEndlessData.soul;
				player.money += _lastEndlessData.gold;
			}
			
			player.endlessInfo.time = _data.time.curTimeStr;
			player.endlessInfo.endlessTime = _view.endless_battle.stopTime();
			player.endlessInfo.endlessLevel = (_view.endless_battle.isSkip == true?(_curEndlessLv - 5):(_curEndlessLv - 1));
			player.endlessInfo.checkMaxLevel(_curEndlessLv - 1);
			player.dailyThingInfo.setThingComplete(7);
			
			_view.endless_fight.hide();
			_view.world.interfaces(InterfaceTypes.REFRESH);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
			_view.toolbar.checkDaily();
			
			_mainRoleModel = player.getRoleModel(V.MAIN_ROLE_NAME);
			_mainRoleModel.checkGrade(rewardAfter, rewardAfter);
		}
		
		private function rewardAfter() : void
		{
			var count:int = (_curEndlessLv - 1) / 10;
			_data.pack.addUpgradeProp(count);
			
			_view.endless_battle.interfaces();
			Log.Trace("无尽闯关战斗结束保存");
			_view.controller.save.onCommonSave(false, 1, false);
		}
		
		private function assignAll(endlessData:Object) : void
		{
			_lastEndlessData = endlessData;
			
			_money.text = "+" + endlessData.gold.toString();
			_exp.text = "+" + endlessData.exp.toString();
			_soul.text = "+" + endlessData.soul.toString();
		}
		
		public function quitEndless(nowEndlessLv:int) : void
		{
			_curEndlessLv = nowEndlessLv;
			
			initUI();
			initEvent();
			display();
			
			checkTab("win");
			
			_view.endless_fight.stopTimeCount();
			
			var endlessData:Object = new Object();
			
			if(_curEndlessLv > 1)
			{
				if(_view.endless_battle.isSkip)
					endlessData = _data.db.interfaces(InterfaceTypes.GET_ENDLESS_BY_ID, (_curEndlessLv - 5));
				else
					endlessData = _data.db.interfaces(InterfaceTypes.GET_ENDLESS_BY_ID, (_curEndlessLv - 1));
				
				assignAll(endlessData);
			}
			else
			{
				_money.text = "+ 0";
				_exp.text = "+ 0";
				_soul.text = "+ 0";
			}
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new EndlessFightResultComponent(_configXML, _titleTxAtlas);
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
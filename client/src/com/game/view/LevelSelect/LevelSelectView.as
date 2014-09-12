package com.game.view.LevelSelect
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.engine.ui.controls.TabBar;
	import com.game.Data;
	import com.game.data.DataList;
	import com.game.data.db.protocal.Message_disposition;
	import com.game.data.player.structure.LevelInfo;
	import com.game.data.player.structure.RoleModel;
	import com.game.data.shop.PaymentData;
	import com.game.data.shop.ShopSubmitData;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.map.HideLVMap;
	
	import flash.utils.getTimer;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.VAlign;

	public class LevelSelectView extends BaseView implements IView
	{
		private var _anti:Antiwear;
		private function get autoGold() : int
		{
			return _anti["autoGold"];
		}
		private function set autoGold(value:int) : void
		{
			_anti["autoGold"] = value;
		}
		
		private function get autoDice() : int
		{
			return _anti["autoDice"];
		}
		private function set autoDice(value:int) : void
		{
			_anti["autoDice"] = value;
		}
		
		private function get autoExp() : int
		{
			return _anti["autoExp"];
		}
		private function set autoExp(value:int) : void
		{
			_anti["autoExp"] = value;
		}
		
		private function get autoSoul() : int
		{
			return _anti["autoSoul"];
		}
		private function set autoSoul(value:int) : void
		{
			_anti["autoSoul"] = value;
		}
		
		
		private var _curSceneId:int;
		private var _curLevel:int;
		
		public function LevelSelectView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.LEVEL_SELECT;
			_loaderModuleName = V.PUBLIC;
			_curLevel = 1;
			_curLVKind = 1;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["autoGold"] = 0;
			_anti["autoDice"] = 0;
			_anti["autoExp"] = 0;
			_anti["autoSoul"] = 0;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_curSceneId = args[0];
					this.show();
					break;
			}
		}
		
		override protected function show():void
		{		
			_curLevel = 1;
	
			super.show();
		}
		
		override protected function init() : void
		{
			getData();
			
			if (!isInit)
			{
				super.init();
				
				initXML();
				initComponent();
				initUI();
				initRender();
				initEvent();
				
				isInit = true;
			}
			
			display();
			render();
		}
		
		private var _curLVInfo:Vector.<LevelInfo>;
		private var _message_dispositions:Vector.<Object>;
		private var _curMessage_Disposition:Message_disposition;
		private var _autoFightInfo:Vector.<Object>;
		private var _battleInfo:Vector.<Object>;
		private function getData() : void
		{
			_curLVInfo = _view.controller.LVSelect.getLVInfos(_curSceneId);
			
			if (!_message_dispositions) _message_dispositions = Data.instance.db.interfaces(InterfaceTypes.GET_MESSAGE_DISPOSITION);
			if (!_autoFightInfo) _autoFightInfo = Data.instance.db.interfaces(InterfaceTypes.GET_AUTO_FIGHT_DATA);
			if (!_battleInfo) _battleInfo = Data.instance.db.interfaces(InterfaceTypes.GET_ALL_BATTLE_DISPOSITION_DATA);
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			if (!_positionXML)
			{
				_positionXML = getXMLData(V.PUBLIC, GameConfig.PUBLIC_RES, "LevelSelectPosition");
			}
		}
		
		private function initUI() : void
		{
			var name:String;
			var obj:*;
			var layerName:String;
			for each(var items:XML in _positionXML.layer)
			{
				layerName = items.@layerName;
				for each(var element:XML in items.item)
				{
					name = element.@name;
					
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						obj["layerName"] = layerName;
						_uiLibrary.push(obj);
					}
				}
			}
		}
		
		private function initComponent() : void
		{
			var name:String;
			var cp:Component;
			var layerName:String;
			for each(var items:XML in _positionXML.component.Items)
			{
				name = items.@name;
				if (!this.checkInComponent(name))
				{
					switch (name)
					{
						case "LevelKind":
							cp = new LevelKindComponent(items, _view.publicRes.titleTxAtlas);
							_components.push(cp);
							break;
					}
				}	
			}
		}
		
		/**
		 * 开始渲染 
		 * 
		 */
		private var _levelFirstBtn:Button;
		private var _levelSecondBtn:Button;
		private var _levelThreeBtn:Button;
		private var _lvSelecteded:Image;
		
		private var _easyKind:LevelKindComponent;
		private var _normalKind:LevelKindComponent;
		private var _hardKind:LevelKindComponent;
		private var _introduce:TextField;
		private var _lvKindTab:TabBar;
		private var _title:MovieClip;
		private var _challengeBtn:Button;
		private var _coldTimeTF:TextField;
		private var _autoFightBtn:Button;
		private function initRender() : void
		{
			_levelFirstBtn = this.searchOf("LevelNumBt1") as Button;
			_levelFirstBtn.fontColor = 0xffffff;
			_levelFirstBtn.fontSize = 20;
			_levelSecondBtn = this.searchOf("LevelNumBt2") as Button;
			_levelSecondBtn.fontColor = 0xffffff;
			_levelSecondBtn.fontSize = 20;
			_levelThreeBtn = this.searchOf("LevelNumBt3") as Button;
			_levelThreeBtn.fontColor = 0xffffff;
			_levelThreeBtn.fontSize = 20;
			
			_lvSelecteded = this.searchOf("levelselect_LevelSelected") as Image;
			
			_easyKind = this.searchOf("LevelKindEasy") as LevelKindComponent;
			_easyKind.hardKind = 1;
			_normalKind = this.searchOf("LevelKindHard") as LevelKindComponent;
			_normalKind.hardKind = 2;
			_hardKind = this.searchOf("LevelKindSpecial") as LevelKindComponent;
			_hardKind.hardKind = 3;
			_lvKindTab = new TabBar([_easyKind, _normalKind, _hardKind]);
			_lvKindTab.addEventListener(TabBar.TYPE_SELECT_CHANGE, onLVKindTabChange);
			_lvKindTab.selectIndex = _curLVKind;
			
			_introduce = searchOf("Tx_Introduce") as TextField;
			_introduce.vAlign = VAlign.TOP;
			_title = (this.searchOf("LevelTitle") as MovieClip);
			
			_coldTimeTF = this.searchOf("ColdTime") as TextField;
			_autoFightBtn = this.searchOf("AutoFight") as Button;
			//(this.searchOf("AutoFight") as Button).visible = false;
		}
		
		// 困难级数
		private var _curLVKind:int;
		protected function onLVKindTabChange(e:Event) : void
		{
			_curLVKind = (e.data as int) + 1;

			if (isInit)
			{
				getCurLvInfo();
				_introduce.text = "      " + this._curMessage_Disposition.level_message;
			}
		}
		
		private function render() : void
		{
			getCurLvInfo();
			_title.currentFrame = _curSceneId - 1;
			_title.readjustSize();
			_title.pivotX = _title.width * 0.5;
			_title.pivotY = _title.height * 0.5;
			_introduce.text = "      " + this._curMessage_Disposition.level_message;
			
			_levelFirstBtn.upState = _levelFirstBtn.downState = getTexture("level_" + _curSceneId + "_1", "");
			_levelFirstBtn.resizeJugle();
			setLVStatus(_levelFirstBtn, (getLVStatus(1) != null));
			
			_levelSecondBtn.upState = _levelSecondBtn.downState =  getTexture("level_" + _curSceneId + "_2", "");
			_levelSecondBtn.resizeJugle();
			setLVStatus(_levelSecondBtn, (getLVStatus(2) != null));
			
			_levelThreeBtn.upState = _levelThreeBtn.downState =  getTexture("level_" + _curSceneId + "_3", "");
			_levelThreeBtn.resizeJugle();
			setLVStatus(_levelThreeBtn, (getLVStatus(3) != null));
			
			setLVSelected();
			_view.layer.setCenter(panel);
			
			autoFightCheck();
		}
		
		/**
		 * 设置当前关卡及困难 
		 * 
		 */		
		protected function setLVSelected() : void
		{
			var targetBtn:Button;
			if (_curLevel == 1) targetBtn = _levelFirstBtn;
			if (_curLevel == 2) targetBtn = _levelSecondBtn;
			if (_curLevel == 3) targetBtn = _levelThreeBtn;
			
			_lvSelecteded.x = targetBtn.x;
			_lvSelecteded.y = targetBtn.y;
			
			setKindSelected();
		}
		
		private function setKindSelected() : void
		{
			var info:LevelInfo = getLVStatus(_curLevel);
			
			setKindStatus(_easyKind.lsk, info.difficulty >= 1);
			setKindStatus(_normalKind.lsk, info.difficulty >= 2);
			setKindStatus(_hardKind.lsk, info.difficulty >= 3);
			
			//_lvKindTab.selectIndex = info.difficulty - 1;
			_lvKindTab.selectIndex = 0;
		}
		
		private function setKindStatus(target:MovieClip, isAble:Boolean) : void
		{
			if (isAble)
			{
				target.currentFrame = 0;
				target.touchable = true;
			}
			else
			{
				target.currentFrame = 2;
				target.touchable = false;
			}
		}
		
		private function setLVStatus(target:DisplayObject, isAble:Boolean) : void
		{
			if (isAble)
			{
				target.filter = null;
				target.touchable = true;
			}
			else
			{
				target.filter = new GrayscaleFilter();
				target.touchable = false;
			}
		}
		
		private function getLVStatus(index:int) : LevelInfo
		{
			var info:LevelInfo;
			
			for (var i:int = 0, len:int = _curLVInfo.length; i < len; i++)
			{
				if (_curLVInfo[i].name == (_curSceneId + "_" + index))
				{
					info = _curLVInfo[i];
					break;
				}
			}
			
			return info;
		}
		
		/**
		 * 事件监听 
		 * @param e
		 * 
		 */		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "Close":
					this.hide();
					break;
				// 关卡1
				case "LevelNumBt1":
					_curLevel = 1;
					break;
				// 关卡2
				case "LevelNumBt2":
					_curLevel = 2;
					//1级向导
					if(_view.first_guide.isGuide)
						_view.first_guide.setFunc();
					break;
				// 关卡3
				case "LevelNumBt3":
					_curLevel = 3;
					break;
				// 挑战
				case "Challenge":
					if (_curLVKind >= 3)
					{
						_view.tip.interfaces(InterfaceTypes.Show,
							"未开启该难度模式！",
							null, null, false, true, false);
						return;
						break;
					}
					else{
						if(_curSceneId == 6 && _curLevel == 2)
						{
							_view.tip.interfaces(
								InterfaceTypes.Show,
								"该地图未开启！",
								null, null, false, true, false);
							return;
							break;
						}
						else
						{
							hide();
							// 屏蔽快速点击击
							_view.map.interfaces(InterfaceTypes.Show, _curSceneId, _curLevel, _curLVKind);
						}
					}
					break;
				case "AutoFight":
					startAutoFight();
					return;
					break;
				default:
					Log.Trace(name);
			}
			render();
		}
		
		private function startAutoFight() : void
		{
			if(_curSceneId == 6 && _curLevel == 2)
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"该地图未开启！", null, null, false, true, false);
			}
			else if(_curLVKind == 3)
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"未开启该难度模式！", null, null, false, true, false);
			}
			else if(!Data.instance.lvSelect.checkLvPass(_curSceneId, _curLevel, (_curLVKind + 1)))
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"还未通过该关卡的该难度模式！", null, null, false, true, false);
			}
			else
			{
				var result:Array = getAutoFightData();
				autoDice = result[0].dice_count;
				autoExp = result[0].exp * result[0].fight_count;
				autoSoul = autoGold = result[0].fight_count * ((result[1].lowest_grade - 1) + (DataList.list[7] - DataList.list[2])) * (result[1].first_in + result[1].second_in + result[1].third_in);
				if(player.dice < autoDice)
				{
					_view.tip.interfaces(InterfaceTypes.Show,
						"骰子不足，无法进行扫荡", null, null, false, true, false);
				}
				else
				{
					if(_canAutoFight)
					{
						_view.tip.interfaces(InterfaceTypes.Show,
							"扫荡本关卡需要消耗" + autoDice + "个骰子，可以获得" + autoExp + "经验，" + autoGold + "金钱和" + autoSoul + "战魂，请问是否进行扫荡？",
							function () : void{Starling.juggler.delayCall(autoFight, .1);}, null, false);
					}
					else
					{
						var costMoney:int = (_calculateDate.minutes * 60 + _calculateDate.seconds) / 300 * 200;
						var info:String = "您需要消耗" + costMoney + "点券才能重新扫荡，是否花费点券？";
						var obj:ShopSubmitData = new ShopSubmitData("940", costMoney, 1);
						PaymentData.startPay(costMoney, obj, paySuccess, info);
						/*_view.tip.interfaces(InterfaceTypes.Show,
						"还在冷却时间内，请稍后再试", null, null, false, true, false);*/
					}
				}
			}
		}
		
		private function paySuccess(info:String = "") : void
		{
			autoFight();
		}
		
		/**
		 * 扫荡模式
		 * 
		 */	
		private function autoFight():void
		{
			_view.prompEffect.play("消耗骰子" + autoDice + "个，获得经验" + autoExp + ",金钱X" + autoGold + ",战魂X" + autoSoul);
			player.money += autoGold;
			player.fight_soul += autoSoul;
			player.dice -= autoDice;
			player.formation.assignExp(autoExp);
			player.autoFightInfo.fightNum++;
			player.autoFightInfo.startTime = Data.instance.time.returnTimeNowStr();
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			autoFightCheck();
		}
		
		private var _canAutoFight:Boolean;
		private var _startTime:Number;
		private var _endTime:Number;
		private var _intervalTime:Number;
		private var _calculateDate:Date;
		private function autoFightCheck() : void
		{
			if(player.autoFightInfo.fightNum >= 2)
			{
				var startDate:Date = Data.instance.time.setDate(player.autoFightInfo.startTime);
				var nowDate:Date = Data.instance.time.returnTimeNow();
				var intervalNum:Number = nowDate.time - startDate.time;
				if(intervalNum >= 5 * 60 * 1000)
				{
					_canAutoFight = true;
				}
				else
				{
					_canAutoFight = false;
					_calculateDate = new Date(2013, 1, 1, 1, 0, 0);
					_calculateDate.time += (5 * 60 * 1000 - intervalNum);
					_startTime = getTimer();
					_view.addToFrameProcessList("AutoFightColdTime", autoFightFrameHandler);
				}
			}
			else
			{
				_canAutoFight = true;
			}
			renderAutoFight();
		}
		
		private function autoFightFrameHandler() : void
		{
			_endTime = getTimer();
			_intervalTime = _endTime - _startTime;
			_calculateDate.time -= _intervalTime;
			_startTime = getTimer();
			_coldTimeTF.text = _calculateDate.minutes + ":" + _calculateDate.seconds;
			
			if(_calculateDate.minutes == 0 && _calculateDate.seconds == 0)
			{
				_coldTimeTF.text = "可扫荡";
				_canAutoFight = true;
				_view.removeFromFrameProcessList("AutoFightColdTime");
				renderAutoFight();
			}
		}
		
		private function renderAutoFight() : void
		{
			/*if(_canAutoFight)
			{
				addTouchable(_autoFightBtn);
			}
			else
			{
				removeTouchable(_autoFightBtn);
			}*/
		}
		
		/**
		 * 获得扫荡数据
		 * @return 
		 * 
		 */		
		private function getAutoFightData() : Array
		{
			var result:Array = new Array();
			var levelName:String = _curSceneId + "_" + _curLevel;
			for each(var item:Object in _autoFightInfo)
			{
				if(levelName == item.level_name && _curLVKind == item.difficulty)
				{
					result.push(item);
					break;
				}
			}
			for each(var battle:Object in _battleInfo)
			{
				if(levelName == battle.level_name && _curLVKind == battle.difficulty)
				{
					result.push(battle);
					break;
				}
			}
			
			return result;
		}
		
		private function getCurLvInfo() : void
		{
			var curSceneLV:String = _curSceneId + "_" + _curLevel;
			
			for each(var ms:Message_disposition in this._message_dispositions)
			{
				if (ms.level_name == curSceneLV && ms.difficulty == _curLVKind)
				{
					_curMessage_Disposition = ms;
					break;
				}
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture> = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			return texture;
		}
		
		override public function close():void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
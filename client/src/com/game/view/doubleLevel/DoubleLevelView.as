package com.game.view.doubleLevel
{
	import com.engine.core.Log;
	import com.engine.ui.controls.TabBar;
	import com.game.Data;
	import com.game.data.DataList;
	import com.game.data.player.structure.LevelInfo;
	import com.game.data.player.structure.Player;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.effect.GlowAnimationEffect;
	import com.game.view.equip.PropTip;
	import com.game.view.ui.UIConfig;
	
	import flash.display.Bitmap;
	import flash.utils.getTimer;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class DoubleLevelView extends BaseView implements IView
	{
		private static const PROPRATE:Number = DataList.littleList[5];
		private static const EQUIPRATE:Number = DataList.littleList[5];
		private static const ROLERATE:Number = DataList.littleList[7];
		private var _doubleTime:int = DataList.list[1];
		
		private var _isHide:Boolean;
		
		public function DoubleLevelView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.DOUBLE_LEVEL;
			_loaderModuleName = V.PUBLIC;
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_isHide = false;
					this.show();
					break;
				case InterfaceTypes.HIDE:
					_isHide = true;
					this.show();
					break;
				case InterfaceTypes.GetTexture:
					return getTexture(args[0], "");
					break;
			}
		}
		
		override protected function init():void
		{
			if (!isInit)
			{
				super.init();
				
				initXML();
				initTexture();
				initComponent();
				initUI();
				getUI();
				initEvent();
				
				isInit = true;
			}
			renderButton();
			_view.layer.setCenter(panel);
			
			if(_isHide)
				this.hide();
		}
		
		private var _positionXML:XML;
		private var _moneyData:Vector.<Object>;
		private function initXML() : void
		{
			if(!_positionXML) _positionXML = getXMLData(V.DOUBLE_LEVEL, GameConfig.DOUBLE_LEVEL_RES, "DoubleLevelPosition");
			if(!_moneyData) _moneyData = Data.instance.db.interfaces(InterfaceTypes.GET_LEVEL_UP_EXP);
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.DOUBLE_LEVEL, GameConfig.DOUBLE_LEVEL_RES, "DoubleLevel");			
				obj = getAssetsObject(V.DOUBLE_LEVEL, GameConfig.DOUBLE_LEVEL_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
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
							cp = new DoubleLevelKindComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
					}
				}
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
		
		private var _selectLevelBtn:Button;
		private var _simpleBtn:DoubleLevelKindComponent;
		private var _hardBtn:DoubleLevelKindComponent;
		private var _hardestBtn:DoubleLevelKindComponent;
		private var _lvKindTab:TabBar;
		private var _resetBtn:Button;
		private var _propTip:PropTip;
		private var _effect:GlowAnimationEffect;
		private var _littleBg:Image;
		private function getUI() : void
		{
			_selectLevelBtn = this.searchOf("double_LevelNumBt") as Button;
			_littleBg = this.searchOf("DoubleLevelLittleBg") as Image;
			_effect = new GlowAnimationEffect(_littleBg, 0xFF0000);
			_simpleBtn = this.searchOf("SimpleBtn") as DoubleLevelKindComponent;
			_simpleBtn.hardKind = 1;
			_hardBtn = this.searchOf("HardBtn") as DoubleLevelKindComponent;
			_hardBtn.hardKind = 2;
			_hardestBtn = this.searchOf("HardestBtn") as DoubleLevelKindComponent;
			_hardestBtn.hardKind = 3;
			resetButton();
			
			_lvKindTab = new TabBar([_simpleBtn, _hardBtn, _hardestBtn]);
			_lvKindTab.addEventListener(TabBar.TYPE_SELECT_CHANGE, onLVKindTabChange);
			
			_resetBtn = this.searchOf("ResetBtn");
			_propTip=_view.ui.interfaces(UIConfig.PROP_TIP);
			_propTip.add({o:_resetBtn,m:{name:"", message:"当前需要消耗" + _moneyData[player.mainRoleModel.info.lv - 1].gold + "金币"}});
		}
		
		public function checkKindStatus() : void
		{
			for each(var item:LevelInfo in player.pass_level)
			{
				if(item.name ==  player.doubleLevelInfo.level)
				{
					setButtonStatus(_simpleBtn.lsk, item.difficulty >= 1);
					setButtonStatus(_hardBtn.lsk, item.difficulty >= 2);
					setButtonStatus(_hardestBtn.lsk, item.difficulty >= 3);
					break;
				}
			}
			_lvKindTab.selectIndex = _curLVKind;
		}
		
		private function setButtonStatus(item:MovieClip, isAble:Boolean) : void
		{
			if (isAble)
			{
				item.currentFrame = 1;
				item.touchable = true;
			}
			else
			{
				item.currentFrame = 2;
				item.touchable = false;
			}
		}
		
		// 困难级数
		private var _curLVKind:int;
		private function onLVKindTabChange(e:Event) : void
		{
			_curLVKind = (e.data as int) + 1;
			//checkKindStatus();
		}
		
		private function renderButton():void
		{
			if(player.vipInfo.checkLevelFour())
				_doubleTime = DataList.list[2];
			else
				_doubleTime = DataList.list[1];
			
			if(player.checkLevelShow("1_3") && player.doubleLevelInfo.startTime != "")
			{
				if(_intervalTime < _doubleTime * 60 * 60 * 1000)
					addTouchable(_resetBtn);
				else
					removeTouchable(_resetBtn);
			}
			else
			{
				removeTouchable(_resetBtn);
			}
			
			if(player.doubleLevelInfo.startTime == "")
			{
				addTouchable(_selectLevelBtn);
				_effect.play();
			}
			else if(player.doubleLevelInfo.startTime != "")
			{
				if(isNaN(_intervalTime) || _intervalTime < _doubleTime * 60 * 60 * 1000)
				{
					addTouchable(_selectLevelBtn);
					_effect.play();
				}
				else
				{
					removeTouchable(_selectLevelBtn);
					_effect.stop();
				}
			}
		}
		private var _startTime:Number;
		private var _endTime:Number;
		private var _intervalTime:Number;
		public function get intervalTime() : Number
		{
			return _intervalTime;
		}
		private var _curDate:Date;
		private var _isStartDouble:Boolean;
		public function get isStartDouble() : Boolean
		{
			return _isStartDouble;
		}
		private var _doubleStartTime:Date;
		public function addTimeCalculate() : void
		{
			if(player.checkLevelShow("1_3") && player.doubleLevelInfo.startTime != "")
			{
				if(player.vipInfo.checkLevelFour())
					_doubleTime = DataList.list[2];
				else
					_doubleTime = DataList.list[1];
				_doubleStartTime = Data.instance.time.setDate(player.doubleLevelInfo.startTime);
				_isStartDouble = false;
				_startTime = getTimer();
				_curDate = Data.instance.time.returnTimeNow();
				_view.addToFrameProcessList("doubleLevel", calculateTime);
			}
		}
		
		private function calculateTime() : void
		{
			_endTime = getTimer();
			_curDate.milliseconds += (_endTime - _startTime);
			
			_intervalTime = _curDate.time - _doubleStartTime.time;
			
			if(_intervalTime < _doubleTime * 60 * 60 * 1000 && !_isStartDouble)
			{
				addTouchable(_resetBtn);
				_isStartDouble = true;
				_view.tip.interfaces(InterfaceTypes.Show,
					"今日双倍副本已经开启！",
					null, null, false, true, false);
				_view.toolbar.deformTip.addNewDeform(_view.toolbar._doubleComponent.doubleLevelBtn, "DoubleLevel");
				
				_selectLevelBtn.upState = _selectLevelBtn.downState = getTexture("level_" + player.doubleLevelInfo.level, "public");
				_selectLevelBtn.resizeJugle();
				addTouchable(_selectLevelBtn);
				
				checkKindStatus();
				
				_view.toolbar._doubleComponent.checkDoubleLevelBtn();
				if(!_view.toolbar.checkStretch())
				{
					_view.toolbar.hideMask();
				}
			}
			else if(_intervalTime >= _doubleTime * 60 * 60 * 1000 && _isStartDouble)
			{
				removeTouchable(_resetBtn);
				_isStartDouble = false;
				_view.tip.interfaces(InterfaceTypes.Show,
					"今日双倍副本已经关闭！",
					null, null, false, true, false);
				_view.toolbar._doubleComponent.doubleLevelTxt.text = "明日刷新";
				_view.toolbar.deformTip.removeDeform("DoubleLevel");
				//_view.toolbar.interfaces(InterfaceTypes.REFRESH);
				_view.removeFromFrameProcessList("doubleLevel");
				resetButton();
				_effect.stop();
			}
			else if (_intervalTime >= _doubleTime * 60 * 60 * 1000 && !_isStartDouble)
			{
				removeTouchable(_resetBtn);
				_view.toolbar._doubleComponent.doubleLevelTxt.text = "明日刷新";
				_view.removeFromFrameProcessList("doubleLevel");
				resetButton();
			}
			
			if(_intervalTime < _doubleTime * 60 * 60 * 1000)
			{
				if(_resetBtn.touchable == false)
					addTouchable(_resetBtn);
				_view.toolbar._doubleComponent.doubleLevelTxt.text = (Data.instance.time.formatTime(_doubleTime * 60 * 60 - _intervalTime * .001)).substr(2);
			}
			
			_startTime = getTimer();
		}
		
		private function resetButton() : void
		{
			removeTouchable(_selectLevelBtn);
			_selectLevelBtn.upState = _selectLevelBtn.downState = getTexture("double_LevelNumBt_1", "public");
			_selectLevelBtn.resizeJugle();
			_simpleBtn.lsk.currentFrame = 2;
			_simpleBtn.lsk.touchable = false;
			_hardBtn.lsk.currentFrame = 2;
			_hardBtn.lsk.touchable = false;
			_hardestBtn.lsk.currentFrame = 2;
			_hardestBtn.lsk.touchable = false;
		}
		
		private function returnLevel(input:String) : String
		{
			var result:String;
			var resultList:Array = input.split("_");
			result = resultList[0] + "-" + resultList[1];
			return result;
		}
		
		/**
		 * 增加道具获得概率
		 * @param rate
		 * @return 
		 * 
		 */		
		public function checkDoublePropRate(rate:Number) : Number
		{
			var resultRate:Number = rate;
			
			if(_isStartDouble && _view.map.curLevel == player.doubleLevelInfo.level)
				resultRate += PROPRATE;
			
			if(resultRate > 1)
				resultRate == 1;
			
			return resultRate;
		}
		
		/**
		 * 增加装备获得概率
		 * @param rate
		 * @return 
		 * 
		 */		
		public function checkDoubleEquipRate(rate:Number) : Number
		{
			var resultRate:Number = rate;
			
			if(_isStartDouble && _view.map.curLevel == player.doubleLevelInfo.level)
				resultRate += EQUIPRATE;
			
			if(resultRate > 1)
				resultRate == 1;
			
			return resultRate;
		}
		
		/**
		 * 增加人物获得概率
		 * @param rate
		 * @return 
		 * 
		 */		
		public function checkDoubleRoleRate(rate:Number) : Number
		{
			var resultRate:Number = rate;
			
			if(resultRate != 0)
			{
				if(_isStartDouble && _view.map.curLevel == player.doubleLevelInfo.level)
					resultRate += ROLERATE;
			}
			
			if(resultRate > 1)
				resultRate == 1;
			
			return resultRate;
		}
		
		/**
		 * 增加经验、战魂、金币
		 * @param input
		 * @return 
		 * 
		 */		
		public function checkDouble(input:int) : int
		{
			var result:int = 0;
			
			if(_isStartDouble && _view.map.curLevel == player.doubleLevelInfo.level)
				result = input;
			
			return result;
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "ResetBtn":
					resetLevel();
					break;
				case "Close":
					this.hide();
					break;
				case "double_LevelNumBt":
					startDouble();
					break;
			}
		}
		
		private function startDouble():void
		{
			if(_intervalTime < _doubleTime * 60 * 60 * 1000)
			{
				if (_curLVKind >= 3)
				{
					_view.tip.interfaces(InterfaceTypes.Show,
						"未开启该难度模式！",
						null, null);
				}
				else
				{
					this.hide();
					//_view.toolbar.stretchEffect.hideMask();
					var result:Array = player.doubleLevelInfo.level.split("_");
					_view.map.interfaces(InterfaceTypes.Show, result[0], result[1], _curLVKind);
				}
			}
			else
			{
				player.doubleLevelInfo.startTime = Data.instance.time.returnTimeNowStr();
				player.dailyThingInfo.setThingComplete(9);
				addTimeCalculate();
				renderButton();
				
				Log.Trace("开启双倍副本保存");
				_view.controller.save.onCommonSave(false, 1, false);
			}
		}
		
		private function resetLevel() : void
		{
			if(player.money < int(_moneyData[player.mainRoleModel.info.lv - 1].gold))
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"您的金币不足，无法刷新双倍副本",
					null, null, false, true, false);
			}
			else
			{
				player.money -= int(_moneyData[player.mainRoleModel.info.lv - 1].gold);
				player.doubleLevelInfo.resetDoubleLevel();
				_selectLevelBtn.upState = _selectLevelBtn.downState = getTexture("level_" + player.doubleLevelInfo.level, "public");
				_selectLevelBtn.resizeJugle();
				addTouchable(_selectLevelBtn);
				
				checkKindStatus();
				_lvKindTab.selectIndex = 0;
				
				_view.prompEffect.play("消耗" + int(_moneyData[player.mainRoleModel.info.lv - 1].gold) + "金币，当前双倍副本为" + returnLevel(player.doubleLevelInfo.level));
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else
			{
				textures = _titleTxAtlas.getTextures(name);
			}
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			if (type == "public")
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			
			return texture;
		}
		
		override public function resetView() : void
		{
			_view.removeFromFrameProcessList("doubleLevel");
		}
	}
}
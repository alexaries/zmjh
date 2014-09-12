package com.game.view.guide
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.guide.GuideData;
	import com.game.data.guide.GuideItemData;
	import com.game.data.guide.GuideTypeData;
	import com.game.data.guide.GuideWordData;
	import com.game.manager.LayerManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.effect.FloatEffect;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class GuideView extends BaseView implements IView
	{
		private static const ARROW_OFFSET:int = 110;
		private static const ARROW_POSITION:int = 15;
		private var _curGuideType:String;
		private var _curLevel:String;
		private var _curSceneType:String;
		private var _callback:Function;
		public function GuideView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.GUIDE;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			Log.Trace("Guide init!" + type + "---" + args);
			switch (type)
			{
				case InterfaceTypes.Show:
					show();
					break;
				case InterfaceTypes.CHECK_GUIDE:
					_curGuideType = args[0];
					_curLevel = args[1];
					_curSceneType = args[2];
					if (args.length >= 3) _callback = args[3];
					showGuide();
					break;
				case InterfaceTypes.CHECK_LV:
					roleLvGuide();
					break;
				case InterfaceTypes.GetTexture:
					return getTexture(args[0], "");
					break;
				case InterfaceTypes.GetTextures:
					return getTextures(args[0], "");
					break;
				case InterfaceTypes.GET_GUIDE_DATA:
					return _guideConfig;
					break;
			}
		}
		
		override protected function init() : void
		{
			if (!isInit)
			{
				super.init();
				isInit = true;
				
				initXML();
				initData();
				initTexture();
				initComponent();
				initUI();
				getUI();
				initEvent();
				initPlayer();
			}
			this.hide();
		}
		
		private var _guideNow:GuideItemData;
		private var _wordNow:int;
		/**
		 * 判断显示向导
		 * 
		 */		
		public function showGuide() : void
		{
			_wordNow = 0;
			_guideNow = null;
			var guideType:Vector.<GuideItemData> = (_curSceneType == "enter"?_guideData.allGuide.enterItem:_guideData.allGuide.passItem);
			for(var i:int = 0; i < guideType.length; i++)
			{
				if(guideType[i].levelName == _curLevel)
				{
					_guideNow = guideType[i];
					break;
				}
			}
			Log.Trace("Guide Show Check!");
			if(!_guideNow || _guideNow.wordList.length == 0)
			{
				Log.Trace("Guide End!");
				if(_callback != null) _callback();
				return;
			}
			//如果已进行过一次向导，则返回
			if(Data.instance.guide.guideInfo.checkGuideInfo(_curLevel ,_curSceneType)) return;
			
			if(_curSceneType == "pass" && (_curLevel == "3_2" || _curLevel == "3_3"))
				_view.toolbar.stretchButton();
			//显示
			this.display();
			//添加存档
			Data.instance.guide.guideInfo.addGuideInfo(_curLevel ,_curSceneType);
			//锁定界面不能点击
			_view.toolbar.interfaces(InterfaceTypes.LOCK);
			
			_view.layer.setTopMaskHide();
			
			LayerManager.instance.gpu_stage.addEventListener(TouchEvent.TOUCH, onContinue);
			//显示向导内容
			setGuideTurn();
			Log.Trace("Guide Start!");
		}

		
		/**
		 * 人物等级向导
		 * 
		 */		
		public function roleLvGuide() : void
		{
			if(_view.map.isClose == false) return;
			_wordNow = 0;
			_guideNow = null;
			var guideType:Vector.<GuideItemData> = _guideData.allGuide.roleLvItem;
			for(var i:int = 0; i < guideType.length; i++)
			{
				if(int(guideType[i].levelName) <= player.mainRoleModel.info.lv)
				{
					_guideNow = guideType[i];
					break;
				}
			}
			if(!_guideNow || _guideNow.wordList.length == 0)
			{
				if(_callback != null) _callback();
				return;
			}
			//如果已进行过一次向导，则返回
			if(Data.instance.guide.guideInfo.checkGuideInfo(_guideNow.levelName, "world")) return;
			//显示
			this.display();
			//添加存档
			Data.instance.guide.guideInfo.addGuideInfo(_guideNow.levelName, "world");
			//锁定界面不能点击
			//_view.toolbar.interfaces(InterfaceTypes.LOCK);
			
			_view.layer.setTopMaskHide();
			
			LayerManager.instance.gpu_stage.addEventListener(TouchEvent.TOUCH, onContinue);
			//显示向导内容
			setGuideTurn();
		}
		
		private var _acceleraCallbackFun:Function;
		/**
		 * 加速向导
		 * 
		 */		
		public function showAccelerateGuide(callbackFun:Function = null) : void
		{
			Log.Trace("Guide Accelerate Check!");
			_acceleraCallbackFun = callbackFun;
			_wordNow = 0;
			_guideNow = null;
			_guideNow = _guideData.allGuide.specialItem[0];
			if(!_guideNow)	return;
			if(Data.instance.guide.guideInfo.checkGuideInfo(_guideData.allGuide.specialItem[0].levelName ,_guideData.allGuide.specialItem[0].levelName))
			{
				_acceleraCallbackFun();
				return;
			}
			this.display();
			//添加存档
			Data.instance.guide.guideInfo.addGuideInfo(_guideData.allGuide.specialItem[0].levelName ,_guideData.allGuide.specialItem[0].levelName);
			
			_view.layer.setTopMaskHide();
			
			LayerManager.instance.gpu_stage.addEventListener(TouchEvent.TOUCH, onContinue);
			//显示向导内容
			setGuideTurn();
			Log.Trace("Guide Accelerate Start!");
		}
		
		/**
		 * 天气向导
		 * 
		 */	
		public function showWeatherGuide(curLevel:String) : void
		{
			Log.Trace("Guide Weather Check!");
			_wordNow = 0;
			_guideNow = null;
			_guideNow = _guideData.allGuide.specialItem[1];
			if(!_guideNow) return;
			if(Data.instance.guide.guideInfo.checkGuideInfo("2_1",  "enter") || (curLevel == "1_1" || curLevel == "1_2" || curLevel == "1_3")) return;
			this.display();
			//添加存档
			Data.instance.guide.guideInfo.addGuideInfo("2_1" , "enter");
			//锁定界面不能点击
			_view.toolbar.interfaces(InterfaceTypes.LOCK);
			
			_view.layer.setTopMaskHide();
			
			LayerManager.instance.gpu_stage.addEventListener(TouchEvent.TOUCH, onContinue);
			
			//显示向导内容
			setGuideTurn();
			Log.Trace("Guide Weather Start!");
		}
		
		/**
		 * 游戏向导
		 * 
		 */		
		public function showMatchGameGuide() : void
		{
			Log.Trace("Guide Match Game Check!");
			_wordNow = 0;
			_guideNow = null;
			_guideNow = _guideData.allGuide.specialItem[2];
			if(!_guideNow)	return;
			if(Data.instance.guide.guideInfo.checkGuideInfo(_guideData.allGuide.specialItem[2].levelName ,_guideData.allGuide.specialItem[2].levelName))
				return;
			
			this.display();
			//添加存档
			Data.instance.guide.guideInfo.addGuideInfo(_guideData.allGuide.specialItem[2].levelName ,_guideData.allGuide.specialItem[2].levelName);
			
			_view.layer.setTopMaskHide();
			
			LayerManager.instance.gpu_stage.addEventListener(TouchEvent.TOUCH, onContinue);
			//显示向导内容
			setGuideTurn();
			Log.Trace("Guide Accelerate Start!");
		}
		
		/**
		 * 点击继续向导内容
		 * @param e
		 * 
		 */		
		private function onContinue(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(LayerManager.instance.gpu_stage);
			
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				if(_wordNow == 0) _wordNow = 1;
				var name:String = getTextureName(touch.target);
				if(_guideNow.wordList[_wordNow - 1].touchName == ""||_guideNow.wordList[_wordNow - 1].touchName == name)
				{
					if(_wordNow == _guideNow.wordList.length)
					{
						this.hide();
						if(_acceleraCallbackFun != null)
						{
							_acceleraCallbackFun();
							_acceleraCallbackFun = null;
						}
						if(_callback != null) _callback();
						LayerManager.instance.gpu_stage.removeEventListener(TouchEvent.TOUCH, onContinue);
						Log.Trace("Guide End!" + _wordNow);
					}
					else
					{
						setGuideTurn();
						Log.Trace("Guide Next!" + _wordNow);
					}
				}
			}
		}
		
		private function getTextureName(obj:DisplayObject) : String
		{
			var result:String = "";
			if(obj.name == null)
			{
				if((obj as Image) != null)
					result = (obj as Image).texture.name;
			}
			else
				result = obj.name;
			
			return result;
		}
		
		/**
		 * 逐步设置向导
		 * 
		 */		
		private function setGuideTurn() : void
		{
			setArrowPosition(_guideNow.wordList[_wordNow]);
			_guideBg.touchable = _guideNow.wordList[_wordNow].touchable;
			_guideComponent.setData(_guideNow.wordList[_wordNow].words);
			_wordNow++;
		}
		
		/**
		 * 设置箭头位置和方向
		 * 
		 */		
		private function setArrowPosition(wordData:*) : void
		{
			_arrowPoint.scaleX = 1;
			_arrowPoint.scaleY = 1;
			switch(wordData.pointForward)
			{
				//左上
				case "leftUp":
					_arrowPoint.scaleX = -1;
					_arrowPoint.scaleY = -1;
					_guideComponent.panel.x = wordData.xPos + _arrowPoint.width + ARROW_POSITION;
					_guideComponent.panel.y = wordData.yPos + _arrowPoint.height + ARROW_POSITION;
					_arrowPoint.x = wordData.xPos + _arrowPoint.width + ARROW_POSITION;
					_arrowPoint.y = wordData.yPos + _arrowPoint.height + ARROW_POSITION;
					drawBg(wordData.xPos, wordData.yPos, wordData);
					break;
				//右上
				case "rightUp":
					_arrowPoint.scaleY = -1;
					_guideComponent.panel.x = wordData.xPos - _guideComponent.panel.width - _arrowPoint.width - ARROW_POSITION;
					_guideComponent.panel.y = wordData.yPos + _arrowPoint.height + ARROW_POSITION;
					_arrowPoint.x = wordData.xPos - _arrowPoint.width - ARROW_POSITION;
					_arrowPoint.y = wordData.yPos + _arrowPoint.height + ARROW_POSITION;
					drawBg(wordData.xPos, wordData.yPos, wordData);
					break;
				//左下
				case "leftDown":
					_arrowPoint.scaleX = -1;
					_guideComponent.panel.x = wordData.xPos + _arrowPoint.width + ARROW_POSITION;
					_guideComponent.panel.y = wordData.yPos - _guideComponent.panel.height - _arrowPoint.height - ARROW_POSITION;
					_arrowPoint.x = wordData.xPos + _arrowPoint.width + ARROW_POSITION;
					_arrowPoint.y = wordData.yPos - _arrowPoint.height - ARROW_POSITION;
					drawBg(wordData.xPos, wordData.yPos, wordData);
					break;
				//右下
				case "rightDown":
					_guideComponent.panel.x = wordData.xPos - _guideComponent.panel.width - _arrowPoint.width - ARROW_POSITION;
					_guideComponent.panel.y = wordData.yPos - _guideComponent.panel.height - _arrowPoint.height - ARROW_POSITION;
					_arrowPoint.x = wordData.xPos - _arrowPoint.width - ARROW_POSITION;
					_arrowPoint.y = wordData.yPos - _arrowPoint.height - ARROW_POSITION;
					drawBg(wordData.xPos, wordData.yPos, wordData);
					break;
			}
			if(wordData.type == "none")
			{
				_arrowPoint.visible = false;
				_arrowFloatEffect.stop();
			}
			else if(wordData.type == "tip")
			{
				_guideComponent.panel.x = 241;
				_guideComponent.panel.y = 161;
				_arrowPoint.visible = false;
				_arrowFloatEffect.stop();
			}
			else
			{
				_arrowPoint.visible = true;
				_arrowFloatEffect.stop();
				_arrowFloatEffect.play();
			}
		}
		
		private var _guideBg:Image;
		private var _maskBg_1:Image;
		private var _maskBg_2:Image;
		private var _maskBg_3:Image;
		private var _maskBg_4:Image;
		/**
		 * 向导的背景蒙板
		 * @param xPos
		 * @param yPos
		 * 
		 */
		private function drawBg(xPos:Number, yPos:Number, data:*) : void
		{
			if(_guideBg && _guideBg.parent) 
			{
				_guideBg.parent.removeChild(_guideBg);
				_guideBg.texture.dispose();
				_guideBg.dispose();
			}
			var _circle:flash.display.Sprite = new flash.display.Sprite();
			_circle.graphics.clear();
			_circle.graphics.lineStyle(0); 
			_circle.graphics.beginFill(0x000000, 1);
			_circle.graphics.drawRect(0, 0, GameConfig.CAMERA_WIDTH, GameConfig.CAMERA_HEIGHT);  
			_circle.graphics.lineStyle(3, 0xFFFFFF, 0); 
			switch(data.shape)
			{
				case "Circle":
					_circle.graphics.drawCircle(xPos, yPos, data.wid);
					break;
				case "Rect":
					_circle.graphics.drawRect(xPos - data.wid * .5, yPos - data.hei * .5, data.wid, data.hei);
					break;
				default:
					_circle.graphics.drawCircle(xPos, yPos, 50);
					break;
			}
			//_circle.graphics.drawCircle(xPos, yPos, 50);
			_circle.graphics.endFill();
			
			_circle.filters = [new BlurFilter(5, 5, BitmapFilterQuality.HIGH)];
			_circle.cacheAsBitmap = true;
			
			var _bmpData:BitmapData = new BitmapData(GameConfig.CAMERA_WIDTH, GameConfig.CAMERA_HEIGHT, true, 0);
			_bmpData.draw(_circle);
			
			var texture:Texture = Texture.fromBitmapData(_bmpData);
			_guideBg = new Image(texture);
			
			_guideBg.x = 0;
			_guideBg.y = 0;
			_guideBg.alpha = .6;
			_guideBg.touchable = false;
			
			this.panel.addChildAt(_guideBg, 0);
			
			
			if(_maskBg_1 && _maskBg_1.parent)
			{
				_maskBg_1.parent.removeChild(_maskBg_1);
				_maskBg_1.texture.dispose();
				_maskBg_1.dispose();
			}			
			_maskBg_1 = createMask(_maskBg_1, 0, 0, xPos - 40, GameConfig.CAMERA_HEIGHT);
			_maskBg_2 = createMask(_maskBg_2, xPos + 40, 0, GameConfig.CAMERA_WIDTH - xPos - 40, GameConfig.CAMERA_HEIGHT);
			_maskBg_3 = createMask(_maskBg_3, 0, 0, GameConfig.CAMERA_WIDTH, yPos - 40);
			_maskBg_4 = createMask(_maskBg_4, 0, yPos + 40, GameConfig.CAMERA_WIDTH, GameConfig.CAMERA_HEIGHT - yPos - 40);
		}
		
		private function createMask(maskBg:Image, xPos:int, yPos:int, width:int, height:int) : Image
		{
			if(maskBg && maskBg.parent)
			{
				maskBg.parent.removeChild(maskBg);
				maskBg.texture.dispose();
				maskBg.dispose();
			}
			
			if(width <= 0)	width = 5;
			if(height <= 0)	 height = 5;
			
			var _maskCircle:flash.display.Sprite = new flash.display.Sprite();
			_maskCircle.graphics.clear();
			_maskCircle.graphics.beginFill(0xFFFFFF, 0);
			_maskCircle.graphics.drawRect(0, 0, width, height);
			_maskCircle.graphics.endFill();
			
			var _maskBmpData:BitmapData = new BitmapData(width, height, true, 0);
			_maskBmpData.draw(_maskCircle);
			
			var maskTexture:Texture = Texture.fromBitmapData(_maskBmpData);
			maskBg = new Image(maskTexture);
			maskBg.x = xPos;
			maskBg.y = yPos;
			maskBg.name = "maskBg" + Math.random() * 100;
			this.panel.addChildAt(maskBg, 1);
			
			return maskBg;
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.GUIDE, GameConfig.GUIDE_RES, "GuidePosition");
		}
		
		private var _guideConfig:XML;
		private var _guideData:GuideData;
		private function initData() : void
		{
			_guideConfig =  this.getXMLData(V.GUIDE, GameConfig.GUIDE_RES, "GuideConfig");
			_guideData = new GuideData();
			_guideData.initData(_guideConfig);
			
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.GUIDE, GameConfig.GUIDE_RES, "Guide");
				obj = getAssetsObject(V.GUIDE, GameConfig.GUIDE_RES, "Textures");
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
						case "GuideWindow":
							cp = new GuideComponent(items, _view.daily.titleTxAtlas);
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
		
		private var _guideComponent:GuideComponent;
		private var _arrowPoint:Image;
		private var _arrowFloatEffect:FloatEffect;
		private function getUI() : void
		{		
			_guideComponent = this.searchOf("guidewindow");
			_arrowPoint = this.searchOf("Arrow");
			_arrowFloatEffect = new FloatEffect(_arrowPoint, 5);
		}
		
		override protected function initEvent() : void
		{
			super.initEvent();
		}
		
		private function initPlayer() : void
		{
			
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.pluginGame.interfaces(InterfaceTypes.GetTextures, name);
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
				texture = _view.pluginGame.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			return texture;
		}
		
		override public function hide() : void
		{
			super.hide();
			if(_guideBg && _guideBg.parent) 
			{
				_guideBg.parent.removeChild(_guideBg);
				_guideBg.texture.dispose();
				_guideBg.dispose();
			}
			_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
		}
		
		private function hideOnly() : void
		{
			super.hide();
			if(_guideBg && _guideBg.parent) 
			{
				_guideBg.parent.removeChild(_guideBg);
				_guideBg.texture.dispose();
				_guideBg.dispose();
			}
		}
	}
}
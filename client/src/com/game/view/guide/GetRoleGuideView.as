package com.game.view.guide
{
	import com.game.Data;
	import com.game.data.guide.GuideData;
	import com.game.data.guide.GuideItemData;
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
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class GetRoleGuideView extends BaseView implements IView
	{
		private static const ARROW_OFFSET:int = 50;
		private static const ARROW_POSITION:int = 20;
		private var _curGuideType:String;
		private var _curLevel:String;
		private var _curSceneType:String;
		private var _callback:Function;
		
		public function GetRoleGuideView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.GET_ROLE_GUIDE;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					show();
					break;
				case InterfaceTypes.GetTexture:
					return getTexture(args[0], "");
					break;
				case InterfaceTypes.GetTextures:
					return getTextures(args[0], "");
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
		 * 获得角色向导
		 * 
		 */		
		public function getRoleGuide() : void
		{
			_wordNow = 0;
			_guideNow = null;
			var guideType:Vector.<GuideItemData> = _guideData.allGuide.getRoleItem;
			
			_guideNow = guideType[0];
			
			if(Data.instance.guide.guideInfo.checkGuideInfo("getRole", "getRole")) return;
			
			//this.display();
			_view.layer.setTopMaskHide();
			_isGuide = true;
			//LayerManager.instance.gpu_stage.addEventListener(TouchEvent.TOUCH, onContinue);
			//显示向导内容
			//setFunc();
			_view.toolbar.onStartRoleFly();
			
			Data.instance.guide.guideInfo.addGuideInfo("getRole", "getRole");
		}
		
		private var _isGuide:Boolean = false;
		public function get isGuide() : Boolean
		{
			return _isGuide;
		}
		public function set isGuide(value:Boolean) : void
		{
			_isGuide = value;
		}
		private var _funcCount:int = -1;
		
		public function setFunc(type:Boolean = false) : void
		{
			_funcCount++;
			if(_funcCount >= _guideNow.wordList.length)
			{
				_isGuide = false;
				return;
			}
			else if(_funcCount == _guideNow.wordList.length - 2)
				_view.toolbar.stretchButton();
			
			this.display();
			_view.layer.setTopMaskHide();
			
			setArrowPosition(_guideNow.wordList[_funcCount]);
			_guideBg.touchable = _guideNow.wordList[_funcCount].touchable;
			_guideComponent.setData(_guideNow.wordList[_funcCount].words);
			
			if(type)
				LayerManager.instance.gpu_stage.addEventListener(TouchEvent.TOUCH, onContinue);
			else
				LayerManager.instance.gpu_stage.addEventListener(TouchEvent.TOUCH, onFunContinue);
		}
		
		private function onFunContinue(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(LayerManager.instance.gpu_stage);
			
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				var name:String = getTextureName(touch.target);
				if(_guideNow.wordList[_funcCount].touchName == ""||_guideNow.wordList[_funcCount].touchName == name)
				{
					hideOnly();
					LayerManager.instance.gpu_stage.removeEventListener(TouchEvent.TOUCH, onFunContinue);
					
					if((_funcCount + 1)< _guideNow.wordList.length)
					{
						if(_guideNow.wordList[_funcCount + 1].touchName == "")
							setFunc(true);
					}
				}
			}
		}
		
		private function onContinue(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(LayerManager.instance.gpu_stage);
			
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				var name:String = getTextureName(touch.target);
				if(_guideNow.wordList[_funcCount].touchName == ""||_guideNow.wordList[_funcCount].touchName == name)
				{
					if(_wordNow == _guideNow.wordList.length)
					{
						this.hide();
						LayerManager.instance.gpu_stage.removeEventListener(TouchEvent.TOUCH, onContinue);
						if(_callback != null) _callback();
					}
					else
					{
						//if(_guideNow.wordList[_funcCount].touchName == ""
						LayerManager.instance.gpu_stage.removeEventListener(TouchEvent.TOUCH, onContinue);
						if((_funcCount + 1)< _guideNow.wordList.length)
						{
							if(_guideNow.wordList[_funcCount + 1].touchName == "")
								setFunc(true);
							else 
								setFunc();
						}
						else
						{
							setFunc();
							this.hide();
						}
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
		 * 设置箭头位置和方向
		 * 
		 */
		private function setArrowPosition(wordData:*) : void
		{
			_arrowPoint.scaleX = 1;
			_arrowPoint.scaleY = 1;
			if(wordData.pointForward == "")
			{
				this.hideOnly();
				return;
			}
			switch(wordData.pointForward)
			{
				//左上
				case "leftUp":
					_arrowPoint.scaleX = -1;
					_arrowPoint.scaleY = -1;
					_arrowPoint.x = wordData.xPos + _arrowPoint.width + ARROW_POSITION;
					_arrowPoint.y = wordData.yPos + _arrowPoint.height + ARROW_POSITION;
					drawBg(wordData.xPos, wordData.yPos, wordData);
					break;
				//右上
				case "rightUp":
					_arrowPoint.scaleY = -1;
					_arrowPoint.x = wordData.xPos - _arrowPoint.width - ARROW_POSITION;
					_arrowPoint.y = wordData.yPos + _arrowPoint.height + ARROW_POSITION;
					drawBg(wordData.xPos, wordData.yPos, wordData);
					break;
				//左下
				case "leftDown":
					_arrowPoint.scaleX = -1;
					_arrowPoint.x = wordData.xPos + _arrowPoint.width + ARROW_POSITION;
					_arrowPoint.y = wordData.yPos - _arrowPoint.height - ARROW_POSITION;
					drawBg(wordData.xPos, wordData.yPos, wordData);
					break;
				//右下
				case "rightDown":
					_arrowPoint.x = wordData.xPos - _arrowPoint.width - ARROW_POSITION;
					_arrowPoint.y = wordData.yPos - _arrowPoint.height - ARROW_POSITION;
					drawBg(wordData.xPos, wordData.yPos, wordData);
					break;
			}
			if(wordData.type == "tip")
			{
				_arrowPoint.visible = false;
				_clickOpen.visible = true;
				_guideComponent.panel.x = 270;
				_guideComponent.panel.y = 70;
				_clickOpen.x = wordData.xPos - _arrowPoint.width - ARROW_OFFSET - ARROW_POSITION;
				_clickOpen.y = wordData.yPos - _arrowPoint.height - ARROW_OFFSET;
				_floatEffect.stop();
				_floatEffect.play();
				_arrowFloatEffect.stop();
			}
			else if(wordData.type == "arrow")
			{
				_arrowPoint.visible = true;
				_clickOpen.visible = false;
				_floatEffect.stop();
				_arrowFloatEffect.stop();
				_arrowFloatEffect.play();
				switch(wordData.pointForward)
				{
					//左上
					case "leftUp":
						_guideComponent.panel.x = wordData.xPos + _arrowPoint.width + ARROW_POSITION;
						_guideComponent.panel.y = wordData.yPos + _arrowPoint.height + ARROW_POSITION;
						break;
					//右上
					case "rightUp":
						_guideComponent.panel.x = wordData.xPos - _guideComponent.panel.width - _arrowPoint.width - ARROW_POSITION;
						_guideComponent.panel.y = wordData.yPos + _arrowPoint.height + ARROW_POSITION;
						break;
					//左下
					case "leftDown":
						_guideComponent.panel.x = wordData.xPos + _arrowPoint.width + ARROW_POSITION;
						_guideComponent.panel.y = wordData.yPos - _guideComponent.panel.height - _arrowPoint.height - ARROW_POSITION;
						break;
					//右下
					case "rightDown":
						_guideComponent.panel.x = wordData.xPos - _guideComponent.panel.width - _arrowPoint.width - ARROW_POSITION;
						_guideComponent.panel.y = wordData.yPos - _guideComponent.panel.height - _arrowPoint.height - ARROW_POSITION;
						break;
				}
			}
			else
			{
				_arrowPoint.visible = false;
				_clickOpen.visible = false;
				_guideComponent.panel.x = 270;
				_guideComponent.panel.y = 70;
				_floatEffect.stop();
				_arrowFloatEffect.stop();
			}
			
			
			if(wordData.wid == 0 && wordData.hei == 0)
			{
				_hand.visible = true;
				_hand.x = _guideComponent.panel.x + _guideComponent.panel.width;
				_hand.y = _guideComponent.panel.y + _guideComponent.panel.height;
				_handFloatEffect.stop();
				_handFloatEffect.play();
			}
			else
			{
				_hand.visible = false;
				_handFloatEffect.stop();
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
					break;
			}
			_circle.graphics.endFill();
			
			_circle.filters = [new BlurFilter(5, 5, BitmapFilterQuality.HIGH)];
			_circle.cacheAsBitmap = true;
			
			var _bmpData:BitmapData = new BitmapData(GameConfig.CAMERA_WIDTH * 2, GameConfig.CAMERA_HEIGHT * 2, true, 0);
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
			switch(data.shape)
			{
				case "Circle":
					_maskBg_1 = createMask(_maskBg_1, 0, 0, xPos - data.wid, GameConfig.CAMERA_HEIGHT);
					_maskBg_2 = createMask(_maskBg_2, xPos + data.wid, 0, GameConfig.CAMERA_WIDTH - xPos - data.wid, GameConfig.CAMERA_HEIGHT);
					_maskBg_3 = createMask(_maskBg_3, 0, 0, GameConfig.CAMERA_WIDTH, yPos - data.hei);
					_maskBg_4 = createMask(_maskBg_4, 0, yPos + data.hei, GameConfig.CAMERA_WIDTH, GameConfig.CAMERA_HEIGHT - yPos - data.hei);
					break;
				case "Rect":
					_maskBg_1 = createMask(_maskBg_1, 0, 0, xPos - data.wid * .5, GameConfig.CAMERA_HEIGHT);
					_maskBg_2 = createMask(_maskBg_2, xPos + data.wid * .5, 0, GameConfig.CAMERA_WIDTH - xPos - data.wid * .5, GameConfig.CAMERA_HEIGHT);
					_maskBg_3 = createMask(_maskBg_3, 0, 0, GameConfig.CAMERA_WIDTH, yPos - data.hei * .5);
					_maskBg_4 = createMask(_maskBg_4, 0, yPos + data.hei * .5, GameConfig.CAMERA_WIDTH, GameConfig.CAMERA_HEIGHT - yPos - data.hei * .5);
					break;
				default:
					break;
			}
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
		private var _clickOpen:Image;
		private var _floatEffect:FloatEffect;
		private var _arrowFloatEffect:FloatEffect;
		private var _hand:Image;
		private var _handFloatEffect:FloatEffect;
		private function getUI() : void
		{		
			_guideComponent = this.searchOf("guidewindow");
			_arrowPoint = this.searchOf("Arrow");
			_clickOpen = new Image(_titleTxAtlas.getTexture("ClickOpen"));
			_clickOpen.visible = false;
			this.panel.addChild(_clickOpen);
			_floatEffect = new FloatEffect(_clickOpen, 5);
			_arrowFloatEffect = new FloatEffect(_arrowPoint, 5);
			
			_hand = new Image(_view.publicRes.titleTxAtlas.getTexture("hand"));
			_hand.visible = false;
			this.panel.addChild(_hand);
			_handFloatEffect = new FloatEffect(_hand, 5);
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
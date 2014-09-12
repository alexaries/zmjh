package com.game.manager
{
	import com.game.View;
	import com.game.template.GameConfig;
	
	import flash.display.Stage;
	import flash.ui.Keyboard;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;

	public class LayerManager
	{
		/**
		 * 传统列表舞台 
		 */		
		public var cpu_stage:flash.display.Stage;
		
		/**
		 * starling舞台 
		 */		
		public var gpu_stage:starling.display.Stage;	
		
		public function get stage() : starling.display.Stage
		{
			return gpu_stage;
		}
		
		public function get width() : int
		{
			return GameConfig.CAMERA_WIDTH;
		}		
		public function get height() : int
		{
			return GameConfig.CAMERA_HEIGHT;
		}
		
		private var _content:Sprite;
		public function get content() : Sprite
		{
			return _content;
		}
		
		private var _toolbar:Sprite;
		public function get toolbar() : Sprite
		{
			return _toolbar;
		}
		
		private var _world:Sprite;
		public function get world() : Sprite
		{
			return _world;
		}
		
		private var _tip:Sprite;
		public function get tip() : Sprite
		{
			return _tip
		}
		
		private var _top:Sprite;
		public function get top() : Sprite
		{
			return _top;
		}
		
		// 空纹理
		private var _maskTexture:Texture;
		public function get maskTexture() : Texture
		{
			return _maskTexture;
		}
		
		public function LayerManager(s : Singleton)
		{
			if (_instance != null)
			{
				throw new Error("LayerManager 是单例！");
			}
		}
		
		private var _nowPanel:Sprite;
		private var _callback:Function;
		public function addKeyDowns(nowPanel:Sprite, callback:Function) : void
		{
			_nowPanel = nowPanel;
			_callback = callback;
			this.gpu_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
		}
		
		private function onKeyDowns(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.SPACE && _nowPanel.touchable)
			{
				if(_callback != null) _callback();
			}
		}
		
		public function removeKeyDowns() : void
		{
			if(this.gpu_stage.hasEventListener(KeyboardEvent.KEY_DOWN)) this.gpu_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
		}
		
		/**
		 * 是否初始化过 
		 */		
		private var _isInit:Boolean = false;		
		public function init() : void
		{
			if (!gpu_stage || _isInit) return;
			
			_isInit = true;
			
			_content = new Sprite();
			_toolbar = new Sprite();
			_world = new Sprite();
			_tip = new Sprite();
			_top = new Sprite();
			
			// 层级
			gpu_stage.addChild(_content);
			gpu_stage.addChild(_world);
			gpu_stage.addChild(_toolbar);			
			gpu_stage.addChild(_tip);
			gpu_stage.addChild(_top);
			
			_maskTexture = Texture.fromColor(GameConfig.CAMERA_WIDTH, GameConfig.CAMERA_HEIGHT, 0xff000000);
			setTipMask();
			setTopMask();
		}
		
		//// -----tip mask
		private var _tipMask:Image;
		private function setTipMask() : void
		{
			_tipMask = new Image(_maskTexture);
			_tipMask.alpha = 0.4;
			_tip.addChild(_tipMask);
			_tipMask.visible = false;
		}
		public function setTipMaskShow() : void
		{
			_tipMask.visible = true;
		}		
		public function setTipMaskHide() : void
		{
			_tipMask.visible = false;
		}
		 
		public function checkTipMask() : Boolean
		{
			return _tipMask.visible;
		}
		
		/// -------top mask
		private var _topMask:Image;
		private function setTopMask() : void
		{
			_topMask = new Image(_maskTexture);
			_topMask.alpha = 0.4;
			_top.addChild(_topMask);
			_topMask.visible = false;
		}
		public function setTopMaskShow() : void
		{
			_topMask.visible = true;
		}
		public function setTopMaskHide() : void
		{
			_topMask.visible = false;
		}
		
		public function checkTopMask() : Boolean
		{
			return _topMask.visible;
		}
		
		
		public function addContentChild(obj:Sprite, type:String) : void
		{
			// 移除一个容器下的全部子对象
			_content.removeChildren();			
			_content.addChild(obj);
		}
		
		public function addToolbarChild(obj:Sprite, type:String) : void
		{		
			_toolbar.addChild(obj);
		}
		
		public function addWorldChild(obj:Sprite, type:String) : void
		{
			_world.removeChildren();			
			_world.addChild(obj);
		}
		
		public function addTipChild(obj:Sprite, type:String) : void
		{
			//_tip.removeChildren();			
			_tip.addChild(obj);
		}
		
		public function addTipChildAt(obj:Sprite, type:String) : void
		{
			_tip.addChildAt(obj, _tip.numChildren - 1);
		}
		
		public function addTopChild(obj:Sprite, type:String) : void
		{
			//_top.removeChildren();
			_top.addChild(obj);
		}
		
		public function addTopChildAt(obj:Sprite, type:String) : void
		{
			_top.addChildAt(obj, _top.numChildren - 1);
		}
		
		public function setLeftBottom(obj:DisplayObject, h:int) : void
		{
			obj.x = 0;
			obj.y = this.height - h;
		}
		
		public function setRightTop(obj:DisplayObject, w:int) : void
		{
			obj.x = this.width - w;
			obj.y = 0;
		}
		
		public function setRightBottom(obj:DisplayObject, w:int, h:int) : void
		{
			obj.x = this.width - w;
			obj.y = this.height - h;
		}
		
		public function setBottom(obj:DisplayObject, h:int, x:int) : void
		{
			obj.x = x;
			obj.y = this.height - h;
		}
		
		public function setCenter(obj:DisplayObject) : void
		{
			obj.x = this.width - obj.width >> 1;
			obj.y = this.height - obj.height >> 1;
		}
		
		private static var _instance : LayerManager;
		public static function get instance () : LayerManager
		{
			if (null == _instance)
			{
				_instance = new LayerManager(new Singleton());
			}
			
			return _instance;
		}
	}
}

class Singleton {}
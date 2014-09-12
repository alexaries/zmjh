package com.game.view.effect
{
	import com.game.View;
	import com.game.template.GameConfig;
	import com.game.view.Component;
	import com.greensock.TweenLite;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class StretchEffect
	{
		private var _mainObj:DisplayObject;
		private var _objList:Array;
		private var _objUpList:Array;
		private var _isStretch:Boolean;
		public function get isStretch() : Boolean
		{
			return _isStretch;
		}
		private var _xPositionList:Array;
		private var _yPositionList:Array;
		private var _isHorizontal:Boolean;
		private var _panel:Sprite
		public function StretchEffect(panel:Sprite, mainObj:DisplayObject, objUpList:Array, isHorizontal:Boolean = true)
		{
			_panel = panel;
			_mainObj = mainObj;
			_isHorizontal = isHorizontal;
			_objUpList = objUpList;
			_isStretch = true;
			
			initMask();
			addEvent();
		}
		
		private var _maskTexture:Texture;
		private var _tipMask:Image;
		private function initMask():void
		{
			if(!_maskTexture)
			{
				_maskTexture = Texture.fromColor(GameConfig.CAMERA_WIDTH, GameConfig.CAMERA_HEIGHT, 0xff000000);
				_tipMask = new Image(_maskTexture);
				_tipMask.alpha = 0.3;
			}
		}
		
		public function initData(objList:Array):void
		{
			_panel.setChildIndex(_mainObj, _panel.numChildren - 1);
			_objList = new Array();
			_objList = objList;
			_xPositionList = new Array();
			_yPositionList = new Array(); 
			var len:int = _objList.length;
			var obj:DisplayObject;
			for(var i:int = 0; i < len; i++)
			{
				if(_objList[i] is Component)
					obj = _objList[i].panel;
				else
					obj = _objList[i];
				_panel.setChildIndex(obj, _panel.numChildren - 1);
				_xPositionList.push(obj.x);
				_yPositionList.push(obj.y);
			}
			var len_1:int = _objUpList.length;
			for(var j:int = 0; j < len_1; j++)
			{
				if(_objUpList[j] is Component)
					obj = (_objUpList[j] as Component).panel;
				else
					obj = _objUpList[j];
				
				_panel.setChildIndex(obj, _panel.numChildren - 1);
			}
		}
		
		private var _glowEffect:GlowAnimationEffect;
		private function addEvent():void
		{
			if(_mainObj != null)
			{
				_mainObj.useHandCursor = true;
				_mainObj.addEventListener(TouchEvent.TOUCH, onTouch);
				_glowEffect = new GlowAnimationEffect(_mainObj, 0xFFFF00);
				_glowEffect.play();
			}
		}
		
		private function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_mainObj);
			if(!touch) return;
			
			if(touch.phase == TouchPhase.ENDED)
			{
				if(_isStretch)
					unStretchList();
				else
					stretchList();
			}
		}
		
		/**
		 * 展开按钮
		 * 
		 */		
		public function stretchList() : void
		{
			_mainObj.removeEventListener(TouchEvent.TOUCH, onTouch);
			(_mainObj as MovieClip).currentFrame = 1;
			_isStretch = true;
			var len:int = _objList.length;
			var obj:DisplayObject;
			var xPos:int;
			for(var i:int = 0; i < len; i++)
			{
				xPos = 840 - (i * 80);
				if(_objList[i] is Component)
				{
					obj = _objList[i].panel;
					xPos -= obj.width * .5;
				}
				else
					obj = _objList[i];
				
				obj.touchable = true;
				obj.visible = true;
				obj.alpha = 0;
				
				if(_isHorizontal)
					TweenLite.to(obj, 1, {x:xPos, alpha:1});
				else
					TweenLite.to(obj, 1, {y:90 + (i * 80), alpha:1});
			}
			_panel.addChildAt(_tipMask, _panel.getChildIndex(_mainObj));
			Starling.juggler.delayCall(addEvent, 1);
		}
		
		/**
		 * 收起按钮
		 * 
		 */		
		public function unStretchList(time:Number = 1) : void
		{
			_mainObj.removeEventListener(TouchEvent.TOUCH, onTouch);
			(_mainObj as MovieClip).currentFrame = 0;
			_isStretch = false;
			var len:int = _objList.length;
			var obj:DisplayObject;
			for(var i:int = 0; i < len; i++)
			{
				if(_objList[i] is Component)
					obj = _objList[i].panel;
				else
					obj = _objList[i];
				obj.touchable = false;
				if(_isHorizontal)
					TweenLite.to(obj, time, {x:_mainObj.x, alpha:0, onComplete:unStretchComplete, onCompleteParams:[obj]});
				else
					TweenLite.to(obj, time, {y:_mainObj.y, alpha:0, onComplete:unStretchComplete, onCompleteParams:[obj]});
			}
			_panel.removeChild(_tipMask);
			Starling.juggler.delayCall(addEvent, time);
		}
		
		private function unStretchComplete(obj:DisplayObject) : void
		{
			obj.alpha = 1;
			obj.visible = false;
			obj.touchable = true;
		}
		
		public function hideMask() : void
		{
			_isStretch = false;
			var len:int = _objList.length;
			var obj:DisplayObject;
			for(var i:int = 0; i < len; i++)
			{
				if(_objList[i] is Component)
					obj = _objList[i].panel;
				else
					obj = _objList[i];
				if(_isHorizontal)
					obj.x = _mainObj.x;
				else
					obj.y = _mainObj.y;
				
				obj.visible = false;
			}
			(_mainObj as MovieClip).currentFrame = 0;
			_panel.removeChild(_tipMask);
		}
	}
}
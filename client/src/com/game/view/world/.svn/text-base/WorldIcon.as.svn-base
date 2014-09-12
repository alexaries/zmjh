package com.game.view.world
{
	import com.game.view.effect.GlowAnimationEffect;
	import com.game.view.effect.OriginalShakeEffect;
	import com.game.view.effect.SpecialShakeEffect;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.textures.Texture;

	public class WorldIcon  
	{
		private var img:Image;
		private var strokeImg:Image;
		private var _animationed:Boolean;
		private var handClick:Function;
		private var _name:String;
		private var _g1:GlowAnimationEffect;
		private var _shake:SpecialShakeEffect;
		private var _strokeImgShake:OriginalShakeEffect;
		private var _isShake:Boolean;
		public function get isShake() : Boolean
		{
			return _isShake;
		}
		public function set isShake(value:Boolean) : void
		{
			_isShake = value;
			if(_isShake) 
			{
				_shake.play();
				_strokeImgShake.play();
			}
			else
			{
				_shake.stop();
				_strokeImgShake.stop();
			}
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function WorldIcon(img:Image, strokeImg:Image, handClick:Function) : void
		{
			this.img = img;
			this.strokeImg = strokeImg;
			this.handClick = handClick;
			this._name = img.name;
			_isShake = false;
			 
			_g1 = new GlowAnimationEffect(img);
			
			img.pivotX = int(img.width * .5);
			img.pivotY = int(img.height * .5);
			img.scaleX = img.scaleY = 0.8;
			strokeImg.scaleX = strokeImg.scaleY = 1;
			
			img.x += img.width * .5;
			img.y += img.height * .5;
			img.addEventListener(TouchEvent.TOUCH, onTouch);
			
			strokeImg.pivotX = int(strokeImg.width * .5);
			strokeImg.pivotY = int(strokeImg.height * .5);
			strokeImg.x += strokeImg.width * .5;
			strokeImg.y += strokeImg.height * .5;
			strokeImg.alpha = 0;
			
			
			_shake = new SpecialShakeEffect(img);
			_strokeImgShake = new OriginalShakeEffect(strokeImg);
		}
		
		private function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(img);

			if (touch&&touch.phase == TouchPhase.HOVER) 
			{
				img.scaleX = img.scaleY = 1;
				strokeImg.scaleX = strokeImg.scaleY = 1;
				 _g1.stop();
				 strokeImg.alpha = 0;
				 _shake.stop();
				 _strokeImgShake.stop();
			}
			else if (touch && touch.phase == TouchPhase.ENDED) 
			{
				handClick.call(null, -1, name);
			}
			else 
			{
				img.scaleX = img.scaleY = 0.8;
				strokeImg.scaleX = strokeImg.scaleY = 1;
				_g1.play();
				strokeImg.alpha = 1;
				if(_isShake)
				{
					_shake.play();
					_strokeImgShake.play();
				}
			}
		}
		
		public function get animationed() : Boolean
		{
			return _animationed;
		}
		
		public function set animationed(value:Boolean) : void
		{
			_animationed = value;
			if (value) 
			{
				_g1.play();
				strokeImg.alpha = 1;
			}
		}
		
		public function clear() : void
		{
			img.removeEventListeners();
			img.dispose();
			img = null;
			
			strokeImg.removeEventListeners();
			strokeImg.dispose();
			strokeImg = null;
			
			_g1.destroy();
			_g1 = null;
		}
	}
}
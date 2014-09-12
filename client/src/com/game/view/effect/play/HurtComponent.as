package com.game.view.effect.play 
{
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author wdc
	 */
	public class HurtComponent implements IAnimatable
	{
		private var _time:Number;
		private var _img:Image;
		private var _callBack:Function;
		private var _totalTime:Number = 0;
		private var _img2:Image;
		private var _per:Number;
		private var _action:uint;
		private var _oldx:Number;
		private var _dirDis:Number=2;
		
		public function HurtComponent()
		{
			
		}
		
		/**
		 * 
		 * @param	img  原图
		 * @param	time 效果持续几秒
		 * @param	callBack	效果完成后回调
		 * @param action 	0为跟随原图动  	1 为原图和效果图一起左右动
		 */
		public function initData(img:Image,time:Number,callBack:Function,action:uint=0) : void
		{
			_action = action;
			_callBack = callBack;
			_img = img;
			_time = time;
			
			_img2 = new Image(Texture.fromTexture(img.texture));
			img.parent.addChild(_img2);
			_img2.pivotX = img.pivotX;
			_img2.pivotY = img.pivotY;
			_img2.scaleX = img.scaleX;
			_img2.scaleY = img.scaleY;
			_img2.x = img.x;
			_img2.y = img.y;
			_img2.color = 0xff0000;
			
			_oldx = img.x;
			
			_per = 1 / 24/time;
			Starling.juggler.add(this);
			
			
			
		}
		public function destroy():void
		{
			_img.x = _oldx;
			_img2.x = _img.x;
			_img2.y = _img.y;
			Starling.juggler.remove(this);
			_img = null;
			_callBack = null;
			_time = NaN;
			_img2.dispose();
			_img2.removeFromParent();
		}
		
		/* INTERFACE starling.animation.IAnimatable */
		
		public function advanceTime(time:Number):void 
		{
			_totalTime += time;
			_img2.alpha -= _per;
			if (_action==0) 
			{
				_img2.x = _img.x;
				_img2.y = _img.y;
			}else if (_action==1) 
			{
				playAction1();
			}
			if (_totalTime >= _time ) 
			{
				_callBack.call(null);
				_totalTime = 0;
				destroy();
			}
		}
		
		private function playAction1():void 
		{
			_img.x += _dirDis;
			_dirDis = -_dirDis;;
			_img2.x = _img.x;
			_img2.y = _img.y;
		}
	}

}
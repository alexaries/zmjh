package com.game.view.effect
{
	import starling.animation.Tween;
	import starling.core.Starling;

	public class FloatEffect
	{
		private var _obj:*;
		private var _yFloat:Number;
		private var _startY:Number;
		private var _tween:Tween;
		public function FloatEffect(obj:*, yFloat:Number)
		{
			_obj = obj;
			_yFloat = yFloat;
		}
		
		/**
		 * 开始播放
		 * 
		 */		
		public function play() : void
		{
			_tween = new Tween(_obj, .4);
			_tween.reverse = true;
			_tween.repeatCount = 0;
			_tween.animate("y", (_obj.y - _yFloat));
			Starling.juggler.add(_tween);
		}
		
		/**
		 * 停止播放
		 * 
		 */		
		public function stop() : void
		{
			if(_tween != null) Starling.juggler.remove(_tween);
		}
		
		public function destroy():void
		{
			Starling.juggler.remove(_tween);
			_tween=null;
		}
	}
}
package com.game.view.effect
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;

	public class TweenEffect
	{
		private var _tween:Tween;
		private var _callback:Function;
		public function TweenEffect()
		{
			
		}
		
		public function setStart(obj:DisplayObject, property:String, change:Number, time:Number, callback:Function) : void
		{
			_callback = callback;
			_tween = new Tween(obj, time);
			_tween.animate(property, change);
			_tween.onComplete = onCompleteFun;
			Starling.juggler.add(_tween);
		}
		
		private function onCompleteFun() : void
		{
			Starling.juggler.remove(_tween);
			if(_callback != null) _callback();
		}
	}
}
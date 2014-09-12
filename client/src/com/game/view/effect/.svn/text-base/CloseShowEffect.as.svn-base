package com.game.view.effect
{
	import com.game.view.Component;
	
	import starling.animation.Tween;
	import starling.core.Starling;

	public class CloseShowEffect
	{
		private var _obj:*;
		private var _time:Number;
		private var _alphaChange:Number;
		private var _tween:Tween;
		private var _isVisible:Boolean;
		
		public function CloseShowEffect(obj:*, time:Number, alphaChange:Number, isVisible:Boolean)
		{
			if(obj is Component)
				_obj = obj.panel;
			else 
				_obj = obj;
			
			_time = time;
			_alphaChange = alphaChange;
			_isVisible = isVisible;
			
			_tween = new Tween(_obj, _time);
			_tween.animate("alpha", _alphaChange);
			_tween.onComplete = onComplete;
			Starling.juggler.add(_tween);
		}
		
		private function onComplete() : void
		{
			Starling.juggler.remove(_tween);
			//_obj.visible = _isVisible;
		}
	}
}
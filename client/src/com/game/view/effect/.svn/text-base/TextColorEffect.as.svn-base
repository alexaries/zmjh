package com.game.view.effect
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.text.TextField;

	public class TextColorEffect
	{
		private var _text:TextField;
		private var _startColor:int;
		private var _endColor:int;
		private var _lastColor:int;
		private var _intervalTime:Number;
		private var _tween:Tween;
		
		public function TextColorEffect(text:TextField, startColor:int, endColor:int, lastColor:int = 0x000000, intervalTime:Number = 1)
		{
			_text = text;
			_startColor = startColor;
			_endColor = endColor;
			_lastColor = lastColor;
			_intervalTime = intervalTime;
			
			_tween = new Tween(_text, _intervalTime);
			_tween.reverse = true;
			_tween.repeatCount = 0;
			_tween.animate("color", _endColor);
		}
		
		/**
		 * 开始播放
		 * 
		 */		
		public function play() : void
		{
			_text.color = _startColor;
			Starling.juggler.add(_tween);
		}
		
		/**
		 * 停止播放
		 * 
		 */		
		public function stop() : void
		{
			if(_tween != null) Starling.juggler.remove(_tween);
			_text.color = _lastColor;
		}
		
		public function destroy():void
		{
			Starling.juggler.remove(_tween);
			_tween=null;
		}
	}
}
package com.game.view.effect
{
	 
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.filters.BlurFilter;

	public class GlowAnimationEffect
	{
		private var _disp:DisplayObject;
		private var t:Tween;
		private var _glowFilter:BlurFilter;
		private var _isPlay:Boolean;
		public function get isPlay() : Boolean
		{
			return _isPlay;
		}
		
		public function GlowAnimationEffect(disp:DisplayObject, color:int = 0xffff00)
		{
			_isPlay = false;
			this._disp=disp;
			_glowFilter = BlurFilter.createGlow(color,1,0);
			t = new Tween(_glowFilter, 1);
			t.reverse = true;
			t.repeatCount = 0;
			t.animate("blurX", 10);
			t.animate("blurY", 10);
		}
		public function play():void
		{
			this._disp.filter=_glowFilter;
			_isPlay = true;
			Starling.juggler.add(t);
		}
		public function stop():void
		{
			_isPlay = false;
			Starling.juggler.remove(t);
			this._disp.filter=null;
		}
		
		public function destroy():void
		{
			Starling.juggler.remove(t);
			t=null;
			this._disp.filter=null;
			_glowFilter.dispose();
			_glowFilter=null;
		}
	}
}
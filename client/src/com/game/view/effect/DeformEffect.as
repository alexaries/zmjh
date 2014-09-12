package com.game.view.effect
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;

	public class DeformEffect
	{
		private var _disp:DisplayObject;
		private var _name:String;
		public function get name() : String
		{
			return _name;
		}
		private var t:Tween;
		private var _startWid:Number;
		private var _startHei:Number;
		private var _startY:Number;
		public function DeformEffect(disp:DisplayObject, name:String)
		{
			_disp = disp;
			_name = name;
			_startWid = _disp.width;
			_startHei = _disp.height;
			_startY = _disp.y;
		}
		
		public function play():void
		{
			onChange();
		}
		
		private function onChange() : void
		{
			Starling.juggler.remove(t);
			t = new Tween(_disp, .2);
			t.animate("scaleY", 1.15);
			t.animate("scaleX", .85);
			t.animate("y", _startY - 7);
			t.onComplete = onContinue_1;
			Starling.juggler.add(t);
		}
		
		private function onContinue_1() : void
		{
			Starling.juggler.remove(t);
			t = new Tween(_disp, .2);
			t.animate("scaleY", .9);
			t.animate("scaleX", 1.05);
			t.animate("y", _startY);
			t.onComplete = onContinue_2;
			Starling.juggler.add(t);
		}
		
		private function onContinue_2() : void
		{
			Starling.juggler.remove(t);
			t = new Tween(_disp, .1);
			t.reverse = true;
			t.repeatCount = 3;
			t.animate("scaleY", 1.05);
			t.animate("scaleX", .95);
			t.onComplete = onChange;
			Starling.juggler.add(t);
		}
		
		public function stop() : void
		{
			Starling.juggler.remove(t);
			_disp.width = _startWid;
			_disp.height = _startHei;
			_disp.y = _startY;
		}
		
		public function destroy():void
		{
			Starling.juggler.remove(t);
			t=null;
		}
	}
}
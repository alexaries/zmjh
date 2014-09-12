package com.game.view.load
{
	import flash.display.Sprite;
	public class Line extends Sprite
	{
		public var sX:int;
		public var sY:int;
		public var eX:int;
		public var eY:int;
		public var linesize:Number;
		public function Line($sX:int, $sY:int, $eX:int, $eY:int, $linesize:Number = 5)
		{
			sX = $sX;
			sY = $sY;
			eX = $eX;
			eY = $eY;
			linesize = $linesize;
			draw();
		}
		private function draw():void
		{
			graphics.clear();
		
			graphics.lineStyle(linesize, 0xFFFFFF);
			graphics.moveTo(sX, sY);
			graphics.lineTo(eX, eY);
		}
		public function update():void
		{
			draw();
			linesize -= 1;

		}
	}
}
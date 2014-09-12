package com.game.view.fight.begin.tl
{
	public class TL_MOVE extends BaseTL
	{
		public var duration:int;
		
		public var EX:int;
		
		public var EY:int;
		
		public function TL_MOVE()
		{
			super();
		}
		
		override public function parseConfig(data:XML) : void
		{
			super.parseConfig(data);
			
			duration = data.duration[0];
			EX = data.EX[0];
			EY = data.EY[0];
		}
	}
}
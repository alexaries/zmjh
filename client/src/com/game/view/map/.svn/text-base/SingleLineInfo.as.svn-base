package com.game.view.map
{
	import flash.geom.Point;

	public class SingleLineInfo
	{
		private var _roadPoints:Vector.<Vector.<Node>>;
		public function get roadPoints() : Vector.<Vector.<Node>>
		{
			return _roadPoints;
		}
		public function set roadPoints(value:Vector.<Vector.<Node>>) : void
		{
			_roadPoints = value;
		}
		
		public function pushNewRoad(nodes:Vector.<Node>) : void
		{
			roadPoints.push(nodes);
		}
		
		public function SingleLineInfo()
		{
			roadPoints = new Vector.<Vector.<Node>>();
		}
	}
}
package com.game.view.fight.begin
{
	public class BaseBeginEffect
	{
		protected var _config:XML;
		
		public var type:String;
		
		public var begin_frame:int;
		
		public var X:int;
		
		public var Y:int;
		
		public function BaseBeginEffect()
		{
		}
		
		public function initData(data:XML) : void
		{
			_config = data;
			
			parseConfig();
		}
		
		protected function parseConfig() : void
		{
			type = _config.@type;
			begin_frame = _config.@begin_frame;
			X = _config.@X;
			Y = _config.@Y;
		}
	}
}
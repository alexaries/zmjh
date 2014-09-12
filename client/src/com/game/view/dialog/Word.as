package com.game.view.dialog
{
	public class Word
	{
		public var id:int;
		public var name:String;
		public var position:String;
		public var content:String;
		
		public function Word()
		{
		}
		
		private var _config:XML;
		public function initData(config:XML) : void
		{
			_config = config;
			
			id = _config.@id;
			name = _config.@name;
			position = _config.@position;
			content = _config.toString();
		}
	}
}
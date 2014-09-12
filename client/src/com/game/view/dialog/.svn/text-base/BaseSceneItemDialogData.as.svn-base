package com.game.view.dialog
{
	public class BaseSceneItemDialogData
	{
		private var _type:String;
		public function get type() : String
		{
			return _type;
		}
		
		private var _id:int;
		public function get id() : int
		{
			return _id;
		}
		
		public function BaseSceneItemDialogData()
		{
		}
		
		protected var _config:XML;
		public function initData(config:XML) : void
		{
			_config = config;
			
			_type = _config.@type;
			_id = _config.@id;
		}
	}
}
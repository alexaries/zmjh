package com.game.view.dialog
{
	public class Dialog
	{
		private var _type:String;
		public function get type() : String
		{
			return _type;
		}
		
		private var _items:Vector.<DialogItemData>;
		public function get items() : Vector.<DialogItemData>
		{
			return _items;
		}
		
		public function Dialog()
		{
			_items = new Vector.<DialogItemData>();
		}
		
		private var _config:XML;
		public function initData(config:XML) : void
		{
			_config = config;
			
			parseConfig();
		}
		
		private function parseConfig() : void
		{
			_type = _config.@type;
			
			var item:DialogItemData;
			for each(var itemXML:XML in _config.item)
			{
				item = new DialogItemData();
				item.initData(itemXML);
				_items.push(item);
			}
		}
	}
}
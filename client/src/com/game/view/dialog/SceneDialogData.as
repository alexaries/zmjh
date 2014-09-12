package com.game.view.dialog
{
	public class SceneDialogData
	{
		private var _type:String;
		public function get type() : String
		{
			return _type;
		}
		
		private var _sceneItems:Vector.<BaseSceneItemDialogData>;
		public function get sceneItems() : Vector.<BaseSceneItemDialogData>
		{
			return _sceneItems;
		}
		
		public function SceneDialogData()
		{
			_sceneItems = new Vector.<BaseSceneItemDialogData>();
		}
		
		private var _config:XML;
		public function initData(config:XML) : void
		{
			_config = config;
			
			parseData();
		}
		
		private function parseData() : void
		{
			_type = _config.@name;
			
			var type:String;
			var baseItem:BaseSceneItemDialogData;
			for each(var itemXML:XML in _config.item)
			{
				type = itemXML.@type;
				
				switch (type)
				{
					case DialogConfig.WORD:
						baseItem = new WordDialogData();
						break;
					case DialogConfig.CARTOON:
						baseItem = new CartoonDialogData();
						break;
				}
				baseItem.initData(itemXML);
				_sceneItems.push(baseItem);
			}
		}
	}
}
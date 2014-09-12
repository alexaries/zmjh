package com.game.view.dialog
{
	public class DialogItemData
	{
		private var _type:String;
		public function get type() : String
		{
			return _type;
		}
		
		private var _scenes:Vector.<SceneDialogData>;
		public function get scenes() : Vector.<SceneDialogData>
		{
			return _scenes;
		}
		
		public function DialogItemData()
		{
			_scenes = new Vector.<SceneDialogData>();
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
			
			var scene:SceneDialogData;
			for each(var sceneItem:XML in _config.scene)
			{
				scene = new SceneDialogData();
				scene.initData(sceneItem);
				_scenes.push(scene);
			}
		}
	}
}
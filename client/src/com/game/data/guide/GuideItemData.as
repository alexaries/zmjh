package com.game.data.guide
{
	public class GuideItemData
	{
		private var _config:XML;
		private var _levelName:String;
		public function get levelName() : String
		{
			return _levelName;
		}
		private var _wordList:Vector.<GuideWordData>;
		public function get wordList() : Vector.<GuideWordData>
		{
			return _wordList;
		}
		private var _funcList:Vector.<GuideFuncData>;
		public function get funcList() : Vector.<GuideFuncData>
		{
			return _funcList;
		}
		public function GuideItemData()
		{
			_wordList = new Vector.<GuideWordData>();
			_funcList = new Vector.<GuideFuncData>();
		}
		
		public function initData(config:XML, type:String) : void
		{
			_levelName = config.@name;
			_config = XML(config.scene.(@name == type));
			for(var i:int = 0; i < _config.word.length(); i++)
			{
				var word:GuideWordData = new GuideWordData();
				word.initData(_config.word[i]);
				_wordList.push(word);
			}
			
			for(var j:int = 0; j < _config.functions.length(); j++)
			{
				var func:GuideFuncData = new GuideFuncData();
				func.initData(_config.functions[j]);
				_funcList.push(func);
			}
		}
	}
}
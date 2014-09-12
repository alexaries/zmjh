package com.game.view.dialog
{
	public class WordDialogData extends BaseSceneItemDialogData
	{
		private var _words:Vector.<Word>;
		public function get words() : Vector.<Word>
		{
			return _words;
		}
		
		public function WordDialogData()
		{
			super();
			
			_words = new Vector.<Word>();
		}
		
		override public function initData(config:XML) : void
		{
			super.initData(config);
			
			parseData();
		}
		
		private function parseData() : void
		{
			var word:Word;
			
			for each(var wordXML:XML in _config.word)
			{
				word = new Word();
				word.initData(wordXML);
				_words.push(word);
			}
		}
	}
}
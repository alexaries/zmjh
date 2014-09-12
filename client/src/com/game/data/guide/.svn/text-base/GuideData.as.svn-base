package com.game.data.guide
{
	import com.game.data.Base;
	import com.game.data.player.structure.GuideInfo;
	import com.game.data.player.structure.Player;

	public class GuideData extends Base
	{
		private var _config:XML;
		private var _allGuide:GuideTypeData;
		public function get allGuide() : GuideTypeData
		{
			return _allGuide;
		}
		public function get player() : Player
		{
			return _data.player.player;
		}
		
		public function get guideInfo() : GuideInfo
		{
			return player.guideInfo;
		}
		
		public function GuideData() 
		{
			
		}
		
		public function initData(config:XML) : void
		{
			_allGuide = new GuideTypeData();
			_config =config;
			parseConfig();
		}
		
		private function parseConfig() : void
		{
			_allGuide.initData(XML(_config.guide.(@type == "special")));
			_allGuide.initData(XML(_config.guide.(@type == "level")));
			_allGuide.initData(XML(_config.guide.(@type == "role_lv")));
			_allGuide.initData(XML(_config.guide.(@type == "firstGuide")));
			_allGuide.initData(XML(_config.guide.(@type == "getRoleGuide")));
		}
	}
}
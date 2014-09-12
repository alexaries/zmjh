package com.game.view.map
{
	import com.game.View;
	import com.game.template.GameConfig;
	
	import flash.utils.ByteArray;

	public class MapInfo
	{
		// 当前等级
		private var _curLevel:String;
		public function get curLevel() : String
		{
			return 	_curLevel;
		}
		
		// 地图宽度
		private var _mapWidth:int;
		public function get mapWidth() : int
		{
			return _mapWidth;
		}
		
		// 地图高度
		private var _mapHeight:int;
		public function get mapHeight() : int
		{
			return _mapHeight;
		}
		
		// 格子行数
		private var _row:int;
		public function get row() : int
		{
			return _row;
		}
		
		// 格子列数
		private var _col:int;
		public function get col() : int
		{
			return _col;
		}
		
		// 地图x偏移
		private var _mpx:int;
		public function get mpx() : int
		{
			return _mpx;
		}
		
		// 地图y偏移
		private var _mpy:int;
		public function get mpy() : int
		{
			return _mpy;
		}
		
		// 玩家位置
		private var _playerPosition:PlayerPosition;
		public function get playerPosition() : PlayerPosition
		{
			return _playerPosition;
		}
		
		// 格子宽度
		private var _titleWidth:int;
		public function get titleWidth() : int
		{
			return _titleWidth;
		}
		
		// 格子高度
		private var _titleHeight:int;
		public function get titleHeight() : int
		{
			return _titleHeight;
		}
		
		/**
		 * 路点 
		 */		
		private var _roadItems:Vector.<Prop>;
		public function get roadItems() : Vector.<Prop>
		{
			return _roadItems;
		}
		
		private var _view:View;
		private var _loadBaseName:String;
		private var _curSwfName:String;
		public function MapInfo(view:View, loadBaseName:String, level:String)
		{
			_view = view;
			_loadBaseName = loadBaseName;
			_curLevel = level;
			_useLevel = level;
			_curSwfName = _curLevel.replace("_", "p");
			_curSwfName += GameConfig.MAP_RES[_curLevel];
			
			initConfigXML();
		}
		
		private var _useLevel:String;
		public function resetMapConfig(num:int) : void
		{
			if(num == 0)
				_curLevel = _useLevel;
			else
				_curLevel = _useLevel + "_" + num;
			resetRoad();
			resetConfigXML();
		}
		
		private function resetConfigXML() : void
		{
			_configXML = getXMLData(_loadBaseName, _curSwfName+".swf", _curLevel);
			initRoads(_configXML.items[0].item);
		}
		
		/**
		 * 解析配置文件 
		 */		
		private var _configXML:XML;
		private function initConfigXML() : void
		{
			_configXML = getXMLData(_loadBaseName, _curSwfName+".swf", _curLevel);
			
			_mapWidth = parseInt(_configXML.@mapwidth);
			_mapHeight = parseInt(_configXML.@mapHeight);
			
			_titleWidth = parseInt(_configXML.floor.@tileWidth);
			_titleHeight = parseInt(_configXML.floor.@tileHeight);
			_row = parseInt(_configXML.floor.@row);
			_col = parseInt(_configXML.floor.@col);
			_mpx = parseInt(_configXML.floor.@px);
			_mpy = parseInt(_configXML.floor.@py);
			
			_playerPosition = new PlayerPosition();
			_playerPosition.gx = parseInt(_configXML.player.@gx);
			_playerPosition.gy = parseInt(_configXML.player.@gy);
			_playerPosition.ix = parseInt(_configXML.player.@ix) + _mpx;
			_playerPosition.iy = parseInt(_configXML.player.@iy)+ _mpy;
			
			initRoads(_configXML.items[0].item);
		}
		
		/**
		 * 解析路径 
		 */		
		private function initRoads(items:XMLList) : void
		{
			_roadItems = new Vector.<Prop>();
			
			var roadInfo:Prop;
			for each(var item:XML in items)
			{
				roadInfo = new Prop(_view.map);
				roadInfo.id = item.@id;
				roadInfo.file = getFileBaseName(item.@file);
				roadInfo.type = item.@type;
				roadInfo.ix = item.@ix;
				roadInfo.iy = item.@iy;
				
				var args:String = item.@args;
				roadInfo.args = !args || args == "" ? {} : JSON.parse(item.@args);
				
				_roadItems.push(roadInfo);
			}
		}
		
		private function getFileBaseName(fileName:String) : String
		{
			var arr:Array = fileName.split("/");
			arr = (arr[arr.length - 1] as String).split(".");
			
			return String(arr[0]);
		}
		
		/**
		 * 获取xml文件 
		 * @param ModelName ： 模块名
		 * @param SWFName ： swf
		 * @param fileName ： 目标文件
		 * @return 
		 * 
		 */		
		protected function getXMLData(ModelName:String, SWFName:String, fileName:String) : XML
		{
			var xmlData:XML;
			var bytes:ByteArray = _view.res.getAssetsObject(ModelName, ModelName, SWFName, fileName) as ByteArray;
			xmlData = XML(bytes.toString());
			
			return xmlData;
		}
		
		public function clear() : void
		{
			while (roadItems.length)
			{
				roadItems.pop().destroy();
			}
		}
		
		private function resetRoad() : void
		{
			while(_roadItems.length > 0)
			{
				var item:Prop = roadItems.pop();
				item.resetImage();
				if(item.parent != null) item.parent.removeChild(item);
				item.dispose();
				item = null;
			}
		}
	}
}
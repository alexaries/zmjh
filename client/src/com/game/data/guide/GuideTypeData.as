package com.game.data.guide
{
	public class GuideTypeData
	{
		private var _config:XML;
		private var _type:String;
		private var _enterItem:Vector.<GuideItemData>;
		public function get enterItem() : Vector.<GuideItemData>
		{
			return _enterItem;
		}
		private var _passItem:Vector.<GuideItemData>;
		public function get passItem() : Vector.<GuideItemData>
		{
			return _passItem;
		}
		private var _specialItem:Vector.<GuideItemData>;
		public function get specialItem() : Vector.<GuideItemData>
		{
			return _specialItem;
		}
		private var _roleLvItem:Vector.<GuideItemData>;
		public function get roleLvItem() : Vector.<GuideItemData>
		{
			return _roleLvItem;
		}
		private var _firstItem:Vector.<GuideItemData>;
		public function get firstItem() : Vector.<GuideItemData>
		{
			return _firstItem;
		}
		private var _getRoleItem:Vector.<GuideItemData>;
		public function get getRoleItem() : Vector.<GuideItemData>
		{
			return _getRoleItem;
		}
		public function GuideTypeData()
		{
			_enterItem = new Vector.<GuideItemData>();
			_passItem = new Vector.<GuideItemData>();
			_specialItem = new Vector.<GuideItemData>();
			_roleLvItem = new Vector.<GuideItemData>();
			_firstItem = new Vector.<GuideItemData>();
			_getRoleItem = new Vector.<GuideItemData>();
		}
		
		public function initData(config:XML) : void
		{
			_config = config;
			_type = config.@type;
			switch(_type)
			{
				case "level":
					setLevelData();
					break;
				case "special":
					setSpecialData();
					break;
				case "role_lv":
					setRoleLvData();
					break;
				case "firstGuide":
					setFirstData();
					break;
				case "getRoleGuide":
					setRoleData();
					break;
			}
		}
		
		private function setLevelData() : void
		{
			for(var i:int = 0; i < _config.item.length(); i++)
			{
				var enterItem:GuideItemData = new GuideItemData();
				enterItem.initData(_config.item[i], "enter");
				_enterItem.push(enterItem);
				
				var passItem:GuideItemData = new GuideItemData();
				passItem.initData(_config.item[i], "pass");
				_passItem.push(passItem);
			}
		}
		
		private function setSpecialData() : void
		{
			for(var i:int = 0; i < _config.item.length(); i++)
			{
				var specialItem:GuideItemData = new GuideItemData();
				specialItem.initData(_config.item[i], _config.item[i].@name);
				_specialItem.push(specialItem);
			}
		}
		private function setRoleLvData() : void
		{
			for(var i:int = 0; i < _config.item.length(); i++)
			{
				var roleLvItem:GuideItemData = new GuideItemData();
				roleLvItem.initData(_config.item[i], "world");
				_roleLvItem.push(roleLvItem);
			}
		}
		
		private function setFirstData() : void
		{
			for(var i:int = 0; i < _config.item.length(); i++)
			{
				var firstItem:GuideItemData = new GuideItemData();
				firstItem.initData(_config.item[i], _config.item[i].@name);
				_firstItem.push(firstItem);
			}
		}
		
		private function setRoleData() : void
		{
			for(var i:int = 0; i < _config.item.length(); i++)
			{
				var getRoleItem:GuideItemData = new GuideItemData();
				getRoleItem.initData(_config.item[i], _config.item[i].@name);
				_getRoleItem.push(getRoleItem);
			}
		}
	}
}
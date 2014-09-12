package com.game.data.player.structure
{
	public class GuideInfo
	{
		private var _guide:Vector.<GuideStructure>;
		public function get guideList() : Vector.<GuideStructure>
		{
			return _guide;
		}
		public function set guideList(value:Vector.<GuideStructure>) : void
		{
			guideList = value;
		}
		
		public function GuideInfo()
		{
			_guide = new Vector.<GuideStructure>();
		}
		
		public function init(data:XML) : void
		{
			var info:GuideStructure;
			for(var i:int = 0; i < data.items.item.length(); i++)
			{
				var item:XML = data.items.item[i];
				info = new GuideStructure();
				info.levelName = item.@levelName;
				info.type = item.@type;
				_guide.push(info);
			}
		}
		
		public function addGuideInfo(level:String, type:String) : void
		{
			if(checkGuideInfo(level, type)) return;
			var info:GuideStructure = new GuideStructure();
			info.levelName = level;
			info.type = type;
			_guide.push(info);
		}
		
		public function checkGuideInfo(level:String, type:String) : Boolean
		{
			var TOF:Boolean = false;
			for(var i:int = 0; i < _guide.length; i++)
			{
				if(_guide[i].levelName == level && _guide[i].type == type)
				{
					TOF = true;
					break;
				}
			}
			return TOF;
		}
		
		public function getXML() : XML
		{
			var node:XML;
			var item:XML;
			var info:XML = <guide></guide>;
			
			node = <items></items>;
			for (var i:int = 0; i < _guide.length; i++)
			{
				item = <item levelName={_guide[i].levelName} type={_guide[i].type}/>
				node.appendChild(item);
			}
			info.appendChild(node);
			
			return info;
		}
	}
}
package com.game.data.achievement
{
	public class AchievementInfo
	{
		private var _achievementList:Vector.<String>;
		public function get achievementList() : Vector.<String>
		{
			return _achievementList;
		}
		public function set achievementList(value:Vector.<String>) : void
		{
			_achievementList = value;
		}
		
		public function AchievementInfo()
		{
			_achievementList = new Vector.<String>();
		}
		
		public function init(data:XML) : void
		{
			var characters:Array = String(data.character).split("|");
			for(var i:int = 0; i < characters.length; i++)
			{
				_achievementList.push(characters[i].toString());
			}
		}
		
		public function getXML() : XML
		{
			var info:XML = <achievement></achievement>;
			
			var characters:String = getCharacters();
			info.appendChild(<characters>{characters}</characters>);
			
			return info;
		}
		
		private function getCharacters() : String
		{
			var result:String = "";
			for(var i:int = 0; i < _achievementList.length; i++)
			{
				if(i != 0) result += "|";
				result += _achievementList[i];
			}
			return result;
		}
		
		/**
		 * 添加角色，返回是否添加成功
		 * @param name
		 * @return 
		 * 
		 */			
		public function addCharacter(name:String) : Boolean
		{
			var result:Boolean = false;
			if(!checkCharacter(name))
			{
				_achievementList.push(name);
				result = true;
			}
			return result;
		}
		
		/**
		 * 删除已存在的角色，返回是否删除成功
		 * @param name
		 * @return 
		 * 
		 */		
		public function removeCharacter(name:String) : Boolean
		{
			var result:Boolean = false;
			for each(var item:String in _achievementList)
			{
				if(name == item)
				{
					_achievementList.splice(_achievementList.indexOf(item), 1);
					result = true;
					break;
				}
			}
			
			return result
		}
		
		/**
		 * 检测是否已经存在该角色
		 * @param name
		 * @return 
		 * 
		 */		
		public function checkCharacter(name:String) : Boolean
		{
			var result:Boolean = false;
			for each(var item:String in _achievementList)
			{
				if(name == item)
				{
					result = true;
					break;
				}
			}
			return result;
		}
	}
}
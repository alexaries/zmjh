package com.game.data.douleLevel
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.View;
	import com.game.data.player.structure.LevelInfo;
	import com.game.data.player.structure.Player;
	import com.game.manager.DebugManager;
	import com.game.template.V;

	public class DoubleLevelInfo
	{
		private var _anti:Antiwear;
		
		public function get player() : Player
		{
			return Data.instance.player.player;
		}
		
		public function get time() : String
		{
			return _anti["time"];
		}
		public function set time(value:String) : void
		{
			_anti["time"] = value;
		}
		
		public function get startTime() : String
		{
			return _anti["startTime"];
		}
		public function set startTime(value:String) : void
		{
			_anti["startTime"] = value;
		}
		
		public function get level() : String
		{
			return _anti["level"];
		}
		public function set level(value:String) : void
		{
			_anti["level"] = value;
		}
		private var _firstClick:Boolean;
		
		public function DoubleLevelInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["time"] = "";
			_anti["startTime"] = "";
			_anti["level"] = "";
			_firstClick = false;
		}
		
		public function init(data:XML) : void
		{
			time = data.time;
			startTime = data.startTime;
			level = data.level;
		}
		
		public function getXML() : XML
		{
			var item:XML;
			var info:XML = <doubleLevel></doubleLevel>;
			info.appendChild(<time>{time}</time>);
			info.appendChild(<startTime>{startTime}</startTime>);
			info.appendChild(<level>{level}</level>);
			
			return info;
		}
		
		public function firstEnter() : void
		{
			var returnList:String = getLevel();
			_anti["time"] = Data.instance.time.curTimeStr;
			_anti["startTime"] = "";
			_anti["level"] = returnList;
			_firstClick = true;
		}
		
		public function firstSave() : void
		{
			if(_firstClick)
			{
				_firstClick = false;
			}
		}
		
		private function getLevel() : String
		{
			var curLevelInfo:LevelInfo;
			var curLevel:String;
			var levelList:Vector.<LevelInfo> = new Vector.<LevelInfo>();
			
			for each(var item:LevelInfo in player.pass_level)
			{
				if(item.name == "6_2" || item.name == "1_4" || item.name == "2_4" || item.name == "3_4" || item.name == "4_4" || item.name == "5_4" || item.name == "1_1" || item.name == "1_2") continue;
				if(item.name == "5_1")
				{
					if(player.checkLevelShow("4_4"))
						levelList.push(item);
				}
				else if(item.name == "6_1")
				{
					if(player.checkLevelShow("5_4"))
						levelList.push(item);
				}
				else
					levelList.push(item);
			}
			
			if(levelList.length == 0)
			{
				curLevel = "0_0";
			}
			else
			{
				curLevelInfo = levelList[Math.floor(Math.random() * levelList.length)];
				curLevel = curLevelInfo.name;
			}
			
			return curLevel;
		}
		
		public function resetDoubleLevel() : void
		{
			level = getLevel();
		}
	}
}
package com.game.data.LevelSelect
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;

	public class AutoFightInfo
	{
		private var _anti:Antiwear;
		
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
		
		public function get fightNum() : int
		{
			return _anti["fightNum"];
		}
		public function set fightNum(value:int) : void
		{
			_anti["fightNum"] = value;
		}
		
		public function AutoFightInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["time"] = "";
			_anti["startTime"] = "";
			_anti["fightNum"] = 0;
		}
		
		public function init(data:XML) : void
		{
			time = data.time;
			startTime = data.startTime;
			fightNum = 0;
		}
		
		public function getXML() : XML
		{
			var info:XML = <autoFight></autoFight>;
			info.appendChild(<time>{time}</time>);
			info.appendChild(<startTime>{startTime}</startTime>);
			info.appendChild(<fightNum>{fightNum}</fightNum>);
			
			return info;
		}
		
		public function initInfo() : void
		{
			time = Data.instance.time.curTimeStr;
			startTime = "";
			fightNum = 0;
		}
	}
}
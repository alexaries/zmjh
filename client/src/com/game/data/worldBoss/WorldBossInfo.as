package com.game.data.worldBoss
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;

	public class WorldBossInfo
	{
		public static const STARTTIME:String = "2013-08-01 0:0:0";
		private var _anti:Antiwear;
		
		public function get time() : String
		{
			return _anti["time"];
		}
		public function set time(value:String) : void
		{
			_anti["time"] = value;
		}
		public function get isComplete() : int
		{
			return _anti["isComplete"];
		}
		public function set isComplete(value:int) : void
		{
			_anti["isComplete"] = value;
		}
		public function get fightHurt() : int
		{
			return _anti["fightHurt"];
		}
		public function set fightHurt(value:int) : void
		{
			_anti["fightHurt"] = value;
		}
		public function get getReward() : int
		{
			return _anti["getReward"];
		}
		public function set getReward(value:int) : void
		{
			_anti["getReward"] = value;
		}
		public function get fightTime() : int
		{
			return _anti["fightTime"];
		}
		public function set fightTime(value:int) : void
		{
			_anti["fightTime"] = value;
		}
		
		public function WorldBossInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["time"] = "";
			_anti["isComplete"] = 0;
			_anti["fightHurt"] = 0;
			_anti["getReward"] = 0;
			_anti["fightTime"] = 0;
		}
		
		public function init(data:XML) : void
		{
			time = data.time;
			isComplete = int(data.isComplete);
			fightHurt = int(data.fightHurt);
			getReward = int(data.getReward);
			fightTime = int(data.fightTime);
		}
		
		public function getXML() : XML
		{
			var item:XML;
			var info:XML = <worldBoss></worldBoss>;
			info.appendChild(<time>{time}</time>);
			info.appendChild(<isComplete>{isComplete}</isComplete>);
			info.appendChild(<fightHurt>{fightHurt}</fightHurt>);
			info.appendChild(<getReward>{getReward}</getReward>);
			info.appendChild(<fightTime>{fightTime}</fightTime>);
			
			return info;
		}
		
		public function firstEnter() : void
		{
			_anti["time"] = Data.instance.time.curTimeStr;
			_anti["isComplete"] = 0;
			_anti["fightHurt"] = 0;
			_anti["getReward"] = 0;
			_anti["fightTime"] = 0;
		}
		
		public function checkDate() : Boolean
		{
			var result:Boolean = Data.instance.time.checkTwoDay(STARTTIME, time);
			return result;
		}
	}
}
package com.game.data.playerFight
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.data.DataList;
	import com.game.data.player.structure.Player;

	public class PlayerFightInfo
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
		
		public function get fightTime() : int
		{
			return _anti["fightTime"];
		}
		public function set fightTime(value:int) : void
		{
			_anti["fightTime"] = value;
		}
		
		public function get rewardTime() : String
		{
			return _anti["rewardTime"];
		}
		public function set rewardTime(value:String) : void
		{
			_anti["rewardTime"] = value;
		}
		
		public function get getReward() : int
		{
			return _anti["getReward"];
		}
		public function set getReward(value:int) : void
		{
			_anti["getReward"] = value;
		}
		
		public function PlayerFightInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["time"] = "";
			_anti["fightTime"] = 0;
			_anti["rewardTime"] = "";
			_anti["getReward"] = 0;
		}
		
		public function init(data:XML) : void
		{
			time = data.time;
			fightTime = int(data.fightTime);
			rewardTime = data.rewardTime;
			getReward = int(data.getReward);
		}
		
		public function getXML() : XML
		{
			var item:XML;
			var info:XML = <playerFight></playerFight>;
			info.appendChild(<time>{time}</time>);
			info.appendChild(<fightTime>{fightTime}</fightTime>);
			info.appendChild(<rewardTime>{rewardTime}</rewardTime>);
			info.appendChild(<getReward>{getReward}</getReward>);
			
			return info;
		}
		
		public function firstEnter() : void
		{
			_anti["time"] = Data.instance.time.curTimeStr;
			_anti["fightTime"] = 0;
			_anti["rewardTime"] = Data.instance.time.curTimeStr;
			_anti["getReward"] = 0;
		}
		
		public function checkCanFight() : Boolean
		{
			var result:Boolean = true;
			
			var startDate:Date = setDate(Data.instance.time.analysisTime(time));
			if((Data.instance.time.returnTimeNow().time - startDate.time) > 15 * 60 * 1000 && fightTime < 10)
				result = true;
			else 
				result = false;
			
			if(fightTime == 0) 
				result = true;
			
			return result;
		}
		
		private function setDate(lastTime:Array) : Date
		{
			var startDate:Date = new Date(lastTime[0], (int(lastTime[1]) - 1), lastTime[2], lastTime[3], lastTime[4], lastTime[5]);
			return startDate;
		}
		
		/**
		 * 检测竞技场每日是否达到4次
		 * @return 
		 * 
		 */		
		public function checkPlayerTime() : Boolean
		{
			var result:Boolean = false;
			
			if(fightTime >= DataList.list[4])
				result = true;
			
			return result;
		}
		
	}
}
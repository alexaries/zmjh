package com.game.data.daily
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.View;

	public class DailyThingInfo
	{
		private var _anti:Antiwear;
		public function get completeStatus() : Array
		{
			return _anti["completeStatus"];
		}
		public function set completeStatus(value:Array) : void
		{
			_anti["completeStatus"] = value;
		}
		
		public function get time() : String
		{
			return _anti["time"];
		}
		public function set time(value:String) : void
		{
			_anti["time"] = value;
		}
		
		public function get getRewardStatus() : Array
		{
			return _anti["getRewardStatus"];
		}
		
		public function set getRewardStatus(value:Array) : void
		{
			_anti["getRewardStatus"] = value;
		}
		
		public var littleCompleteTime:Array = [1,1,1,1,1,3,1,1,1,4,3];
		public var completeTime:Array = [1,1,1,1,1,4,1,1,1,4,3];
		
		public function DailyThingInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["completeStatus"] = new Array();
			_anti["getRewardStatus"] = new Array();
			_anti["time"] = "";
		}
		
		public function init(data:XML) : void
		{
			time = data.time;
			completeStatus = analysisData(data.complete);
			getRewardStatus = analysisData(data.reward);
		}
		
		private function analysisData(str:String) : Array
		{
			var result:Array = new Array();
			if(str == "")
				result = [0,0,0,0,0,0,0,0,0,0,0];
			else
				result = str.split("|");
			
			return result;
		}
		
		public function getXML() : XML
		{
			var info:XML = <dailyThing></dailyThing>;
			info.appendChild(<time>{time}</time>);
			info.appendChild(<complete>{getCompleteData(completeStatus)}</complete>);
			info.appendChild(<reward>{getCompleteData(getRewardStatus)}</reward>);

			return info;
		}
		
		private function getCompleteData(inputList:Array) : String
		{
			var result:String = "";
			for each(var count:int in inputList)
			{
				if(result != "") result += "|";
				result += count;
			}
			return result;
		}
		
		public function initInfo() : void
		{
			time = Data.instance.time.curTimeStr;
			completeStatus = [0,0,0,0,0,0,0,0,0,0,0];
			getRewardStatus = [0,0,0,0,0,0,0,0,0,0,0];
		}
		
		/**
		 * 设置任务完成
		 * @param count
		 * 
		 */		
		public function setThingComplete(count:int) : void
		{
			var list:Array = completeStatus;
			list[count - 1] = 1;
			completeStatus = list;
			View.instance.toolbar.checkDailyWork();
		}
		
		/**
		 * 设置奖励领取
		 * @param count
		 * 
		 */		
		public function setRewardComplete(count:int) : void
		{
			var list:Array = getRewardStatus;
			list[count - 1] = 1;
			getRewardStatus = list;
			View.instance.toolbar.checkDailyWork();
		}
		
		/**
		 * 酒色财气
		 * 
		 */		
		public function checkPlugin() : int
		{
			var list:Array = Data.instance.player.player.pluginGameInfo.checkIsComplete();
			if(list[0])
				setThingComplete(6);
			
			return list[1];
		}
		
		/**
		 * 竞技场
		 * 
		 */		
		public function checkPlayerFight() : void
		{
			if(Data.instance.player.player.playerFightInfo.checkPlayerTime())
				setThingComplete(10);
		}
		
		/**
		 * 每日任务
		 * 
		 */		
		public function checkDailyTask() : int
		{
			var list:Array = Data.instance.player.player.missonInfo.checkIsComplete();
			if(list[0])
				setThingComplete(11);
			
			return list[1]
		}
		
		/**
		 * 是否有完成但未领取的奖励
		 * @return 
		 * 
		 */		
		public function checkIsComplete() : Boolean
		{
			var result:Boolean = false;
			for(var i:int = 0; i < completeStatus.length; i++)
			{
				if(getRewardStatus[i] == 0)
				{
					result = true;
					break;
				}
			}
			
			return result;
		}
		
	}
}
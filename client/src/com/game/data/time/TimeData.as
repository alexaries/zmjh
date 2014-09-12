package com.game.data.time
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.engine.net.Http;
	import com.game.View;
	import com.game.data.Base;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.SignInInfo;
	import com.game.manager.DebugManager;
	import com.game.manager.URIManager;
	import com.game.template.GameConfig;
	import com.game.template.V;
	
	import flash.utils.getTimer;

	public class TimeData extends Base
	{
		private var _anti:Antiwear;
		/**
		 * 最大签到时间 
		 */		
		public static const MAX_SIGN_DAY:int = 5;
		
		private var _http:Http;
		// 当前时间
		private var _curTime:Array = [];
		// 年-月-日
		//private var _ymd:String;
		private function get ymd() : String
		{
			return _anti["ymd"];
		}
		private function set ymd(value:String) : void
		{
			_anti["ymd"] = value;
		}
		// 时-分-秒
		private var _hms:String;
		// 时间差
		private var _disTime:int;
		
		// 当前时间
		public function get curTimeStr() : String
		{
			return _anti["curTimeStr"];
		}
		public function set curTimeStr(value:String) : void
		{
			_anti["curTimeStr"] = value;
		}
		private var _serverDate:Date;
		public function get serverDate() : Date
		{
			return _serverDate;
		}
		//private var _curTimeList:Array;
		private function get curTimeList() : Array
		{
			return _anti["curTimeList"];
		}
		private function set curTimeList(value:Array) : void
		{
			_anti["curTimeList"] = value;
		}
		
		private function get timeNowStr() : String
		{
			return _anti["timeNowStr"];
		}
		private function set timeNowStr(value:String) : void
		{
			_anti["timeNowStr"] = value;
		}
		
		/**
		 * 获取服务器时间 
		 */		
		private var _isGetTime:Boolean;
		public function get isGetTime() : Boolean
		{
			return _isGetTime;
		}
		
		public function TimeData()
		{
			//_ymd = '';
			_hms = '';
			
			_isGetTime = false;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["curTimeStr"] = "";
			_anti["ymd"] = "";
			_anti["timeNowStr"] = "";
			_anti["curTimeList"] = new Array();
		}
		
		/**
		 * 请求时间 
		 * @param callback
		 * 
		 */		
		public function reqTime(callback:Function = null) : void
		{
			if (!_http) _http = new Http();
			_http.onComplete = function (data:String) : void
			{
				Log.Trace("服务器时间:" + data);
				_isGetTime = true;
				View.instance.loadData.hide();
				
				var info:Object = JSON.parse(data);
				var timeData:Array = new Array();

				curTimeStr = info["time"];
				timeData = info["time"].split(" ");
				
				/*curTimeStr = "2013-09-30 15:59:45";
				timeData = curTimeStr.split(" ");*/
				
				ymd = timeData[0];
				_hms = timeData[1];
				
				_curTime = ymd.split("-");
				
				curTimeList = analysisTime(curTimeStr);
				_serverDate = new Date(curTimeList[0], (int(curTimeList[1]) - 1), curTimeList[2], curTimeList[3], curTimeList[4], curTimeList[5]);
				
				trace("服务器时间:" + data);
				if (callback != null) callback();
			};
			_http.loads(URIManager.timeURL);
		}
		
		/**
		 * 检测当前可签到日期 
		 * @param lastDay 上次签到时间
		 * @return -1:已经签到过了
		 * 
		 */		
		public function checkDailyDay(signInInfo:SignInInfo) : int
		{
			var day:int = -1;
			var lastDay:String = signInInfo.lastDay.split(" ")[0];

			var disTime:Number = disDayNum(lastDay, ymd);
			
			// 当天签到过了
			if (disTime == 0)
			{
				return day;	
			}
			
			// 如果一天没来签到，则扣除一天的累积值
			day = signInInfo.duration - (disTime==1?0:disTime);
			
			if (day < 0) day = 0;
			
			day = day + 1;
			
			if (day > MAX_SIGN_DAY) day = MAX_SIGN_DAY;
			
			return day;
		}
		
		/**
		 * 检测是否可以进入每日插件游戏 
		 * @param lastDay
		 * @return 
		 * 
		 */		
		public function checkEveryDayPlay(lastDay:String) : Boolean
		{
			var lastDay:String = lastDay.split(" ")[0];
			var disTime:int = disDayNum(lastDay, ymd);
			
			var bol:Boolean = (disTime != 0);
			
			return bol;
		}
		
		public function checkTwoDay(lastDay:String, startDay:String) : Boolean
		{
			var lastDay:String = lastDay.split(" ")[0];
			var startDay:String = startDay.split(" ")[0];
			var disTime:int = disDayNum(lastDay, startDay);
			
			var result:Boolean;
			if(disTime % 2 == 0)
				result = true;
			else
				result = false;
			
			if(disTime == 0)
				result = false;
			return result;
		}
		
		
		/**
		 * 相差天数 
		 * @return 
		 * 
		 */		
		public function disDayNum(lastDay:String, newYMD:String) : Number
		{
			lastDay = lastDay.replace("-", "");
			lastDay = lastDay.replace("-", "");
			
			newYMD = newYMD.replace("-", "");
			newYMD = newYMD.replace("-", "");
			
			var disTime:Number = DateUtil.manyDayNum(lastDay, newYMD);
			
			Log.Trace("disTime: " + disTime);
			
			return disTime;
		}
		
		
		public function formatTime(count:int) : String
		{
			var result:String = "";
			var second:int = count % 60;
			var minute:int = count / 60;
			var hour:int = count / 3600;
			result = hour + ":" + minute + ":" + second;
			return result;
		}
		
		public function analysisTime(time:String) : Array
		{
			var timeList:Array = time.split(" ");
			var yearList:Array = timeList[0].split("-");
			var dayList:Array = timeList[1].split(":")
			var lastTime:Array = new Array();
			for(var i:int = 0; i < yearList.length; i++)
			{
				lastTime.push(yearList[i]);
			}
			for(var j:int = 0; j < dayList.length; j++)
			{
				lastTime.push(dayList[j]);
			}
			return lastTime;
		}
		
		public function returnTimeNow() : Date
		{
			if(curTimeList == null)
			{
				curTimeList = analysisTime(curTimeStr);
				_serverDate = new Date(curTimeList[0], (int(curTimeList[1]) - 1), curTimeList[2], curTimeList[3], curTimeList[4], curTimeList[5]);
			}
			var newDate:Date = new Date(curTimeList[0], (int(curTimeList[1]) - 1), curTimeList[2], curTimeList[3], curTimeList[4], curTimeList[5]);
			newDate.milliseconds += getTimer();
			
			return newDate;
		}
		
		public function returnTimeNowStr() : String
		{
			var nowDate:Date = returnTimeNow();
			timeNowStr = nowDate.fullYear + "-" + addPre(nowDate.month + 1) + "-" + nowDate.date + " " + nowDate.hours + ":" + nowDate.minutes + ":" + nowDate.seconds;
			return timeNowStr;
		}
		
		public function returnInputTimeStr(nowDate:Date) : String
		{
			var str:String =  nowDate.fullYear + "-" + addPre(nowDate.month + 1) + "-" + nowDate.date + " " + nowDate.hours + ":" + nowDate.minutes + ":" + nowDate.seconds;
			return str;
		}
		
		private function addPre(count:Number) : String
		{
			var result:String = "";
			if(count < 10)
				result = "0" + count;
			else
				result = count.toString();
			
			return result
		}
		
		public function setDate(time:String) : Date
		{
			var lastTime:Array = analysisTime(time);
			var startDate:Date = new Date(lastTime[0], (int(lastTime[1]) - 1), lastTime[2], lastTime[3], lastTime[4], lastTime[5]);
			return startDate;
		}
	}
}
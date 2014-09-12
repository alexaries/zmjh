package com.game.data.time
{
	import com.game.Data;
	import com.game.data.DataList;
	
	import starling.display.DisplayObject;
	import starling.filters.GrayscaleFilter;

	public class ActivityTimeData
	{
		private static var _data:Data = Data.instance;
		
		public function ActivityTimeData()
		{
			
		}
		
		/**
		 * 判断活动是否还在日期之内
		 * @param startTime		开始日期 —— 如：“2013-10-01”
		 * @param duration		结束日期 —— 如：“2013-10-07”
		 * @param startHour		开始日期具体到小时 —— 如：“16”代表从2013-10-01号16点开始
		 * @param endHour		结束日期具体到小时 —— 如：“16”代表到2013-10-07号16点结束
		 * return				返回当前是否还在活动日期内 —— -1：活动还未开始，0：活动正在进行，1：活动已经结束
		 * 
		 */		
		public static function renderButtonShow(startTime:String, endTime:String, startHour:int = 0, endHour:int = 24) : int
		{
			var result:int = -1;
			var date:Date = _data.time.returnTimeNow();
			var maxTime:int = _data.time.disDayNum(startTime, endTime);
			var intervalTime:int = _data.time.disDayNum(startTime, _data.time.curTimeStr.split(" ")[0]);
			if(intervalTime >= 0 && intervalTime <= maxTime)
			{
				if(intervalTime == 0 && date.hours < startHour)
					result = -1;
				else if(intervalTime == maxTime && date.hours >= endHour)
					result = 1;
				else
					result = 0;
			}
			else if(intervalTime < 0)
				result = -1;
			else 
				result = 1;
			
			return result;
		}
		
	}
}
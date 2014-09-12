package com.game.data.shop
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.data.DataList;

	public class VIPInfo
	{
		private var _anti:Antiwear;
		private function get list() : Vector.<int>
		{
			return DataList.list;
		}
		public function get levelList() : Array
		{
			if(_anti["levelList"] == null)
			{
				_anti["levelList"] = [list[1], list[5], list[10], list[20], list[50]];
			}
			return _anti["levelList"];
		}
		
		public function get time() : String
		{
			return _anti["time"];
		}
		public function set time(value:String) : void
		{
			_anti["time"] = value;
		}
		public function get alreadyGet() : int
		{
			return _anti["alreadyGet"];
		}
		public function set alreadyGet(value:int) : void
		{
			_anti["alreadyGet"] = value;
		}
		
		public function get nowVIPLevel() : int
		{
			return _anti["nowVIPLevel"];
		}
		public function set nowVIPLevel(value:int) : void
		{
			_anti["nowVIPLevel"] = value;
		}
		
		public function get nowRecharged() : int
		{
			return _anti["nowRecharged"];
		}
		public function set nowRecharged(value:int) : void
		{
			_anti["nowRecharged"] = value;
			setVIPLevel();
		}
		
		public function VIPInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["nowVIPLevel"] = 0;
			_anti["nowRecharged"] = 0;
			_anti["time"] = "";
			_anti["alreadyGet"] = 0;
		}
		
		public function init(data:XML) : void
		{
			nowVIPLevel = data.nowVIPLevel;
			nowRecharged = data.nowRecharged;
			time = data.time;
			alreadyGet = data.alreadyGet;
		}
		
		public function getXML() : XML
		{
			var info:XML = <vip></vip>;
			info.appendChild(<nowVIPLevel>{nowVIPLevel}</nowVIPLevel>);
			info.appendChild(<nowRecharged>{nowRecharged}</nowRecharged>);
			info.appendChild(<time>{time}</time>);
			info.appendChild(<alreadyGet>{alreadyGet}</alreadyGet>);
			
			return info;
		}
		
		public function setVIPLevel() : void
		{
			if(nowRecharged < levelList[0] * DataList.list[1000])
				nowVIPLevel = list[0];
			else if(nowRecharged >= levelList[0] * DataList.list[1000] && nowRecharged < levelList[1] * DataList.list[1000])
				nowVIPLevel = list[1];
			else if(nowRecharged >= levelList[1] * DataList.list[1000] && nowRecharged < levelList[2] * DataList.list[1000])
				nowVIPLevel = list[2];
			else if(nowRecharged >= levelList[2] * DataList.list[1000] && nowRecharged < levelList[3] * DataList.list[1000])
				nowVIPLevel = list[3];
			else if(nowRecharged >= levelList[3] * DataList.list[1000] && nowRecharged < levelList[4] * DataList.list[1000])
				nowVIPLevel = list[4];
			else if(nowRecharged >= levelList[4] * DataList.list[1000])
				nowVIPLevel = list[5];
		}
		
		public function checkRPUp(rate:Number) : Number
		{
			var result:Number = rate;
			if(rate != 0)
			{
				if(nowVIPLevel >= DataList.list[1])
				{
					result += DataList.littleList[3];
				}
			}
			return result;
		}
		
		public function checkDoubleExp(input:int) : int
		{
			var result:int = 0;
			
			if(checkLevelTwo())
				result = input;
			
			return result;
		}
		
		public function checkLevelOne() : Boolean
		{
			if(nowVIPLevel >= DataList.list[1])
				return true;
			return false;
		}
		
		public function checkLevelTwo() : Boolean
		{
			if(nowVIPLevel >= DataList.list[2])
				return true;
			return false;
		}
		
		public function checkLevelThree() : Boolean
		{
			if(nowVIPLevel >= DataList.list[3])
				return true;
			return false;
		}
		
		public function checkLevelFour() : Boolean
		{
			if(nowVIPLevel >= DataList.list[4])
				return true;
			return false;
		}
		
		public function checkLevelFive() : Boolean
		{
			if(nowVIPLevel >= DataList.list[5])
				return true;
			return false;
		}
		
		public function checkAlreadyGet() : Boolean
		{
			var resutl:Boolean = (alreadyGet >= 1?false:true);
			return resutl;
		}
		
		
		public function initInfo() : void
		{
			time = Data.instance.time.curTimeStr;
			alreadyGet = 0;
		}
	}
}
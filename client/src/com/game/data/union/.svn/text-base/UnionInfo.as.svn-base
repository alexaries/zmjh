package com.game.data.union
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;

	public class UnionInfo
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
		
		public function get completeList() : Array
		{
			return _anti["completeList"];
		}
		public function set completeList(value:Array) : void
		{
			_anti["completeList"] = value;
		}
		
		public function UnionInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["time"] = "";
			_anti["completeList"] = [];
		}
		
		public function init(data:XML) : void
		{
			time = data.time;
			completeList = analysisComplete(data.complete);
		}
		
		private function analysisComplete(str:String) : Array
		{
			var resultList:Array = new Array();
			
			resultList = str.split("|");
			
			if(resultList.length < 9)
				resultList = [0,0,0,0,0,0,0,0,0];
			
			return resultList;
		}
		
		public function getXML() : XML
		{
			var info:XML = <union></union>;
			info.appendChild(<time>{time}</time>);
			info.appendChild(<complete>{getComplete()}</complete>);
			
			return info;
		}
		
		private function getComplete() : String
		{
			var result:String = "";
			for(var i:int = 0; i < completeList.length; i++)
			{
				if(i != 0) result += "|";
				result += completeList[i];
			}
			
			return result;
		}
		
		public function setComplete(type:int, count:int) : void
		{
			var resultList:Array = completeList;
			resultList[(type - 1) * 3 + (count - 1)] = 1;
			completeList = resultList;
		}
		
		public function initInfo() : void
		{
			time = Data.instance.time.curTimeStr;
			completeList = [0,0,0,0,0,0,0,0,0];
		}
		
		public function canFight() : int
		{
			for(var i:int = 8; i >= 0; i--)
			{
				if(completeList[i] == 1)
					break;
			}
			
			return (i + 1);
		}
	}
}
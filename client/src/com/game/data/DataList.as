package com.game.data
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class DataList
	{
		public function DataList()
		{
			
		}
		
		private static var _anti:Antiwear;
		
		public static function get list() : Vector.<int>
		{
			if(_anti == null)
				_anti = new Antiwear(new binaryEncrypt());
			if(_anti["list"] == null)
				_anti["list"] = getList();
			
			return _anti["list"];
		}
		private static function getList() : Vector.<int>
		{
			var resultList:Vector.<int> = new Vector.<int>();
			for(var i:int = 0; i <= 1000; i++)
			{
				resultList.push(i);
			}
			return resultList;
		}
		
		public static function get littleList() : Vector.<Number>
		{
			if(_anti == null)
				_anti = new Antiwear(new binaryEncrypt());
			if(_anti["littleList"] == null)
				_anti["littleList"] = getLittleList();
			
			return _anti["littleList"];
		}
		private static function getLittleList() : Vector.<Number>
		{
			var resultList:Vector.<Number> = new Vector.<Number>();
			for(var i:int = 0; i <= 100; i++)
			{
				resultList.push(i * .01);
			}
			return resultList;
		}
			
	}
}
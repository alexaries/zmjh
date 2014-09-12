package com.game.data.start
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.data.Base;

	public class StartData extends Base
	{	
		private static var _anti:Antiwear;
		private static var _allData:Vector.<int>;
		public static function get allData() : Vector.<int>
		{
			return _allData;
		}
		
		public function StartData()
		{
			
		}
		
		public static function initData() : void
		{
			_anti = new Antiwear(new binaryEncrypt());
			_allData = new Vector.<int>();
			
			for(var i:int = 0; i <= 1000; i++)
			{
				_anti["StartData_" + i] = i;
				_allData.push(_anti["StartData_" + i]);
			}
		}
	}
}
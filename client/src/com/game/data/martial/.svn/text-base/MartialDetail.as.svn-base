package com.game.data.martial
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class MartialDetail
	{
		private var _anti:Antiwear;
		
		public function get name() : String
		{
			return _anti["name"];
		}
		
		public function set name(value:String) : void
		{
			_anti["name"] = value;
		}
		
		public function get startTime() : String
		{
			return _anti["startTime"];
		}
		public function set startTime(value:String) : void
		{
			_anti["startTime"] = value;
		}
		
		public function get duration() : int
		{
			return _anti["duration"];
		}
		public function set duration(value:int) : void
		{
			_anti["duration"] = value;
		}
		
		public function MartialDetail()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["name"] = '';
			_anti["startTime"] = '';
			_anti["duration"] = 0;
		}
	}
}
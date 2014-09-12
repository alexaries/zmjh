package com.game.data.Activity
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class ActivityDetail
	{
		private var _anti:Antiwear;
		
		public function get id() : int
		{
			return _anti["id"];
		}
		
		public function set id(value:int) : void
		{
			_anti["id"] = value;
		}
		
		public function get activityName() : String
		{
			return _anti["activityName"];
		}
		public function set activityName(value:String) : void
		{
			_anti["activityName"] = value;
		}
		
		public function get alreadyGet() : String
		{
			return _anti["alreadyGet"];
		}
		public function set alreadyGet(value:String) : void
		{
			_anti["alreadyGet"] = value;
		}
		
		public function get time() : String
		{
			return _anti["time"];
		}
		public function set time(value:String) : void
		{
			_anti["time"] = value;
		}
		
		public function ActivityDetail()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["id"] = 0;
			_anti["activityName"] = '';
			_anti["alreadyGet"] = '';
			_anti["time"] = '';
		}
	}
}
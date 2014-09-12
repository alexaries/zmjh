package com.game.data.online
{
	import com.edgarcai.gamelogic.Antiwear;

	public class OnlineTimeDetail
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
		
		public function get alreadyGet() : int
		{
			return _anti["alreadyGet"];
		}
		
		public function set alreadyGet(value:int) : void
		{
			_anti["alreadyGet"] = value;
		}
		
		public function OnlineTimeDetail()
		{
		}
	}
}
package com.game.data.player
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class GlowingDetail
	{
		private var _anti:Antiwear;
		
		public function get glowingTime() : String
		{
			return _anti["glowingTime"];
		}
		
		public function set glowingTime(value:String) : void
		{
			_anti["glowingTime"] = value;
		}
		
		public function get startName() : String
		{
			return _anti["startName"];
		}
		public function set startName(value:String) : void
		{
			_anti["startName"] = value;
		}
		
		public function get endName() : String
		{
			return _anti["endName"];
		}
		public function set endName(value:String) : void
		{
			_anti["endName"] = value;
		}
		
		public function GlowingDetail()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["glowingTime"] = '';
			_anti["startName"] = '';
			_anti["endName"] = '';
		}
	}
}
package com.game.data.strength
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class StrengthDetail
	{
		private var _anti:Antiwear;
		
		public function get ats_exp() : int
		{
			return _anti["ats_exp"];
		}
		public function set ats_exp(value:int) : void
		{
			_anti["ats_exp"] = value;
		}
		
		public function get adf_exp() : int
		{
			return _anti["adf_exp"];
		}
		public function set adf_exp(value:int) : void
		{
			_anti["adf_exp"] = value;
		}
		
		public function get ats() : int
		{
			return _anti["ats"];
		}
		public function set ats(value:int) : void
		{
			_anti["ats"] = value;
		}
		
		public function get adf() : int
		{
			return _anti["adf"];
		}
		public function set adf(value:int) : void
		{
			_anti["adf"] = value;
		}
		
		public function StrengthDetail()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["ats_exp"] = 0;
			_anti["adf_exp"] = 0;
			_anti["ats"] = 0;
			_anti["adf"] = 0;
		}
	}
}
package com.game.data.role
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class RoleFashionDetail
	{
		private var _anti:Antiwear;
		
		public function get owner() : String
		{
			return _anti["owner"];
		}
		public function set owner(value:String) : void
		{
			_anti["owner"] = value;
		}
		
		public function get type() : String
		{
			return _anti["type"];
		}
		public function set type(value:String) : void
		{
			_anti["type"] = value;
		}
		
		public function get getTime() : String
		{
			return _anti["getTime"];
		}
		public function set getTime(value:String) : void
		{
			_anti["getTime"] = value;
		}
		
		public function get isUse() : int
		{
			return _anti["isUse"];
		}
		public function set isUse(value:int) : void
		{
			_anti["isUse"] = value;
		}
		
		
		public function RoleFashionDetail()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["owner"] = "";
			_anti["type"] = "";
			_anti["getTime"] = "";
			_anti["isUse"] = 0;
		}
	}
}
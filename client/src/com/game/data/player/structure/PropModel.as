package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.data.db.protocal.Prop;

	public class PropModel
	{
		private var _anti:Antiwear;	
		public var config:Prop;
		
		//public var id:int;
		public function get id() : int
		{
			return 	_anti["id"];
		}
		public function set id(value:int) : void
		{
			_anti["id"] = value;
		}
		
		//public var num:int;
		public function get num() : int
		{
			return 	_anti["num"];
		}
		public function set num(value:int) : void
		{
			_anti["num"] = value;
		}
		
		public function get name() : String
		{
			return _anti["name"];
		}
		
		public function set name(value:String) : void
		{
			_anti["name"] = value;
		}
		
		public var isNew:Boolean;
		
		public function PropModel()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			id = 0;
			num = 0;
			name = "";
			
			isNew = false;
		}
	}
}
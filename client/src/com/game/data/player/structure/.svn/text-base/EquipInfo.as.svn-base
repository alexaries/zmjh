package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.data.equip.EquipUtilies;

	public class EquipInfo
	{
		private var _anti:Antiwear;
		
		/**
		 * 武器 
		 */		
		//public var weapon:int;
		public function get weapon() : int
		{
			return 	_anti["weapon"];
		}
		public function set weapon(value:int) : void
		{
			_anti["weapon"] = value;
		}
		
		/**
		 * 服饰 
		 */		
		//public var cloth:int;
		public function get cloth() : int
		{
			return 	_anti["cloth"];
		}
		public function set cloth(value:int) : void
		{
			_anti["cloth"] = value;
		}
		
		/**
		 * 饰品 
		 */		
		//public var thing:int;
		public function get thing() : int
		{
			return 	_anti["thing"];
		}
		public function set thing(value:int) : void
		{
			_anti["thing"] = value;
		}
		
		public function EquipInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["weapon"] = -1;
			_anti["cloth"] = -1;
			_anti["thing"] = -1;
		}
	}
}
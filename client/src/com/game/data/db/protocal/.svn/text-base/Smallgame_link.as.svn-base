package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	
	public class Smallgame_link
	{
		private var _anti:Antiwear;
		
		/**
		 * 
		 */
		public var id:int;
		
		
		/**
		 * 
		 */
		public function get item() : String
		{
			return _anti["item"];
		}
		public function set item(value:String) : void
		{
			_anti["item"] = value;
		}
		
		
		/**
		 * 
		 */
		public function get number() : int
		{
			return _anti["number"];
		}
		public function set number(value:int) : void
		{
			_anti["number"] = value;
		}
		
		public function Smallgame_link()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			
			_anti["item"] = "";
			
			
			_anti["number"] = 0;
		}
		
		public function assign(data:XML) : void
		{
			
			
			id = data.@id
			
			
			item = data.@item
			
			
			number = data.@number
			
		}
		
		public function copy() : Smallgame_link
		{
			var target:Smallgame_link = new Smallgame_link();
			
			
			target.id = this.id;
			
			
			target.item = this.item;
			
			
			target.number = this.number;
			
			
			return target;
		}
	}
}
package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Online_bonus extends Object
	{
		private var _anti:Antiwear;
		
		/**
		 * 
		 */
		public var id:int;
		
		/**
		 * 
		 */
		public function get time() : int
		{
			return _anti["time"];
		}
		public function set time(value:int) : void
		{
			_anti["time"] = value;
		}
		
		/**
		 * 
		 */
		public function get dice() : int
		{
			return _anti["dice"];
		}
		public function set dice(value:int) : void
		{
			_anti["dice"] = value;
		}
		
		/**
		 * 
		 */
		public function get prop_id() : String
		{
			return _anti["prop_id"];
		}
		public function set prop_id(value:String) : void
		{
			_anti["prop_id"] = value;
		}
		
		/**
		 * 
		 */
		public function get number() : String
		{
			return _anti["number"];
		}
		public function set number(value:String) : void
		{
			_anti["number"] = value;
		}
		
		public function Online_bonus()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			
			_anti["time"] = 0;
			
			
			_anti["dice"] = 0;
			
			
			_anti["prop_id"] = "";
			
			
			_anti["number"] = "";
			
		}
		
		public function assign(data:XML) : void
		{
			
			id = data.@id
			
			
			time = data.@time
			
			
			dice = data.@dice
			
			
			prop_id = data.@prop_id
			
			
			number = data.@number
			
		}
		
		public function copy() : Online_bonus
		{
			var target:Online_bonus = new Online_bonus();
			
			
			target.id = this.id;
			
			
			target.time = this.time;
			
			
			target.dice = this.dice;
			
			
			target.prop_id = this.prop_id;
			
			
			target.number = this.number;
			
			
			return target;
		}
	}
}
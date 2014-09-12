package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Fragment extends Object
	{
		private var _anti:Antiwear;
		
		
		
		/**
		 * 
		 */
		public var id:int;
		
		
		/**
		 * 
		 */
		public function get name() : String
		{
			return _anti["name"];
		}
		public function set name(value:String) : void
		{
			_anti["name"] = value;
		}
		
		/**
		 * 
		 */
		public function get use_value() : int
		{
			return _anti["use_value"];
		}
		public function set use_value(value:int) : void
		{
			_anti["use_value"] = value;
		}
		
		/**
		 * 
		 */
		public function get add_value() : int
		{
			return _anti["add_value"];
		}
		public function set add_value(value:int) : void
		{
			_anti["add_value"] = value;
		}
		
		public function Fragment()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			
			_anti["name"] = "";
			
			
			_anti["use_value"] = 0;
			
			
			_anti["add_value"] = 0;
		}
		
		public function assign(data:XML) : void
		{
			
			id = data.@id
			
			
			name = data.@name
			
			
			use_value = data.@use_value
			
			
			add_value = data.@add_value
		}
		
		public function copy() : Fragment
		{
			var target:Fragment = new Fragment();
			
			
			target.id = this.id;
			
			
			target.name = this.name;
			
			
			target.use_value = this.use_value;
			
			
			target.add_value = this.add_value;
			
			
			return target;
		}
	}
}
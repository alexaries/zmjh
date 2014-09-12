package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class SkyEarth
	{
		private var _anti:Antiwear;
		
		public var id:int;
		
		public var level:String;
		
		public var type:int;
		
		
		public function get name() : String
		{
			return _anti["name"];
		}
		public function set name(value:String) : void
		{
			_anti["name"] = value;
		}
		
		public function get lv() : String
		{
			return _anti["lv"];
		}
		public function set lv(value:String) : void
		{
			_anti["lv"] = value;
		}
		
		public function get hp_up() : Number
		{
			return _anti["hp_up"];
		}
		public function set hp_up(value:Number) : void
		{
			_anti["hp_up"] = value;
		}
		
		public function get i_force() : int
		{
			return _anti["i_force"];
		}
		public function set i_force(value:int) : void
		{
			_anti["i_force"] = value;
		}
		
		public function SkyEarth()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["name"] = "";
			_anti["lv"] = "";
			_anti["i_force"] = 0;
		}
		
		public function assign(data:XML) : void
		{
			id = data.@id;
			
			level = data.@level;
			
			type = data.@type;
			
			name = data.@name;
			
			lv = data.@lv;
			
			hp_up = data.@hp_up;
			
			i_force = data.@i_force;
		}
		
		public function copy() : SkyEarth
		{
			var target:SkyEarth = new SkyEarth();
			
			target.id = this.id;
			
			target.level = this.level;
			
			target.type = this.type;
			
			target.name = this.name;
			
			target.lv = this.lv;
			
			target.hp_up = this.hp_up;
			
			target.i_force = this.i_force;
			
			return target;
		}
	}
}
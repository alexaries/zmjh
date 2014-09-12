package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Skill_up
	{
		private var _anti:Antiwear;
		
		public var id:int;
		
		public function get up() : Number
		{
			return _anti["up"];
		}
		public function set up(value:Number) : void
		{
			_anti["up"] = value;
		}
		
		public function get number() : int
		{
			return _anti["number"];
		}
		public function set number(value:int) : void
		{
			_anti["number"] = value;
		}
		
		public function get gold() : int
		{
			return _anti["gold"];
		}
		public function set gold(value:int) : void
		{
			_anti["gold"] = value;
		}
		
		public function Skill_up()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["up"] = 0;
			_anti["number"] = 0;
			_anti["gold"] = 0;
		}
		
		public function assign(data:XML) : void
		{
			id = data.@id;
			up = data.@up;
			number = data.@number;
			gold = data.@gold;
		}
		
		public function copy() : Skill_up
		{
			var target:Skill_up = new Skill_up();
			
			target.id = this.id;
			
			target.up = this.up;
			
			target.number = this.number;
			
			target.gold = this.gold;
			
			return target;
		}
	}
}
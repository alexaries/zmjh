package com.game.data.fight.structure
{
	public class Hurt
	{
		private var _type:String;
		public function get type() : String
		{
			return _type;
		}
		
		private var _value:int;
		public function get value() : int
		{
			return _value;
		}
		
		public function Hurt(type:String, value:int)
		{
			_type = type;
			_value = value;
		}
	}
}
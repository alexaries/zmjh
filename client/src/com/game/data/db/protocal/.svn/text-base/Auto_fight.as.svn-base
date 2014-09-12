package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Auto_fight extends Object
	{
		private var _anti:Antiwear;
		/**
		 * ID
		 * 
		 */		
		public var id:int;
		
		public var level_name:String;
		
		public var difficulty:String;
		
		/**
		 * 战斗次数
		 * @return 
		 * 
		 */		
		public function get fight_count() : int
		{
			return _anti["fight_count"];
		}
		public function set fight_count(value:int) : void
		{
			_anti["fight_count"] = value;
		}
		
		/**
		 * 骰子消耗
		 * @return 
		 * 
		 */		
		public function get dice_count() : int
		{
			return _anti["dice_count"];
		}
		public function set dice_count(value:int) : void
		{
			_anti["dice_count"] = value;
		}
		
		/**
		 * 经验获得
		 * @return 
		 * 
		 */		
		public function get exp() : int
		{
			return _anti["exp"];
		}
		public function set exp(value:int) : void
		{
			_anti["exp"] = value;
		}
		
		public function Auto_fight()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["fight_count"] = 0;
			_anti["dice_count"] = 0;
			_anti["exp"] = 0;
		}
		
		public function assign(data:XML) : void
		{
			id = data.@id;
			
			level_name = data.@level_name;
			
			difficulty = data.@difficulty;
			
			fight_count = data.@fight_count;
			
			dice_count = data.@dice_count;
			
			exp = data.@exp;
		}
		
		public function copy() : Auto_fight
		{
			var target:Auto_fight = new Auto_fight();
			
			target.id = this.id;
			
			target.level_name = this.level_name;
			
			target.difficulty = this.difficulty;
			
			target.fight_count = this.fight_count;
			
			target.dice_count = this.dice_count;
			
			target.exp = this.exp;
			
			return target;
		}
	}
}
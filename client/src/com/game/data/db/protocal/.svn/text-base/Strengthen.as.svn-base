package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Strengthen extends Object
	{
		private var _anti:Antiwear
		
		/**
		 * ID
		 * @return 
		 * 
		 */		
		public var id:int;
		
		/**
		 * 强化等级
		 * @return 
		 * 
		 */		
		public function get strengthen_level() : int
		{
			return _anti["strengthen_level"];
		}
		public function set strengthen_level(value:int) : void
		{
			_anti["strengthen_level"] = value;
		}
		
		/**
		 * 强化成功概率
		 * @return 
		 * 
		 */		
		public function get strengthen_rate() : Number
		{
			return _anti["strengthen_rate"];
		}
		public function set strengthen_rate(value:Number) : void
		{
			_anti["strengthen_rate"] = value;
		}
		
		/**
		 * 强化所需要消耗的石头
		 * @return 
		 * 
		 */		
		public function get strengthen_stone() : int
		{
			return _anti["strengthen_stone"];
		}
		public function set strengthen_stone(value:int) : void
		{
			_anti["strengthen_stone"] = value;
		}
		
		/**
		 * 强化增加的属性
		 * @return 
		 * 
		 */		
		public function get strengthen_add() : Number
		{
			return _anti["strengthen_add"];
		}
		public function set strengthen_add(value:Number) : void
		{
			_anti["strengthen_add"] = value;
		}
		
		/**
		 * 强化需要的金钱
		 * @return 
		 * 
		 */		
		public function get money_add() : Number
		{
			return _anti["money_add"];
		}
		public function set money_add(value:Number) : void
		{
			_anti["money_add"] = value;
		}
		
		/**
		 * 强化失败
		 * @return 
		 * 
		 */		
		public function get failure() : String
		{
			return _anti["failure"];
		}
		public function set failure(value:String) : void
		{
			_anti["failure"] = value;
		}
		
		
		public function Strengthen()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["strengthen_level"] = 0;
			_anti["strengthen_rate"] = 0;
			_anti["strengthen_stone"] = 0;
			_anti["strengthen_add"] = 0;
			_anti["money_add"] = 0;
			_anti["failure"] = "";
		}
		
		public function assign(data:XML) : void
		{
			id = data.@id;
				
			strengthen_level = data.@strengthen_level;
			
			strengthen_rate = data.@strengthen_rate;
			
			strengthen_stone = data.@strengthen_stone;
			
			strengthen_add = data.@strengthen_add;
			
			money_add = data.@money_add;
			
			failure = data.@failure;
		}
		
		public function copy() : Strengthen
		{
			var target:Strengthen = new Strengthen();
			
			target.id = this.id;
			
			target.strengthen_level = this.strengthen_level;
			
			target.strengthen_rate = this.strengthen_rate;
			
			target.strengthen_stone = this.strengthen_stone;
			
			target.strengthen_add = this.strengthen_add;
			
			target.money_add = this.money_add;
			
			target.failure = this.failure;
			
			return target;
		}
	}
}
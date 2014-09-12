package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Special_boss
	{
		private var _anti:Antiwear;
		
		/**
		 * ID
		 * @return 
		 * 
		 */		
		public var id:int;
		
		/**
		 * 特殊Boss名字
		 * @return 
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
		 * 特殊Boss出现概率
		 * @return 
		 * 
		 */		
		public function get boss_rate() : Number
		{
			return _anti["boss_rate"];
		}
		public function set boss_rate(value:Number) : void
		{
			_anti["boss_rate"] = value;
		}
		
		/**
		 * 奖励列表
		 * @return 
		 * 
		 */		
		public var reward:String;
		
		/**
		 * 奖励数量
		 * @return 
		 * 
		 */		
		public var reward_number:String;
		
		/**
		 * 奖励概率
		 * @return 
		 * 
		 */		
		public var reward_rate:String;
		
		public function Special_boss()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["name"] = "";
			
			_anti["boss_rate"] = 0;
		}
		
		public function assign(data:XML) : void
		{
			id = data.@id;
			
			name = data.@name;
			
			boss_rate = data.@boss_rate;
			
			reward = data.@reward;
			
			reward_number = data.@reward_number;
			
			reward_rate = data.@reward_rate;
		}
		
		public function copy() : Special_boss
		{
			var target:Special_boss = new Special_boss();
			
			target.id = this.id;
			
			target.name = this.name;
			
			target.boss_rate = this.boss_rate;
			
			target.reward = this.reward;
			
			target.reward_number = this.reward_number;
			
			target.reward_rate = this.reward_rate;
			
			return target;
		}
	}
}
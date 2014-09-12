package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Real_Boss
	{
		private var _anti:Antiwear;
		
		/**
		 * ID
		 * @return 
		 * 
		 */		
		public var id:int;
		
		/**
		 * 金币
		 * @return 
		 * 
		 */		
		public function get gold() : int
		{
			return _anti["gold"];
		}
		public function set gold(value:int) : void
		{
			_anti["gold"] = value;
		}
		
		/**
		 * 战魂
		 * @return 
		 * 
		 */		
		public function get soul() : int
		{
			return _anti["soul"];
		}
		public function set soul(value:int) : void
		{
			_anti["soul"] = value;
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
		
		public function Real_Boss()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["gold"] = 0;
			_anti["soul"] = 0;
		}
		
		public function assign(data:XML) : void
		{
			id = data.@id;
			gold = data.@gold;
			soul = data.@soul;
			reward = data.@reward;
			reward_number = data.@reward_number;
		}
		
		public function copy() : Real_Boss
		{
			var target:Real_Boss = new Real_Boss();
			
			target.id = this.id;
			
			target.gold = this.gold;
			
			target.soul = this.soul;
			
			target.reward = this.reward;
			
			target.reward_number = this.reward_number;
			
			return target;
		}
	}
}
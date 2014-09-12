package com.game.data.fight.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.data.player.structure.RoleModel;

	public class FightResult
	{
		private var _anti:Antiwear;
		/**
		 *  1->成功； -1->失败
		 */		
		public var result:int;
		/**
		 * 将魂 
		 */		
		//public var soul:int;
		public function get soul() : int
		{
			return _anti["soul"];
		}
		public function set soul(value:int) : void
		{
			_anti["soul"] = value;
		}
		/**
		 * 金钱 
		 */		
		//public var money:int;
		public function get money() : int
		{
			return _anti["money"];
		}
		public function set money(value:int) : void
		{
			_anti["money"] = value;
		}
		/**
		 * 经验 
		 */		
		//public var exp:int;
		public function get exp() : int
		{
			return _anti["exp"];
		}
		public function set exp(value:int) : void
		{
			_anti["exp"] = value;
		}
		
		/**
		 * 收服敌人 
		 */		
		public var sudueEnemy:Vector.<RoleModel>;
		
		public function FightResult()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["soul"] = 0;
			_anti["money"] = 0;
			_anti["exp"] = 0;
			
			sudueEnemy = new Vector.<RoleModel>();
		}
	}
}
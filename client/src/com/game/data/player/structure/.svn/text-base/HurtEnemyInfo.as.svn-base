package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class HurtEnemyInfo
	{
		private var _anti:Antiwear;
		
		/**
		 * 怪物id 
		 * @return 
		 * 
		 */		
		public function get id() : int
		{
			return _anti["id"];
		}
		public function set id(value:int) : void
		{
			_anti["id"] = value;
		}
		
		/**
		 * 数量 
		 * @return 
		 * 
		 */		
		public function get num() : int
		{
			return _anti["num"];
		}
		public function set num(value:int) : void
		{
			if (value < 0) value = 0;
			_anti["num"] = value;
		}
		
		public function HurtEnemyInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["id"] = 0;
			_anti["num"] = 0;
		}
	}
}
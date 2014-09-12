package com.game.data.prop
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class MultiRewardData
	{
		private var _anti:Antiwear;
		
		/**
		 * 持续时间
		 * @return 
		 * 
		 */		
		public function get lastTime() : int
		{
			return _anti["lastTime"];
		}
		public function set lastTime(value:int) : void
		{
			_anti["lastTime"] = value;
		}
		
		/**
		 * N倍
		 * @return 
		 * 
		 */		
		public function get multiTimes() : int
		{
			return _anti["multiTimes"];
		}
		public function set multiTimes(value:int) : void
		{
			_anti["multiTimes"] = value;
		}
		
		/**
		 * 类型——1，2，3——经验，战魂，金币，RP
		 * @return 
		 * 
		 */		
		public function get multiType() : int
		{
			return _anti["multiType"];
		}
		public function set multiType(value:int) : void
		{
			_anti["multiType"] = value;
		}
		
		public function MultiRewardData()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["lastTime"] = 0;
			_anti["multiTimes"] = 0;
			_anti["multiType"] = 0;
		}
	}
}
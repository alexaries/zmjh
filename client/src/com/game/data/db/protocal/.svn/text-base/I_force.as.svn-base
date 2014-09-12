package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class I_force
	{
		private var _anti:Antiwear;
		
		/**
		 * ID
		 * @return 
		 * 
		 */		
		public var id:int;
		
		/**
		 * 当前等级所需经验值
		 * @return 
		 * 
		 */		
		public function get exp_all() : int
		{
			return _anti["exp_all"];
		}
		public function set exp_all(value:int) : void
		{
			_anti["exp_all"] = value;
		}
		
		/**
		 * 每级所加内功
		 * @return 
		 * 
		 */		
		public function get ads() : int
		{
			return _anti["ads"];
		}
		public function set ads(value:int) : void
		{
			_anti["ads"] = value;
		}
		
		/**
		 * 每级所加罡气
		 * @return 
		 * 
		 */		
		public function get adf() : int
		{
			return _anti["adf"];
		}
		public function set adf(value:int) : void
		{
			_anti["adf"] = value;
		}
		
		/**
		 * 当前等级每次修炼所需消耗
		 * @return 
		 * 
		 */		
		public function get exp_add() : int
		{
			return _anti["exp_add"];
		}
		public function set exp_add(value:int) : void
		{
			_anti["exp_add"] = value;
		}
		
		public function get scroll() : int
		{
			return _anti["scroll"];
		}
		public function set scroll(value:int) : void
		{
			_anti["scroll"] = value;
		}
		
		/**
		 * 当前等级每次修炼所需战魂
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
		
		public var hp_up:int;
		
		public function I_force()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["exp_all"] = 0;
			_anti["ads"] = 0;
			_anti["adf"] = 0;
			_anti["exp_add"] = 0;
			_anti["scroll"] = 0;
			_anti["soul"] = 0;
		}
		
		public function assign(data:XML) : void
		{
			id = data.@id;
			exp_all = data.@exp_all;
			ads = data.@ads;
			adf = data.@adf;
			exp_add = data.@exp_add;
			scroll = data.@scroll;
			soul = data.@soul;
			hp_up = data.@hp_up;
		}
		
		public function copy() : I_force
		{
			var target:I_force = new I_force();
			
			target.id = this.id;
			
			target.exp_all = this.exp_all;
			
			target.ads = this.ads;
			
			target.adf = this.adf;
			
			target.exp_add = this.exp_add;
			
			target.scroll = this.scroll;
			
			target.soul = this.soul;
			
			target.hp_up = this.hp_up;
			
			return target;
		}
	}
}
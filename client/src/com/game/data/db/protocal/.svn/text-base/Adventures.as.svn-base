
package com.game.data.db.protocal
{
	public class Adventures extends Object
	{
		
		
		/**
		 * 奇遇事件减少当前血量数值
		 */
		public var hp_down:Number;
		
		
		/**
		 * 奇遇事件增加当前蓝量数值
		 */
		public var mp_up:Number;
		
		
		/**
		 * 奇遇事件减少当前蓝量数值
		 */
		public var mp_down:Number;
		
		
		/**
		 * 
		 */
		public var rate:Number;
		
		
		/**
		 * 奇遇事件增加当前血量数值
		 */
		public var hp_up:Number;
		
		
		/**
		 * 奇遇事件ID
		 */
		public var id:int;
		
		
		/**
		 * 奇遇事件名称
		 */
		public var name:String;
		
		
		public function Adventures()
		{
			
		}
		
		public function assign(data:XML) : void
		{
			
			
			hp_down = data.@hp_down
			
			
			mp_up = data.@mp_up
			
			
			mp_down = data.@mp_down
			
			
			rate = data.@rate
			
			
			hp_up = data.@hp_up
			
			
			id = data.@id
			
			
			name = data.@name
			
		}
		
		public function copy() : Adventures
		{
			var target:Adventures = new Adventures();
			
			
			target.hp_down = this.hp_down;
			
			
			target.mp_up = this.mp_up;
			
			
			target.mp_down = this.mp_down;
			
			
			target.rate = this.rate;
			
			
			target.hp_up = this.hp_up;
			
			
			target.id = this.id;
			
			
			target.name = this.name;
			
			
			return target;
		}
	}
}

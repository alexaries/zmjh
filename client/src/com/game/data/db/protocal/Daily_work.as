package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Daily_work extends Object
	{
		private var _anti:Antiwear;
		
		/**
		 * ID 
		 */		
		public var id:int;
		
		public var name:String;
		
		public var infomation:String;
		
		/**
		 * 礼包奖励列表
		 */
		public function get prop_id() : String
		{
			return _anti["prop_id"];
		}
		public function set prop_id(value:String) : void
		{
			_anti["prop_id"] = value;
		}
		
		/**
		 * 礼包奖励数量
		 */
		public function get prop_number() : String
		{
			return _anti["prop_number"];
		}
		public function set prop_number(value:String) : void
		{
			_anti["prop_number"] = value;
		}
		
		/**
		 * 获得金币
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
		
		public function Daily_work()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["prop_id"] = "";
			_anti["prop_number"] = "";
			_anti["gold"] = 0;
		}
		
		public function assign(data:XML) : void
		{
			id = data.@id
			
			name = data.@name
				
			infomation = data.@infomation
			
			prop_id = data.@prop_id
			
			prop_number = data.@prop_number
			
			gold = data.@gold
		}
		
		public function copy() : Daily_work
		{
			var target:Daily_work = new Daily_work();
			
			target.id = this.id;
			
			target.prop_id = this.prop_id;
			
			target.name = this.name;
			
			target.infomation = this.infomation;
			
			target.prop_number = this.prop_number;
			
			target.gold = this.gold;
			
			return target;
		}
	}
}
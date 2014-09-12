package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Gift_package extends Object
	{
		private var _anti:Antiwear;
		
		/**
		 * ID
		 */
		public var id:int;
		
		
		/**
		 * 礼包名字
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
		 * 礼包类型
		 */
		public var type:int;
		
		/**
		 * 礼包奖励列表
		 */
		public var prop_id:String;
		
		/**
		 * 礼包奖励数量
		 */
		public var prop_number:String;
		
		/**
		 * 礼包奖励装备
		 */
		public var equipment_id:String;
		
		
		/**
		 * 礼包奖励金币
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
		 * 礼包奖励战魂
		 */
		public function get soul() : int
		{
			return _anti["soul"];
		}
		public function set soul(value:int) : void
		{
			_anti["soul"] = value;
		}
		
		public function Gift_package()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			
			_anti["name"] = "";
			
			
			_anti["gold"] = 0;
			
			
			_anti["soul"] = 0;
		}
		
		
		public function assign(data:XML) : void
		{
			
			id = data.@id
			
			
			name = data.@name
			
			
			prop_id = data.@prop_id
			
			
			prop_number = data.@prop_number
				
				
			equipment_id = data.@equipment_id
				
				
			gold = data.@gold
				
				
			soul = data.@soul
		}
		
		public function copy() : Gift_package
		{
			var target:Gift_package = new Gift_package();
			
			
			target.id = this.id;
			
			
			target.name = this.name;
			
			
			target.prop_id = this.prop_id;
			
			
			target.prop_number = this.prop_number;
			
			
			target.equipment_id = this.equipment_id;
			
			
			target.gold = this.gold;
			
			
			target.soul = this.soul;
			
			
			return target;
		}
	}
}
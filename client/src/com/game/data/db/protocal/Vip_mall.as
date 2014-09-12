package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Vip_mall
	{
		private var _anti:Antiwear;
		
		/**
		 * 商品ID
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
		 * 商品名称
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
		 * 最低消费个数
		 * @return 
		 * 
		 */		
		public function get number() : int
		{
			return _anti["number"];
		}
		public function set number(value:int) : void
		{
			_anti["number"] = value;
		}
		
		public function get gold_before() : int
		{
			return _anti["gold_before"];
		}
		public function set gold_before(value:int) : void
		{
			_anti["gold_before"] = value;
		}
		
		public function get gold() : int
		{
			return _anti["gold"];
		}
		public function set gold(value:int) : void
		{
			_anti["gold"] = value;
		}
		
		public function get conpou_before() : int
		{
			return _anti["conpou_before"];
		}
		public function set conpou_before(value:int) : void
		{
			_anti["conpou_before"] = value;
		}
		
		public function get conpou() : int
		{
			return _anti["conpou"];
		}
		public function set conpou(value:int) : void
		{
			_anti["conpou"] = value;
		}
		
		/**
		 * 是否是推荐商品
		 * @return 
		 * 
		 */		
		public var recommend:int;
		
		/**
		* 商品类型
		* @return 
		* 
		*/		
		public var type:int;
		
		/**
		 * 商品对应到商城API的ID
		 * @return 
		 * 
		 */	
		public function get propId() : String
		{
			return _anti["propId"];
		}
		public function set propId(value:String) : void
		{
			_anti["propId"] = value;
		}
		
		public function get vip_type() : int
		{
			return _anti["vip_type"];
		}
		public function set vip_type(value:int) : void
		{
			_anti["vip_type"] = value;
		}
		
		public function Vip_mall()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["id"] = 0; 
			_anti["name"] = "";
			_anti["number"] = 0;
			_anti["gold_before"] = 0;
			_anti["gold"] = 0;
			_anti["conpou_before"] = 0;
			_anti["conpou"] = 0;
			_anti["propId"] = 0;
			_anti["vip_type"] = 0;
		}
		
		public function assign(data:XML) : void
		{
			id = data.@id;
			name = data.@name;
			number = data.@number;
			gold_before = data.@gold_before;
			gold = data.@gold;
			conpou_before = data.@conpou_before;
			conpou = data.@conpou;
			recommend = data.@recommend;
			type = data.@type;
			propId = data.@propId;
			vip_type = data.@vip_type;
		}
		
		public function copy() : Vip_mall
		{
			var target:Vip_mall = new Vip_mall();
			
			target.id = this.id;
			
			target.name = this.name;
			
			target.number = this.number;
			
			target.gold_before = this.gold_before;
			
			target.gold = this.gold;
			
			target.conpou_before = this.conpou_before;
			
			target.conpou = this.conpou;
			
			target.recommend = this.recommend;
			
			target.type = this.type;
			
			target.propId = this.propId;
			
			target.vip_type = this.vip_type;
			
			return target;
		}
	}
}
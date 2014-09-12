package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Mall extends Object
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
		
		/**
		 * 消耗点券
		 * @return 
		 * 
		 */		
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
		
		public function Mall()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["id"] = 0;
			_anti["name"] = "";
			_anti["number"] = 0;
			_anti["conpou"] = 0;
			_anti["propId"] = "";
		}
		
		public function assign(data:XML) : void
		{
			id = data.@id;
			name = data.@name;
			number = data.@number;
			conpou = data.@conpou;
			recommend = data.@recommend;
			type = data.@type;
			propId = data.@propId;
		}
		
		public function copy() : Mall
		{
			var target:Mall = new Mall();
			
			target.id = this.id;
			
			target.name = this.name;
			
			target.number = this.number;
			
			target.conpou = this.conpou;
			
			target.recommend = this.recommend;
			
			target.type = this.type;
			
			target.propId = this.propId;
			
			return target;
		}
	}
}
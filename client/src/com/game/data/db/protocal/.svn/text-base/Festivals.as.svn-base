package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Festivals
	{
		private var _anti:Antiwear;
		
		/**
		 * ID
		 */		
		public var id:int;
		
		/**
		 * 需要月饼数量
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
		 * 类型
		 */		
		public var type:int;
		
		/**
		 * 奖励道具ID
		 */		
		public var prop_id:String;
		
		/**
		 * 奖励道具数量
		 */		
		public var prop_number:String;
		
		/**
		 * 奖励金币数量
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
		 * 奖励战魂数量
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
		 * 奖励称号
		 */		
		public function get title() : String
		{
			return _anti["title"];
		}
		public function set title(value:String) : void
		{
			_anti["title"] = value;
		}
		
		/**
		 * 奖励角色
		 */		
		public function get characters() : String
		{
			return _anti["characters"];
		}
		public function set characters(value:String) : void
		{
			_anti["characters"] = value;
		}
		
		public function Festivals()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["number"] = 0;
			_anti["gold"] = 0;
			_anti["soul"] = 0;
			_anti["title"] = "";
			_anti["characters"] = "";
		}
		
		public function assign(data:XML) : void
		{
			id = data.@id;
			number = data.@number;
			type = data.@type;
			prop_id = data.@prop_id;
			prop_number = data.@prop_number;
			gold = data.@gold;
			soul = data.@soul;
			title = data.@title;
			characters = data.@characters;
		}
		
		public function copy() : Festivals
		{
			var target:Festivals = new Festivals();
			target.id = this.id;
			target.number = this.number;
			target.type = this.type;
			target.prop_id = this.prop_id;
			target.prop_number = this.prop_number;
			target.gold = this.gold;
			target.soul = this.soul;
			target.title = this.title;
			target.characters = this.characters;
			
			
			return target;
		}
	}
}
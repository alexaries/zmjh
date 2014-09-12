package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Title
	{
		private var _anti:Antiwear;
		
		public var id:int;
		
		/**
		 * 称号名称
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
		 * hp增加百分比 
		 * @return 
		 * 
		 */		
		public function get hp() : Number
		{
			return _anti["hp"];
		}
		public function set hp(value:Number) : void
		{
			_anti["hp"] = value;
		}
		
		/**
		 * mp增加百分比 
		 * @return 
		 * 
		 */		
		public function get mp() : Number
		{
			return _anti["mp"];
		}
		public function set mp(value:Number) : void
		{
			_anti["mp"] = value;
		}
		
		/**
		 * atk增加百分比 
		 * @return 
		 * 
		 */		
		public function get atk() : Number
		{
			return _anti["atk"];
		}
		public function set atk(value:Number) : void
		{
			_anti["atk"] = value;
		}
		
		/**
		 * def增加百分比 
		 * @return 
		 * 
		 */		
		public function get def() : Number
		{
			return _anti["def"];
		}
		public function set def(value:Number) : void
		{
			_anti["def"] = value;
		}
		
		/**
		 * spd增加百分比 
		 * @return 
		 * 
		 */		
		public function get spd() : Number
		{
			return _anti["spd"];
		}
		public function set spd(value:Number) : void
		{
			_anti["spd"] = value;
		}
		
		/**
		 * 特殊效果
		 * @return 
		 * 
		 */		
		public var special:String;
		
		/**
		 * 称号获得条件
		 * @return 
		 * 
		 */		
		public var info:String;
		
		public function Title()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["name"] = "";
			_anti["hp"] = 0;
			_anti["mp"] = 0;
			_anti["atk"] = 0;
			_anti["def"] = 0;
			_anti["spd"] = 0;
		}
		
		
		public function assign(data:XML) : void
		{
			name = data.@name;
			hp = data.@hp;
			mp = data.@mp;
			atk = data.@atk;
			def = data.@def;
			spd = data.@spd;
			special = data.@special;
			info = data.@info;
		}
		
		public function copy() : Title
		{
			var target:Title = new Title();
			
			target.name = this.name;
			
			target.hp = this.hp;
			
			target.mp = this.mp;
			
			target.atk = this.atk;
			
			target.def = this.def;
			
			target.spd = this.spd;
			
			target.special = this.special;
			
			target.info = this.info;
			
			return target;
		}
	}
}
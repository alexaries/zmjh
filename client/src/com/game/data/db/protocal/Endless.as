package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Endless extends Object
	{
		private var _anti:Antiwear;
		
		/**
		 * ID
		 * @return 
		 * 
		 */		
		public var id:int;
		
		/**
		 * 关卡类型，1为小怪，2为BOSS
		 * @return 
		 * 
		 */		
		public var type:int;
		
		/**
		 * 关卡敌人名字
		 * @return 
		 * 
		 */		
		public var name:String;
		
		/**
		 * 关卡敌人的等级
		 * @return 
		 * 
		 */		
		public var grade:String;
		
		/**
		 * 获得经验
		 * @return 
		 * 
		 */		
		public function get exp() : int
		{
			return _anti["exp"];
		}
		
		public function set exp(value:int) : void
		{
			_anti["exp"] = value;
		}
		
		/**
		 * 获得金钱
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
		
		/**
		 * 获得战魂
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
		
		/**
		 * 快速跳关需要的时间
		 * @return 
		 * 
		 */		
		public function get time() : int
		{
			return _anti["time"];
		}
		
		public function set time(value:int) : void
		{
			_anti["time"] = value;
		}
		
		/**
		 * 怪物属性加成
		 * @return 
		 * 
		 */		
		public var up:Number;
		public function Endless()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["id"] = 0;
			_anti["exp"] = 0;
			_anti["gold"] = 0;
			_anti["soul"] = 0;
			_anti["time"] = 0;
		}
		
		public function assign(data:XML) : void
		{
			id = data.@id;
			
			type = data.@type;
			
			name = data.@name;
			
			grade = data.@grade;
			
			exp = data.@exp;
			
			gold = data.@gold;
			
			soul = data.@soul;
			
			time = data.@time;
			
			up = data.@up;
		}
		
		public function copy() : Endless
		{
			var target:Endless = new Endless();
			
			target.id = this.id;
			
			target.type = this.type;
			
			target.name = this.name;
			
			target.grade = this.grade;
			
			target.exp = this.exp;
			
			target.gold = this.gold;
			
			target.soul = this.soul;
			
			target.time = this.time;
			
			target.up = this.up;
			
			return target;
		}
	}
}
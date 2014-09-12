package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	
	import starling.events.EventDispatcher;

	public class BaseRole extends EventDispatcher
	{
		/**
		 * 罡气
		 */
		//public var adf:int;
		public function get adf() : int
		{
			return _anti["adf"];
		}
		public function set adf(value:int) : void
		{
			_anti["adf"] = value;
		}
		/**
		 * 精准
		 */
		//public var hit:int;	
		public function get hit() : int
		{
			return _anti["hit"];
		}
		public function set hit(value:int) : void
		{
			_anti["hit"] = value;
		}
		/**
		 * 基本格挡率 百分比
		 */
		public var block_rate:Number;
		
		/**
		 * 名称
		 */
		//public var name:String;
		public function get name() : String
		{
			return _anti["name"];
		}
		public function set name(value:String) : void
		{
			_anti["name"] = value;
		}
		/**
		 * 外功
		 */
		//public var atk:int;
		public function get atk() : int
		{
			return _anti["atk"];
		}
		public function set atk(value:int) : void
		{
			_anti["atk"] = value;
		}
		
		/**
		 * 性别：0->男 1->女 2->禽兽
		 */
		public var gender:int;
		
		/**
		 * 基本闪避率 百分比
		 */
		public var evasion_rate:Number;
		
		/**
		 * 内功
		 */
		//public var ats:int;
		public function get ats() : int
		{
			return 	_anti["ats"];
		}
		public function set ats(value:int) : void
		{
			_anti["ats"] = value;
		}
		/**
		 * 攻击触发值
		 */
		public var atk_point:int;
		/**
		 * 暴击
		 */
		//public var crit:int;
		public function get crit() : int
		{
			return 	_anti["crit"];
		}
		public function set crit(value:int) : void
		{
			_anti["crit"] = value;
		}
		/**
		 * 步法
		 */
		//public var spd:int;
		public function get spd() : int
		{
			return 	_anti["spd"];
		}
		public function set spd(value:int) : void
		{
			_anti["spd"] = value;
		}
		/**
		 * ID
		 */
		public var id:int;
		
		/**
		 * 灵活
		 */
		//public var evasion:int;	
		public function get evasion() : int
		{
			return 	_anti["evasion"];
		}
		public function set evasion(value:int) : void
		{
			_anti["evasion"] = value;
		}
		/**
		 * 元气
		 */
		//public var mp:int;
		public function get mp() : int
		{
			return 	_anti["mp"];
		}
		public function set mp(value:int) : void
		{
			_anti["mp"] = value;
		}
		/**
		 * 体力
		 */
		public function set hp(value:int) : void
		{
			_anti["hp"] = value;
			this.dispatchEventWith("HP_CHANGE");
		}
		public function get hp() : int
		{
			return _anti["hp"];
		}
		
		
		/**
		 * 基本暴击率 百分比
		 */
		public var crit_rate:Number;	
		
		/**
		 * 防御
		 */
		//public var def:int;
		public function get def() : int
		{
			return 	_anti["def"];
		}
		public function set def(value:int) : void
		{
			_anti["def"] = value;
		}
		/**
		 * 韧性
		 */
		//public var toughness:int;
		public function get toughness() : int
		{
			return 	_anti["toughness"];
		}
		public function set toughness(value:int) : void
		{
			_anti["toughness"] = value;
		}
		
		/**
		 * 等级
		 */
		public function get lv() : int
		{
			return 	_anti["lv"];
		}
		public function set lv(value:int) : void
		{
			_anti["lv"] = value;
		}
		
		public function get hp_compose() : int
		{
			return _anti["hp_compose"];
		}
		public function set hp_compose(value:int) : void
		{
			_anti["hp_compose"] = value;
		}
		
		public function get mp_compose() : int
		{
			return _anti["mp_compose"];
		}
		public function set mp_compose(value:int) : void
		{
			_anti["mp_compose"] = value;
		}
		
		public function get atk_compose() : int
		{
			return _anti["atk_compose"];
		}
		public function set atk_compose(value:int) : void
		{
			_anti["atk_compose"] = value;
		}
		
		public function get def_compose() : int
		{
			return _anti["def_compose"];
		}
		public function set def_compose(value:int) : void
		{
			_anti["def_compose"] = value;
		}
		
		public function get spd_compose() : int
		{
			return _anti["spd_compose"];
		}
		public function set spd_compose(value:int) : void
		{
			_anti["spd_compose"] = value;
		}
		
		public function get evasion_compose() : int
		{
			return _anti["evasion_compose"];
		}
		public function set evasion_compose(value:int) : void
		{
			_anti["evasion_compose"] = value;
		}
		
		public function get crit_compose() : int
		{
			return _anti["crit_compose"];
		}
		public function set crit_compose(value:int) : void
		{
			_anti["crit_compose"] = value;
		}
		
		public function get grade() : String
		{
			return _anti["grade"];
		}
		public function set grade(value:String) : void
		{
			_anti["grade"] = value;
		}
		
		private var _anti:Antiwear;
		
		public function BaseRole()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["adf"] = 0;
			_anti["hit"] = 0;
			_anti["ats"] = 0;
			_anti["name"] = "";
			_anti["atk"] = 0;
			_anti["crit"] = 0;
			_anti["spd"] = 0;
			_anti["evasion"] = 0;
			_anti["hp"] = 0;
			_anti["mp"] = 0;
			_anti["def"] = 0;
			_anti["toughness"] = 0;
			_anti["lv"] = 0;
			_anti["hp_compose"] = 0;
			_anti["mp_compose"] = 0;
			_anti["atk_compose"] = 0;
			_anti["def_compose"] = 0;
			_anti["spd_compose"] = 0;
			_anti["evasion_compose"] = 0;
			_anti["crit_compose"] = 0;
			_anti["grade"] = "";
		}
	}
}
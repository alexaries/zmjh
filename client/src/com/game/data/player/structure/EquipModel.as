package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.data.db.protocal.Equipment;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class EquipModel extends EventDispatcher
	{
		private var _anti:Antiwear;		
		public var config:Equipment;
		
		public function get id() : int
		{
			return 	_anti["id"];
		}
		public function set id(value:int) : void
		{
			_anti["id"] = value;
		}
		
		public function get exp() : int
		{
			return 	_anti["exp"];
		}
		public function set exp(value:int) : void
		{
			_anti["exp"] = value;
		}
		
		/**
		 * 强化等级 
		 */		
		public function get lv() : int
		{
			return 	_anti["lv"];
		}
		public function set lv(value:int) : void
		{
			//if((value - _anti["lv"]) > 1) this.dispatchEventWith(EquipEvent.STRENGTHEN_LV_CHANGE, false, (value - _anti["lv"]));
			_anti["lv"] = value;
		}
		/**
		 * 攻击 
		 */		
		public function get atk() : int
		{
			return 	_anti["atk"];
		}
		public function set atk(value:int) : void
		{
			_anti["atk"] = value;
		}
		/**
		 * 防御力 
		 */		
		public function get def() : int
		{
			return 	_anti["def"];
		}
		public function set def(value:int) : void
		{
			_anti["def"] = value;
		}
		/**
		 * 速度 
		 */		
		public function get spd() : int
		{
			return 	_anti["spd"];
		}
		public function set spd(value:int) : void
		{
			_anti["spd"] = value;
		}
		/**
		 * 唯一ID 
		 */		
		public function get mid() : int
		{
			return 	_anti["mid"];
		}
		public function set mid(value:int) : void
		{
			_anti["mid"] = value;
		}
		
		public function get hp() : Number
		{
			return _anti["hp"];
		}
		
		public function set hp(value:Number) : void
		{
			_anti["hp"] = value;
		}
		
		public function get mp() : Number
		{
			return _anti["mp"];
		}
		
		public function set mp(value:Number) : void
		{
			_anti["mp"] = value;
		}
		
		public function get crit() : Number
		{
			return _anti["crit"];
		}
		
		public function set crit(value:Number) : void
		{
			_anti["crit"] = value;
		}
		
		public function get evasion() : Number
		{
			return _anti["evasion"];
		}
		
		public function set evasion(value:Number) : void
		{
			_anti["evasion"] = value;
		}
		
		public function get hp_compose() : Number
		{
			return _anti["hp_compose"];
		}
		
		public function set hp_compose(value:Number) : void
		{
			_anti["hp_compose"] = value;
		}
		
		public function get mp_compose() : Number
		{
			return _anti["mp_compose"];
		}
		
		public function set mp_compose(value:Number) : void
		{
			_anti["mp_compose"] = value;
		}
		
		public function get atk_compose() : Number
		{
			return _anti["atk_compose"];
		}
		
		public function set atk_compose(value:Number) : void
		{
			_anti["atk_compose"] = value;
		}
		
		public function get def_compose() : Number
		{
			return _anti["def_compose"];
		}
		
		public function set def_compose(value:Number) : void
		{
			_anti["def_compose"] = value;
		}
		
		public function get spd_compose() : Number
		{
			return _anti["spd_compose"];
		}
		
		public function set spd_compose(value:Number) : void
		{
			_anti["spd_compose"] = value;
		}
		
		public function get evasion_compose() : Number
		{
			return _anti["evasion_compose"];
		}
		
		public function set evasion_compose(value:Number) : void
		{
			_anti["evasion_compose"] = value;
		}
		
		public function get crit_compose() : Number
		{
			return _anti["crit_compose"];
		}
		
		public function set crit_compose(value:Number) : void
		{
			_anti["crit_compose"] = value;
		}
		
		/**
		 * 是否装备在身上了 
		 */		
		public  var _isEquiped:Boolean;
		public function get isEquiped() : Boolean
		{
			return _isEquiped;
		}
		public function set isEquiped(value:Boolean) : void
		{
			_isEquiped = value;
			isNew = false;
		}
		
		public var isNew:Boolean;
		
		public function EquipModel()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			mid = 0;
			spd = 0;
			def = 0;
			atk = 0;
			lv = 0;
			exp = 0;
			id = 0;
			mp = 0;
			hp = 0;
			evasion = 0;
			crit = 0;
			hp_compose = 0;
			mp_compose = 0;
			atk_compose = 0;
			def_compose = 0;
			spd_compose = 0;
			evasion_compose = 0;
			crit_compose = 0;
			isNew = false;
			
			/*if(!this.hasEventListener(EquipEvent.STRENGTHEN_LV_CHANGE))
				this.addEventListener(EquipEvent.STRENGTHEN_LV_CHANGE, strengthenLvChange);*/
		}
		
		private function strengthenLvChange(e:Event) : void
		{
			trace(e.data);
		}
	}
}
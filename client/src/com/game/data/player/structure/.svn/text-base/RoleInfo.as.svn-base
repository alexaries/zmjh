package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.data.db.protocal.Characters;

	public class RoleInfo
	{
		private var _anti:Antiwear;
		
		/**
		 * 角色名称 
		 */		
		//public var roleName:String;
		public function get roleName() : String
		{
			return 	_anti["roleName"];
		}
		public function set roleName(value:String) : void
		{
			_anti["roleName"] = value;
		}
		
		/**
		 * 当前等级 
		 */
		//public var lv:int;
		public function get lv() : int
		{
			return 	_anti["lv"];
		}
		public function set lv(value:int) : void
		{
			_anti["lv"] = value;
		}
		
		/**
		 * 经验
		 */		
		//public var exp:int;
		public function get exp() : int
		{
			return 	_anti["exp"];
		}
		public function set exp(value:int) : void
		{
			_anti["exp"] = value;
		}
		
		/**
		 * 品质 
		 */		
		//public var quality:uint;
		public function get quality() : int
		{
			return 	_anti["quality"];
		}
		public function set quality(value:int) : void
		{
			_anti["quality"] = value;
		}
		
		/**
		 * 装备 
		 */
		public var equip:EquipInfo;
		/**
		 * 技能
		 */
		public var skill:SkillInfo;
		
		public var hp:int;
		
		public function RoleInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["roleName"] = "";
			_anti["lv"] = 0;
			_anti["exp"] = 0;
			_anti["quality"] = 0;
			
			equip = new EquipInfo();
			skill = new SkillInfo();
		}
	}
}
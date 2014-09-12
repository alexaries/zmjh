package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.data.db.protocal.Skill;
	import com.game.data.player.SkillUtitiles;
	import com.game.template.InterfaceTypes;

	public class SkillInfo
	{
		private var _anti:Antiwear;
		
		/**
		 * 技能 1
		 */		
		//public var skill1:String;
		public function get skill1() : String
		{
			return 	_anti["skill1"];
		}
		public function set skill1(value:String) : void
		{
			_anti["skill1"] = value;
		}
		
		/**
		 * 技能2 
		 */		
		//public var skill2:String;
		public function get skill2() : String
		{
			return 	_anti["skill2"];
		}
		public function set skill2(value:String) : void
		{
			_anti["skill2"] = value;
		}
		
		/**
		 * 技能3
		 */		
		//public var skill3:String;
		public function get skill3() : String
		{
			return 	_anti["skill3"];
		}
		public function set skill3(value:String) : void
		{
			_anti["skill3"] = value;
		}
		
		/**
		 * 已学到的技能 
		 */		
		//public var learnedSkill:String;
		public function get learnedSkill() : String
		{
			return 	_anti["learnedSkill"];
		}
		public function set learnedSkill(value:String) : void
		{
			_anti["learnedSkill"] = value;
		}
		
		public function SkillInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			skill1 = "";
			skill2 = "";
			skill3 = "";
			learnedSkill = "";
		}
	}
}
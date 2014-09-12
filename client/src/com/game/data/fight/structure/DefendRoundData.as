package com.game.data.fight.structure
{
	import com.game.data.db.protocal.Skill;
	
	import flash.display.Loader;

	public class DefendRoundData extends BaseRoundData
	{
		/**
		 * 内功造成的伤害值 (hp)
		 */		
		public var NeiGongHurtValue:int;
		
		/**
		 * 受伤值 (hp)
		 */		
		public var hurtHPValue:int;
		
		/**
		 *mp 
		 */	
		public var hurtMPValue:int;
		
		/**
		 * 受攻击类型 
		 */		
		public var hurtType:String;
		
		/**
		 *  技能
		 */
		public var skill:Skill;
		
		/**
		 * 是否技能暴击
		 * 
		 */		
		public var skillCrit:Boolean;
		
		public function DefendRoundData()
		{
			super();
		}
	}
}
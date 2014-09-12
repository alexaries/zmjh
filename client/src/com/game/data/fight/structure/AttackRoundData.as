package com.game.data.fight.structure
{
	import com.game.data.db.protocal.Skill;

	public class AttackRoundData extends BaseRoundData
	{
		/**
		 *  状态(中毒， 晕阙， 睡眠, 混乱, 酒)
		 */
		public var states:Vector.<String>;
		/**
		 * 伤害(hp, mp) 
		 */		
		public var hurts:Vector.<Hurt>;
		/**
		 * 攻击类型 
		 */		
		public var attackType:String;
		/**
		 * 技能 
		 */
		public var skill:Skill;
		
		public function AttackRoundData()
		{
			super();
			
			hurts = new Vector.<Hurt>();
			states = new Vector.<String>();
		}
	}
}
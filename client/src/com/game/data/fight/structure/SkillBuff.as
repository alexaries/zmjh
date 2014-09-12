package com.game.data.fight.structure
{
	import com.game.data.db.protocal.Status;

	public class SkillBuff
	{
		/**
		 * 技能名称 
		 */		
		public var skill_name:String;
		
		/**
		 * buff名称
		 */
		public var buff_name:String;
		
		/**
		 * 伤害 
		 */		
		public var hurt:int;
		
		/**
		 * 回合数 
		 */		
		public var time:int;
		
		public var status:Status;
		
		public var lastTime:int;
		
		public function SkillBuff()
		{
		}
		
		public function copy() : SkillBuff
		{
			var buff:SkillBuff = new SkillBuff();
			
			buff.buff_name = buff_name;
			buff.hurt = hurt;
			buff.time = time;
			buff.lastTime = lastTime;
			buff.status = status.copy();
			
			return buff;
		}
	}
}
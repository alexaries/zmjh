package com.game.data.fight
{
	import com.engine.core.Log;
	import com.engine.utils.Utilities;
	import com.game.View;
	import com.game.data.db.protocal.Skill;
	import com.game.data.fight.structure.AttackRoundData;
	import com.game.data.fight.structure.BaseModel;
	import com.game.data.fight.structure.BaseRoundData;
	import com.game.data.fight.structure.Battle_EnemyModel;
	import com.game.data.fight.structure.Battle_WeModel;
	import com.game.data.fight.structure.DefendRoundData;
	import com.game.data.fight.structure.FightRound;
	import com.game.data.fight.structure.SkillBuff;
	import com.game.template.V;

	public class FightCommonUtitiles
	{
		private static var _configData:*;
		private static var _round:FightRound;
		
		public function FightCommonUtitiles()
		{
		}
		
		/**
		 * 
		 * @param configData
		 * @param round
		 * 
		 */
		public static function init(configData:*, round:FightRound) : void
		{
			_configData = configData;
			_round = round;
		}
		
		/**
		 * 是否暴击 
		 * @param attack
		 * @param defend
		 * @return 
		 * 
		 */
		public static function countCrit(attack:AttackRoundData, defend:DefendRoundData) : Boolean
		{
			// 暴击
			var CritRate:Number = getCritRate(attack, defend);
			var isCritHit:Boolean = Utilities.hitProbability(CritRate);
			
			return isCritHit;
		}
		
		public static function countCommonAttack(attack:AttackRoundData, defend:DefendRoundData) : void
		{
			// 内功
			var NeiGongHurtValue:Number = countNeiGong(attack, defend);
			// 闪避
			var DodgeRate:Number = getDodgeRate(attack, defend);
			// 格挡
			var BlockRate:Number = getBlockRate(attack, defend);
			// 暴击
			var CritRate:Number = getCritRate(attack, defend);
			// 外功
			var OutHarm:Harm = countOutHurt(attack, defend, DodgeRate, BlockRate, CritRate);
			
			Log.Trace("攻击方：" + attack.configRole.name + "被攻击方：" + defend.configRole.name 
				+ "闪避:" + DodgeRate + "格挡:" + BlockRate + "暴击:" + CritRate + "外功:" + OutHarm.value
			+ "攻击类型:" + OutHarm.type);
			
			// 被攻击类型
			defend.hurtType = OutHarm.type;
			defend.hurtHPValue = OutHarm.value;
			defend.NeiGongHurtValue = NeiGongHurtValue;
			
			countExWorkHurt(attack, defend, NeiGongHurtValue, OutHarm.value);
			
			// 打断睡眠状态
			defend.model.removeBuff(FightConfig.ASLEEP);
		}
		
		public static function countExWorkHurt(attack:AttackRoundData, defend:DefendRoundData, inHurt:int, outHurt:int) : void
		{
			var hurt:int = inHurt + outHurt;
			
			//闪避伤害为0
			if (hurt < 0) hurt = 0;
			
			defend.countRole.hp -= hurt;
			
			if (defend.countRole.hp < 0) defend.countRole.hp = 0;
			
			defend.remainHP = defend.countRole.hp;
			defend.remainMP = defend.countRole.mp;
			
			attack.remainHP = attack.countRole.hp;
			attack.remainMP = attack.countRole.mp;
		}
		
		/**
		 * 计算外功伤害 
		 * @param DodgeRate
		 * @param BlockRate
		 * @param CritRate
		 * @return 
		 * 
		 */		
		protected static function countOutHurt(attack:BaseRoundData, defend:BaseRoundData, DodgeRate:Number, BlockRate:Number, CritRate:Number) : Harm
		{
			var result:Harm = new Harm();
			
			var hurtBase:int = countCommonHurt(attack, defend);
			
			var isDodgeHit:Boolean = Utilities.hitProbability(DodgeRate);
			var isBlockHit:Boolean = Utilities.hitProbability(BlockRate);
			var isCritHit:Boolean = Utilities.hitProbability(CritRate);
			
			/**********闪避*********/
			// 闪避
			if (DodgeRate > 0 && isDodgeHit)
			{
				result.type = FightConfig.DODGE
				result.value = 0;
			}
			// 中
			else
			{
				/*************格挡***************/
				if (isBlockHit)
				{
					result.type = FightConfig.BLOCK_HURT;
					
					var resultBlock:Number = hurtBase * 0.5;
					
					result.value = (resultBlock<1?1:resultBlock);
				}
				else
				{
					/*************暴击***************/
					if (isCritHit)
					{
						result.type = FightConfig.CRIT_HURT;
						result.value = hurtBase * 2;
					}
						// 既没格挡也没暴击  ---》 普通伤害
					else
					{
						result.type = FightConfig.COMMON_HURT;
						result.value = hurtBase;
					}
				}
			}
						
			return result;
		}
		
		/**
		 *  最终暴击率 = 我方基本暴击率+（我方暴击-对方韧性）*0.05+（我方技能暴击值-敌方技能韧性值)*0.05
		 * @return 
		 * 
		 */		
		protected static function getCritRate(attack:BaseRoundData, defend:BaseRoundData) : Number
		{
			var rate:Number = 0;
			
			// 攻击在暴击判断时，当对方角色有石灰状态时，则要减少对方角色的韧性值600。
			var dis:int = 0;
			var buff:SkillBuff = defend.model.getBuff(FightConfig.LINE);
			if (buff) dis = buff.status.toughness_down;
			
			rate = attack.configRole.crit_rate + (attack.baseRole.crit - (defend.baseRole.toughness + dis)) * FightConfig.RATIO +
			// （我方技能暴击值-敌方技能韧性值)*0.05
			(attack.model.countSpecificOfEffect(FightConfig.CRIT_UP) - defend.model.countSpecificOfEffect(FightConfig.TOUGHNESS_UP)) * FightConfig.RATIO;
			
			if (rate < 0)
			{
				rate = 0;
				//throw new Error("最终暴击率计算有误");
			}
			
			
			return rate;
		}
		
		/**
		 * 角色最终格挡率=对方角色基本格挡率 + 对方角色技能加成格挡率
		 * @return 
		 * 
		 */		
		protected static function getBlockRate(attack:BaseRoundData, defend:BaseRoundData) : Number
		{
			var rate:Number = 0;
			
			rate = defend.configRole.block_rate +
			// + 对方角色技能加成格挡率
			defend.model.countSpecificOfEffect(FightConfig.BLOCK_UP);
			
			if (rate < 0)
			{
				rate = 0;
				//throw new Error("最终格挡率计算有误");
			}
			
			return rate;
		}
		
		/**
		 *闪避率 
		 * 最终闪避率=敌方基本闪避率+（敌方灵活-我方精准）*0.05+（敌方技能闪避值-我方技能精准值)*0.05 
		 * @return 
		 * 
		 */		
		protected static function getDodgeRate(attack:BaseRoundData, defend:BaseRoundData) : Number
		{
			var rate:Number = 0;
			
			// 角色有酒状态时，要减少我方角色精准值600
			var dis:int = 0;
			var buff:SkillBuff = attack.model.getBuff(FightConfig.DRUNK);
			if (buff) 
			{
				dis= buff.status.hit_down;
			}
			
			rate = defend.configRole.evasion_rate + (defend.baseRole.evasion - (attack.baseRole.hit + dis)) * FightConfig.RATIO +
			// （敌方技能闪避值-我方技能精准值)*0.05
			(defend.model.countSpecificOfEffect(FightConfig.EVASION_UP) - attack.model.countSpecificOfEffect(FightConfig.HIT_UP)) * FightConfig.RATIO;
			
			if (rate < 0)
			{
				rate = 0;
				//throw new Error("闪避率计算有误");
			}
			
			return rate;
		}
		
		/**
		 * 内功
		 * @param configData
		 * @return 
		 * 
		 */
		protected static function countNeiGong(attack:BaseRoundData, defend:BaseRoundData) : int
		{
			var hurt:int;
			
			hurt = attack.baseRole.ats - defend.baseRole.adf;
			
			if (hurt < 0) hurt = 0;
			
			return hurt;
		}
		
		/**
		 * 外功
		 * @return 
		 * 
		 */		
		public static function countCommonHurt(attack:BaseRoundData, defend:BaseRoundData) : int
		{
			var hurt:int;
			
			hurt = attack.baseRole.atk - defend.baseRole.def;
			
			//if (hurt < 0) hurt = 0;			
			if (hurt < 1) hurt = 1;
			
			if(defend.baseRole.name == "小桂子" && View.instance.world_boss.useCount != 0)
				hurt = hurt * (1 + View.instance.world_boss.useCount / 10);
			
			return hurt;
		}
	}
}

class Harm
{
	public var type:String;
	
	public var value:Number;
}
package com.game.data.playerKilling
{
	import com.game.data.db.protocal.Skill;
	import com.game.data.fight.FightCommonUtitiles;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.FightSkillUtitiles;
	import com.game.data.fight.Hand;
	import com.game.data.fight.structure.DefendRoundData;
	import com.game.data.fight.structure.FightRound;
	import com.game.template.V;

	public class CountPlayerKillingFightRound
	{
		private static var _configData:PlayerKillingFightModelStructure;
		private static var _round:FightRound;

		
		public static function getRound(configData:PlayerKillingFightModelStructure, round:FightRound) : void
		{
			_configData = configData;
			_round = round;
			
			init();
			beginCount();
		}
		
		public static function init() : void
		{
			// 初始化
			FightCommonUtitiles.init(_configData, _round);
			FightSkillUtitiles.init(_configData, _round);
		}
		
		protected static function beginCount() : void
		{
			var defend:DefendRoundData;
			var defendHand:Hand;
			var attackHand:Hand = new Hand();
			attackHand.index = _round.attack.index;
			attackHand.postion = _round.attack.position;
			// 剩余血量
			var remainHp:int;
			// 是否处于混乱状态
			if (_round.attack.attackType == FightConfig.CONFUSION_ATTACK)
			{
				defendHand = PlayerKillingFightProcessManager.getDefendWhenConfusion(attackHand.postion);
				
				defend = new DefendRoundData();
				defend.setPlayerKillingBaseInfo(defendHand.index, defendHand.postion, _configData);
				
				// 基础伤害 :我方外功-对象根骨				
				defend.hurtType = FightConfig.COMMON_HURT;
				var hurtBase:uint = FightCommonUtitiles.countCommonHurt(_round.attack, defend);
				defend.hurtHPValue = hurtBase;
				FightCommonUtitiles.countExWorkHurt(_round.attack, defend, 0, hurtBase);
				_round.defend.push(defend);
			}
			else
			{
				var skill:Skill = FightSkillUtitiles.getWayOut(_round.attack.model);
				
				if(skill)
				{
					var position:String = getDefendPosition(skill);
					//判断是否是加血技能，是加血技能则判断血量是否小于80%
					if(skill.hp_up != 0)	var releaseSkill:Boolean = PlayerKillingFightProcessManager.getBloodRemainHand(position);
				}
				
				if (!skill || (skill && skill.hp_up != 0 &&  !releaseSkill))
					//if(!skill)
				{
					_round.attack.attackType  = FightConfig.COMMON_HURT;
					defendHand = PlayerKillingFightProcessManager.getFixDefendHand(attackHand.postion);
					
					defend = new DefendRoundData();
					defend.setPlayerKillingBaseInfo(defendHand.index, defendHand.postion, _configData);
					
					FightCommonUtitiles.countCommonAttack(_round.attack, defend);
					_round.defend.push(defend);
				}
				else
				{
					FightSkillUtitiles.countAttackSkillHarm(skill, _round.attack);
					
					// 技能攻击
					_round.attack.attackType = FightConfig.SKILL_ATTACK;
					_round.attack.skill = skill;
					
					// 单体攻击
					if (skill.range == FightConfig.SINGLE_ATTACK)
					{
						// 固定
						if (skill.choice == FightConfig.FIXED)
						{
							defendHand = PlayerKillingFightProcessManager.getFixDefendHand(position);
						}
							// 随机
						else
						{
							// 非加血技能
							if (skill.hp_up == 0)
							{
								defendHand = PlayerKillingFightProcessManager.getRandomDefendHand(position);
							}
							else
							{
								defendHand = PlayerKillingFightProcessManager.getBloodDefendHand(position);
							}
						}
						
						setSkillDefendRound(skill, defendHand);
					}
					else if(skill.range == FightConfig.GROUP_ATTACK)
					{
						// 攻击						
						var defendHands:Vector.<Hand> = PlayerKillingFightProcessManager.getGroupDefend(position);
						
						for each(var hand:Hand in defendHands)
						{
							setSkillDefendRound(skill, hand);
						}
					}
					else
					{
						throw new Error("here");
					}
				}
			}
		}
		
		protected static function getDefendPosition(skill:Skill) : String
		{
			var position:String;
			if (skill.camp == FightConfig.ENEMY)
			{
				position = _round.attack.position;
			}
			else
			{
				if (_round.attack.position == V.ME) position = V.ENEMY;
				else position = V.ME;
			}
			
			return position;
		}
		
		protected static function setSkillDefendRound(skill:Skill, defendHand:Hand) : void
		{
			var defend:DefendRoundData = new DefendRoundData();
			defend.hurtType = FightConfig.SKILL_ATTACK;
			defend.skill = skill;
			
			defend.setPlayerKillingBaseInfo(defendHand.index, defendHand.postion, _configData);
			
			FightSkillUtitiles.countBuff(skill, _round.attack, defend, true);
			FightSkillUtitiles.countDefendSkillHarm(skill, _round.attack, defend);
			
			_round.defend.push(defend);
		}
	}
}
package com.game.data.fight
{
	import com.engine.core.Log;
	import com.engine.utils.Utilities;
	import com.game.data.db.protocal.Characters;
	import com.game.data.db.protocal.Enemy;
	import com.game.data.db.protocal.Skill;
	import com.game.data.fight.structure.BaseModel;
	import com.game.data.fight.structure.Battle_EnemyModel;
	import com.game.data.fight.structure.Battle_WeModel;
	import com.game.data.fight.structure.DefendRoundData;
	import com.game.data.fight.structure.FightRound;
	import com.game.template.V;

	public class CountFightRound
	{
		private static var _configData:FightModelStructure;
		private static var _round:FightRound;
		
		public static function getRound(configData:FightModelStructure, round:FightRound) : void
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
				defendHand = FightProcessManager.getDefendWhenConfusion(attackHand.postion);
				
				defend = new DefendRoundData();
				defend.setBaseInfo(defendHand.index, defendHand.postion, _configData);
				
				// 基础伤害 :我方外功-对象根骨				
				defend.hurtType = FightConfig.COMMON_HURT;
				var hurtBase:uint = FightCommonUtitiles.countCommonHurt(_round.attack, defend);
				defend.hurtHPValue = hurtBase;
				FightCommonUtitiles.countExWorkHurt(_round.attack, defend, 0, hurtBase);
				_round.defend.push(defend);
				
				if(defend.baseRole.name == "小桂子")
					(_configData as FightModelStructure).allHurt += hurtBase;
			}
			else
			{
				var skill:Skill;
				//小桂子特殊设置
				if(_round.attack.baseRole.name == "小桂子")
				{
					if(_round.Count >= 10)
					{
						skill = FightSkillUtitiles.getSpecial(_round.attack.model);
					}
				}
				else
				{
					skill = FightSkillUtitiles.getWayOut(_round.attack.model);
				}
				
				if(skill)
				{
					var position:String = getDefendPosition(skill);
					//判断是否是加血技能，是加血技能则判断血量是否小于80%
					if(skill.hp_up != 0)	var releaseSkill:Boolean = FightProcessManager.getBloodRemainHand(position);
				}
				
				if (!skill || (skill && skill.hp_up != 0 &&  !releaseSkill))
				//if(!skill)
				{
					_round.attack.attackType  = FightConfig.COMMON_HURT;
					defendHand = FightProcessManager.getFixDefendHand(attackHand.postion);
					
					defend = new DefendRoundData();
					defend.setBaseInfo(defendHand.index, defendHand.postion, _configData);
					
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
							defendHand = FightProcessManager.getFixDefendHand(position);
						}
						// 随机
						else
						{
							// 非加血技能
							if (skill.hp_up == 0)
							{
								defendHand = FightProcessManager.getRandomDefendHand(position);
							}
							else
							{
								defendHand = FightProcessManager.getBloodDefendHand(position);
							}
						}
						
						setSkillDefendRound(skill, defendHand);
					}
					else if(skill.range == FightConfig.GROUP_ATTACK)
					{
						// 攻击						
						var defendHands:Vector.<Hand> = FightProcessManager.getGroupDefend(position);
						
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
			
			defend.setBaseInfo(defendHand.index, defendHand.postion, _configData);
			
			FightSkillUtitiles.countBuff(skill, _round.attack, defend);
			FightSkillUtitiles.countDefendSkillHarm(skill, _round.attack, defend);
			
			_round.defend.push(defend);
		}
	}
}
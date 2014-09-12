package com.game.data.fight
{
	import com.engine.utils.Utilities;
	import com.game.Data;
	import com.game.View;
	import com.game.data.db.protocal.Characters;
	import com.game.data.db.protocal.Enemy;
	import com.game.data.db.protocal.Skill;
	import com.game.data.db.protocal.Status;
	import com.game.data.fight.structure.AttackRoundData;
	import com.game.data.fight.structure.BaseModel;
	import com.game.data.fight.structure.BaseRoundData;
	import com.game.data.fight.structure.Battle_EnemyModel;
	import com.game.data.fight.structure.Battle_WeModel;
	import com.game.data.fight.structure.DefendRoundData;
	import com.game.data.fight.structure.FightRound;
	import com.game.data.fight.structure.Hurt;
	import com.game.data.fight.structure.SkillBuff;
	import com.game.data.player.structure.Player;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;

	// 技能处理
	public class FightSkillUtitiles
	{
		private static var _configData:*;
		private static var _round:FightRound;

		private static var _data:Data;
		
		private static function get player() : Player
		{
			return _data.player.player;
		}
		
		public function FightSkillUtitiles()
		{
			
		}
		
		public static function init(configData:*, round:FightRound) : void
		{
			if (!_data) _data = Data.instance;
			
			_configData = configData;
			_round = round;
		}
		
		/**
		 * 计算技能伤害 
		 * @param skill
		 * @param attack
		 * @param defend
		 * @return 
		 * 
		 */
		public static function countDefendSkillHarm(skill:Skill, attack:AttackRoundData, defend:DefendRoundData) : DefendRoundData
		{		
			var hurtBase:int = FightCommonUtitiles.countCommonHurt(attack, defend);
			// hp
			defend.countRole.hp -= defend.hurtHPValue;
			// 技能内功伤害
			defend.countRole.hp -= defend.NeiGongHurtValue;
			if (defend.countRole.hp < 0) defend.countRole.hp = 0;
			if (defend.countRole.hp > defend.baseRole.hp) defend.countRole.hp = defend.baseRole.hp;			
			defend.remainHP = defend.countRole.hp;
			
			// mp
			defend.hurtMPValue = skill.mp_down * defend.baseRole.mp;
			defend.countRole.mp -= defend.hurtMPValue;
			if (defend.countRole.mp < 0) defend.countRole.mp = 0;
			defend.remainMP = defend.countRole.mp;
			
			return defend;
		}
		
		
		/**
		 *计算技能伤害 
		 * 
		 */		
		public static function countAttackSkillHarm(skill:Skill, attack:AttackRoundData) : void
		{
			/// 攻击
			// hp
			/*
			attack.countRole.hp += attack.baseRole.hp * skill.hp_up;
			if (attack.countRole.hp > attack.baseRole.hp)
			{
				attack.countRole.hp = attack.baseRole.hp;
			}
			attack.remainHP = attack.countRole.hp;*/
			attack.remainHP = attack.countRole.hp;
			
			// mp
			attack.countRole.mp += attack.baseRole.mp * skill.mp_up;
			if (attack.countRole.mp > attack.baseRole.mp)
			{
				attack.countRole.mp = attack.baseRole.mp;
			}
			//消耗技能mp值与等级有关
			//attack.countRole.mp -= (skill.skill_mp + _round.attack.baseRole.lv);
			attack.countRole.mp -= skill.skill_mp;
			if (attack.countRole.mp < 0)
			{
				attack.countRole.mp = 0;
			}
			attack.remainMP = attack.countRole.mp;
		}
		
		/**
		 * 技能BUFF
		 * @param skill
		 * 
		 */		
		public static function countBuff(skill:Skill, attack:AttackRoundData, defend:DefendRoundData, isPlayerKilling:Boolean = false) : void
		{
			var hurt:int = getSkillHpHurt(skill, attack, defend, isPlayerKilling);
			var neiGongHurt:int = getNeiGongHpHurt(skill, attack, isPlayerKilling);
			
			defend.hurtHPValue = hurt;
			defend.NeiGongHurtValue = neiGongHurt;
			
			// 技能状态作用在那方身上 0->敌方，1->我方
			var curStatusModel:BaseModel;
			
			if (skill.choice_status_obj == 1)
			{
				curStatusModel = attack.model;
				handleStatus(hurt, skill, curStatusModel, attack);
				handleEffect(skill, curStatusModel);
			}
			else if (skill.choice_status_obj == 0)
			{
				curStatusModel = defend.model;
				handleStatus(hurt, skill, curStatusModel, defend);
				handleEffect(skill, curStatusModel);
			}
		}
		
		protected static function getNeiGongHpHurt(skill:Skill, attack:AttackRoundData, isPlayerKilling:Boolean = false) : int
		{
			var neiGongHurt:int = 0;
			//非加血技能才有内功伤害
			if(skill.hp_up == 0)
			{
				if(attack.position == V.ME)
				{
					if(isPlayerKilling)
						neiGongHurt = attack.baseRole.ats * (skill.damage_ratio + _data.playerKillingPlayer.player.upgradeSkill.isUpgradeSkill(skill) * 0.01);
					else
						neiGongHurt = attack.baseRole.ats * (skill.damage_ratio + player.upgradeSkill.isUpgradeSkill(skill) * 0.01);
				}
				else
					neiGongHurt = attack.baseRole.ats * skill.damage_ratio;
			}
			return neiGongHurt;
		}
		
		/**
		 * 伤害数值 
		 * @param skill
		 * @return 
		 * 
		 */		
		protected static function getSkillHpHurt(skill:Skill, attack:AttackRoundData, defend:DefendRoundData, isPlayerKilling:Boolean = false) : int
		{
			var totalHurt:int = 0;
			
			// 加血
			if (skill.hp_up != 0)
			{
				if(isPlayerKilling)
					totalHurt = (skill.hp_up + _data.playerKillingPlayer.player.upgradeSkill.isUpgradeSkill(skill) * 0.01) * defend.baseRole.hp;
				else
					totalHurt = (skill.hp_up + player.upgradeSkill.isUpgradeSkill(skill) * 0.01) * defend.baseRole.hp;
				return -totalHurt;
			}
			
			var hurtBase:int = FightCommonUtitiles.countCommonHurt(attack, defend);
			var rate:Number = 0;
			// 是否暴击
			var isCritHit:Boolean = FightCommonUtitiles.countCrit(attack, defend);
			rate = isCritHit ? 2 : 1;
			defend.skillCrit = isCritHit ? true : false;
			
			var buff:SkillBuff;
			// 混沌属性
			if (skill.chaos == 1)
			{
				// 混沌属性对敌方身上有任何状态会使该伤害100%暴击；
				if (rate == 1)
				{
					if (defend.model.curBuffs.length > 0)
					{
						rate = 2;
						defend.skillCrit = true;
					}
				}
			}
			
			// 毒属性
			if (skill.poison == 1)
			{
				// 毒属性则是不会打断角色的睡眠状态，其他属性伤害都会打断角色的睡眠状态  毒属性不暴击
				rate = 1;
				defend.skillCrit = false;
			}
			else
			{
				// 打断睡眠状态
				defend.model.removeBuff(FightConfig.ASLEEP);
			}
			
			// 水属性
			if (skill.water == 1)
			{
				// 水属性对敌方身上有石灰状态的角色会造成30%的额外伤害
				buff = defend.model.getBuff(FightConfig.LINE);
				if (buff)
				{
					rate += buff.status.water_damage;
				}
			}
			
			// 火属性
			if (skill.fire == 1)
			{
				// 火属性对敌方身上有酒醉状态的角色会造成30%的额外伤害
				buff = defend.model.getBuff(FightConfig.DRUNK);
				if (buff)
				{
					rate += buff.status.fire_damage;
				}
			}
			
			// 攻击方为我方
			if(attack.position == V.ME)
				totalHurt = hurtBase * (skill.damage_ratio + player.upgradeSkill.isUpgradeSkill(skill) * 0.01) * rate;
			// 攻击方为敌方
			else
			{
				// 在竞技场中
				if(isPlayerKilling)
					totalHurt = hurtBase * (skill.damage_ratio + _data.playerKillingPlayer.player.upgradeSkill.isUpgradeSkill(skill) * 0.01) * rate;
				// 正常打怪
				else
					totalHurt = hurtBase * skill.damage_ratio * rate;
			}
			
			if (totalHurt < 1) totalHurt = 1;
			
			return totalHurt;
		}
		
		/**
		 * 技能buff
		 * @param hurt
		 * @param skill
		 * @param curStatusModel
		 * 
		 */		
		protected static function handleStatus(hurt:int, skill:Skill, curStatusModel:BaseModel, target:BaseRoundData) : void
		{
			var status:Status;
			var buff:SkillBuff;
			// 毒状态
			if (skill.Damage_time >= 2)
			{
				buff = new SkillBuff();
				buff.buff_name = FightConfig.POISON;
				buff.hurt = hurt;
				buff.status = getStatus("poison");
				buff.time = skill.status_time;
				buff.lastTime = skill.status_time;
				buff.skill_name = skill.skill_name;
				curStatusModel.addBuff(buff);
				target.newBuffs.push(buff);
			}
			
			// 状态持续回合数
			if (skill.status_time <= 0)
			{
				return;
			}
			
			// 醉酒状态
			if (skill.drunk_status == 1)
			{
				buff = new SkillBuff();
				buff.buff_name = FightConfig.DRUNK;
				buff.hurt = 0;
				buff.status = getStatus("drunk");
				buff.time = skill.status_time;
				buff.lastTime = skill.status_time;
				buff.skill_name = skill.skill_name;
				curStatusModel.addBuff(buff);
				target.newBuffs.push(buff);
			}
			
			// 晕阙状态
			if (skill.syncope_status == 1)
			{
				buff = new SkillBuff();
				buff.buff_name = FightConfig.SYNCOPE;
				buff.hurt = 0;
				buff.status = getStatus("syncope");
				buff.time = skill.status_time;
				buff.lastTime = skill.status_time;
				buff.skill_name = skill.skill_name;
				curStatusModel.addBuff(buff);
				target.newBuffs.push(buff);
			}
			
			// 石灰状态
			if (skill.lime_status == 1)
			{
				buff = new SkillBuff();
				buff.buff_name = FightConfig.LINE;
				buff.hurt = 0;
				buff.status = getStatus("lime");
				buff.time = skill.status_time;
				buff.lastTime = skill.status_time;
				buff.skill_name = skill.skill_name;
				curStatusModel.addBuff(buff);
				target.newBuffs.push(buff);
			}
			
			// 睡眠状态
			if (skill.asleep_status == 1)
			{
				buff = new SkillBuff();
				buff.buff_name = FightConfig.ASLEEP;
				buff.hurt = 0;
				buff.status = getStatus("asleep");
				buff.time = skill.status_time;
				buff.lastTime = skill.status_time;
				buff.skill_name = skill.skill_name;
				curStatusModel.addBuff(buff);
				target.newBuffs.push(buff);
			}
			
			// 混乱状态
			if (skill.confusion_status == 1)
			{
				buff = new SkillBuff();
				buff.buff_name = FightConfig.CONFUSION;
				buff.hurt = 0;
				buff.status = getStatus("confusion");
				buff.time = skill.status_time;
				buff.lastTime = skill.status_time;
				buff.skill_name = skill.skill_name;
				curStatusModel.addBuff(buff);
				target.newBuffs.push(buff);
			}
		}
		
		/**
		 * 技能效果（增加或减少某种属性） 
		 * @param skill
		 * @param curStatusModel
		 * 
		 */		
		protected static function handleEffect(skill:Skill, curStatusModel:BaseModel) : void
		{
			var effect:SkillEffectProperty = new SkillEffectProperty();
			
			for (var key:String in effect)
			{
				if (skill.hasOwnProperty(key))
				{
					effect[key] = skill[key];
				}
			}
			
			curStatusModel.addEffect(effect);
		}
		
		
		/**
		 * 获取buff-status
		 * @param skill
		 * @return 
		 * 
		 */		
		protected static function getStatus(status_name:String) : Status
		{
			var status:Status;
			
			_data.db.interfaces(
				InterfaceTypes.GET_STATUS_DATA,
				status_name, 
				function (data:Status) : void
				{
					status = data;
				}
			);
			
			return status;
		}
		
		public static function getSpecial(attackModel:BaseModel) : Skill
		{
			var skills:Vector.<Skill>;
			
			var commonAttackPoint:int;
			
			skills = getSkills(_round.attack.model.skills, _round.attack.countRole.mp);
			
			var skill:Skill;
			if(skills.length > 0)
				skill = skills[0];
			
			return skill;
		}
		
		/**
		 * 计算出手方式 
		 * @param attack
		 * @param attackModel
		 * @return 
		 * 
		 */		
		public static function getWayOut(attackModel:BaseModel) : Skill
		{
			var skills:Vector.<Skill>;
			
			var commonAttackPoint:int;
			
			skills = getSkills(_round.attack.model.skills, _round.attack.countRole.mp);
			
			//根据元气减少普通攻击触发的数值
			if(_round.attack.position == V.ME)
				commonAttackPoint = _round.attack.baseRole.atk_point - int(_round.attack.baseRole.mp / 40);
			else
				commonAttackPoint = _round.attack.baseRole.atk_point;
			
			//普通攻击触发数值小于0的情况
			if(commonAttackPoint <= 0)
			{
				if(_round.attack.baseRole.name == V.MOON_ENEMY)
					commonAttackPoint = 0;
				else
					commonAttackPoint = _round.attack.baseRole.atk_point;
			}
			
			var skillRates:Vector.<int> = new Vector.<int>();
			var skillTotals:uint = 0;
			
			// 普通攻击
			skillRates.push(commonAttackPoint);
			skillTotals += commonAttackPoint;			
			for (var i:int = 0; i <　skills.length; i++) 
			{
				skillTotals += (skills[i] as Skill).skill_point;
				skillRates.push((skills[i] as Skill).skill_point);
			}
			
			var rate:uint = Utilities.GetRandomIntegerInRange(0, skillTotals);
			
			var curRates:uint = 0;
			for (var j:int = 0; j <　skillRates.length; j++)
			{
				curRates += skillRates[j];
				
				if (rate <= curRates)
				{
					break;
				}
			}
			
			var skill:Skill;
			// 普通攻击
			if (j == 0)
			{
				
			}
			else// 技能
			{
				skill = skills[j-1];
			}
			
			// test(先播放技能)
			//if (skills.length >= 1) skill = skills[0];
			
			return skill;
		}
		
		/**
		 * 过滤由于mp值不够的技能 
		 * @param data
		 * @param mp
		 * @return 
		 * 
		 */		
		protected static function getSkills(data:Vector.<Skill>, mp:int) : Vector.<Skill>
		{
			var skills:Vector.<Skill> = new Vector.<Skill>();
			
			for each(var item:Skill in data)
			{
				//消耗技能mp跟等级有关
				//if ((item.skill_mp + _round.attack.baseRole.lv) <= mp)
				if (item.skill_mp <= mp)
				{
					skills.push(item);
				}
			}
			
			return skills;
		}
	}
}
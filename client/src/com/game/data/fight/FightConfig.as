package com.game.data.fight
{
	import com.game.template.V;

	public class FightConfig
	{
		/**
		 * 系数 
		 */		
		//public static const RATIO:Number = 0.0005;
		public static function get RATIO() : Number
		{
			if (!V.anti["RATIO"])
			{
				V.anti["RATIO"] = 0.0005;
			}
			
			return V.anti["RATIO"];
		}
				
		
		public static const ATTACK:String = "attack";
		
		public static const DEFEND:String = "defend";
		
		
		/*********************攻击类型***********************************/
		/**
		 * 混乱攻击 
		 */		
		public static const CONFUSION_ATTACK:String = "CONFUSION_ATTACK";		
		/**
		 * 技能伤害 
		 */		
		public static const SKILL_ATTACK:String = "SKILL_ATTACK";
		
		/**
		 *  角色最终正常伤害值
		 */		
		public static const COMMON_HURT:String = "common_hurt";
		/**
		 *  角色最终格挡伤害值
		 */
		public static const BLOCK_HURT:String = "block_hurt";
		/**
		 *  角色最终暴击伤害值
		 */		
		public static const CRIT_HURT:String = "crit_hurt";
		/**
		 *  内功伤害 
		 */
		public static const IN_HURT:String = "in_hurt";
		/**
		 * 闪避 
		 */
		public static const DODGE:String = "dodge";
		
		/*********************buff 类型*********************************/		
		public static const DRUNK:String = "酒醉状态";
		
		public static const SYNCOPE:String = "晕厥状态";
		
		public static const POISON:String = "中毒状态";
		
		public static const LINE:String = "石灰状态";
		
		public static const ASLEEP:String = "睡眠状态";
		
		public static const CONFUSION:String = "混乱状态";
		
		
		/*******************buff 影响属性********************************/
		// 精准值
		public static const HIT:String = "hit_down";
		// 韧性值
		public static const TOUGHNESS:String = "toughness_down";
		// 火焰附加伤害
		public static const FIRE_DAMAGE:String = "fire_damage";
		// 水附加伤害
		public static const WATER_DAMAGE:String = "water_damage";
		
		
		/*******************角色属性伤害**************************/
		//技能使得，角色外功值增加或者减少的值
		public static const ATK_UP:String = "atk_up";
		//技能使得，角色根骨值增加或者减少的值
		public static const DEF_UP:String = "def_up";
		//技能使得，角色步法值增加或者减少的值
		public static const SPD_UP:String = "spd_up";
		//技能使得，角色灵活值增加或者减少的值
		public static const EVASION_UP:String = "evasion_up";
		//技能使得，角色暴击值增加或者减少的值
		public static const CRIT_UP:String = "crit_up";
		//技能使得，角色精准值增加或者减少的值
		public static const HIT_UP:String = "hit_up";
		//技能使得，角色韧性值增加或者减少的值
		public static const TOUGHNESS_UP:String = "toughness_up";
		//技能使得，角色内功值增加或者减少的值
		public static const ATS_UP:String = "ats_up";
		//技能使得，角色罡气值增加或者减少的值
		public static const ADF_UP:String = "adf_up";
		
		public static const BLOCK_UP:String = "block_up";
		
		
		/***************************Buff 数值 **************************/		
		//public static const CONFUSION_RATE:Number = 0.5;
		public static function get CONFUSION_RATE() : Number
		{
			if (!V.anti["CONFUSION_RATE"])
			{
				V.anti["CONFUSION_RATE"] = 0.5;
			}
			
			return V.anti["CONFUSION_RATE"];
		}
		
		/***************************攻击范围************************/
		// 单体
		public static const SINGLE_ATTACK:String = "单体";
		// 群体
		public static const GROUP_ATTACK:String = "群体";
		// 固定
		public static const FIXED:String = "固定";
		// 随机
		public static const RANDOM:String = "random";
		
		/***************************怪物类型**************************/
		/**
		 * 普通怪物 
		 */		
		public static const COMMON_MONSTER:String = "common_monster";
		/**
		 * 精英怪物 
		 */		
		public static const ECS_MONSTER:String = "ecs_monster";
		/**
		 * BOSS
		 */		
		public static const BOSS_MONSTER:String = "boss_monster";
		
		/**
		 *  前锋
		 */
		public static const FRONT_POS:String = "front";
		/**
		 * 中坚 
		 */		
		public static const MIDDLE_POS:String = "middle";
		/**
		 * 大将 
		 */		
		public static const BACK_POS:String = "back";
		/**
		 * 无站位 
		 */		
		public static const NONE_POS:String = "none";
		
		/**
		 * 我方 
		 */		
		public static const WE:String = "我";
		/**
		 * 敌方 
		 */		
		public static const ENEMY:String = "敌";
	}
}
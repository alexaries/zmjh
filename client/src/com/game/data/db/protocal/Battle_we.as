
package com.game.data.db.protocal
{
	public class Battle_we extends Object
	{
		
		
		/**
		 * 关联buff表，是否拥有战神附体的buff，0->否，1->是
		 */
		public var full_buff:int;
		
		
		/**
		 * 关联fight_soul表def（根骨）的级数加成
		 */
		public var fight_soul_def_lv:int;
		
		
		/**
		 * 关联equipment表的装备名字
		 */
		public var equipment_clothes:int;
		
		
		/**
		 * 关联buff表，是否拥有寿星附体的buff，0->否，1->是
		 */
		public var health_buff:int;
		
		
		/**
		 * 
		 */
		public var id:int;
		
		
		/**
		 * 关联fight_soul表adf（罡气）的级数加成
		 */
		public var fight_soul_adf_lv:int;
		
		
		/**
		 * 关联buff表，是否拥有衰神附体的buff，0->否，1->是
		 */
		public var fuck_debuff:int;
		
		
		/**
		 * 关联fight_soul表atk（外功）的级数加成
		 */
		public var fight_soul_atk_lv:int;
		
		
		/**
		 * 关联fight_soul表hit（精准）的级数加成
		 */
		public var fight_soul_hit_lv:int;
		
		
		/**
		 * 关联chracters表的角色名字
		 */
		public var characters_name:String;
		
		
		/**
		 * 第一个技能名字
		 */
		public var skill_name_1:String;
		
		
		/**
		 * 关联equipment表的装备名字
		 */
		public var equipment_thing:int;
		
		
		/**
		 * 关联quality_up表增加的数值，该处写品级，1为白色，2为绿色，以此类推
		 */
		public var characters_quality:int;
		
		
		/**
		 * 关联fight_soul表ats（内功）的级数加成
		 */
		public var fight_soul_ats_lv:int;
		
		
		/**
		 * 关联level_up表增加数值，该处写等级数字
		 */
		public var characters_lv:int;
		
		
		/**
		 * 关联fight_soul表spd（速度）的级数加成
		 */
		public var fight_soul_spd_lv:int;
		
		
		/**
		 * 关联fight_soul表hp（体力）的级数加成
		 */
		public var fight_soul_hp_lv:int;
		
		
		/**
		 * 关联fight_soul表cirt（暴击）的级数加成
		 */
		public var fight_soul_crit_lv:int;
		
		
		/**
		 * 关联fight_soul表mp（元气）的级数加成
		 */
		public var fight_soul_mp_lv:int;
		
		
		/**
		 * 关联buff表，是否拥有财神附体的buff，0->否，1->是
		 */
		public var money_buff:int;
		
		
		/**
		 * 关联equipment表的装备名字
		 */
		public var equipment_weapon:int;
		
		
		/**
		 * 第二个技能名字
		 */
		public var skill_name_2:String;
		
		
		/**
		 * 第三个技能名字
		 */
		public var skill_name_3:String;
		
		
		/**
		 * 关联buff表，是否拥有福星附体的buff，0->否，1->是
		 */
		public var exp_buff:int;
		
		
		/**
		 * 关联fight_soul表evasion（灵活）的级数加成
		 */
		public var fight_soul_evasion_lv:int;
		
		
		/**
		 * 关联fight_soul表toughness（韧性）的级数加成
		 */
		public var fight_soul_toughness_lv:int;
		
		
		/**
		 * 关联buff表，是否拥有恶星附体的buff，0->否，1->是
		 */
		public var health_debuff:int;
		
		
		public function Battle_we()
		{
			
		}
		
		public function assign(data:XML) : void
		{
			
			
			full_buff = data.@full_buff
			
			
			fight_soul_def_lv = data.@fight_soul_def_lv
			
			
			equipment_clothes = data.@equipment_clothes
			
			
			health_buff = data.@health_buff
			
			
			id = data.@id
			
			
			fight_soul_adf_lv = data.@fight_soul_adf_lv
			
			
			fuck_debuff = data.@fuck_debuff
			
			
			fight_soul_atk_lv = data.@fight_soul_atk_lv
			
			
			fight_soul_hit_lv = data.@fight_soul_hit_lv
			
			
			characters_name = data.@characters_name
			
			
			skill_name_1 = data.@skill_name_1
			
			
			equipment_thing = data.@equipment_thing
			
			
			characters_quality = data.@characters_quality
			
			
			fight_soul_ats_lv = data.@fight_soul_ats_lv
			
			
			characters_lv = data.@characters_lv
			
			
			fight_soul_spd_lv = data.@fight_soul_spd_lv
			
			
			fight_soul_hp_lv = data.@fight_soul_hp_lv
			
			
			fight_soul_crit_lv = data.@fight_soul_crit_lv
			
			
			fight_soul_mp_lv = data.@fight_soul_mp_lv
			
			
			money_buff = data.@money_buff
			
			
			equipment_weapon = data.@equipment_weapon
			
			
			skill_name_2 = data.@skill_name_2
			
			
			skill_name_3 = data.@skill_name_3
			
			
			exp_buff = data.@exp_buff
			
			
			fight_soul_evasion_lv = data.@fight_soul_evasion_lv
			
			
			fight_soul_toughness_lv = data.@fight_soul_toughness_lv
			
			
			health_debuff = data.@health_debuff
			
		}
	}
}

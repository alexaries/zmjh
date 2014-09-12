package com.game.data.playerKilling
{
	import com.game.data.db.protocal.Battle_we;
	import com.game.data.fight.FightConfig;
	import com.game.data.player.structure.FightAttachInfo;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.RoleInfo;
	import com.game.data.player.structure.RoleModel;
	public class PlayerKillingFightDataUtitlies
	{
		public function PlayerKillingFightDataUtitlies()
		{
		}
		
		public static function convertPlayerToBattleData(player:PlayerKillingPlayer) : Object
		{
			var data:Object = {"1":{}, "2":{}, "3":{}};
			
			var model:PlayerKillingModel;
			// 前锋
			if (player.formation.front && player.formation.front != "")
			{
				model = player.getRoleModel(player.formation.front);
				data["1"] = model;
			}
			
			// 中坚
			if (player.formation.middle && player.formation.middle != "")
			{
				model = player.getRoleModel(player.formation.middle);
				data["2"] = model;
			}
			
			// 大将
			if (player.formation.back && player.formation.back != "")
			{
				model = player.getRoleModel(player.formation.back);
				data["3"] = model;
			}
			
			return data;
		}
		
		public static function getBattleWe(player:PlayerKillingPlayer, role:RoleInfo, type:String) : Battle_we
		{
			var battle:Battle_we = new Battle_we();
			
			battle.characters_lv = role.lv;
			battle.characters_name = role.roleName;
			battle.characters_quality = role.quality;
			
			// 技能
			battle.skill_name_1 = role.skill.skill1;
			battle.skill_name_2 = role.skill.skill2;
			battle.skill_name_3 = role.skill.skill3;
			
			// 装备
			battle.equipment_weapon = role.equip.weapon;
			battle.equipment_clothes = role.equip.cloth;
			battle.equipment_thing = role.equip.thing;
			
			// 战附
			battle.fight_soul_hp_lv = ((type == FightConfig.NONE_POS || type == "") || type == "") ? 0 : (player.fightAttach[type] as FightAttachInfo).hp;
			battle.fight_soul_mp_lv = (type == FightConfig.NONE_POS || type == "") ? 0 : (player.fightAttach[type] as FightAttachInfo).mp;
			battle.fight_soul_atk_lv = (type == FightConfig.NONE_POS || type == "") ? 0 : (player.fightAttach[type] as FightAttachInfo).atk;
			battle.fight_soul_def_lv = (type == FightConfig.NONE_POS || type == "") ? 0 : (player.fightAttach[type] as FightAttachInfo).def;
			battle.fight_soul_spd_lv = (type == FightConfig.NONE_POS || type == "") ? 0 : (player.fightAttach[type] as FightAttachInfo).spd;
			battle.fight_soul_evasion_lv = (type == FightConfig.NONE_POS || type == "") ? 0 : (player.fightAttach[type] as FightAttachInfo).evasion;
			battle.fight_soul_crit_lv = (type == FightConfig.NONE_POS || type == "") ? 0 : (player.fightAttach[type] as FightAttachInfo).crit;
			battle.fight_soul_hit_lv = (type == FightConfig.NONE_POS || type == "") ? 0 : (player.fightAttach[type] as FightAttachInfo).hit;
			battle.fight_soul_toughness_lv = (type == FightConfig.NONE_POS || type == "") ? 0 : (player.fightAttach[type] as FightAttachInfo).toughness;
			battle.fight_soul_ats_lv = (type == FightConfig.NONE_POS || type == "") ? 0 : (player.fightAttach[type] as FightAttachInfo).ats;
			battle.fight_soul_adf_lv = (type == FightConfig.NONE_POS || type == "") ? 0 : (player.fightAttach[type] as FightAttachInfo).adf;
			
			return battle;
		}
	}
}
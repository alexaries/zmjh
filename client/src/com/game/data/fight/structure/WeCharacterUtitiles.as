package com.game.data.fight.structure
{
	import com.game.Data;
	import com.game.View;
	import com.game.data.db.protocal.Battle_we;
	import com.game.data.db.protocal.Characters;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.db.protocal.Equipment_strengthen;
	import com.game.data.db.protocal.Fight_soul;
	import com.game.data.db.protocal.Level_up;
	import com.game.data.db.protocal.Quality_up;
	import com.game.data.db.protocal.Skill;
	import com.game.data.equip.EquipConfig;
	import com.game.data.fight.FightConfig;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.RoleInfo;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;

	public class WeCharacterUtitiles
	{
		private static var _data:Data = Data.instance;
		
		public function WeCharacterUtitiles()
		{
			
		}
		
		/**
		 * 计算总角色属性 
		 * 
		 */		
		public static const CountProperty:Array = ["hp", "mp", "atk", "def", "spd", "evasion", "crit", "hit", "toughness", "ats", "adf", "atk_point", "crit_rate", "evasion_rate", "block_rate"];
		public static function countCharater(_characters:Array, config:Battle_we) : Characters
		{
			var model:Characters = new Characters();
			
			for each(var proper:String in CountProperty)
			{
				for each(var role:Characters in _characters)
				{
					model[proper] += role[proper];
				}
			}
			
			model.name = config.characters_name;			
			// 重设等级
			model.lv = config.characters_lv;
			
			return model;
		}
		
		/**
		 * 基础 
		 * 
		 */		
		public static function getCharacterBaseData(roleName:String) : Characters
		{
			var _characterConfig:Characters;
			_data.db.interfaces(InterfaceTypes.GET_ROLE_BASE_DATA, V.ME, roleName, callback);
			
			function callback(data:Characters) : void
			{
				_characterConfig = data;
			}
			
			return _characterConfig;
		}
		
		/**
		 * 等级 
		 * 
		 */		
		public static function getCharacterLVData(player:*, lv:int, roleName:String, _characterConfig:Characters) : Characters
		{
			var lv:int = lv - 1;			
			if (lv < 0) lv = 0;
			
			var lvData:Characters = new Characters();
			
			_data.db.interfaces(
				InterfaceTypes.GET_ROLE_LV__DATA,
				V.ME,
				roleName,
				callback);
			
			function callback(data:Level_up) : void
			{
				lvData.hp = lv * data.hp * _characterConfig.hp;
				lvData.mp = lv * data.mp * _characterConfig.mp;
				lvData.atk = lv * data.atk * _characterConfig.atk;
				lvData.def = lv * data.def * _characterConfig.def;
				
				if(roleName.split("（")[0] == V.MAIN_ROLE_NAME.split("（")[0])
				{
					var fashionData:Characters = player.roleFashionInfo.additionProperty(lvData, _characterConfig);
					var titleData:Characters = player.roleTitleInfo.additionProperty(player, lvData, _characterConfig);
					lvData.hp += (fashionData.hp + titleData.hp);
					lvData.mp += (fashionData.mp + titleData.mp);
					lvData.atk += (fashionData.atk + titleData.atk);
					lvData.def += (fashionData.def + titleData.def);
					lvData.spd += (fashionData.spd + titleData.spd);
					lvData.evasion += (fashionData.evasion + titleData.evasion);
					lvData.crit += (fashionData.crit + titleData.crit);
				}
			}
			
			return lvData;
		}
		
		/**
		 * 下一等级经验 
		 * @param lv
		 * @param roleName
		 * @param _characterConfig
		 * @return 
		 * 
		 */		
		public static function getNextExpData(lv:int, roleName:String) : int
		{
			var exp:int = 0;
			
			var lvData:Object = _data.db.interfaces(InterfaceTypes.GET_NEXT_EXP_DATA, lv);
			exp = lvData.exp;
			
			/*function callback(data:Level_up) : void
			{
				//exp = lv * data.exp_add;
				lv -= 1;
				exp = data.exp_add * lv * lv + data.exp_add * lv + data.basic_exp;
			}*/
			
			return exp;
		}
		
		/**
		 * 品质 
		 * 
		 */		
		public static function getQualityData(lv:int, roleName:String) : Characters
		{
			var lv:int = lv - 1;			
			if (lv < 0) lv = 0;
			
			var qualityData:Characters = new Characters();
			
			if (lv == 0) return qualityData;
			
			_data.db.interfaces(
				InterfaceTypes.GET_ROLE_QUALITY,
				V.ME,
				roleName,
				callback);
			
			function callback(data:Quality_up) : void
			{
				qualityData.spd = data.spd * lv;
				qualityData.evasion = data.evasion * lv;
				qualityData.crit = data.crit * lv;
				qualityData.hit = data.hit * lv;
				qualityData.toughness = data.toughness * lv;
				qualityData.ats = data.ats * lv;
				
				/*if(roleName == V.MAIN_ROLE_NAME && _data.player.player.roleFashionInfo.checkFashionUse(V.MAIN_ROLE_NAME) != "")
				{
					qualityData.spd *= (1 + FASHIONADDITIONPROPERTY);
					qualityData.evasion *= (1 + FASHIONADDITIONPROPERTY);
					qualityData.crit *= (1 + FASHIONADDITIONPROPERTY);
				}*/
			}
			
			return qualityData;
		}
		
		// 所有装备基础 
		private static var _weaponCharacter:Characters;
		private static var _clothesCharacter:Characters;
		private static var _thingCharacter:Characters;
		public static function getTotalEquipBaseData(config:Battle_we, isPlayerKilling:Boolean = false) : Characters
		{
			var equipCharacter:Characters = new Characters();
			
			_weaponCharacter = new Characters();
			_clothesCharacter = new Characters();
			_thingCharacter = new Characters();
			
			// 武器
			getEquipBaseData(config.equipment_weapon, _weaponCharacter, isPlayerKilling);
			// 衣服
			getEquipBaseData(config.equipment_clothes, _clothesCharacter, isPlayerKilling);
			// 饰品
			getEquipBaseData(config.equipment_thing, _thingCharacter, isPlayerKilling);
			
			countTotalEquip(equipCharacter);
			
			return equipCharacter;
		}
		
		private static function getEquipBaseData(mid:int, targetCharacter:Characters, isPlayerKilling:Boolean = false) : void
		{
			if (mid == -1) return;
			var equipModel:EquipModel
			if(!isPlayerKilling)
				equipModel = _data.pack.getEquipModelByMID(mid);
			else
				equipModel = _data.playerKillingPack.getEquipModelByMID(mid);
			targetCharacter.hit = equipModel.config.hit;
			targetCharacter.toughness = equipModel.config.toughness;
			targetCharacter.ats = equipModel.config.ats;
			targetCharacter.adf = equipModel.config.adf;
			
			/// atk def spd 每把武器随机
			targetCharacter.atk = equipModel.atk;
			targetCharacter.def = equipModel.def;
			targetCharacter.spd = equipModel.spd;
			targetCharacter.hp = equipModel.hp;
			targetCharacter.mp = equipModel.mp;
			targetCharacter.evasion = equipModel.evasion;
			targetCharacter.crit = equipModel.crit;
		}
		
		private static function countTotalEquip(equipCharacter:Characters) : void
		{
			add(_weaponCharacter);
			add(_clothesCharacter);
			add(_thingCharacter);
			
			function add(targetCharacter:Characters) : void
			{
				equipCharacter.hp += targetCharacter.hp;
				equipCharacter.mp += targetCharacter.mp;
				equipCharacter.atk += targetCharacter.atk;
				equipCharacter.def += targetCharacter.def;
				equipCharacter.spd += targetCharacter.spd;
				equipCharacter.evasion += targetCharacter.evasion;
				equipCharacter.crit += targetCharacter.crit;
				equipCharacter.hit += targetCharacter.hit;
				equipCharacter.toughness += targetCharacter.toughness;
				equipCharacter.ats += targetCharacter.ats;
				equipCharacter.adf += targetCharacter.adf;
			}
		}
		
		
		private static var _weaponComposeCharacter:Characters;
		private static var _clothesComposeCharacter:Characters;
		private static var _thingComposeCharacter:Characters;
		/**
		 * 装备充灵
		 * @param config
		 * @return 
		 * 
		 */		
		public static function getTotalComposeEquipData(config:Battle_we, isPlayerKilling:Boolean = false) : Characters
		{
			var equipCharacter:Characters = new Characters();
			
			_weaponComposeCharacter = new Characters();
			_clothesComposeCharacter = new Characters();
			_thingComposeCharacter = new Characters();
			
			// 武器
			getEquipComposeData(config.equipment_weapon, _weaponComposeCharacter, isPlayerKilling);
			// 衣服
			getEquipComposeData(config.equipment_clothes, _clothesComposeCharacter, isPlayerKilling);
			// 饰品
			getEquipComposeData(config.equipment_thing, _thingComposeCharacter, isPlayerKilling);
			
			countTotalComposeEquip(equipCharacter);
			
			return equipCharacter;
		}
		
		private static function getEquipComposeData(mid:int, targetCharacter:Characters, isPlayerKilling:Boolean) : void
		{
			if (mid == -1) return;
			
			var equipModel:EquipModel;
			if(!isPlayerKilling)
				equipModel = _data.pack.getEquipModelByMID(mid);
			else
				equipModel = _data.playerKillingPack.getEquipModelByMID(mid);
			
			/// atk def spd 每把武器随机
			targetCharacter.atk_compose = equipModel.atk_compose;
			targetCharacter.def_compose = equipModel.def_compose;
			targetCharacter.spd_compose = equipModel.spd_compose;
			targetCharacter.hp_compose = equipModel.hp_compose;
			targetCharacter.mp_compose = equipModel.mp_compose;
			targetCharacter.evasion_compose = equipModel.evasion_compose;
			targetCharacter.crit_compose = equipModel.crit_compose;
		}
		
		private static function countTotalComposeEquip(equipCharacter:Characters) : void
		{
			add(_weaponComposeCharacter);
			add(_clothesComposeCharacter);
			add(_thingComposeCharacter);
			
			function add(targetCharacter:Characters) : void
			{
				equipCharacter.hp += targetCharacter.hp_compose;
				equipCharacter.mp += targetCharacter.mp_compose;
				equipCharacter.atk += targetCharacter.atk_compose;
				equipCharacter.def += targetCharacter.def_compose;
				equipCharacter.spd += targetCharacter.spd_compose;
				equipCharacter.evasion += targetCharacter.evasion_compose;
				equipCharacter.crit += targetCharacter.crit_compose;
			}
		}
		
		/**
		 * 装备强化 
		 * 
		 */
		private static var _weaponLVCharacter:Characters;
		private static var _clothesLVCharacter:Characters;
		private static var _thingLVCharacter:Characters;
		public static function getTotalEquipLVData(info:RoleInfo, isPlayerKilling:Boolean = false) : Characters
		{
			var equipLVData:Characters = new Characters();
			
			_weaponLVCharacter = new Characters();
			_clothesLVCharacter = new Characters();
			_thingLVCharacter = new Characters();
			
			getEquipLVData(info.equip.weapon, EquipConfig.WEAPON, _weaponLVCharacter, isPlayerKilling);
			getEquipLVData(info.equip.cloth,  EquipConfig.CLOTHES, _clothesLVCharacter, isPlayerKilling);
			getEquipLVData(info.equip.thing,  EquipConfig.THING, _thingLVCharacter, isPlayerKilling);
			
			countTotalEquipLV(equipLVData);
			
			return equipLVData;
		}
		private static function getEquipLVData(mid:int, type:String, targetCharacter:Characters, isPlayerKilling:Boolean) : void
		{
			if (mid == -1) return;
			
			var equipModel:EquipModel;
			if(!isPlayerKilling)
				equipModel = _data.pack.getEquipModelByMID(mid);
			else
				equipModel = _data.playerKillingPack.getEquipModelByMID(mid);
			
			var lv:int = equipModel.lv;
			lv = lv - 1;
			
			if (lv < 0) lv = 0;
			
			var config:Characters;
			switch (type)
			{
				case EquipConfig.WEAPON:
					config = _weaponCharacter;
					break;
				case EquipConfig.CLOTHES:
					config = _clothesCharacter;
					break;
				case EquipConfig.THING:
					config = _thingCharacter;
					break;
			}
			
			var lvData:Array = View.instance.controller.equip.getEquipmentLv(equipModel);
			targetCharacter.atk = lvData[0];
			targetCharacter.def = lvData[1];
			targetCharacter.spd = lvData[2];
			
			/*_data.db.interfaces(
				InterfaceTypes.GET_EQUIP_LV_DATA,
				type,
				callback);
			
			function callback(data:Equipment_strengthen) : void
			{
				targetCharacter.atk = data.atk_add * config.atk * lv;
				targetCharacter.def = data.def_add * config.def * lv;
				targetCharacter.spd = data.spd_add * config.spd * lv;
			}*/
		}
		
		private static function countTotalEquipLV(equipLVData:Characters) : void
		{
			add(_weaponLVCharacter);
			add(_clothesLVCharacter);
			add(_thingLVCharacter);
			
			function add(targetCharacter:Characters) : void
			{
				equipLVData.atk += targetCharacter.atk;
				equipLVData.def += targetCharacter.def;
				equipLVData.spd += targetCharacter.spd;
			}
		}
		
		/**
		 * 附体
		 * 
		 */	
		public static function getFightSoulLV(config:Battle_we, position:String) : Characters
		{
			var fightSoulLV:Characters = new Characters();
			
			_data.db.interfaces(InterfaceTypes.GET_FIGHT_SOUL_LV, position, callback);
			
			function callback(data:Fight_soul) : void
			{
				fightSoulLV.hp = (position == FightConfig.NONE_POS || position == "") ? 0 : config.fight_soul_hp_lv * data.hp;
				fightSoulLV.mp = (position == FightConfig.NONE_POS || position == "") ? 0 : config.fight_soul_mp_lv * data.mp;
				fightSoulLV.atk = (position == FightConfig.NONE_POS || position == "") ? 0 : config.fight_soul_atk_lv * data.atk;
				fightSoulLV.def = (position == FightConfig.NONE_POS || position == "") ? 0 : config.fight_soul_def_lv * data.def;
				fightSoulLV.spd = (position == FightConfig.NONE_POS || position == "") ? 0 : config.fight_soul_spd_lv * data.spd;
				fightSoulLV.evasion = (position == FightConfig.NONE_POS || position == "") ? 0 : config.fight_soul_evasion_lv * data.evasion;
				fightSoulLV.crit = (position == FightConfig.NONE_POS || position == "") ? 0 : config.fight_soul_crit_lv * data.crit;
				fightSoulLV.hit = (position == FightConfig.NONE_POS || position == "") ? 0 : config.fight_soul_hit_lv * data.hit;
				fightSoulLV.toughness = (position == FightConfig.NONE_POS || position == "") ? 0 : config.fight_soul_toughness_lv * data.toughness;
				fightSoulLV.ats = (position == FightConfig.NONE_POS || position == "") ? 0 : config.fight_soul_ats_lv * data.ats;
				fightSoulLV.adf = (position == FightConfig.NONE_POS || position == "") ? 0 : config.fight_soul_adf_lv * data.adf;
			}
			
			return fightSoulLV;
		}
		
		private static var _strengthData:Vector.<Object>;
		
		public static function getNeiGongLV(config:Battle_we, position:String, roleName:String) : Characters
		{
			if(_strengthData == null)
			{
				_strengthData = new Vector.<Object>();
				_strengthData = _data.db.interfaces(InterfaceTypes.GET_STRENGTH_DATA);
			}
			var neiGongLV:Characters = new Characters();
			if(config.fight_soul_ats_lv == 0)
				neiGongLV.ats = 0;
			else
				neiGongLV.ats = (position == FightConfig.NONE_POS || position == "") ? 0 : _strengthData[config.fight_soul_ats_lv - 1].ads;
			
			if(config.fight_soul_adf_lv == 0)
				neiGongLV.adf = 0;
			else
				neiGongLV.adf = (position == FightConfig.NONE_POS || position == "") ? 0 : _strengthData[config.fight_soul_adf_lv - 1].adf;
			
			return neiGongLV;
		}
		
		/**
		 * 技能 
		 * 
		 */		
		public static function getSkillDatas(config:Battle_we) : Vector.<Skill>
		{
			var skills:Vector.<Skill> = new Vector.<Skill>();
			
			for (var i:int = 1; i <= 3; i++)
			{
				if (config["skill_name_" + i].length > 0)
				{
					CreateSkillData(config["skill_name_" + i], skills);
				}
			}
			
			return skills;
		}
		
		public static function CreateSkillData(skillName:String, skills:Vector.<Skill>) : void
		{
			_data.db.interfaces(InterfaceTypes.GET_SKILL_DATA, skillName, callback);
			
			function callback(data:Skill) : void
			{
				skills.push(data);
			}
		}
	}
}
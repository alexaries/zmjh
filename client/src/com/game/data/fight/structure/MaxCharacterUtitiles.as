package com.game.data.fight.structure
{
	import com.game.Data;
	import com.game.data.db.protocal.Battle_we;
	import com.game.data.db.protocal.Characters;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.db.protocal.Equipment_strengthen;
	import com.game.data.db.protocal.Fight_soul;
	import com.game.data.equip.EquipConfig;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.RoleInfo;
	import com.game.template.InterfaceTypes;

	public class MaxCharacterUtitiles
	{
		private static var _data:Data = Data.instance;
		
		public function MaxCharacterUtitiles()
		{
		}
		
		/**
		 * 计算总角色属性 
		 * 
		 */		
		public static const CountProperty:Array = ["hp", "mp", "atk", "def", "spd", "evasion", "crit"];
		public static function countCharater(_characters:Array) : Characters
		{
			var model:Characters = new Characters();
			
			for each(var proper:String in CountProperty)
			{
				for each(var role:Characters in _characters)
				{
					model[proper] += role[proper];
				}
			}
			
			return model;
		}
		
		public static function getMaxFightSoulLV(maxLv:int) : Characters
		{
			var maxFightSoul:Characters = new Characters();
			
			_data.db.interfaces(InterfaceTypes.GET_FIGHT_SOUL_LV, "front", callback);
			
			function callback(data:Fight_soul) : void
			{
				maxFightSoul.hp = maxLv * data.hp;
				maxFightSoul.mp = maxLv * data.mp;
				maxFightSoul.atk = maxLv * data.atk;
				maxFightSoul.def = maxLv * data.def;
				maxFightSoul.spd =  maxLv * data.spd;
				maxFightSoul.evasion = maxLv * data.evasion;
				maxFightSoul.crit = maxLv * data.crit;
				maxFightSoul.hit = maxLv * data.hit;
				maxFightSoul.toughness = maxLv * data.toughness;
				maxFightSoul.ats = maxLv * data.ats;
				maxFightSoul.adf = maxLv * data.adf;
			}
			
			return maxFightSoul;
		}
		
		// 所有装备基础 
		private static var _weaponCharacter:Characters;
		private static var _clothesCharacter:Characters;
		private static var _thingCharacter:Characters;
		public static function getTotalEquipBaseData(config:Battle_we) : Characters
		{
			var equipCharacter:Characters = new Characters();
			
			_weaponCharacter = new Characters();
			_clothesCharacter = new Characters();
			_thingCharacter = new Characters();
			
			// 武器
			getEquipBaseData(config.equipment_weapon, _weaponCharacter);
			// 衣服
			getEquipBaseData(config.equipment_clothes, _clothesCharacter);
			// 饰品
			getEquipBaseData(config.equipment_thing, _thingCharacter);
			
			countTotalEquip(equipCharacter);
			
			return equipCharacter;
		}
		
		private static function getEquipBaseData(mid:int, targetCharacter:Characters) : void
		{
			if (mid == -1) return;
			
			var equipModel:EquipModel
			equipModel = _data.pack.getEquipModelByMID(mid);
			_data.db.interfaces(InterfaceTypes.GET_EQUIP_DATA_BY_ID, equipModel.id, callback);
			
			function callback(data:Object) : void
			{
				var resultData:Equipment = data as Equipment;
				targetCharacter.atk = getResultData(resultData.atk_space);
				targetCharacter.def = getResultData(resultData.def_space);
				targetCharacter.spd = getResultData(resultData.spd_space);
				targetCharacter.hp = getResultData(resultData.hp);
				targetCharacter.mp = getResultData(resultData.mp);
				targetCharacter.evasion = getResultData(resultData.evasion);
				targetCharacter.crit = getResultData(resultData.crit);
				
				targetCharacter.hit = resultData.hit;
				targetCharacter.toughness = resultData.toughness;
				targetCharacter.ats = resultData.ats;
				targetCharacter.adf = resultData.adf;
			}
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
		
		private static function getResultData(str:String) : int
		{
			if(str == "0") return 0;
			
			var result:int;
			var list:Array = str.split("|");
			if(int(list[0]) > 0)
				result = int(list[1]);
			else
				result = int(list[0]);
			
			return result;
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
		public static function getTotalComposeEquipData(config:Battle_we) : Characters
		{
			var equipCharacter:Characters = new Characters();
			
			_weaponComposeCharacter = new Characters();
			_clothesComposeCharacter = new Characters();
			_thingComposeCharacter = new Characters();
			
			// 武器
			getEquipComposeData(config.equipment_weapon, _weaponComposeCharacter);
			// 衣服
			getEquipComposeData(config.equipment_clothes, _clothesComposeCharacter);
			// 饰品
			getEquipComposeData(config.equipment_thing, _thingComposeCharacter);
			
			countTotalComposeEquip(equipCharacter);
			
			return equipCharacter;
		}
		
		private static function getEquipComposeData(mid:int, targetCharacter:Characters) : void
		{
			if (mid == -1) return;
			
			var equipModel:EquipModel;
			equipModel = _data.pack.getEquipModelByMID(mid);
			var equipData:Object = _data.db.interfaces(InterfaceTypes.GET_STRENGTHEN_DATA, equipModel.id);
			var composeData:Object = Data.instance.db.interfaces(InterfaceTypes.GET_FRAGMENT)[0];
			
			targetCharacter.hp_compose = (equipData as  Equipment_strengthen).total_value * composeData.add_value / composeData.use_value;
		}
		
		private static function countTotalComposeEquip(equipCharacter:Characters) : void
		{
			add(_weaponComposeCharacter);
			add(_clothesComposeCharacter);
			add(_thingComposeCharacter);
			
			function add(targetCharacter:Characters) : void
			{
				equipCharacter.hp += targetCharacter.hp_compose;
			}
		}
		
		private static var _weaponLVCharacter:Characters;
		private static var _clothesLVCharacter:Characters;
		private static var _thingLVCharacter:Characters;
		/**
		 * 装备强化 
		 * 
		 */
		public static function getTotalEquipLVData(info:RoleInfo) : Characters
		{
			var equipLVData:Characters = new Characters();
			
			_weaponLVCharacter = new Characters();
			_clothesLVCharacter = new Characters();
			_thingLVCharacter = new Characters();
			
			getEquipLVData(info.equip.weapon, EquipConfig.WEAPON, _weaponLVCharacter);
			getEquipLVData(info.equip.cloth,  EquipConfig.CLOTHES, _clothesLVCharacter);
			getEquipLVData(info.equip.thing,  EquipConfig.THING, _thingLVCharacter);
			
			countTotalEquipLV(equipLVData);
			
			return equipLVData;
		}
		private static function getEquipLVData(mid:int, type:String, targetCharacter:Characters) : void
		{
			if (mid == -1) return;
			
			var equipModel:EquipModel;
			equipModel = _data.pack.getEquipModelByMID(mid);
			_data.db.interfaces(InterfaceTypes.GET_EQUIP_DATA_BY_ID, equipModel.id, callback);
			
			function callback(data:Object) : void
			{
				var resultData:Equipment = data as Equipment;
				var lvData:Array = [];
				switch(type)
				{
					case EquipConfig.WEAPON:
						targetCharacter.atk = getResultData(resultData.atk_space);
						lvData = _data.equip.getEquipMaxLvData(targetCharacter.atk, EquipConfig.WEAPON);
						break;
					case EquipConfig.CLOTHES:
						targetCharacter.def = getResultData(resultData.def_space);
						lvData = _data.equip.getEquipMaxLvData(targetCharacter.def, EquipConfig.CLOTHES);
						break;
					case EquipConfig.THING:
						targetCharacter.spd = getResultData(resultData.spd_space);
						lvData = _data.equip.getEquipMaxLvData(targetCharacter.spd, EquipConfig.THING);
						break;
				}
				targetCharacter.atk = lvData[0];
				targetCharacter.def = lvData[1];
				targetCharacter.spd = lvData[2];
			}
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
	}
}
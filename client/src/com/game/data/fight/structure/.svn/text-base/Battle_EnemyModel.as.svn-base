package com.game.data.fight.structure
{
	import com.engine.core.Log;
	import com.game.data.db.protocal.Battle_enemy;
	import com.game.data.db.protocal.Enemy;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.db.protocal.Equipment_strengthen;
	import com.game.data.db.protocal.Fight_soul;
	import com.game.data.db.protocal.Level_up_enemy;
	import com.game.data.db.protocal.Quality_up_enemy;
	import com.game.data.db.protocal.Skill;
	import com.game.data.equip.EquipConfig;
	import com.game.data.fight.FightConfig;
	import com.game.data.player.structure.EquipModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;

	public class Battle_EnemyModel extends BaseModel
	{
		// 最终数值
		private var _enemyModel:Enemy;
		public function get enemyModel() : Enemy
		{
			return _enemyModel;
		}
		
		// 基础属性值
		private var _enemyConfig:Enemy;
		public function get enemyConfig() : Enemy
		{
			return _enemyConfig;
		}
		
		// 等级附加属性
		private var _enemyLv:Enemy;
		
		// 品级
		private var _enemyQuality:Enemy;
		
		// 装备
		private var _enemyEquip:Enemy;
		
		// 装备强化
		private var _enemyEquipLv:Enemy;
		
		// 将魂
		private var _enemyFightSoulLV:Enemy;
		
		private var _position:String;
		
		private var _config:Battle_enemy;
		public function get config() : Battle_enemy
		{
			return _config;
		}
		
		/**
		 * 开始初始化计算用的 
		 */		
		private var _countEnemyModel:Enemy;
		public function get countEnemyModel() : Enemy
		{
			return _countEnemyModel;
		}
		public function beginInitCountModel() : void
		{
			_countEnemyModel = new Enemy();
			_countEnemyModel.name = _enemyModel.name;
			_countEnemyModel.hp = _enemyModel.hp;
			_countEnemyModel.mp = _enemyModel.mp;
		}
		
		public function copy() : Battle_EnemyModel
		{
			var model:Battle_EnemyModel = new Battle_EnemyModel();
			model.parse(_config, _position);
			
			return model;
		}
		
		public function Battle_EnemyModel()
		{
			super();
		}
		
		/**
		 *当前角色步法值 （含buff）
		 * @return 
		 * 
		 */		
		public function get spd() : int
		{
			var spd:int = this._enemyModel.spd;
			
			return spd;
		}
		
		public function parse(config:Battle_enemy, position:String) : void
		{
			_config = config;
			_position = position;
			
			getEnemyBaseData();
			getEnemyLVData();
			getQualityData();
			getTotalEquipBaseData();			
			getTotalEquipLVData();
			getFightSoulLV();
			getSkillDatas();
			
			countEnemy();
		}
		
		/**
		 * 计算总角色属性 
		 * 
		 */
		public const CountProperty:Array = ["hp", "mp", "atk", "def", "spd", "evasion", "crit", "hit", "toughness", "ats", "adf", "exp", "money", "soul", "atk_point"];
		private function countEnemy() : void
		{
			_enemyModel = new Enemy();
			
			var _characters:Array = [_enemyConfig, _enemyLv, _enemyQuality, _enemyEquip, _enemyEquipLv, _enemyFightSoulLV];
			
			for each(var proper:String in CountProperty)
			{
				for each(var role:Enemy in _characters)
				{	
					var addProp:Number = 0;
					if(!isNaN(_config.useGlowing))
						addProp = (role[proper] * (_config.useGlowing - 1));
					_enemyModel[proper] += (role[proper] + addProp);
					//trace(role[proper], _enemyModel[proper], _config.useGlowing);
				}
			}
			_enemyModel.name = _enemyConfig.name;
			// 重设等级
			_enemyModel.lv = _config.enemy_lv;
			trace(enemyModel.name + ": exp=" + enemyModel.exp + " lv=" + enemyModel.lv);
		}
		
		/**
		 * 基础 
		 * 
		 */		
		private function getEnemyBaseData() : void
		{
			var roleName:String = config.enemy_name;
			_data.db.interfaces(InterfaceTypes.GET_ROLE_BASE_DATA, V.ENEMY, roleName, callback);
			
			function callback(data:Enemy) : void
			{
				_enemyConfig = data;
				
			}
		}
		
		/**
		 * 等级 
		 * 
		 */		
		private function getEnemyLVData() : void
		{
			var lv:int = config.enemy_lv - 1;
			
			if (lv < 0) lv = 0;
			
			var lvData:Enemy = new Enemy();
			
			
			
			_data.db.interfaces(
				InterfaceTypes.GET_ROLE_LV__DATA,
				V.ENEMY,
				config.enemy_name,
				callback);
			
			function callback(data:Level_up_enemy) : void
			{
				lvData.hp = lv * data.hp * _enemyConfig.hp;
				lvData.mp = lv * data.mp * _enemyConfig.mp;
				lvData.atk = lv * data.atk * _enemyConfig.atk;
				lvData.def = lv * data.def * _enemyConfig.def;
				
				lvData.money = lv * data.money_add;
				lvData.soul = lv * data.soul_add;
				
				//lvData.exp = lv * data.exp_add;
				lvData.exp = data.exp_add * lv * lv + 11 * data.exp_add * lv; 
				//lvData.exp = data.exp_add * lv * _enemyConfig.exp;
					
				_enemyLv = lvData;
			}
		}
		
		/**
		 * 品质 
		 * 
		 */		
		private function getQualityData() : void
		{
			var lv:int = config.enemy_quality - 1;
			
			if (lv < 0) lv = 0;
			
			var qualityData:Enemy = new Enemy();
			
			if (lv != 0)
			{
				_data.db.interfaces(
					InterfaceTypes.GET_ROLE_QUALITY,
					V.ENEMY,
					config.enemy_name,
					callback);
				
				function callback(data:Quality_up_enemy) : void
				{
					qualityData.spd = data.spd * lv;
					qualityData.evasion = data.evasion * lv;
					qualityData.crit = data.crit * lv;
					qualityData.hit = data.hit * lv;
					qualityData.toughness = data.toughness * lv;
					qualityData.ats = data.ats * lv;
					qualityData.adf = data.adf * lv;
					
					qualityData.money = lv * data.money_add;
					qualityData.exp = lv * data.exp_add;
					qualityData.soul = lv * data.soul_add;
				}
			}
			
			_enemyQuality = qualityData;
		}
		
		/**
		 * 所有装备基础 
		 * 
		 */
		private var _weaponEnemy:Enemy;
		private var _clothesEnemy:Enemy;
		private var _thingEnemy:Enemy;
		private function getTotalEquipBaseData() : void
		{
			_weaponEnemy = new Enemy();
			_clothesEnemy = new Enemy();
			_thingEnemy = new Enemy();
			
			// 武器
			getEquipBaseData(config.equipment_weapon, _weaponEnemy);
			// 衣服
			getEquipBaseData(config.equipment_clothes, _clothesEnemy);
			// 饰品
			getEquipBaseData(config.equipment_thing, _thingEnemy);
			
			countTotalEquip();
		}		
		private function getEquipBaseData(mid:int, targetEnemy:Enemy) : void
		{
			if (mid != -1) return;
			
			var equipModel:EquipModel = _data.pack.getEquipModelByMID(mid);
			targetEnemy.hit = equipModel.config.hit;
			targetEnemy.toughness = equipModel.config.toughness;
			targetEnemy.ats = equipModel.config.ats;
			targetEnemy.adf = equipModel.config.adf;
			
			/// atk def spd 每把武器随机
			targetEnemy.atk = equipModel.atk;
			targetEnemy.def = equipModel.def;
			targetEnemy.spd = equipModel.spd;
			targetEnemy.hp = equipModel.hp;
			targetEnemy.mp = equipModel.mp;
			targetEnemy.evasion = equipModel.evasion;
			targetEnemy.crit = equipModel.crit;
		}
		private function countTotalEquip() : void
		{
			_enemyEquip = new Enemy();
			
			add(_weaponEnemy);
			add(_clothesEnemy);
			add(_thingEnemy);
			
			function add(targetEnemy:Enemy) : void
			{
				_enemyEquip.hp += targetEnemy.hp;
				_enemyEquip.mp += targetEnemy.mp;
				_enemyEquip.atk += targetEnemy.atk;
				_enemyEquip.def += targetEnemy.def;
				_enemyEquip.spd += targetEnemy.spd;
				_enemyEquip.evasion += targetEnemy.evasion;
				_enemyEquip.crit += targetEnemy.crit;
				_enemyEquip.hit += targetEnemy.hit;
				_enemyEquip.toughness += targetEnemy.toughness;
				_enemyEquip.ats += targetEnemy.ats;
				_enemyEquip.adf += targetEnemy.adf;
			}
		}
		
		/**
		 * 装备强化 
		 * 
		 */
		private var _weaponLVEnemy:Enemy;
		private var _clothesLVEnemy:Enemy;
		private var _thingLVEnemy:Enemy;
		private function getTotalEquipLVData() : void
		{
			_weaponLVEnemy = new Enemy();
			_clothesLVEnemy = new Enemy();
			_thingLVEnemy = new Enemy();
			
			getEquipLVData(config.equipment_weapon, config.equipment_thing_lv, EquipConfig.WEAPON, _weaponLVEnemy);
			getEquipLVData(config.equipment_weapon, config.equipment_clothes_lv, EquipConfig.CLOTHES, _clothesLVEnemy);
			getEquipLVData(config.equipment_weapon, config.equipment_thing_lv, EquipConfig.THING, _thingLVEnemy);
			
			countTotalEquipLV();
		}
		private function getEquipLVData(mid:int, lv:int, type:String, targetEnemy:Enemy) : void
		{
			lv = lv - 1;
			
			if (lv < 0) lv = 0;
			
			var config:Enemy;
			switch (type)
			{
				case EquipConfig.WEAPON:
					config = _weaponEnemy;
					break;
				case EquipConfig.CLOTHES:
					config = _clothesEnemy;
					break;
				case EquipConfig.THING:
					config = _thingEnemy;
					break;
			}
			
			_data.db.interfaces(
				InterfaceTypes.GET_EQUIP_LV_DATA,
				type,
				callback);
			
			function callback(data:Equipment_strengthen) : void
			{
				targetEnemy.atk = config.atk * lv;
				targetEnemy.def = config.def * lv;
				targetEnemy.spd = config.spd * lv;
			}
		}
		private function countTotalEquipLV() : void
		{
			_enemyEquipLv = new Enemy();
			
			add(_weaponEnemy);
			add(_clothesEnemy);
			add(_thingEnemy);
			
			function add(targetEnemy:Enemy) : void
			{
				_enemyEquipLv.atk += targetEnemy.atk;
				_enemyEquipLv.def += targetEnemy.def;
				_enemyEquipLv.spd += targetEnemy.spd;
			}
		}
		
		/**
		 * 将魂 
		 * 
		 */
		
		private function getFightSoulLV() : void
		{
			_enemyFightSoulLV = new Enemy();
			
			_data.db.interfaces(InterfaceTypes.GET_FIGHT_SOUL_LV, this._position, callback);
			
			function callback(data:Fight_soul) : void
			{
				_enemyFightSoulLV.hp = config.fight_soul_hp_lv * data.hp;
				_enemyFightSoulLV.mp = config.fight_soul_mp_lv * data.mp;
				_enemyFightSoulLV.atk = config.fight_soul_atk_lv * data.atk;
				_enemyFightSoulLV.def = config.fight_soul_def_lv * data.def;
				_enemyFightSoulLV.spd = config.fight_soul_spd_lv * data.spd;
				_enemyFightSoulLV.evasion = config.fight_soul_evasion_lv * data.evasion;
				_enemyFightSoulLV.crit = config.fight_soul_crit_lv * data.crit;
				_enemyFightSoulLV.hit = config.fight_soul_hit_lv * data.hit;
				_enemyFightSoulLV.toughness = config.fight_soul_toughness_lv * data.toughness;
				_enemyFightSoulLV.ats = config.fight_soul_ats_lv * data.ats;
				_enemyFightSoulLV.adf = config.fight_soul_adf_lv * data.adf;
			}
		}
		
		/**
		 * 技能 
		 * 
		 */		
		private function getSkillDatas() : void
		{
			// 专属技能
			if(_enemyConfig.fixedskill_name && _enemyConfig.fixedskill_name != "") 
			{
				CreateSkillData(_enemyConfig.fixedskill_name);
			}
			
			/*
			for (var i:int = 1; i <= 3; i++)
			{
				if (_config["skill_name_" + i] && _config["skill_name_" + i].length > 0)
				{
					CreateSkillData(_config["skill_name_" + i]);
				}
			}*/
		}		
		private function CreateSkillData(skillName:String) : void
		{
			_data.db.interfaces(InterfaceTypes.GET_SKILL_DATA, skillName, callback);
			
			function callback(data:Skill) : void
			{
				_skills.push(data);
			}
		}
	}
}
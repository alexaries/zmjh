package com.game.data.db
{
	import com.engine.utils.Utilities;
	import com.game.data.Base;
	import com.game.data.db.protocal.Battle_disposition;
	import com.game.data.db.protocal.Characters;
	import com.game.data.db.protocal.Daily_attendance;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.db.protocal.Level_up_exp;
	import com.game.data.db.protocal.Prop;
	import com.game.data.db.protocal.Strengthen;
	import com.game.data.db.templateData.AdventuresTemplateData;
	import com.game.data.db.templateData.ArenaTemplateData;
	import com.game.data.db.templateData.Auto_fightTemplateData;
	import com.game.data.db.templateData.BattleDispositionTemplateData;
	import com.game.data.db.templateData.BuffTemplateData;
	import com.game.data.db.templateData.CharactersTemplateData;
	import com.game.data.db.templateData.Daily_attendanceTemplateData;
	import com.game.data.db.templateData.Daily_workTemplateDate;
	import com.game.data.db.templateData.EndlessTemplateData;
	import com.game.data.db.templateData.EnemyTemplateData;
	import com.game.data.db.templateData.EquipmentTemplateData;
	import com.game.data.db.templateData.Equipment_strengthenTemplateData;
	import com.game.data.db.templateData.Exclusive_equipmentTemplateData;
	import com.game.data.db.templateData.FestivalsTemplateData;
	import com.game.data.db.templateData.Fight_soulTemplateData;
	import com.game.data.db.templateData.FragmentTemplateData;
	import com.game.data.db.templateData.GiftPackageTemplateData;
	import com.game.data.db.templateData.IForceTemplateDate;
	import com.game.data.db.templateData.ItemDispositionTemplateData;
	import com.game.data.db.templateData.Level_upTemplateData;
	import com.game.data.db.templateData.Level_up_enemyTemplateData;
	import com.game.data.db.templateData.Level_up_expTemplateData;
	import com.game.data.db.templateData.MallTemplateData;
	import com.game.data.db.templateData.Message_dispositionTemplateData;
	import com.game.data.db.templateData.MissionTemplateData;
	import com.game.data.db.templateData.OnlineBonusTemplateData;
	import com.game.data.db.templateData.PropTemplateData;
	import com.game.data.db.templateData.Quality_upTemplateData;
	import com.game.data.db.templateData.Quality_up_enemyTemplateData;
	import com.game.data.db.templateData.RealBossTemplateData;
	import com.game.data.db.templateData.SkillTemplateData;
	import com.game.data.db.templateData.Skill_upTemplateData;
	import com.game.data.db.templateData.SkyEarthTemplateData;
	import com.game.data.db.templateData.Smallgame_cardTemplateData;
	import com.game.data.db.templateData.Smallgame_fallingTemplateData;
	import com.game.data.db.templateData.Smallgame_linkTemplateData;
	import com.game.data.db.templateData.Smallgame_runTemplateData;
	import com.game.data.db.templateData.Special_bossTemplateData;
	import com.game.data.db.templateData.StatusTemplateData;
	import com.game.data.db.templateData.StrengthenTemplateData;
	import com.game.data.db.templateData.TitleTemplateData;
	import com.game.data.db.templateData.Vip_infoTemplateData;
	import com.game.data.db.templateData.Vip_mallTemplateData;
	import com.game.data.db.templateData.WeatherTemplateData;
	import com.game.data.player.structure.RoleInfo;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	
	import flash.utils.getTimer;

	public class DBData extends Base implements IDBData
	{
		private var _buff:BuffTemplateData;
		private var _characters:CharactersTemplateData;
		private var _enemy:EnemyTemplateData;
		private var _equip:EquipmentTemplateData;
		private var _equip_strengthen:Equipment_strengthenTemplateData;
		private var _exclusive_equip:Exclusive_equipmentTemplateData;
		private var _fight_soule:Fight_soulTemplateData;
		private var _level_up:Level_upTemplateData;
		private var _level_up_enemy:Level_up_enemyTemplateData;
		private var _quality_up:Quality_upTemplateData;
		private var _quality_up_enemy:Quality_up_enemyTemplateData;
		private var _skill:SkillTemplateData;
		private var _status:StatusTemplateData;
		private var _itemDisposition:ItemDispositionTemplateData;
		private var _battleDisposition:BattleDispositionTemplateData;
		private var _adventures:AdventuresTemplateData;
		private var _prop:PropTemplateData;
		private var _message_disposition:Message_dispositionTemplateData;
		private var _level_up_exp:Level_up_expTemplateData;
		private var _daily:Daily_attendanceTemplateData;
		private var _smallGameFallingTemplateData:Smallgame_fallingTemplateData;
		private var _smallGameCardTemplateData:Smallgame_cardTemplateData;
		private var _missionTemplateData:MissionTemplateData;
		private var _smallGameLinkTemplateData:Smallgame_linkTemplateData;
		private var _strengthenTemplateData:StrengthenTemplateData;
		private var _mallTemplatedData:MallTemplateData;
		private var _weatherTemplateData:WeatherTemplateData;
		private var _fragmentTemplateData:FragmentTemplateData;
		private var _giftPackageTemplateData:GiftPackageTemplateData;
		private var _endlessTemplateData:EndlessTemplateData;
		private var _specialBossTemplateData:Special_bossTemplateData;
		private var _onlineBonusTemplateData:OnlineBonusTemplateData;
		private var _realBossTemplateData:RealBossTemplateData;
		private var _arenaTemplateData:ArenaTemplateData;
		private var _skillUpTemplateData:Skill_upTemplateData;
		private var _titleTemplateData:TitleTemplateData;
		private var _festivalsTemplateData:FestivalsTemplateData;
		private var _iForceTemplateData:IForceTemplateDate;
		private var _skyEarthTemplateData:SkyEarthTemplateData;
		private var _vipInfoTemplateData:Vip_infoTemplateData;
		private var _vipMallTemplateData:Vip_mallTemplateData;
		private var _dailyWorkTemplateData:Daily_workTemplateDate;
		private var _autoFightTemplateData:Auto_fightTemplateData;
		
		public function DBData()
		{
			_buff = new BuffTemplateData();
			_characters = new CharactersTemplateData();
			_enemy = new EnemyTemplateData();
			_equip = new EquipmentTemplateData();
			_equip_strengthen = new Equipment_strengthenTemplateData();
			_exclusive_equip = new Exclusive_equipmentTemplateData();
			_fight_soule = new Fight_soulTemplateData();
			_level_up = new Level_upTemplateData();
			_level_up_enemy = new Level_up_enemyTemplateData();
			_quality_up = new Quality_upTemplateData();
			_quality_up_enemy = new Quality_up_enemyTemplateData();
			_skill = new SkillTemplateData();
			_status = new StatusTemplateData();
			_itemDisposition = new ItemDispositionTemplateData();
			_battleDisposition = new BattleDispositionTemplateData();
			_adventures = new AdventuresTemplateData();
			_prop = new PropTemplateData();
			_message_disposition = new Message_dispositionTemplateData();
			_level_up_exp = new Level_up_expTemplateData();
			_daily = new Daily_attendanceTemplateData();
			_smallGameFallingTemplateData = new Smallgame_fallingTemplateData();
			_smallGameCardTemplateData = new Smallgame_cardTemplateData();
			_missionTemplateData = new MissionTemplateData();
			_smallGameLinkTemplateData = new Smallgame_linkTemplateData();
			_strengthenTemplateData = new StrengthenTemplateData();
			_mallTemplatedData = new MallTemplateData();
			_weatherTemplateData = new WeatherTemplateData();
			_fragmentTemplateData = new FragmentTemplateData();
			_giftPackageTemplateData = new GiftPackageTemplateData();
			_endlessTemplateData = new EndlessTemplateData();
			_specialBossTemplateData = new Special_bossTemplateData();
			_onlineBonusTemplateData = new OnlineBonusTemplateData();
			_realBossTemplateData = new RealBossTemplateData();
			_arenaTemplateData = new ArenaTemplateData();
			_skillUpTemplateData = new Skill_upTemplateData();
			_titleTemplateData = new TitleTemplateData();
			_festivalsTemplateData = new FestivalsTemplateData();
			_iForceTemplateData = new IForceTemplateDate();
			_skyEarthTemplateData = new SkyEarthTemplateData();
			_vipInfoTemplateData = new Vip_infoTemplateData();
			_vipMallTemplateData = new Vip_mallTemplateData();
			_dailyWorkTemplateData = new Daily_workTemplateDate();
			_autoFightTemplateData = new Auto_fightTemplateData();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.INIT;
			
			switch (type)
			{
				case InterfaceTypes.INIT:
					init();
					break;
				case InterfaceTypes.GET_ROLE_BASE_DATA:
					getRoleBaseData(args);
					break;
				case InterfaceTypes.GET_ROLE_LV__DATA:
					getRoleLvData(args);
					break;
				case InterfaceTypes.GET_ROLE_QUALITY:
					getRoleQuality(args);
					break;
				case InterfaceTypes.GET_EQUIP_BASE_DATA:
					getEquiptBaseData(args);
					break;
				case InterfaceTypes.GET_EQUIP_LV_DATA:
					getEquipLVData(args);
					break;
				case InterfaceTypes.GET_EQUIP_DATA_BY_ID:
					getEquipDataByID(args);
					break;
				case InterfaceTypes.GET_FIGHT_SOUL_LV:
					getFightSoulLV(args);
					break;
				case InterfaceTypes.GET_SKILL_DATA:
					getSkillData(args);
					break;
				case InterfaceTypes.GET_SKILL_DATA_BY_iD:
					getSkillDataById(args);
					break;
				case InterfaceTypes.GET_STATUS_DATA:
					getStatusData(args);
					break;
				case InterfaceTypes.GET_ITEM_DISPOSITION_DATA:
					getItemDispositionData(args);
					break;
				case InterfaceTypes.GET_BATTLE_DISPOSITION_DATA:
					getBattleDisposition(args);
					break;
				case InterfaceTypes.GET_SKILL_ALL_DATA:
					getSkillAllData(args);
					break;
				case InterfaceTypes.GET_ALL_SKILL_DATA:
					return _skill.data;
					break;
				case InterfaceTypes.GET_EQUIP_DATA_BY_GRADE:
					return getEquipDataByGrade(args);
					break;
				case InterfaceTypes.GET_ADVENTURES_DATA:
					return _adventures.data;
					break;
				case InterfaceTypes.GET_PROP_BASE_DATA:
					getPropBaseData(args);
					break;
				case InterfaceTypes.GET_PROP_DATA:
					return _prop.data;
					break;
				case InterfaceTypes.GET_MESSAGE_DISPOSITION:
					return _message_disposition.data;
					break;
				case InterfaceTypes.GET_ITEM_DISPOSITION:
					return _itemDisposition.data;
					break;
				case InterfaceTypes.GET_LEVEL_UP_EXP:
					return this._level_up_exp.data;
					break;
				case InterfaceTypes.GET_DAILY_DATA:
					return _daily.data;
					break;
				case InterfaceTypes.GET_SMALLGAME_FALL:
					return _smallGameFallingTemplateData.data;
					break;
				case InterfaceTypes.GET_SMALLGAME_RUN:
					return _smallGameFallingTemplateData.data;
					break;
				case InterfaceTypes.GET_SMALLGAME_CARD:
					return _smallGameCardTemplateData.data;
					break;
				case InterfaceTypes.GET_MISSION_DATA:
					return _missionTemplateData.data;
					break;
				case InterfaceTypes.GET_SMALLGAME_LINK:
					return _smallGameLinkTemplateData.data;
					break;
				case InterfaceTypes.GET_STRENGTHEN:
					return _strengthenTemplateData.data;
					break;
				case InterfaceTypes.GET_STRENGTHEN_DATA:
					return getEquipMoneyData(args);
					break;
				case InterfaceTypes.GET_MALL:
					return _mallTemplatedData.data;
					break;
				case InterfaceTypes.GET_WEATHER_DATA:
					return _weatherTemplateData.data;
					break;
				case InterfaceTypes.GET_FRAGMENT:
					return _fragmentTemplateData.data;
					break;
				case InterfaceTypes.GET_GIFT_BY_ID:
					return getGiftData(args);
					break;
				case InterfaceTypes.GET_GIFT_DATA:
					return _giftPackageTemplateData.data;
					break;
				case InterfaceTypes.GET_PROP_BY_ID:
					return getPropData(args);
					break;
				case InterfaceTypes.GET_GRADE_BY_NAME:
					return getGrade(args);
					break;
				case InterfaceTypes.GET_SKILL_ID:
					return getSkillID(args);
					break;
				case InterfaceTypes.GET_PROP_BY_NAME:
					return getPropByName(args);
					break;
				case InterfaceTypes.GET_ALL_EQUIP_DATA:
					return _equip.data;
					break;
				case InterfaceTypes.GET_EQUIP_STRENGTHEN_DATA:
					return _equip_strengthen.data;
					break;
				case InterfaceTypes.GET_ENDLESS_BY_ID:
					return getEndlessByID(args);
					break;
				case InterfaceTypes.GET_ENDLESS_DATA:
					return _endlessTemplateData.data;
					break;
				case InterfaceTypes.GET_SPECIAL_BOSS_DATA:
					return _specialBossTemplateData.data;
					break;
				case InterfaceTypes.GET_ONLINE_BONUS_DATA:
					return _onlineBonusTemplateData.data;
					break;
				case InterfaceTypes.GET_REAL_BOSS_DATA:
					return _realBossTemplateData.data;
					break;
				case InterfaceTypes.GET_CHARACTER_DATA:
					return _characters.data;
					break;
				case InterfaceTypes.GET_ARENA_DATA:
					return _arenaTemplateData.data;
					break;
				case InterfaceTypes.GET_SKILL_UP_DATA:
					return _skillUpTemplateData.data;
					break;
				case InterfaceTypes.GET_ROLE_DATA_BY_NAME:
					return getRoleDataByName(args);
					break;
				case InterfaceTypes.GET_TITLE_ADD_DATA:
					return _titleTemplateData.data;
					break;
				case InterfaceTypes.GET_FESTIVALS_DATA:
					return _festivalsTemplateData.data;
					break;
				case InterfaceTypes.GET_STRENGTH_DATA:
					return _iForceTemplateData.data;
					break;
				case InterfaceTypes.GET_SKY_EARTH_DATA:
					return _skyEarthTemplateData.data;
					break;
				case InterfaceTypes.GET_VIP_INFO_DATA:
					return _vipInfoTemplateData.data;
					break;
				case InterfaceTypes.GET_VIP_MALL_DATA:
					return _vipMallTemplateData.data;
					break;
				case InterfaceTypes.GET_NEXT_EXP_DATA:
					return getNextExpData(args);
					break;
				case InterfaceTypes.GET_DAILY_WORK_DATA:
					return _dailyWorkTemplateData.data;
					break;
				case InterfaceTypes.GET_AUTO_FIGHT_DATA:
					return _autoFightTemplateData.data;
					break;
				case InterfaceTypes.GET_ALL_BATTLE_DISPOSITION_DATA:
					return _battleDisposition.data;
					break;
			}
		}
		
		/**
		 *  
		 * 获取角色基础数据
		 */		
		private function getNextExpData(args:Array) : Object
		{
			var lv:String = args[0];
			return _level_up_exp.interfaces(InterfaceTypes.GET_DATA, lv);
		}
		
		private function getRoleDataByName(args:Array):Characters
		{
			var name:String = args[0];
			return _characters.interfaces(InterfaceTypes.GET_ROLE_DATA_BY_NAME, name);
		}
		
		private function getEndlessByID(args:Array) : Object
		{
			var id:int = args[0];
			return _endlessTemplateData.interfaces(InterfaceTypes.GET_ENDLESS_BY_ID, id);
		}
		
		private function getPropByName(args:Array) : Prop
		{
			var name:String = args[0];
			return _prop.interfaces(InterfaceTypes.GET_PROP_BY_NAME, name);
		}
		
		private function getSkillID(args:Array) : int
		{
			var skillName:String = args[0];
			return _skill.interfaces(InterfaceTypes.GET_SKILL_ID, skillName);
		}
		
		private function getGrade(args:Array) : String
		{
			var name:String = args[0];
			return _characters.interfaces(InterfaceTypes.GET_GRADE_BY_NAME, name);
		}
		
		private function getPropData(args:Array) : Prop
		{
			var id:int = args[0];
			return _prop.interfaces(InterfaceTypes.GET_PROP_BY_ID, id);
		}
		
		private function getGiftData(args:Array) : Object
		{
			var id:int = args[0];
			return _giftPackageTemplateData.interfaces(InterfaceTypes.GET_DATA, id);
		}
		
		/**
		 *  
		 * 获取角色基础数据
		 */		
		private function getRoleBaseData(args:Array) : void
		{
			var type:String = args[0];
			var roleName:String = args[1];
			var callback:Function = args[2];
			
			switch (type)
			{
				case V.ME:
					_characters.interfaces(InterfaceTypes.GET_DATA, roleName, callback);
					break;
				case V.ENEMY:
					_enemy.interfaces(InterfaceTypes.GET_DATA, roleName, callback);
					break;
			}
		}
		
		/**
		 * 获取角色等级配置数据
		 * @param args
		 * 
		 */		
		private function getRoleLvData(args:Array) : void
		{
			var type:String = args[0];
			var roleName:String = args[1];
			var callback:Function = args[2];
			
			switch (type)
			{
				case V.ME:
					_level_up.interfaces(InterfaceTypes.GET_DATA, roleName, callback);
					break;
				case V.ENEMY:
					_level_up_enemy.interfaces(InterfaceTypes.GET_DATA, roleName, callback);
					break;
			}
		}
		
		/**
		 * 角色品质 
		 * @param args
		 * 
		 */		
		private function getRoleQuality(args:Array) : void
		{
			var type:String = args[0];
			var roleName:String = args[1];
			var callback:Function = args[2];
			
			switch (type)
			{
				case V.ME:
					_quality_up.interfaces(InterfaceTypes.GET_DATA, roleName, callback);
					break;
				case V.ENEMY:
					_quality_up_enemy.interfaces(InterfaceTypes.GET_DATA, roleName, callback);
					break;
			}
		}
		
		/**
		 * 装备基础 
		 * @param args
		 * 
		 */		
		private function getEquiptBaseData(args:Array) : void
		{
			var equipName:String = args[0];
			var callback:Function = args[1];
			
			_equip.interfaces(InterfaceTypes.GET_DATA, equipName, callback);
		}
		
		/**
		 * 装备强化 
		 * @param args
		 * 
		 */		
		private function getEquipLVData(args:Array) : void
		{
			var type:String = args[0];
			var callback:Function = args[1];
			
			_equip_strengthen.interfaces(InterfaceTypes.GET_DATA, type, callback);
		}
		
		private function getEquipMoneyData(args:Array) : Object
		{
			var id:String = args[0];
			return _equip_strengthen.interfaces(InterfaceTypes.GET_EQUIP_LV_DATA, id);
		}
		
		private function getEquipDataByID(args:Array) : void
		{
			var id:int = args[0];
			var callback:Function = args[1];
			
			_equip.interfaces(InterfaceTypes.GET_EQUIP_DATA_BY_ID, id, callback);
		}
		
		/**
		 * 将魂 
		 * @param args
		 * 
		 */		
		private function getFightSoulLV(args:Array) : void
		{
			var postion:String = args[0];
			var callback:Function = args[1];
			
			_fight_soule.interfaces(InterfaceTypes.GET_DATA, postion, callback);
		}
		
		/**
		 * buff 
		 * @param args
		 * 
		 */		
		private function getBuffData(args:Array) : void
		{
			
		}
		
		/**
		 * 技能 
		 * @param args
		 * 
		 */		
		private function getSkillData(args:Array) : void
		{
			var skillName:String = 	args[0];
			var callback:Function = args[1];
			
			this._skill.interfaces(InterfaceTypes.GET_DATA, skillName, callback);
		}
		
		private function getSkillDataById(args:Array) : void
		{
			var skillID:int = args[0];
			var callback:Function = args[1];
			
			this._skill.interfaces(InterfaceTypes.GET_SKILL_DATA_BY_iD, skillID, callback);
		}
		
		private function getStatusData(args:Array) : void
		{
			var status_name:String = 	args[0];
			var callback:Function = args[1];
			
			this._status.interfaces(InterfaceTypes.GET_DATA, status_name, callback);
		}
		
		/**
		 * 掉落概率 
		 * @param args
		 * 
		 */		
		private function getItemDispositionData(args:Array) : void
		{
			var levelName:String = args[0];
			var difficult:int = args[1];
			var callback:Function = args[2];
			
			this._itemDisposition.interfaces(InterfaceTypes.GET_DATA, levelName, difficult, callback);
		}
		
		private function getBattleDisposition(args:Array) : void
		{
			var levelName:String = args[0];
			var difficult:int = args[1];
			var callback:Function = args[2];
			
			this._battleDisposition.interfaces(InterfaceTypes.GET_DATA, levelName, difficult, callback);
		}
		
		private function getSkillAllData(args:Array) : void
		{
			var info:RoleInfo = args[0];
			var callback:Function = args[1];
			this._skill.interfaces(InterfaceTypes.GET_SKILL_ALL_DATA, info, callback);
		}
		
		private function getEquipDataByGrade(args:Array) : Vector.<Equipment>
		{
			var grade:int = args[0];
			var quality:String = args[1];
			
			return this._equip.interfaces(InterfaceTypes.GET_EQUIP_DATA_BY_GRADE, grade, quality);
		}
		
		private function getPropBaseData(args:Array) : void
		{
			var id:int = args[0];
			var callback:Function = args[1];
			
			_prop.interfaces(InterfaceTypes.GET_DATA, id, callback);
		}
		
		/**
		 * 模块数据初始化 
		 * 
		 */		
		protected function init() : void
		{
			_buff.interfaces();
			_characters.interfaces();
			_enemy.interfaces();
			_equip.interfaces();
			_equip_strengthen.interfaces();
			_exclusive_equip.interfaces();
			_fight_soule.interfaces();
			_level_up.interfaces();
			_level_up_enemy.interfaces();
			_quality_up.interfaces();
			_quality_up_enemy.interfaces();
			_skill.interfaces();
			_status.interfaces();
			_itemDisposition.interfaces();
			_battleDisposition.interfaces();
			_adventures.interfaces();
			_prop.interfaces();
			_message_disposition.interfaces();
			_level_up_exp.interfaces();
			_daily.interfaces();
			_smallGameFallingTemplateData.interfaces();
			_smallGameCardTemplateData.interfaces();
			_missionTemplateData.interfaces();
			_smallGameLinkTemplateData.interfaces();
			_strengthenTemplateData.interfaces();
			_mallTemplatedData.interfaces();
			_weatherTemplateData.interfaces();
			_fragmentTemplateData.interfaces();
			_giftPackageTemplateData.interfaces();
			_endlessTemplateData.interfaces();
			_specialBossTemplateData.interfaces();
			_onlineBonusTemplateData.interfaces();
			_realBossTemplateData.interfaces();
			_arenaTemplateData.interfaces();
			_skillUpTemplateData.interfaces();
			_titleTemplateData.interfaces();
			_festivalsTemplateData.interfaces();
			_iForceTemplateData.interfaces();
			_skyEarthTemplateData.interfaces();
			_vipInfoTemplateData.interfaces();
			_vipMallTemplateData.interfaces();
			_dailyWorkTemplateData.interfaces();
			_autoFightTemplateData.interfaces();
		}
	}
}
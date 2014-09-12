package com.game.template
{

	public class GameConfig
	{
		[Embed(source = '../resources/Game_Config.xml', mimeType = 'application/octet-stream')]
		private var CONFIG:Class;
		
		/**
		 * 模块配置(path:元件路径, res:资源路径) 
		 */		
		public var ASSETS:Object;
		
		/**
		 *舞台宽 
		 */		
		public static var CAMERA_WIDTH:int = 940;
		/**
		 *舞台高 
		 */		
		public static var CAMERA_HEIGHT:int = 590;
		
		/**
		 * 保存的间隔时间（距离上次保存多少秒后才能继续[点击]保存）
		 * */
		public static const SAVE_DELAY:uint = 60;
		
		public function GameConfig(s:Singleton)
		{
			if (_instance != null)
			{
				throw new Error("LayerManager 是单例！");
			}
			
			var xml:XML=XML(new CONFIG());
			ASSETS={};
			for each (var item:XML in xml.modules.item) 
			{
				var ob:Object={};
				for (var i:int = 0; i < item.children().length(); i++) 
				{
					var na:String=	 item.children()[i].name();
					if(na=="path")
					{
						ob[na]=item.children()[i].toString();
					}
					else
					{
						ob[na]=String(item.children()[i].toString()).split(",");
						if (ob[na].length==1&&ob[na][0]=="") 
						{
							ob[na]=[];
						}
					}
				}
				ASSETS[item.@name]=ob;
			}
		}
		
		private static var _instance : GameConfig;
		public static function get instance () : GameConfig
		{
			if (null == _instance)
			{
				_instance = new GameConfig(new Singleton());
			}
			
			return _instance;
		}
		
		/************** 资源模块  *************************/
		public static const START_RES:String = "startV122.mp3";
		
		public static const PUBLIC_RES:String = "PublicV145.swf";
		
		public static const PLAYER_RES:String = "PlayerV138.swf";
		
		public static const PLAYER_NEW_RES:String = "PlayerNewV140.swf";
		
		public static const WORLD_RES:String = "WorldV142.swf";
		
		public static const ROLE_RES:String = "RoleV142.swf";
		
		public static const ROLE_BIG_RES:String = "RoleBigV142.swf";
		
		public static const FIGHT_RES:String = "fightV142.swf";
		
		public static const FIGHT_SOUND_RES:String = "fightV122.mp3";
		
		public static const LOAD_RES:String = "loadV144.swf";
		
		public static const CTRL_RES:String = "ctrl_mo_v5.swf";
		
		public static const DB_RES:String = "dbV144.swf";
		
		public static const LE_RES:String = "LevelEventV131.swf";
		
		public static const FE_RES:String = "FightEffectV141.swf";
		
		public static const EE_RES:String = "EventEffectV138.swf";
		
		public static const DIALOG_RES:String = "dialogV142.swf";
		
		public static const ICON_RES:String = "iconV144.swf";
		
		public static const APPATR_RES:String = "AppendAttributeV116.swf";
		
		public static const DAILY_RES:String = "DailyV142.swf";
		
		public static const PLUGIN_GAME_RES:String = "PluginGameV144.swf";
		
		public static const TDH_PREPARE_RES:String = "TdhPrepareV142.swf";
		
		public static const DAILY_WORK_RES:String = "DailyWorkV144.swf";
		
		public static const MOVE_GAME_RES:String = "MoveGameV118.swf";
		
		public static const FLIP_GAME_RES:String = "FlipGameV144.swf";
		
		public static const LINK_GAME_RES:String = "LinkGameV122.swf";
		
		public static const MATCH_GAME_RES:String = "MatchGameV143.swf";
		
		public static const RUN_GAME_RES:String = "RunGameV138.swf";
		
		public static const EQUIP_STRENGTHEN:String = "EquipStrengthenV144.swf";
		
		public static const SHOP_RES:String = "ShopV142.swf";
		
		public static const AUTO_FIGHT_RES:String = "AutoFightV124.swf";
		
		public static const GUIDE_RES:String = "GuideV144.swf";
		
		public static const WEATHER_RES:String = "WeatherV129.swf";
		
		public static const OTHER_EFFECT_RES:String = "OtherEffectV142.swf";
		
		public static const ACTIVITY_RES:String = "ActivityV144.swf";
		
		public static const INSTRUCTION_RES:String = "InstructionV142.swf";
		
		public static const ENDLESS_BATTLE_RES:String = "EndlessBattleV142.swf";
		
		public static const DOUBLE_LEVEL_RES:String = "DoubleLevelV142.swf";
		
		public static const WORLD_BOSS_RES:String = "WorldBossV142.swf";
		
		public static const ACHIEVEMENT_RES:String = "AchievementV137.swf";
		
		public static const PLAYER_FIGHT_RES:String = "PlayerFightV137.swf";
		
		public static const UPGRADE_SKILL_RES:String = "UpgradeV142.swf";
		
		public static const MID_AUTUMN_RES:String = "MidAutumnV141.swf";
		
		public static const VIP_RES:String = "VipV142.swf";
		
		public static const STRENGTH_RES:String = "StrengthV142.swf";
		
		public static const UNION_RES:String = "UnionV142.swf";
		
		public static const MAP_RES:Object = {
			"1_1" : 'V132',
			"1_2" : 'V122',
			"1_3" : 'V142',
			"1_4" : 'V122',
			"2_1" : 'V122',
			"2_2" : 'V122',
			"2_3" : 'V122',
			"2_4" : 'V122',
			"3_1" : 'V122',
			"3_2" : 'V122',
			"3_3" : 'V126',
			"3_4" : 'V138',
			"4_1" : 'V122',
			"4_2" : 'V122',
			"4_3" : 'V126',
			"4_4" : 'V138',
			"5_1" : 'V126',
			"5_2" : 'V127',
			"5_3" : 'V136',
			"5_4" : 'V136',
			"6_1" : 'V142'
		};
		
		public static const MAP_SOUND_RES:Object = {
			"1" : "V122",
			"2" : "V122",
			"3" : "V122",
			"4" : "V122",
			"5" : "V122",
			"6" : "V142"
		}
	}
}


class Singleton {}
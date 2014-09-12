package com.game.template
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class V
	{
		/**
		 * 加密数据对象 
		 */		
		public static const anti:Antiwear = new Antiwear(new binaryEncrypt());
		
		/**
		 * 宋体 
		 * @return 
		 * 
		 */		
		public static const SONG_TI:String = "宋体";
		
		/**
		 * 骰子最大数 
		 */		
		public static function get DICE_MAX_NUM() : int
		{
			if (!V.anti["DICE_MAX_NUM"])
			{
				V.anti["DICE_MAX_NUM"] = 399;
			}
			
			return V.anti["DICE_MAX_NUM"];
		}
		
		/**
		 * 道具最大数 
		 */		
		public static function get PROP_MAX_NUM() : int
		{
			if (!V.anti["PROP_MAX_NUM"])
			{
				V.anti["PROP_MAX_NUM"] = 99;
			}
			
			return V.anti["PROP_MAX_NUM"];
		}
		
		public static function get PROP_SPECIAL_MAX_NUM() : int
		{
			if (!V.anti["PROP_SPECIAL_MAX_NUM"])
			{
				V.anti["PROP_SPECIAL_MAX_NUM"] = 999;
			}
			
			return V.anti["PROP_SPECIAL_MAX_NUM"];
		}
		
		/**
		 * 奖励时间 
		 * @return 
		 * 
		 */		
		public static function get BONUS_TIME() : String
		{
			if (!V.anti["BONUS_TIME"])
			{
				V.anti["BONUS_TIME"] = "23:59:59";
				//V.anti["BONUS_TIME"] = "14:0:0";
			}
			
			return V.anti["BONUS_TIME"];
		}
		
		public static var MAX_COMMON_SKILL_LEVEL:int = 100;
		public static var MAX_CURE_SKILL_LEVEL:int = 50;
		
		//　主角
		public static var MAIN_ROLE_NAME:String = "韦小宝";
		
		public static const MOON_ENEMY:String = "兔爷";
		
		/*****************版本类型*************************/
		public static const DEVELOP:String = "develop";
		
		public static const RELEASE:String = "release";
		
		public static const SETDATA:String = "setData";
		
		public static const LOCAL:String = "local";
		
		/*****************关卡困难模式**********************/
		/**
		 * 简单模式 
		 */		
		public static const SIMPLE_LV:int = 1;
		/**
		 * 普通模式 
		 */		
		public static const COMMON_LV:int = 2;
		/**
		 * 困难模式 
		 */		
		public static const HARD_LV:int = 3;
		
		
		/****************模块名***************************/
			
		public static const DICE:String = "dice";
		
		public static const FREE_DICE:String = "free_dice";
		
		public static const FIGHT:String = "fight";
		
		public static const ENDLESS_FIGHT:String = "end_less";
		
		public static const BOSS_FIGHT:String = "boss_fight";
		
		public static const PLAYER_KILLING_FIGHT:String = "player_killing";
		
		public static const LEVEL_SELECT:String = "levelselect";
		
		public static const PRELOAD:String = "preload";
		
		public static const ROLE:String = "role";
		
		public static const ROLE_IMAGE:String = "role_image";
		
		public static const ROLE_DETAIL:String = "role_detail";
		
		public static const ROLE_SELECT:String = "role_select";
		
		public static const TOOLBAR:String = "toolbar";
		
		public static const WORLD:String = "world";
		
		public static const PLAYER:String = "player";
		
		public static const PLAYER_NEW:String = "player_new";
		
		public static const MAP:String = "map";
		
		public static const LOAD:String = "load";
		
		public static const SKILL:String = "skill";

		public static const TDH_SKILL:String = "tdh_skill";
		
		public static const EQUIP:String = "equip";
		
		public static const PROPS:String = "props";
		
		public static const UI:String = "ui";
		
		public static const FIGHT_EFFECT:String = "fight_effect";
		
		public static const PLAYER_KILLING_FIGHT_EFFECT:String = "player_killing_fight_effect";
		
		public static const START:String = "start";
		
		public static const FIGHT_BEGIN:String = "fight_begin";
		
		public static const ADVENTURES:String = "adventures";
		
		public static const EVENT_EFFECT:String = "event_effect";
		
		public static const SAVE:String = "save"; 
		
		public static const CARTOON:String = "cartoon";
		
		public static const DIALOG:String = "dialog";
		
		public static const TALK:String = "talk";
		
		public static const ICON:String = "icon";
		
		public static const TIP:String = "tip";
		
		public static const BUY:String = "buy";
		
		public static const ROLE_LEVLE_UP:String = "role_lvup";
		
		public static const ROLE_GAIN_SKILL:String = "role_gain_skill";
		
		public static const LOAD_DATA:String = "load_data";
		
		public static const PROMP_EFFECT:String = "promp_effect";
		
		public static const ROLE_RES:String = "role_res";
		
		public static const ROLE_GAIN:String = "role_gain";
		
		public static const PASS_LV:String = "pass_lv";
		
		public static const WEATHEAR_PROP:String = "weather_prop";
		
		public static const MOONCAKE_PROP:String = "mooncake_prop";
		
		public static const ENDLESS_BATTLE:String = "endless_battle";
		
		public static const ONLINE_TIME:String = "online_time";
		
		public static const DOUBLE_LEVEL:String = "double_level";
		
		/// 关卡
		public static const OPEN_ITEM_BOX:String = "openItemBox";
		
		public static const ENDLESS_PROP_BOX:String = "endless_prop_box";
		
		public static const TASK_ITEM_BOX:String = "taskItemBox";
		
		public static const LEVEL_EVENT:String = "levelEvent";
		
		/**
		 * 金钱宝箱 
		 */		
		public static const MONEY_ITEMBOX:String = "money_itembox";
		/**
		 * 道具宝箱 
		 */		
		public static const PROP_ITEMBOX:String = "prop_itembox";
		/**
		 * 装备宝箱 
		 */		
		public static const EQUIP_ITEMBOX:String = "equip_itembox";
		/**
		 * 无尽闯关宝箱
		 */		
		public static const ENDLESS_PROP_ITEMBOX:String = "endless_prop_itembox";
		/**
		 * 战附 
		 */		
		public static const APPEND_ATTRIBUTE:String = "append_attribute";
		/**
		 * 买筛子 
		 */
		public static const BUY_DICE:String = "buy_dice";
		/**
		 * 每日 
		 */		
		public static const DAILY:String = "daily";
		/**
		 * 接金币 
		 */		
		public static const MOVE_GAME:String = "move_game";
		/**
		 * 翻牌游戏
		 */		
		public static const FLIP_GAME:String = "flip_game";
		/**
		 * 跑步游戏
		 */		
		public static const RUN_GAME:String = "run_game";
		/**
		 * 签到 
		 */		
		public static const SIGN_IN:String = "sign_in";
		/**
		 * 插件游戏 
		 */		
		public static const PLUGIN_GAME:String = "plugin_game";
		/**
		 * 副本说明 
		 */		
		public static const INTRODUCE_PLUGIN_GAME:String = "introducePluginGame";
		/**
		 * 天地会准备
		 */		
		public static const TDH_PREPARE:String = "tdh_prepare";
		/**
		 * 每日任务
		 */		
		public static const DAILY_TASK:String = "task";
		/**
		 * 每日必做
		 */		
		public static const DAILY_WORK:String = "daily_work";
		
		/**
		 * 连连看
		 */		
		public static const LINK_GAME:String = "link_game";
		/**
		 * 三连消除
		 */		
		public static const MATCH_GAME:String = "match_game";
		/**
		 * 装备强化
		 */		
		public static const EQUIP_STRENGTHEN:String = "equip_strengthen";
		
		public static const INSTRUCTION_STRENGTHEN:String = "instruction_strengthen";
		
		public static const INSTRUCTION_DECOMPOSE:String = "instruction_decompose";
		
		public static const INSTRUCTION_COMPOSE:String = "instruction_compose";
		
		public static const INSTRUCTION_MARTIAL:String = "instruction_martial";
		
		public static const INSTRUCTION_TRANSFER:String = "instruction_transfer";
		
		public static const INSTRUCTION_GLOWING:String = "instruction_glowing";
		
		public static const INSTRUCTION_ENDLESS:String = "instruction_endless";
		
		public static const INSTRUCTION_UPGRADE_SKILL:String = "instruction_upgrade_skill";
		
		public static const INSTRUCTION_MID_AUTUMN:String = "instruction_mid_autumn";
		
		public static const INSTRUCTION_STRENGTH:String = "instruction_strength";
		
		public static const INSTRUCTION_UNION:String = "instruction_union";
		
		public static const SHOP:String = "shop";
		
		public static const AUTO_FIGHT:String = "auto_fight";
		
		public static const SPEED_CHANGE:String = "speed_change";
		
		public static const GUIDE:String = "guide";
		
		public static const FIRST_GUIDE:String = "first_guide";
		
		public static const GET_ROLE_GUIDE:String = "get_role_guide";
		
		public static const WEATHER:String = "weather";
		
		public static const WEATHER_PASS:String = "weather_pass";
		
		public static const OTHER_EFFECT:String = "other_effect";
		
		public static const INTEGRATION:String = "integration";
		
		public static const TANABATA:String = "tanabata";
		
		public static const AUTUMN_FESTIVAL:String = "autumn_festival";
		
		public static const TWO_FESTIVAL:String = "two_festival";
		
		public static const NATIONAL_DAY:String = "national_day";
		
		public static const GLOWING:String = "glowing";
		
		public static const MARTIAL:String = "martial";
		
		public static const INSTRUCTION:String = "instruction";
		
		public static const ROLE_BIG:String = "role_big";
		
		public static const WORLD_BOSS:String = "world_boss";
		
		public static const RANK_LIST:String = "rank_list";
		
		public static const ACHIEVEMENT:String = "achievement";
		
		public static const PLAYER_FIGHT:String = "player_fight";
		
		public static const PLAYER_RANK_LIST:String = "player_rank_list";
		
		public static const TRANSFER_ROLE_TYPE:String = "transfer_role_type";
		
		public static const UPGRADE_SKILL:String = "upgrade";
		
		public static const WEATHER_SELECT:String = "weather_select";
		
		public static const MID_AUTUMN:String = "mid_autumn";
		
		public static const CONTRIBUTE_MOONCAKE:String = "contribute_mooncake";
		
		public static const VIP:String = "vip";
		
		public static const UNION:String = "union";
		
		public static const STRENGTH:String = "strength";
		
		public static const VIP_SHOP:String = "vip_shop";
		
		public static const NATIONAL_PASS:String = "national_pass";
		
		/**
		 * 此比较特殊，非模块为公用资源 
		 */		
		public static const PUBLIC:String = "public";		
		
		public static const ACTIVITY:String = "activity";
		
		public static const DB:String = "db";
		
		
		public static const ME:String = "me";		
		public static const ENEMY:String = "enemy";
		
		/**
		 * 成功 
		 */
		public static const WIN:int = 1;
		/**
		 * 失败 
		 */		
		public static const LOSE:int = -1;
		
		/**
		 * 角色面板人物缩放 
		 */		
		public static const ROLE_SCALE:Number = 0.67;
		/**
		 * 战斗人物缩放 
		 */		
		public static const FIGHT_SCALE:Number = 0.5;
		/**
		 * 白色 
		 */		
		public static const WIHTE_COLOR:int = 0xffffff;
		/**
		 * 黑色 
		 */		
		public static const BLACK_COLOR:int = 0x000000;
		/**
		 * 绿色 
		 */		
		public static const GREEN_COLOR:int = 0x66CC33;
		/**
		 * 蓝色 
		 */		
		public static const BLUE_COLOR:int = 0x3399ff;
		public static const LITTLE_BLUE_COLOR:int = 0x66ffff;
		public static const LITTLE_BLACK_COLOR:int = 0x663300;
		public static const YELLOW_COLOR:int = 0x9900FF;
		public static const WIND_COLOR:int = 0x999999;
		
		public static const NIGHT_TYPE:String = "夜";
		public static const RAIN_TYPE:String = "雨";
		public static const THUNDER_TYPE:String = "雷";
		public static const WIND_TYPE:String = "风";
		
		public static const WEATHER_LEFT:String = "weather_left";
		public static const WEATHER_RIGHT:String = "weather_right";
		
		public static function get ROLE_TITLE () : Object
		{
			if (!V.anti["ROLE_TITLE"])
			{
				V.anti["ROLE_TITLE"] = {
					"花好月圆" : "MidAutumnTitle",
					"普天同庆" : "NationalDayTitle",
					"初出江湖" : "BeginWorldTitle",
					"天下第一" : "WorldFirstTitle",
					"富甲天下" : "WealthyTitle"
				};
			}
			return V.anti["ROLE_TITLE"];
		}
		
		public static function get ROLE_NAME() : Array
		{
			if(!V.anti["ROLE_NAME"])
				V.anti["ROLE_NAME"] = ["花好月圆", "普天同庆", "初出江湖", "天下第一", "富甲天下"];
			return V.anti["ROLE_NAME"];
		}
		
		/**
		 *　数字转中文 
		 */		
		public static const NUM_TO_CHINA:Object = {
			1 : "一",
			2 : "二",
			3 : "三",
			4 : "四",
			5 : "五",
			6 : "六",
			7 : "七",
			8 : "八",
			9 : "九"
		};
	}
}
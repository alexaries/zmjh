package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.engine.utils.Utilities;
	import com.game.Data;
	import com.game.data.Activity.ActivityDetail;
	import com.game.data.Activity.ActivityInfo;
	import com.game.data.LevelSelect.AutoFightInfo;
	import com.game.data.daily.DailyThingInfo;
	import com.game.data.db.protocal.Skill;
	import com.game.data.douleLevel.DoubleLevelInfo;
	import com.game.data.endless.EndlessInfo;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.structure.WeCharacterUtitiles;
	import com.game.data.martial.MartialInfo;
	import com.game.data.midAutumn.MidAutumnInfo;
	import com.game.data.online.OnlineTimeInfo;
	import com.game.data.player.GlowingInfo;
	import com.game.data.player.PlayerDataSafe;
	import com.game.data.player.PlayerEvent;
	import com.game.data.player.PlayerFightDataUtitlies;
	import com.game.data.player.PlayerUtitiles;
	import com.game.data.playerFight.PlayerFightInfo;
	import com.game.data.prop.MultiRewardInfo;
	import com.game.data.role.RoleFashionInfo;
	import com.game.data.role.RoleTitleInfo;
	import com.game.data.role.UpgradeRoleInfo;
	import com.game.data.shop.VIPInfo;
	import com.game.data.skill.UpgradeSkillDetail;
	import com.game.data.skill.UpgradeSkillInfo;
	import com.game.data.strength.StrengthInfo;
	import com.game.data.union.UnionInfo;
	import com.game.data.worldBoss.WorldBossInfo;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	
	import starling.errors.AbstractClassError;
	import starling.events.EventDispatcher;

	public class Player extends EventDispatcher
	{
		private var _anti:Antiwear;
		private var _data:Data = Data.instance;
		
		/**
		 *  最高关卡
		 */
		public var pass_level:Vector.<LevelInfo>;
		
		/**
		 * 角色信息 
		 */		
		public var roles:Vector.<RoleInfo>;
		
		/**
		 * 战附
		 */
		public var fightAttach:FightAttach;
		
		/**
		 * 战斗阵型 
		 */		
		public var formation:FormationInfo;
		
		/**
		 * 背包 
		 */		
		public var pack:PackInfo;
		
		public function get fightingNum() : int
		{
			return _anti["fightingNum"];
		}
		public function set fightingNum(value:int) : void
		{
			_anti["fightingNum"] = value;
		}
		
		public function get maxFightingNum() : int
		{
			return _anti["maxFightingNum"];
		}
		public function set maxFightingNum(value:int) : void
		{
			_anti["maxFightingNum"] = value;
		}
		
		public function get dice() : int
		{
			return _anti["dice"];
		}
		public function set dice(value:int) : void
		{
			if (value > V.DICE_MAX_NUM) value = V.DICE_MAX_NUM;
			_anti["dice"] = value;
			
			this.dispatchEventWith(PlayerEvent.PLAYER_CHANGE);
		}
		
		/**
		 * 金钱值 
		 */
		public function get money() : int
		{
			return _anti["money"];
		}
		public function set money(value:int) : void
		{
			_anti["money"] = value;
			
			this.dispatchEventWith(PlayerEvent.PLAYER_CHANGE);
		}
		
		/**
		 * 战魂值 
		 */		
		public function get fight_soul() : int
		{
			return _anti["fight_soul"];
		}
		public function set fight_soul(value:int) : void
		{
			_anti["fight_soul"] = value;
			this.dispatchEventWith(PlayerEvent.PLAYER_CHANGE);
		}
		
		/**
		 * 内功修为
		 * @return 
		 * 
		 */		
		public function get strength_exp() : int
		{
			return _anti["strength_exp"];
		}
		public function set strength_exp(value:int) : void
		{
			_anti["strength_exp"] = value;
		}
		
		/**
		 * 初始化 
		 */		
		private var _isInit:Boolean;
		public function get isInit() : Boolean
		{
			return _isInit;
		}
		public function set isInit(value:Boolean) : void
		{
			_isInit = value;
		}
		
		/**
		 * 角色维护 
		 */		
		private var _roleModels:Vector.<RoleModel>;
		public function get roleModels() : Vector.<RoleModel>
		{
			return _roleModels;
		}
		
		/**
		 * 主角 
		 */		
		private var _mainRoleModel:RoleModel;
		public function get mainRoleModel() : RoleModel
		{
			return _mainRoleModel;
		}
		
		/**
		 * 每日签到 
		 */		
		private var _signInInfo:SignInInfo;
		public function get signInInfo() : SignInInfo
		{
			return _signInInfo;
		}
		
		/**
		 * 插件游戏
		 */	
		private var _pluginGameInfo:PluginGameInfo;
		public function get pluginGameInfo() : PluginGameInfo
		{
			return _pluginGameInfo;
		}
		
		/**
		 * 每日任务 
		 */		
		private var _missonInfo:MissonInfo;
		public function get missonInfo() : MissonInfo
		{
			return _missonInfo;
		}
		
		/**
		 * 向导
		 */		
		private var _guideInfo:GuideInfo;
		public function get guideInfo() : GuideInfo
		{
			return _guideInfo;
		}
		
		/**
		 * 礼包
		 */		
		private var _activityInfo:ActivityInfo;
		public function get activityInfo() : ActivityInfo
		{
			return _activityInfo;
		}
		
		/**
		 * 多倍
		 */		
		private var _multiRewardInfo:MultiRewardInfo;
		public function get multiRewardInfo() : MultiRewardInfo
		{
			return _multiRewardInfo;
		}
		
		/**
		 * 练功
		 */		
		private var _martialInfo:MartialInfo;
		public function get martialInfo() : MartialInfo
		{
			return _martialInfo;
		}
		
		/**
		 * 觉醒存档
		 */		
		private var _glowingInfo:GlowingInfo;
		public function get glowingInfo() : GlowingInfo
		{
			return _glowingInfo;
		}
		
		/**
		 * 附体检测
		 */		
		private var _playerSafe:PlayerDataSafe;
		public function get playerSafe() : PlayerDataSafe
		{
			return _playerSafe;
		}
		
		/**
		 * 无尽闯关
		 */		
		private var _endlessInfo:EndlessInfo
		public function get endlessInfo() : EndlessInfo
		{
			return _endlessInfo;
		}
		
		/**
		 * 在线奖励
		 */		
		private var _onlineTimeInfo:OnlineTimeInfo;
		public function get onlineTimeInfo() : OnlineTimeInfo
		{
			return _onlineTimeInfo;
		}
		
		/**
		 * 双倍副本
		 */		
		private var _doubleLevelInfo:DoubleLevelInfo;
		public function get doubleLevelInfo() : DoubleLevelInfo
		{
			return _doubleLevelInfo;
		}
		
		/**
		 * 真假小宝
		 */		
		private var _worldBossInfo:WorldBossInfo;
		public function get worldBossInfo() : WorldBossInfo
		{
			return _worldBossInfo;
		}
		
		/**
		 * 时装
		 */		
		private var _roleFashionInfo:RoleFashionInfo;
		public function get roleFashionInfo() : RoleFashionInfo
		{
			return _roleFashionInfo;
		}
		
		/**
		 * 玩家PK
		 */		
		private var _playerFightInfo:PlayerFightInfo;
		public function get playerFightInfo() : PlayerFightInfo
		{
			return _playerFightInfo;
		}
		
		/**
		 * 技能升级
		 */		
		private var _upgradeSkill:UpgradeSkillInfo;
		public function get upgradeSkill() : UpgradeSkillInfo
		{
			return _upgradeSkill;
		}
		
		/**
		 * 角色图鉴
		 */		
		private var _upgradeRole:UpgradeRoleInfo;
		public function get upgradeRole() : UpgradeRoleInfo
		{
			return _upgradeRole;
		}
		
		/**
		 * 称号系统
		 */		
		private var _roleTitleInfo:RoleTitleInfo;
		public function get roleTitleInfo() : RoleTitleInfo
		{
			return _roleTitleInfo;
		}
		
		/**
		 * 中秋活动
		 */		
		private var _midAutumnInfo:MidAutumnInfo;
		public function get midAutumnInfo() : MidAutumnInfo
		{
			return _midAutumnInfo;
		}
		
		/**
		 * vip系统
		 */		
		private var _vipInfo:VIPInfo
		public function get vipInfo() : VIPInfo
		{
			return _vipInfo;
		}
		
		/**
		 * 内功系统
		 */		
		private var _strengthInfo:StrengthInfo;
		public function get strengthInfo() : StrengthInfo
		{
			return _strengthInfo;
		}
		
		/**
		 * 天地会
		 */		
		private var _unionInfo:UnionInfo;
		public function get unionInfo() : UnionInfo
		{
			return _unionInfo;
		}
		
		/**
		 * 每日必做
		 */		
		private var _dailyThingInfo:DailyThingInfo;
		public function get dailyThingInfo() : DailyThingInfo
		{
			return _dailyThingInfo;
		}
		
		/**
		 * 扫荡模式
		 */		
		private var _autoFightInfo:AutoFightInfo;
		public function get autoFightInfo() : AutoFightInfo
		{
			return _autoFightInfo;
		}
		//public var activity:Number;
		
		public function Player()
		{
			_isInit = false;
			
			registerClass();
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["money"] = 0;
			_anti["fight_soul"] = 0;
			_anti["dice"] = 0;
			_anti["fightingNum"] = 0;
			_anti["maxFightingNum"] = 0;
		}
		
		/**
		 * 注册类对象 
		 * 
		 */
		private function registerClass() : void
		{
			Utilities.overrideRegisterClassAlias(new EquipInfo());
			Utilities.overrideRegisterClassAlias(new SkillInfo());
			Utilities.overrideRegisterClassAlias(new RoleInfo());
			Utilities.overrideRegisterClassAlias(new LevelInfo());
			Utilities.overrideRegisterClassAlias(new FightAttach());
		}
		
		public function init(configXML:XML) : void
		{
			isInit = true;
			
			parseXML(configXML);
			initRoleModel();
			
			countRoleFight();
			
			// 检测存档作弊
			checkDataSafe();
			
			calculateData();
		}
		
		/**
		 * 数据计算
		 * 
		 */		
		private function calculateData():void
		{
			calculateFighting();
			calculateUpgradeSkill();
			calculateUpgradeRole();
			calculateTitle();
		}
		
		/**
		 * 称号系统
		 * 
		 */		
		private function calculateTitle():void
		{
			if(_mainRoleModel.model.lv >= 30)
				roleTitleInfo.addNewTitle(V.ROLE_NAME[2]);
		}
		
		/**
		 * 角色图鉴
		 * 
		 */		
		private function calculateUpgradeRole():void
		{
 			for each(var item:RoleInfo in roles)
			{
				_upgradeRole.addRole(item.roleName);
			}
			_upgradeRole.resetRole();
		}
		
		/**
		 * 计算技能升级
		 * 
		 */		
		private function calculateUpgradeSkill() : void
		{
			var _canUpgradeSkill:Vector.<String> = new Vector.<String>(); 
			for each(var item:RoleInfo in roles)
			{
				if(item.skill.skill1 != "")
					_canUpgradeSkill.push(item.skill.skill1);
				if(item.skill.skill2 != "")
					_canUpgradeSkill.push(item.skill.skill2);
				if(item.skill.skill3 != "")
					_canUpgradeSkill.push(item.skill.skill3);
				
				var skillList:Array = item.skill.learnedSkill.split("|");
				if(skillList.length > 0)
				{
					for each(var skill:String in skillList)
					{
						if(skill != "")
							_canUpgradeSkill.push(skill);
					}
				}
			}
			
			for each(var skillName:String in _canUpgradeSkill)
			{
				upgradeSkill.addSkillName(skillName);
			}
		}
		
		/**
		 * 计算战斗力
		 * 
		 */		
		public function calculateFighting() : void
		{
			fightingNum = 0;
			maxFightingNum = 0;
			for each(var item:RoleModel in roleModels)
			{
				if(getRolePosition(item.configData.name) != FightConfig.NONE_POS)
				{
					fightingNum += item.fightingNum;
					maxFightingNum += item.maxFightingNum;
				}
			}
			if(checkLevelShow("6_1"))
			{
				var result:Array = strengthInfo.getStrengthLevel(formation);
				fightingNum += result[0];
				maxFightingNum += result[1];
			}
			Log.Trace("队伍战斗值：" + fightingNum);
			Log.Trace("队伍最大战斗值：" + maxFightingNum);
		}
		
		public function countFormationFighting() : void
		{
			for each(var item:RoleModel in roleModels)
			{
				if(getRolePosition(item.configData.name) != FightConfig.NONE_POS)
				{
					item.countFightingAll();
				}
			}
		}
		
		private function checkDataSafe() : void
		{
			_playerSafe = new PlayerDataSafe();
			_playerSafe.checkSafe();
		}
		
		/**
		 * 是否已通过关卡 
		 * @param lv
		 * @return 
		 * 
		 */		
		public function juglePassLevel(lv:String) : Boolean
		{
			var isPass:Boolean = false;
			
			for (var i:int = 0; i <　pass_level.length; i++)
			{
				if (pass_level[i].name == lv)
				{
					isPass = true;
					break;
				}
			}
			
			return isPass;
		}
		
		/**
		 * 恢复所有成员 
		 * 
		 */		
		public function recoverAllRole() : void
		{
			var role:RoleModel;
			for (var i:int = 0, len:int = _roleModels.length; i < len; i++)
			{
				role = _roleModels[i];
				
				role.hp = role.model.hp;
				role.mp = role.model.mp;
			}
			
			this.dispatchEventWith(PlayerEvent.PLAYER_CHANGE);
		}
		
		/**
		 * 空置的角色 
		 * @return 
		 * 
		 */		
		public function getIdleRoles() : Vector.<RoleModel>
		{
			var models:Vector.<RoleModel> = new Vector.<RoleModel>();
			
			var role:RoleModel;
			for (var i:int = 0, len:int = _roleModels.length; i < len; i++)
			{
				role = _roleModels[i];
				
				if (formation.jugleInFormation(role.info.roleName)) continue;
				if (martialInfo.isInMartial(role.info.roleName)) continue;
				
				models.push(role);
			}
			
			return models;
		}
		
		/**
		 * 可以觉醒的角色
		 * @return 
		 * 
		 */		
		public function getGlowingRoles() : Vector.<RoleModel>
		{
			var models:Vector.<RoleModel> = new Vector.<RoleModel>();
			var role:RoleModel;
			for (var i:int = 0, len:int = _roleModels.length; i < len; i++)
			{
				role = _roleModels[i];
				
				if (martialInfo.isInMartial(role.info.roleName)) continue;
				if (role.configData.quality == 0 || role.configData.quality == 5) continue;
				
				models.push(role);
			}
			
			return models;
		}
		
		/**
		 * 玩家是否拥有该角色
		 * @param name
		 * @return 
		 * 
		 */		
		public function hasRole(name:String) : Boolean
		{
			var result:Boolean = false;
			for each(var role:RoleModel in _roleModels)
			{
				if(role.info.roleName == name)
				{
					result = true;
					break;
				}
			}
			return result;
		}
		
		/**
		 * 添加角色 
		 * @param roleInfo
		 * 
		 */		
		public function addRole(roleInfo:RoleInfo) : RoleModel
		{
			var model:RoleModel;
			
			// 检测当前是否已经收服过该角色
			if (!getRole(roleInfo.roleName))
			{
				roles.push(roleInfo);
				model = new RoleModel();
				model.initModel(this, roleInfo);
				_roleModels.push(model);
				
				//获得角色后添加可升级技能的列表
				if(roleInfo.skill.skill1 != "") upgradeSkill.addSkillName(roleInfo.skill.skill1);
				upgradeRole.addRole(roleInfo.roleName);
			}
			else
			{
				Log.Trace("你已经获得该角色 " + roleInfo.roleName);
			}
			
			return model;
		}
		
		/**
		 * 角色 
		 * 
		 */
		protected function initRoleModel() : void
		{
			_roleModels = new Vector.<RoleModel>();
			var model:RoleModel;
			var info:RoleInfo;
			var position:String;
			for (var i:int = 0, len:int = roles.length; i < len; i++)
			{
				info = roles[i];
				model = new RoleModel();
				model.initModel(this, info);
				_roleModels.push(model);
			}
			
			_mainRoleModel = getRoleModel(V.MAIN_ROLE_NAME);
		}
		
		private function countRoleFight() : void
		{
			for each(var role:RoleModel in _roleModels)
			{
				role.countFightingAll();
			}
		}
		
		public function getMyRoleModel(name:String) : RoleModel
		{
			var roleModel:RoleModel;
			for each(var item:RoleModel in _roleModels)
			{
				if(item.info.roleName == name)
				{
					roleModel = item;
					break;
				}
			}
			
			//if(roleModel == null) throw new Error("不存在" + name);
			
			return roleModel;
		}
		
		public function getTypeRoleModel(name:String) : RoleModel
		{
			var roleModel:RoleModel;
			var newName:String = name.split("（")[0];
			
			if(roleModel == null && getMyRoleModel(newName) != null)
				roleModel = getMyRoleModel(newName);
			
			if(roleModel == null && getMyRoleModel(newName + "（夜）") != null)
				roleModel = getMyRoleModel(newName + "（夜）");
			
			if(roleModel == null && getMyRoleModel(newName + "（雨）") != null)
				roleModel = getMyRoleModel(newName + "（雨）");
			
			if(roleModel == null && getMyRoleModel(newName + "（风）") != null)
				roleModel = getMyRoleModel(newName + "（风）");
			
			if(roleModel == null && getMyRoleModel(newName + "（雷）") != null)
				roleModel = getMyRoleModel(newName + "（雷）");
			
			return roleModel;
		}
		
		public function returnNowFashion(input:String, name:String) : String
		{
			var result:String = "";
			var roleUseFashion:String = getTypeRoleModel(name).nowUseFashion;
			if(roleUseFashion == "")
				result = input + name;
			else
				result = input + name + "_" + roleUseFashion;
			
			return result;
		}
		
		/**
		 * 删除角色
		 * @param name
		 * 
		 */		
		public function removeRole(name:String) : void
		{
			for each(var roleInfo:RoleInfo in roles)
			{
				if(roleInfo.roleName == name)
				{
					roles.splice(roles.indexOf(roleInfo), 1);
					break;
				}
			}
			for each(var roleModel:RoleModel in _roleModels)
			{
				if(roleModel.info.roleName == name)
				{
					_roleModels.splice(_roleModels.indexOf(roleModel), 1);
					break;
				}
			}
		}
		
		/**
		 * 检测竞技场
		 * @return 
		 * 
		 */	
		public function checkPlayerFight() : Boolean
		{
			var result:Boolean;
			result = _playerFightInfo.checkCanFight();
			return result;
		}
		
		/**
		 * 检测练功房
		 * @return 
		 * 
		 */		
		public function checkMartialRole() : Boolean
		{
			var result:Boolean;
			result = _martialInfo.checkIsComplete();
			return result;
		}
		
		/**
		 * 检测每日签到
		 * @return 
		 * 
		 */		
		public function checkDaily() : Boolean
		{
			var result:Boolean;
			result = _data.time.checkEveryDayPlay(_signInInfo.lastDay);
			return result;
		}
		
		/**
		 * 检测无尽闯关
		 * @return 
		 * 
		 */		
		public function checkEndless() : Boolean
		{
			var result:Boolean;
			result = _data.time.checkEveryDayPlay(_endlessInfo.time);
			if(vipInfo.checkLevelFour())
			{
				if(_endlessInfo.isComplete == 1)
					result == true
			}
			
			return result;
		}
		
		/**
		 * 检测成长礼包
		 * @return 
		 * 
		 */		
		public function checkGlowingReward() : Boolean
		{
			var result:Boolean = false;
			var resultList:Array = [1, 1, 1, 1, 1, 1, 1, 1, 1];
			var count:int = Math.floor(mainRoleModel.info.lv / 10);
			for(var i:int = resultList.length - 1; i >= count; i--)
			{
				resultList[i] = 0;
			}
			if(mainRoleModel.info.lv < 70)   resultList[5] = 0;
			if(mainRoleModel.info.lv < 100)   resultList[6] = 0;
			if(mainRoleModel.info.lv < 120)   resultList[7] = 0;
			if(mainRoleModel.info.lv < 130)   resultList[8] = 0;
			
			for each(var item:ActivityDetail in activityInfo.activities)
			{
				if(item.id >= 23 && item.id <= 30)
					resultList[item.id - 23] = 0;
				if(item.id == 55)
					resultList[8] = 0;
			}
			
			for each(var num:int in resultList)
			{
				if(num == 1)
				{
					result = true;
					break;
				}
			}
			
			return result;
		}
		
		/**
		 * 检测暑期礼包
		 * @return 
		 * 
		 */		
		public function checkSummer() : Boolean
		{
			var result:Boolean = false;
			for each(var activity:ActivityDetail in activityInfo.activities)
			{
				if(activity.id == 40)
				{
					if(!_data.time.checkEveryDayPlay(activity.time))
					{
						result = true;
						break;
					}
				}
			}
			return result;
		}
		
		public function checkMidAutumn() : Boolean
		{
			var infoData:Vector.<Object> = Data.instance.db.interfaces(InterfaceTypes.GET_FESTIVALS_DATA);
			var result:Boolean = false;
			for(var i:uint = 0; i < midAutumnInfo.alreadyGet.length; i++)
			{
				if(int(midAutumnInfo.alreadyGet[i]) == 0)
					break;
			}
			
			if(i < infoData.length && (pack.getPropById(49).num + midAutumnInfo.moonCakeUse) >= infoData[i].number)
				result = true;
			
			return result;
		}
		
		public function checkFirstGuide() : Boolean
		{
			var result:Boolean = false;
			for each(var item:GuideStructure in guideInfo)
			{
				if(item.levelName == "first")
				{
					result = true;
					break;
				}
			}
			return result;
		}
		
		public function checkRoleGetGuide() : Boolean
		{
			var result:Boolean = false;
			for each(var item:GuideStructure in guideInfo)
			{
				if(item.levelName == "getRole")
				{
					result = true;
					break;
				}
			}
			return result;
		}
		
		/**
		 * 检测是否存在该关卡
		 * @param str
		 * @return 
		 * 
		 */		
		public function checkLevelShow(str:String) : Boolean
		{
			var result:Boolean = false;
			for each(var item:LevelInfo in pass_level)
			{
				if(item.name == str)
				{
					result = true;
					break;
				}
			}
			
			return result;
		}
		
		public function getPlayerFightInfo() : String
		{
			var result:String = "";
			result = mainRoleModel.info.lv + "|" + getFormationName() + "|" + fightingNum;
			return result;
		}
		
		private function getFormationName() : String
		{
			var result:String = "";
			if(formation.back != "")
				result = formation.back;
			else if(formation.middle != "")
				result = formation.middle;
			else
				result = formation.front;
			
			return result;
		}
		
		/**
		 * 解析XML 
		 * @param configXML
		 * 
		 */		
		protected function parseXML(configXML:XML) : void
		{
			dice = configXML.dice;
			money = configXML.money;
			fight_soul = configXML.fight_soul;
			strength_exp = configXML.strength_exp;
			pass_level = PlayerUtitiles.assignPassLevel(configXML.pass_level[0]);
			formation = PlayerUtitiles.assignFormation(configXML.formation[0]);
			fightAttach = PlayerUtitiles.assignFightAttach(configXML.fightAttach[0]);
			roles = PlayerUtitiles.assignRoles(configXML.roles[0]);
			pack = PlayerUtitiles.assignPack(configXML.pack[0]);
			_strengthInfo = PlayerUtitiles.assignStrength(configXML.strength[0]);
			_signInInfo = PlayerUtitiles.assignSignIn(configXML.sign_in[0]);
			_pluginGameInfo = PlayerUtitiles.assignPluginGame(configXML.plugin_game[0]);
			_missonInfo = PlayerUtitiles.assignMisson(configXML.mission[0]);
			_guideInfo = PlayerUtitiles.assignGuide(configXML.guide[0]);
			_activityInfo = PlayerUtitiles.assignActivity(configXML.activity[0]);
			_multiRewardInfo = PlayerUtitiles.assignMultiReward(configXML.multiReward[0]);
			_martialInfo = PlayerUtitiles.assignMartial(configXML.martial[0]);
			_glowingInfo = PlayerUtitiles.assignGlowing(configXML.glowing[0]);
			_endlessInfo = PlayerUtitiles.assignEndless(configXML.endless[0]);
			_onlineTimeInfo = PlayerUtitiles.assignOnlineTime(configXML.onlineTime[0]);
			_doubleLevelInfo = PlayerUtitiles.assignDoubleLevel(configXML.doubleLevel[0]);
			_worldBossInfo = PlayerUtitiles.assignWorldBoss(configXML.worldBoss[0]);
			_roleFashionInfo = PlayerUtitiles.assignFashion(configXML.fashion[0]);
			_playerFightInfo = PlayerUtitiles.assignPlayerFight(configXML.playerFight[0]);
			_upgradeSkill = PlayerUtitiles.assignUpgradeSkill(configXML.upgradeSkill[0]);
			_upgradeRole = PlayerUtitiles.assignUpgradeRole(configXML.upgradeRole[0]);
			_roleTitleInfo = PlayerUtitiles.assignRoleTitle(configXML.roleTitle[0]);
			_midAutumnInfo = PlayerUtitiles.assignMidAutumn(configXML.midAutumn[0]);
			_vipInfo = PlayerUtitiles.assignVIP(configXML.vip[0]);
			_unionInfo = PlayerUtitiles.assignUnion(configXML.union[0]);
			_dailyThingInfo = PlayerUtitiles.assignDailyThing(configXML.dailyThing[0]);
			_autoFightInfo = PlayerUtitiles.assignAutoFight(configXML.autoFight[0]);
			
			initWhenPlayerInit();
			
			checkGuide();
			checkRoleFashion();
		}
		
		private function checkRoleFashion():void
		{
			if(roleFashionInfo.checkFashionExist(V.MAIN_ROLE_NAME, "NewDress"))
			{
				if(roleFashionInfo.returnLastTime(V.MAIN_ROLE_NAME, "NewDress") <= 0)
				{
					multiRewardInfo.removeMultiReward(5);
					roleFashionInfo.removeFashionInfo(V.MAIN_ROLE_NAME, "NewDress");
					Data.instance.pack.changePropNum(43, -1);
				}
			}
		}
		
		private function checkGuide() : void
		{
			for each(var info:LevelInfo in pass_level)
			{
				//老玩家添加向导
				if(info.name == "1_2" && info.difficulty >= 2)
				{
					Data.instance.guide.guideInfo.addGuideInfo("getRole", "getRole");
				}
				if(info.name == "4_1")
				{
					Data.instance.guide.guideInfo.addGuideInfo("3_3", "pass");
				}
			}
		}
		
		
		/**
		 * 当玩家初始化数据后，需要初始的其他模块
		 * 
		 */		
		protected function initWhenPlayerInit() : void
		{
			_data.equip.initEquip();
			_data.pack.initPack();
			_data.skill.initSkill();
			_data.formation.initFormation();
		}
		
		/**
		 * 获取角色 
		 * @param name
		 * @return 
		 * 
		 */		
		/*private function getRole(name:String) : RoleInfo
		{
			var info:RoleInfo;
			for each(var role:RoleInfo in roles)
			{
				if (role.roleName == name)
				{
					info = role;
					break;
				}
			}
			
			return info;
		}*/
		
		private function getRole(name:String) : Boolean
		{
			var result:Boolean = false;
			for each(var role:RoleModel in _roleModels)
			{
				if(role.configData.quality == 0)
				{
					if(role.info.roleName == name)
					{
						result = true;
						break;
					}
				}
				else
				{
					if(role.info.roleName.split("（")[0] == name)
					{
						result = true;
						break;
					}
				}
			}
			return result;
		}
		
		/**
		 * 获取角色基础站位 
		 * @param name
		 * @return 
		 * 
		 */		
		public function getRolePosition(name:String) : String
		{
			var position:String = FightConfig.NONE_POS;
			
			if (formation.front == name) position = FightConfig.FRONT_POS;
			
			else if (formation.middle == name) position = FightConfig.MIDDLE_POS;
			
			else if (formation.back == name) position = FightConfig.BACK_POS;
			
			return position;
		}
		
		public function getRoleModel(name:String) : RoleModel
		{
			var model:RoleModel;
			for each(var item:RoleModel in this._roleModels)
			{
				if (item.model.name == name)
				{
					model = item;
					break;
				}
			}
			
			return model;
		}
		
		public function getPlayerOfXML() : XML
		{
			var data:XML = new XML("<DATA></DATA>");
			
			// 骰子个数
			var diceXML:XML = getDiceXML();
			data.appendChild(diceXML);
			
			// 金钱
			var moneyXML:XML = getMoneyXML();
			data.appendChild(moneyXML);
			
			// 战魂
			var fight_soul:XML = getFightSoulXML();
			data.appendChild(fight_soul);
			
			// 内功修为
			var strengthExpXML:XML = getStrengthExpXML();
			data.appendChild(strengthExpXML);
			
			// 关卡
			var passLV:XML = getPassLVXML();
			data.appendChild(passLV);
			
			// 战附
			var fightAttach:XML = this.fightAttach.getFightAttach();
			data.appendChild(fightAttach);
			
			// 阵型
			var formation:XML = this.formation.getXML();
			data.appendChild(formation);
			
			// 背包
			var pack:XML = this.pack.getXML();
			data.appendChild(pack);
			
			// 角色
			var roles:XML = getRoleXML();
			data.appendChild(roles);
			
			// 每日签到
			var signInXML:XML = _signInInfo.getSignInXML();
			data.appendChild(signInXML);
			
			// 插件游戏
			var pluginXML:XML = _pluginGameInfo.getXML();
			data.appendChild(pluginXML);
			
			// 每日任务
			var missonXML:XML = _missonInfo.getXML();
			data.appendChild(missonXML);
			
			//向导
			var guideXML:XML = _guideInfo.getXML();
			data.appendChild(guideXML);
			
			//活动
			var activityXML:XML = _activityInfo.getXML();
			data.appendChild(activityXML);
			
			//双倍
			var multiRewardXML:XML = _multiRewardInfo.getXML();
			data.appendChild(multiRewardXML);
			
			//练功
			var martialXML:XML = _martialInfo.getXML();
			data.appendChild(martialXML);
			
			//觉醒存档
			var glowingXML:XML = _glowingInfo.getXML();
			data.appendChild(glowingXML);
			
			//无尽闯关
			var endlessXML:XML = _endlessInfo.getXML();
			data.appendChild(endlessXML);
			
			//在线奖励
			var onlineTimeXML:XML = _onlineTimeInfo.getXML();
			data.appendChild(onlineTimeXML);
			
			//双倍副本
			var doubleLevelXML:XML = _doubleLevelInfo.getXML();
			data.appendChild(doubleLevelXML);
			
			//真假小宝
			var worldBossXML:XML = _worldBossInfo.getXML();
			data.appendChild(worldBossXML);
			
			//时装
			var fashionXML:XML = _roleFashionInfo.getXML();
			data.appendChild(fashionXML);
			
			//玩家PK
			var playerFightXML:XML = _playerFightInfo.getXML();
			data.appendChild(playerFightXML);
			
			//技能升级
			var upgradeSkillXML:XML = _upgradeSkill.getXML();
			data.appendChild(upgradeSkillXML);
			
			//角色图鉴
			var upgradeRoleXML:XML = _upgradeRole.getXML();
			data.appendChild(upgradeRoleXML);
			
			//称号系统
			var roleTitleXML:XML = _roleTitleInfo.getXML();
			data.appendChild(roleTitleXML);
			
			//中秋送礼
			var midAutumnXML:XML = _midAutumnInfo.getXML();
			data.appendChild(midAutumnXML);
			
			//vip
			var vipXML:XML = _vipInfo.getXML();
			data.appendChild(vipXML);
			
			//内功
			var strengthXML:XML = _strengthInfo.getXML();
			data.appendChild(strengthXML);
			
			//天地会
			var unionXML:XML = _unionInfo.getXML();
			data.appendChild(unionXML);
			
			//每日必做
			var dailyThingXML:XML = _dailyThingInfo.getXML();
			data.appendChild(dailyThingXML);
			
			//扫荡
			var autoFightXML:XML = _autoFightInfo.getXML();
			data.appendChild(autoFightXML);
			
			return data;
		}
		
		private function getRoleXML() : XML
		{
			var data:XML = <roles> </roles>;
			
			var role:XML;
			for (var i:int = 0; i < this.roleModels.length; i++)
			{
				role = roleModels[i].getXML();
				data.appendChild(role);
			}
			
			return data;
		}
		
		private function getPassLVXML() : XML
		{
			var xml:XML = <pass_level></pass_level>;
			var node:XML;
			var name:String;
			for (var i:int = 0; i < this.pass_level.length; i++)
			{
				node = <level name={pass_level[i].name} lv={pass_level[i].difficulty} />;
				xml.appendChild(node);
			}
			
			return xml;
		}
		
		private function getFightSoulXML() : XML
		{
			var xml:XML = <fight_soul>{fight_soul}</fight_soul>;
			return xml;
		}
		
		private function getMoneyXML() : XML
		{
			var xml:XML = <money>{money}</money>;
			return xml;
		}
		
		private function getDiceXML() : XML
		{
			var xml:XML = <dice>{dice}</dice>;
			return xml;
		}
		
		private function getStrengthExpXML() : XML
		{
			var xml:XML = <strength_exp>{strength_exp}</strength_exp>;
			return xml;
		}
		
		public function resetPlayer() : void
		{
			_isInit = false;
			pass_level = new Vector.<LevelInfo>();
			roles = new Vector.<RoleInfo>();
			fightAttach = new FightAttach();
			formation = new FormationInfo();
			pack = new PackInfo();
			_roleModels = new Vector.<RoleModel>();
			_mainRoleModel = new RoleModel();
			_signInInfo = new SignInInfo();
			_pluginGameInfo = new PluginGameInfo();
			_missonInfo = new MissonInfo();
			_guideInfo = new GuideInfo();
			_activityInfo = new ActivityInfo();
			_multiRewardInfo = new MultiRewardInfo();
			_martialInfo = new MartialInfo();
			_glowingInfo = new GlowingInfo();
			_endlessInfo = new EndlessInfo();
			_onlineTimeInfo = new OnlineTimeInfo();
			_doubleLevelInfo = new DoubleLevelInfo();
			_worldBossInfo = new WorldBossInfo();
			_roleFashionInfo = new RoleFashionInfo();
			_playerFightInfo = new PlayerFightInfo();
			_upgradeSkill = new UpgradeSkillInfo();
			_upgradeRole = new UpgradeRoleInfo();
			_roleTitleInfo = new RoleTitleInfo();
			_midAutumnInfo = new MidAutumnInfo();
			_vipInfo = new VIPInfo();
			_strengthInfo = new StrengthInfo();
			_unionInfo = new UnionInfo();
			_dailyThingInfo = new DailyThingInfo();
			_autoFightInfo = new AutoFightInfo();
		}
	}
}
package com.game.data.player
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.Activity.ActivityDetail;
	import com.game.data.Activity.ActivityInfo;
	import com.game.data.LevelSelect.AutoFightInfo;
	import com.game.data.daily.DailyThingInfo;
	import com.game.data.db.protocal.Characters;
	import com.game.data.db.protocal.Prop;
	import com.game.data.douleLevel.DoubleLevelInfo;
	import com.game.data.endless.EndlessInfo;
	import com.game.data.equip.EquipUtilies;
	import com.game.data.martial.MartialInfo;
	import com.game.data.midAutumn.MidAutumnInfo;
	import com.game.data.online.OnlineTimeInfo;
	import com.game.data.player.structure.EquipInfo;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.FightAttach;
	import com.game.data.player.structure.FightAttachInfo;
	import com.game.data.player.structure.FormationInfo;
	import com.game.data.player.structure.GuideInfo;
	import com.game.data.player.structure.LevelInfo;
	import com.game.data.player.structure.MissonInfo;
	import com.game.data.player.structure.PackInfo;
	import com.game.data.player.structure.PluginGameInfo;
	import com.game.data.player.structure.PropModel;
	import com.game.data.player.structure.RoleInfo;
	import com.game.data.player.structure.SignInInfo;
	import com.game.data.player.structure.SkillInfo;
	import com.game.data.playerFight.PlayerFightInfo;
	import com.game.data.prop.MultiRewardInfo;
	import com.game.data.prop.PropUtilies;
	import com.game.data.role.RoleFashionInfo;
	import com.game.data.role.RoleTitleInfo;
	import com.game.data.role.UpgradeRoleInfo;
	import com.game.data.shop.VIPInfo;
	import com.game.data.skill.UpgradeSkillInfo;
	import com.game.data.strength.StrengthInfo;
	import com.game.data.union.UnionInfo;
	import com.game.data.worldBoss.WorldBossInfo;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;

	public class PlayerUtitiles
	{
		/**
		 * 关卡信息 
		 * @param lvData
		 * @return 
		 * 
		 */		
		public static function assignPassLevel(lvData:XML) : Vector.<LevelInfo>
		{
			var lvInfos:Vector.<LevelInfo> = new Vector.<LevelInfo>();
			
			var info:LevelInfo;
			for each(var item:XML in lvData.level)
			{
				info = new LevelInfo();
				info.name = item.@name;
				info.difficulty = item.@lv;
				
				lvInfos.push(info);
			}
			
			return lvInfos;
		}
		
		/**
		 * 阵型 
		 * @param formation
		 * @return 
		 * 
		 */
		public static function assignFormation(formation:XML) : FormationInfo
		{
			var info:FormationInfo = new FormationInfo();
			info.front = formation.@front;
			info.middle = formation.@middle;
			info.back = formation.@back;
			
			return info;
		}
		
		/**
		 * 战附 
		 * @param data
		 * @return 
		 * 
		 */		
		public static function assignFightAttach(data:XML) : FightAttach
		{
			var fightAttack:FightAttach = new FightAttach();
			
			fightAttack.front = assignAttachInfo(data.front[0]);
			fightAttack.middle = assignAttachInfo(data.middle[0]);
			fightAttack.back = assignAttachInfo(data.back[0]);
			
			return fightAttack;
		}
		public static function assignAttachInfo(item:XML) : FightAttachInfo
		{
			var info:FightAttachInfo = new FightAttachInfo();
			
			info.hp = item.@hp;
			info.mp = item.@mp;
			info.atk = item.@atk;
			info.def = item.@def;
			info.spd = item.@spd;
			info.evasion = item.@evasion;
			info.crit = item.@crit;
			info.hit = item.@hit;
			info.toughness = item.@toughness;
			info.ats = item.@ats;
			info.adf = item.@adf;
			info.exp = item.@exp;
			
			return info;
		}
		
		/**
		 * 角色 
		 * @param data
		 * 
		 */		
		public static function assignRoles(data:XML) : Vector.<RoleInfo>
		{
			var roles:Vector.<RoleInfo> = new Vector.<RoleInfo>();
			
			var role:RoleInfo;
			for each(var item:XML in data.role)
			{
				role = assignRole(item);
				roles.push(role);
			}
			//设置主角名字
			V.MAIN_ROLE_NAME = roles[0].roleName;
			return roles;
		}	
		
		/**
		 * 角色 
		 * @param data
		 * 
		 */		
		public static function assignEnemyRoles(data:XML) : Vector.<RoleInfo>
		{
			var roles:Vector.<RoleInfo> = new Vector.<RoleInfo>();
			
			var role:RoleInfo;
			for each(var item:XML in data.role)
			{
				role = assignRole(item);
				roles.push(role);
			}
			
			return roles;
		}	
		
		public static function assignRole(data:XML) : RoleInfo
		{
			var info:RoleInfo = new RoleInfo();
			info.roleName = data.roleName;
			info.lv = data.lv;
			info.exp = data.exp;
			info.quality = data.quality;
			info.equip = assignEquip(data.equip[0]);
			info.skill = assignSkill(data.skill[0], info.roleName);                                       
			
			return info;
		}
		// 装备
		public static function assignEquip(data:XML) : EquipInfo
		{
			var info:EquipInfo = new EquipInfo();
			info.weapon = data.weapon || -1;
			info.cloth = data.cloth || -1;
			info.thing = data.thing || -1;
			
			return info;
		}
		// 技能
		public static function assignSkill(data:XML, roleName:String) : SkillInfo
		{
			var info:SkillInfo = new SkillInfo();
			
			// 主角
			if (roleName == V.MAIN_ROLE_NAME)
			{
				info.skill1 = data.skill1;
				info.skill2 = data.skill2;
				info.skill3 = data.skill3;
				info.learnedSkill = data.learnedSkill;
			}
			// 非主角(技能从配置走)
			else
			{
				Data.instance.db.interfaces(
					InterfaceTypes.GET_ROLE_BASE_DATA,
					V.ME,
					roleName,
					function (datas:Characters) : void
					{
						if (datas.fixedskill_name == "无")
						{
							info.skill1 = data.skill1;
							return;
						}
						
						var skills:Array = datas.fixedskill_name.split("|");
						var index:int;
						for (var i:int = 0; i < skills.length; i++)
						{
							index = i + 1;
							info["skill" + index] = skills[i];
						}
						
					});
				info.skill2 = data.skill2;
				info.skill3 = data.skill3;
				info.learnedSkill = data.learnedSkill;
			}
			
			return info;
		}
		
		// 装备-道具
		public static function assignPack(data:XML) : PackInfo
		{
			var info:PackInfo = new PackInfo();
			// 装备
			info.equips = assignPackEquip(data.equip[0]);
			info.equips_cur_id = data.equip[0].@curid;
			// 道具
			info.props = assignPackProp(data.prop[0]);
			
			return info;
		}
		
		/**
		 * 道具 
		 * @param data
		 * @return 
		 * 
		 */		
		public static function assignPackProp(data:XML) : Vector.<PropModel>
		{
			var props:Vector.<PropModel> = new Vector.<PropModel>();
			
			var propModel:PropModel;
			for each(var itemXML:XML in data.item)
			{
				propModel = new PropModel();
				propModel.id = itemXML.@id;
				propModel.num = itemXML.@num;
				propModel.config = PropUtilies.getPropById(propModel.id);
				props.push(propModel);
			}
			
			return props;
		}
		
		/**
		 * 装备 
		 * @param data
		 * @return 
		 * 
		 */		
		public static function assignPackEquip(data:XML) : Vector.<EquipModel>
		{
			var equips:Vector.<EquipModel> = new Vector.<EquipModel>();
			var model:EquipModel;
			for each(var item:XML in data.item)
			{
				model = new EquipModel();
				model.mid = item.@mid;
				model.id = item.@id;
				model.lv = item.@lv;
				model.atk = item.@atk;
				model.def = item.@def;
				model.spd = item.@spd;
				addEquipData(item, model);
				addComposeData(item, model);
				model.isEquiped = (item.@isEquiped == "true");
				model.config = EquipUtilies.getEquip(model.id);
				equips.push(model);
			}
			
			return equips;
		}
		
		private static function addEquipData(item:XML, model:EquipModel) : void
		{
			if(!item.hasOwnProperty("@hp")) model.hp = 0;
			else model.hp = item.@hp;
			if(!item.hasOwnProperty("@mp")) model.mp = 0;
			else model.mp = item.@mp
			if(!item.hasOwnProperty("@evasion") && !item.hasOwnProperty("@crit")) 
			{
				Data.instance.db.interfaces(InterfaceTypes.GET_EQUIP_DATA_BY_ID,
					model.id,
					function (data:Object) : void
					{
						model.evasion = EquipUtilies.getBalanceValue(data.evasion);
						model.crit = EquipUtilies.getBalanceValue(data.crit);
					})
			}
			else 
			{
				model.evasion = item.@evasion;
				model.crit = item.@crit;
			}
			//trace(model.evasion, model.crit);
		}
		
		private static function addComposeData(item:XML, model:EquipModel) : void
		{
			if(!item.hasOwnProperty("@hp_compose")) model.hp_compose = 0;
			else model.hp_compose = item.@hp_compose;
			if(!item.hasOwnProperty("@mp_compose")) model.mp_compose = 0;
			else model.mp_compose = item.@mp_compose;
			if(!item.hasOwnProperty("@atk_compose")) model.atk_compose = 0;
			else model.atk_compose = item.@atk_compose;
			if(!item.hasOwnProperty("@def_compose")) model.def_compose = 0;
			else model.def_compose = item.@def_compose;
			if(!item.hasOwnProperty("@spd_compose")) model.spd_compose = 0;
			else model.spd_compose = item.@spd_compose;
			if(!item.hasOwnProperty("@evasion_compose")) model.evasion_compose = 0;
			else model.evasion_compose = item.@evasion_compose;
			if(!item.hasOwnProperty("@crit_compose")) model.crit_compose = 0;
			else model.crit_compose = item.@crit_compose;
		}
		
		/**
		 * 每日签到 
		 * @param data
		 * @return 
		 * 
		 */		
		public static function assignSignIn(data:XML) : SignInInfo
		{
			// 没有签到记录（旧文档）
			if (!data)
			{
				Log.Trace("旧的文档记录!");
				data = XML("<sign_in><duration>0</duration><lastDay>1970-01-01 0:0:0</lastDay><signDays></signDays></sign_in>");
			}
			
			var info:SignInInfo = new SignInInfo();
			
			info.duration = data.duration || 0;
			info.lastDay = data.lastDay || '';
			info.signDays = data.signDays || '';
			
			return info;
		}
		
		/**
		 * 插件游戏 
		 * @param data
		 * @return 
		 * 
		 */		
		public static function assignPluginGame(data:XML) : PluginGameInfo
		{
			if (!data)
			{
				Log.Trace("旧的文档记录!");
				data = <plugin_game>
					<!-- 酒 -->
			    	<wine>0000-00-00 0:0:0</wine>
			    	<!-- 色 -->
			    	<lechery>0000-00-00 0:0:0</lechery>
			    	<!-- 财 -->
			    	<money>0000-00-00 0:0:0</money>
			    	<!-- 气 -->
			    	<breath>0000-00-00 0:0:0</breath>
				</plugin_game>;
			}
			
			var info:PluginGameInfo = new PluginGameInfo();
			info.init(data);
			
			return info;
		}
		
		/**
		 * 每日任务 
		 * @param data
		 * @return 
		 * 
		 */		
		public static function assignMisson(data:XML) : MissonInfo
		{
			if (!data)
			{
				data = <mission>
					    	<!-- 上次任务时间  -->
					    	<time>0000-00-00 0:0:0</time>
					    	<items>
								<!-- id:任务id, isComplete:是否完成领取， equipment:装备ID，prop:道具ID-->
								<!-- <item id="1" isComplete="-1" equipmentID="-1" propID="-1"/> -->
					    	</items>
							<!-- 1-2|2-3 1:怪物id,2:怪物数量 -->
					    	<enemy></enemy>
					    </mission>;
			}
			
			var info:MissonInfo = new MissonInfo();
			info.init(data);
			
			return info;
		}
		
		public static function assignGuide(data:XML) : GuideInfo
		{
			if(!data)
			{
				data = <guide>
							<items>
								<!--id:向导id,   levelName:向导的关卡名   type:向导类型   isComplete:是否已完成 -->
								<!--<item id="1" levelName="1_1" type="enter" isComplete="-1">-->
							</items>
					   </guide>;
			}
			
			var info:GuideInfo = new GuideInfo();
			info.init(data);
			
			return info
		}
		
		public static function assignActivity(data:XML) : ActivityInfo
		{
			if(!data)
			{
				data = <activity>
					   </activity>;
			}
			
			var info:ActivityInfo = new ActivityInfo();
			info.init(data);
			
			return info;
		}
		
		public static function assignMultiReward(data:XML) : MultiRewardInfo
		{
			if(!data)
			{
				data = <multiReward>
					</multiReward>;
			}
			var info:MultiRewardInfo = new MultiRewardInfo();
			info.init(data);
			
			return info;
		}
		
		public static function assignMartial(data:XML) : MartialInfo
		{
			if(!data)
			{
				data = <martial>
					</martial>;
			}
			var info:MartialInfo = new MartialInfo();
			info.init(data);
			
			return info;
		}
		
		public static function assignGlowing(data:XML) : GlowingInfo
		{
			if(!data)
			{
				data = <glowing>
					</glowing>;
			}
			var info:GlowingInfo = new GlowingInfo();
			info.init(data);
			
			return info;
		}
		
		public static function assignEndless(data:XML) : EndlessInfo
		{
			if(!data)
			{
				data = <endless>
					</endless>;
			}
			var info:EndlessInfo = new EndlessInfo();
			info.init(data);
			
			return info;
		}
		
		public static function assignOnlineTime(data:XML) : OnlineTimeInfo
		{
			if(!data)
			{
				data = <onlineTime>
					</onlineTime>;
			}
			var info:OnlineTimeInfo = new OnlineTimeInfo();
			info.init(data);
			
			return info;
		}
		
		public static function assignDoubleLevel(data:XML) : DoubleLevelInfo
		{
			if(!data)
			{
				data = <doubleLevel>
					</doubleLevel>;
			}
			var info:DoubleLevelInfo = new DoubleLevelInfo();
			info.init(data);
			
			return info;
		}
		
		public static function assignWorldBoss(data:XML) : WorldBossInfo
		{
			if(!data)
			{
				data = <worldBoss>
					</worldBoss>;
			}
			var info:WorldBossInfo = new WorldBossInfo();
			info.init(data);
			
			return info;
		}
		
		public static function assignFashion(data:XML) : RoleFashionInfo
		{
			if(!data)
			{
				data = <fashion>
					</fashion>;
			}
			var info:RoleFashionInfo = new RoleFashionInfo();
			info.init(data);
			
			return info;
		}
		
		public static function assignPlayerFight(data:XML) : PlayerFightInfo
		{
			if(!data)
			{
				data = <playerFight>
					</playerFight>;
			}
			
			var info:PlayerFightInfo = new PlayerFightInfo();
			info.init(data);
			
			return info;
		}
		
		
		public static function assignUpgradeSkill(data:XML) : UpgradeSkillInfo
		{
			if(!data)
			{
				data = <upgradeSkill>
					</upgradeSkill>;
			}
			
			var info:UpgradeSkillInfo = new UpgradeSkillInfo();
			info.init(data);
			
			return info;
		}
		
		public static function assignUpgradeRole(data:XML) : UpgradeRoleInfo
		{
			if(!data)
			{
				data = <upgradeRole>
					</upgradeRole>;
			}
			
			var info:UpgradeRoleInfo = new UpgradeRoleInfo();
			info.init(data);
			
			return info;
		}
		
		public static function assignStrength(data:XML) : StrengthInfo
		{
			if(!data)
			{
				data = <strength>
					   </strength>;
			}
			
			var info:StrengthInfo = new StrengthInfo();
			info.init(data);
			
			return info;
		}
		
		public static function assignRoleTitle(data:XML) : RoleTitleInfo
		{
			if(!data)
			{
				data = <roleTitle>
					   </roleTitle>;
			}
			
			var info:RoleTitleInfo = new RoleTitleInfo();
			info.init(data);
			
			return info;
		}
		
		public static function assignMidAutumn(data:XML) : MidAutumnInfo
		{
			if(!data)
			{
				data = <midAutumn>
						</midAutumn>;
			}
			
			var info:MidAutumnInfo = new MidAutumnInfo;
			info.init(data);
			
			return info;
		}
		
		public static function assignVIP(data:XML) : VIPInfo
		{
			if(!data)
			{
				data = <vip>
						</vip>;
			}
			
			var info:VIPInfo = new VIPInfo;
			info.init(data);
			
			return info;
		}
		
		public static function assignUnion(data:XML) : UnionInfo
		{
			if(!data)
			{
				data = <union>
						</union>;
			}
			
			var info:UnionInfo = new UnionInfo;
			info.init(data);
			
			return info;
		}
		
		public static function assignDailyThing(data:XML) : DailyThingInfo
		{
			if(!data)
			{
				data = <dailyThing>
						</dailyThing>;
			}
			
			var info:DailyThingInfo = new DailyThingInfo;
			info.init(data);
			
			return info;
		}
		
		public static function assignAutoFight(data:XML) : AutoFightInfo
		{
			if(!data)
			{
				data = <autoFight>
						</autoFight>;
			}
			
			var info:AutoFightInfo = new AutoFightInfo;
			info.init(data);
			
			return info;
		}
	}
}
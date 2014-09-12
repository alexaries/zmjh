package com.game.data.playerKilling
{
	import com.game.Data;
	import com.game.data.fight.FightConfig;
	import com.game.data.player.PlayerUtitiles;
	import com.game.data.player.structure.FightAttach;
	import com.game.data.player.structure.FormationInfo;
	import com.game.data.player.structure.PackInfo;
	import com.game.data.player.structure.RoleInfo;
	import com.game.data.player.structure.RoleModel;
	import com.game.data.role.RoleFashionInfo;
	import com.game.data.role.RoleTitleInfo;
	import com.game.data.shop.VIPInfo;
	import com.game.data.skill.UpgradeSkillInfo;
	import com.game.data.strength.StrengthInfo;
	import com.game.template.V;
	
	import starling.events.EventDispatcher;

	public class PlayerKillingPlayer extends EventDispatcher
	{
		private var _data:Data = Data.instance;
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
		
		/**
		 * 角色维护 
		 */		
		private var _roleModels:Vector.<PlayerKillingModel>;
		public function get roleModels() : Vector.<PlayerKillingModel>
		{
			return _roleModels;
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
		 * 内功系统
		 */		
		private var _strengthInfo:StrengthInfo;
		public function get strengthInfo() : StrengthInfo
		{
			return _strengthInfo;
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
		 * vip系统
		 */		
		private var _vipInfo:VIPInfo;
		public function get vipInfo() : VIPInfo
		{
			return _vipInfo;
		}
		
		/**
		 * 技能升级
		 */		
		private var _upgradeSkill:UpgradeSkillInfo;
		public function get upgradeSkill() : UpgradeSkillInfo
		{
			return _upgradeSkill;
		}
		
		public function PlayerKillingPlayer()
		{
			
		}
		
		public function init(configXML:XML) : void
		{
			parseXML(configXML);
			initRoleModel();
		}
		
		/**
		 * 解析XML 
		 * @param configXML
		 * 
		 */		
		protected function parseXML(configXML:XML) : void
		{
			formation = PlayerUtitiles.assignFormation(configXML.formation[0]);
			fightAttach = PlayerUtitiles.assignFightAttach(configXML.fightAttach[0]);
			roles = PlayerUtitiles.assignEnemyRoles(configXML.roles[0]);
			pack = PlayerUtitiles.assignPack(configXML.pack[0]);
			_strengthInfo = PlayerUtitiles.assignStrength(configXML.strength[0]);
			_roleFashionInfo = PlayerUtitiles.assignFashion(configXML.fashion[0]);
			_roleTitleInfo = PlayerUtitiles.assignRoleTitle(configXML.roleTitle[0]);
			_vipInfo = PlayerUtitiles.assignVIP(configXML.vip[0]);
			_upgradeSkill = PlayerUtitiles.assignUpgradeSkill(configXML.upgradeSkill[0]);
			
			_data.playerKillingPack.initPack();
		}
		
		/**
		 * 角色 
		 * 
		 */
		protected function initRoleModel() : void
		{
			_roleModels = new Vector.<PlayerKillingModel>();
			var model:PlayerKillingModel;
			var info:RoleInfo;
			var position:String;
			for (var i:int = 0, len:int = roles.length; i < len; i++)
			{
				info = roles[i];
				model = new PlayerKillingModel();
				model.initModel(this, info);
				_roleModels.push(model);
			}
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

		
		public function getRoleModel(name:String) : PlayerKillingModel
		{
			var model:PlayerKillingModel;
			for each(var item:PlayerKillingModel in this._roleModels)
			{
				if (item.model.name == name)
				{
					model = item;
					break;
				}
			}
			
			return model;
		}
		
		public function getTypeRoleModel(name:String) : PlayerKillingModel
		{
			var roleModel:PlayerKillingModel;
			var newName:String = name.split("（")[0];
			
			if(roleModel == null && getRoleModel(newName) != null)
				roleModel = getRoleModel(newName);
			
			if(roleModel == null && getRoleModel(newName + "（夜）") != null)
				roleModel = getRoleModel(newName + "（夜）");
			
			if(roleModel == null && getRoleModel(newName + "（雨）") != null)
				roleModel = getRoleModel(newName + "（雨）");
			
			if(roleModel == null && getRoleModel(newName + "（风）") != null)
				roleModel = getRoleModel(newName + "（风）");
			
			if(roleModel == null && getRoleModel(newName + "（雷）") != null)
				roleModel = getRoleModel(newName + "（雷）");
			
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
		
	}
}
package com.game.data.role
{
	import com.game.View;
	import com.game.data.Base;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.RoleInfo;
	import com.game.data.player.structure.RoleModel;
	import com.game.data.player.structure.SkillInfo;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;

	public class RoleSelectData extends Base
	{
		private var _player:Player;
		private function get player():Player
		{
			_player= _data.player.player;
			return _player;
		}
		
		public function RoleSelectData()
		{
			
		}
		
		
		/**
		 * 创建觉醒后的角色数据
		 * @return 
		 * 
		 */		
		public function createEndRole(roleModel:RoleModel, glowingType:String) : RoleModel
		{
			var newRoleInfo:RoleInfo = createRoleInfo(roleModel, glowingType);
			var newRole:RoleModel = new RoleModel();
			newRole.initModel(player, newRoleInfo, true, roleModel.info.roleName);
			
			return newRole;
		}
		
		private function createRoleInfo(roleModel:RoleModel, glowingType:String) : RoleInfo
		{
			var info:RoleInfo = new RoleInfo();
			info.roleName = roleModel.info.roleName.split("（")[0] + "（" + glowingType + "）";
			info.lv = roleModel.info.lv;
			info.exp = roleModel.info.exp;
			info.quality = roleModel.info.quality;
			info.equip = roleModel.info.equip;
			info.skill = roleModel.info.skill;
			
			return info;
		}
		
		/**
		 * 学习技能
		 * @param mainRoleModel
		 * @param secondRoleModel
		 * 
		 */		
		public function learnRoleSkill(mainRoleModel:RoleModel, secondRoleModel:RoleModel) : void
		{
			var curSkill:SkillInfo = mainRoleModel.info.skill;
			var newSkillId:int = _data.db.interfaces(InterfaceTypes.GET_SKILL_ID, (secondRoleModel.info.skill.skill1));
			_data.skill.learnSkill(newSkillId, curSkill);
			View.instance.gain_skill.interfaces(InterfaceTypes.Show, newSkillId, mainRoleModel.info.roleName);
		}
		
		/**
		 * 觉醒角色
		 * @param startRole
		 * @param endRole
		 * @param glowingType
		 * 
		 */		
		public function glowingRole(startRole:RoleModel, endRole:RoleModel, glowingType:String) : void
		{
			
			var requestRoles:Array = endRole.configData.synthetic.split("|");
			for(var j:int = 0; j < requestRoles.length; j++)
			{
				var name:String = requestRoles[j];
				player.pack.unLoadRoleEquip(player.getMyRoleModel(name));
				player.removeRole(name);
				
				if(player.formation.front == name)
					player.formation.front = "";
				if(player.formation.middle == name)
					player.formation.middle = "";
				if(player.formation.back == name)
					player.formation.back = "";
			}
			
			var startName:String = startRole.info.roleName;
			var endName:String = "";
			for(var i:int = 0; i < player.roles.length; i++)
			{
				if(player.roles[i].roleName == startName)
				{
					endName = startName.split("（")[0] + "（" + glowingType + "）";
					player.formation.glowingChange(startName, endName);
					player.roles[i].roleName = endName;
					player.roleModels[i].initModel(player, player.roles[i]);
					break;
				}
			}
			
			if(startName.split("（")[0] == "韦小宝")
				V.MAIN_ROLE_NAME = endName;
			
			player.glowingInfo.addGlowing(startName, endName);
			_data.player.player.upgradeRole.addRole(endName);
		}
		
		/**
		 * 降低角色属性类型
		 * @param roleName
		 * 
		 */		
		public function reduceRoleType(roleName:String) : void
		{
			for(var i:int = 0; i < player.roles.length; i++)
			{
				if(player.roles[i].roleName == roleName)
				{
					var startNameList:Array = roleName.split("（");
					switch(startNameList[1])
					{
						case "夜）":
							startTranslate(player.roles[i], player.roleModels[i]);
							break;
						case "雨）":
							startTranslate(player.roles[i], player.roleModels[i]);
							break;
						case "风）":
							startTranslate(player.roles[i], player.roleModels[i], "夜");
							break;
						case "雷）":
							startTranslate(player.roles[i], player.roleModels[i], "雨");
							break;
					}
					break;
				}
			}
		}
		
		/**
		 * 转换角色对应类型属性
		 * @param roleName
		 * 
		 */		
		public function translateRoleType(roleName:String) : void
		{
			for(var i:int = 0; i < player.roles.length; i++)
			{
				if(player.roles[i].roleName == roleName)
				{
					var startNameList:Array = roleName.split("（");
					switch(startNameList[1])
					{
						case "夜）":
							startTranslate(player.roles[i], player.roleModels[i], "雨");
							break;
						case "雨）":
							startTranslate(player.roles[i], player.roleModels[i], "夜");
							break;
						case "风）":
							startTranslate(player.roles[i], player.roleModels[i], "雷");
							break;
						case "雷）":
							startTranslate(player.roles[i], player.roleModels[i], "风");
							break;
					}
					break;
				}
			}
		}
		
		/**
		 * 开始转换属性
		 * @param role
		 * @param roleModel
		 * @param translateType
		 * 
		 */		
		private function startTranslate(role:RoleInfo, roleModel:RoleModel, translateType:String = "") : void
		{
			var startName:String = role.roleName;
			var endName:String;
			if(translateType == "")
				endName = startName.split("（")[0];
			else
				endName = startName.split("（")[0] + "（" + translateType + "）";
			player.formation.glowingChange(startName, endName);
			role.roleName = endName;
			roleModel.initModel(player, role);
			
			if(startName.split("（")[0] == "韦小宝")
				V.MAIN_ROLE_NAME = endName;
		}
		
		/**
		 * 可以转换属性类型的角色
		 * @return 
		 * 
		 */		
		public function getTranslateRoles() : Vector.<RoleModel>
		{
			var models:Vector.<RoleModel> = new Vector.<RoleModel>();
			var role:RoleModel;
			for (var i:int = 0, len:int = player.roleModels.length; i < len; i++)
			{
				role = player.roleModels[i];
				
				if (player.martialInfo.isInMartial(role.info.roleName)) continue;
				if (role.info.roleName.split("（").length == 1) continue;
				
				models.push(role);
			}
			
			return models;
		}
		
		
		public function sortByGrade(x:Object, y:Object) : Number
		{
			var result:Number = 0;
			
			switch(x.grade)
			{
				case "极":
					if(y.grade == "极")
						result = 0;
					else
						result = 1;
					break;
				case "甲+":
					if(y.grade != "丁" && y.grade != "丙" && y.grade != "乙" && y.grade != "甲" && y.grade != "甲+")
						result = -1;
					else if(y.grade == "甲+")
						result = 0;
					else
						result = 1;
					break;
				case "甲":
					if(y.grade != "丁" && y.grade != "丙" && y.grade != "乙" && y.grade != "甲")
						result = -1;
					else if(y.grade == "甲")
						result = 0;
					else
						result = 1;
					break;
				case "乙":
					if(y.grade != "丁" && y.grade != "丙" && y.grade != "乙")
						result = -1;
					else if(y.grade == "乙")
						result = 0;
					else
						result = 1;
					break;
				case "丙":
					if((y.grade != "丁" && y.grade != "丙"))
						result = -1;
					else if(y.grade == "丙")
						result = 0;
					else
						result = 1;
					break;
				case "丁":
					if(y.grade != "丁")
						result = -1;
					else
						result = 0;
					break;
			}
			
			return result;
		}
	}
}
package com.game.data.skill
{
	import com.game.Data;
	import com.game.data.Base;
	import com.game.data.db.protocal.Skill;
	import com.game.data.player.SkillUtitiles;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.RoleModel;
	import com.game.data.player.structure.SkillInfo;
	import com.game.data.player.structure.SkillModel;
	import com.game.template.InterfaceTypes;

	public class SkillData extends Base
	{
		private var _player:Player;
		
		public function SkillData()
		{
			
		}
		
		public function initSkill() : void
		{
			_player = _data.player.player;
		}
		
		public function setEquip(roleModel:RoleModel, skill:SkillModel) : void
		{
			if (searchSkill(roleModel, skill.skill.skill_name)) return;
			
			if (!roleModel.info.skill.skill1 || roleModel.info.skill.skill1 == "")
			{
				roleModel.info.skill.skill1 = skill.skill.skill_name;
			}
			else if (!roleModel.info.skill.skill2 || roleModel.info.skill.skill2 == "")
			{
				roleModel.info.skill.skill2 = skill.skill.skill_name;
			}
			else if (!roleModel.info.skill.skill3 || roleModel.info.skill.skill3 == "")
			{
				roleModel.info.skill.skill3 = skill.skill.skill_name;
			}
			else
			{
				roleModel.info.skill.skill1 = skill.skill.skill_name;
			}
		}
		
		protected function searchSkill(roleModel:RoleModel, skill_name:String) : Boolean
		{
			var bol:Boolean = false;
			
			if (roleModel.info.skill.skill1 == skill_name)
			{
				bol = true;
			}
			else if (roleModel.info.skill.skill2 == skill_name)
			{
				bol = true;
			}
			else if (roleModel.info.skill.skill3 == skill_name)
			{
				bol = true;
			}
			
			return bol;
		}
		
		public function downEquip(roleModel:RoleModel, skill:SkillModel) : void
		{
			if (roleModel.info.skill.skill1 == skill.skill.skill_name)
			{
				roleModel.info.skill.skill1 = "";
			}
			
			if (roleModel.info.skill.skill2 == skill.skill.skill_name)
			{
				roleModel.info.skill.skill2 = "";
			}
			
			if (roleModel.info.skill.skill3 == skill.skill.skill_name)
			{
				roleModel.info.skill.skill3 = "";
			}
		}
		
		/**
		 * 学习技能 
		 * @param skillName
		 * 
		 */		
		public function learnSkill(skill_id:int, skillInfo:SkillInfo) : void
		{
			var skillName:String;
			Data.instance.db.interfaces(
				InterfaceTypes.GET_SKILL_DATA_BY_iD,
				skill_id,
				function (data:Skill) : void
				{
					skillName = data.skill_name;
				});
			
			Data.instance.player.player.upgradeSkill.addSkillName(skillName);
				
			var learned:Array = skillInfo.learnedSkill.split("|");
			
			if (learned.indexOf(skillName) == -1)
			{
				skillInfo.learnedSkill += "|" + skillName;
			}
		}
		
		
		public function getSkills(skillInfo:SkillInfo) : Vector.<SkillModel>
		{
			var skills:Vector.<SkillModel> = new Vector.<SkillModel>();
			var skillModel:SkillModel;
			var skill:Skill;
			if (skillInfo.skill1 && skillInfo.skill1 != "")
			{
				skill = SkillUtitiles.getSkill(skillInfo.skill1);
				skillModel = new SkillModel();
				skillModel.isLearned = true;
				skillModel.skill = skill;
				skillModel.isEquiped = true;
				skills.push(skillModel);
			}
			else
			{
				skills.push(null);
			}
			
			if (skillInfo.skill2 && skillInfo.skill2 != "")
			{
				skill = SkillUtitiles.getSkill(skillInfo.skill2);
				skillModel = new SkillModel();
				skillModel.isLearned = true;
				skillModel.skill = skill;
				skillModel.isEquiped = true;
				skills.push(skillModel);
			}
			else
			{
				skills.push(null);
			}
			
			if (skillInfo.skill3 && skillInfo.skill3 != "")
			{
				skill = SkillUtitiles.getSkill(skillInfo.skill3);
				skillModel = new SkillModel();
				skillModel.isLearned = true;
				skillModel.skill = skill;
				skillModel.isEquiped = true;
				skills.push(skillModel);
			}	
			else
			{
				skills.push(null);
			}
			
			return skills;
		}
	}
}
package com.game.data.player
{
	import com.game.Data;
	import com.game.data.db.protocal.Skill;
	import com.game.data.player.structure.RoleInfo;
	import com.game.data.player.structure.SkillInfo;
	import com.game.data.player.structure.SkillModel;
	import com.game.template.InterfaceTypes;

	public class SkillUtitiles
	{
		private static var _data:Data = Data.instance;
		
		public function SkillUtitiles()
		{
			
		}
		
		public static function getAllSkills(info:RoleInfo, data:Vector.<Object>) : Vector.<SkillModel>
		{
			var skills:Vector.<SkillModel> = new Vector.<SkillModel>();
			
			var skillName:String;
			var skillModel:SkillModel;
			var skill:Skill;
			for (var i:int = 0, len:int = data.length; i < len; i++)
			{
				skill = data[i] as Skill;
				
				if (skill.type == 0 || skill.type == 1)
				{
					skillModel = new SkillModel();
					skillModel.isLearned = judgeSkillLearned(info.skill, skill.skill_name);
					skillModel.skill = skill;
					skills.push(skillModel);
				}
			}

			return skills;
		}
		
		public static function getSkill(skillName:String) : Skill
		{
			var skill:Skill;
			
			_data.db.interfaces(
				InterfaceTypes.GET_SKILL_DATA,
				skillName,
				function (data:Skill) : void
				{
					skill = data;
				});
			
			return skill;
		}
		
		public static function judgeSkillLearned(info:SkillInfo, skillName:String) : Boolean
		{
			var learned:Array = info.learnedSkill.split("|");
			
			return (learned.indexOf(skillName) != -1)
		}
	}
}
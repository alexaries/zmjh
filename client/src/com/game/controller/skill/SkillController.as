package com.game.controller.skill
{
	import com.game.controller.Base;
	import com.game.data.player.structure.RoleModel;
	import com.game.data.player.structure.SkillModel;

	public class SkillController extends Base
	{
		public function SkillController()
		{
		}
		
		public function setEquip(roleModel:RoleModel, skill:SkillModel) : void
		{
			_controller.data.skill.setEquip(roleModel, skill);
		}
		
		public function downEquip(roleModel:RoleModel, skill:SkillModel) : void
		{
			_controller.data.skill.downEquip(roleModel, skill);
		}
	}
}
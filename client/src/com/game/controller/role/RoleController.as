package com.game.controller.role
{
	import com.game.controller.Base;
	import com.game.data.player.structure.RoleInfo;
	import com.game.data.player.structure.RoleModel;

	public class RoleController extends Base
	{
		public function RoleController()
		{
		}
		
		public function createEndRole(roleModel:RoleModel, glowingType:String) : RoleModel
		{
			return _controller.data.role_select.createEndRole(roleModel, glowingType);
		}
		
		public function learnRoleSkill(mainRoleModel:RoleModel, secondRoleModel:RoleModel) : void
		{
			_controller.data.role_select.learnRoleSkill(mainRoleModel, secondRoleModel);
		}
		
		public function glowingRole(startRole:RoleModel, endRole:RoleModel, glowingType:String) : void
		{
			_controller.data.role_select.glowingRole(startRole, endRole, glowingType);
		}
	}
}
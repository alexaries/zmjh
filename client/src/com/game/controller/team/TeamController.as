package com.game.controller.team
{
	import com.game.controller.Base;

	public class TeamController extends Base
	{
		public function TeamController()
		{
		}
		
		public function setTeam(roleName:String) : void
		{
			_controller.data.team.setTeam(roleName);
		}
		
		public function removeTeam(roleName:String) : void
		{
			_controller.data.team.removeTeam(roleName);
		}
	}
}
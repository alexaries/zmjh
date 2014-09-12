package com.game.controller.adventures
{
	import com.game.controller.Base;
	import com.game.data.db.protocal.Adventures;
	import com.game.template.InterfaceTypes;

	public class AdventuresController extends Base
	{
		public function AdventuresController()
		{
		}
		
		public function getAdventuresConfigData() : Vector.<Object>
		{
			return _controller.data.db.interfaces(InterfaceTypes.GET_ADVENTURES_DATA);
		}
		
		/**
		 * 奇遇角色buff 
		 * 
		 */		
		public function setRoleModelDataByAdventures(adventures:Adventures) : void
		{
			_controller.data.formation.setRoleModelDataByAdventures(adventures);
		}
	}
}
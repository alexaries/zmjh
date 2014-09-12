package com.game.controller.db
{
	import com.game.controller.Base;
	import com.game.data.player.structure.RoleInfo;
	import com.game.template.InterfaceTypes;

	public class DBController extends Base
	{
		public function DBController()
		{
		}
		
		public function init() : void
		{
			_controller.data.db.interfaces();
		}
		
		public function getItemDisposition(levelName:String, difficult:int, callback:Function) : void
		{
			_controller.data.db.interfaces(InterfaceTypes.GET_ITEM_DISPOSITION_DATA, levelName, difficult, callback);
		}
		
		public function getSkillAllData(info:RoleInfo, callback:Function) : void
		{
			_controller.data.db.interfaces(InterfaceTypes.GET_SKILL_ALL_DATA, info, callback);
		}
	}
}
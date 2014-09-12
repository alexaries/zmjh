package com.game
{
	import com.game.controller.LevelSelect.LVSelectController;
	import com.game.controller.adventures.AdventuresController;
	import com.game.controller.db.DBController;
	import com.game.controller.equip.EquipController;
	import com.game.controller.fight.FightController;
	import com.game.controller.formation.FormationController;
	import com.game.controller.pack.PackController;
	import com.game.controller.player.PlayerController;
	import com.game.controller.profiler.ProfilerController;
	import com.game.controller.role.RoleController;
	import com.game.controller.save.SaveController;
	import com.game.controller.skill.SkillController;
	import com.game.controller.start.StartController;

	public class ControllerBase extends ControllerSuperBase implements IBase
	{
		public function get profiler() : ProfilerController
		{
			return this.createObject(ProfilerController) as ProfilerController;
		}
		
		public function get db() : DBController
		{
			return this.createObject(DBController) as DBController;
		}
		
		public function get fight() : FightController
		{
			return this.createObject(FightController) as FightController;
		}
		
		public function get player() : PlayerController
		{
			return this.createObject(PlayerController) as PlayerController;
		}
		
		public function get equip() : EquipController
		{
			return this.createObject(EquipController) as EquipController;
		}
		
		public function get skill() : SkillController
		{
			return this.createObject(SkillController) as SkillController;
		}
		
		public function get formation() : FormationController
		{
			return this.createObject(FormationController) as FormationController; 
		}
		
		public function get LVSelect() : LVSelectController
		{
			return this.createObject(LVSelectController) as LVSelectController; 
		}
		
		public function get pack() : PackController
		{
			return this.createObject(PackController) as PackController; 
		}
		
		public function get start() : StartController
		{
			return this.createObject(StartController) as StartController; 
		}
		
		public function get adventures() : AdventuresController
		{
			return this.createObject(AdventuresController) as AdventuresController; 
		}
		
		public function get save() : SaveController
		{
			return this.createObject(SaveController) as SaveController;
		}
		
		public function get role() : RoleController
		{
			return this.createObject(RoleController) as RoleController;
		}
		
		public function ControllerBase()
		{
			super();
		}
		
		public function init(data:Data, view:View, lang:Lang) : void
		{
			_data = data;
			_view = view;
			_lang = lang;
			
			preInitModel();
		}
		
		public function preInitModel() : void
		{
			//profiler.init();
		}
	}
}
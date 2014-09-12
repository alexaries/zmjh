package com.game.controller.formation
{
	import com.game.controller.Base;

	public class FormationController extends Base
	{
		public function FormationController()
		{
		}
		
		public function setTransposition(sIndex:int, eIndex:int, refreshDetailView:Boolean = true) : void
		{
			_controller.data.formation.setTransposition(sIndex, eIndex, refreshDetailView);
		}
		
		public function getFormationData() : Object
		{
			return _controller.data.formation.getFormationData();
		}
		
		public function removeTransposition(roleName:String, position:String) : void
		{
			_controller.data.formation.removeTransposition(roleName, position);
		}
		
		public function setDefaultPosition(roleName:String) : void
		{
			_controller.data.formation.setDefaultPosition(roleName);
		}
	}
}
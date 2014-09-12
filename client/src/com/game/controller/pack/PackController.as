package com.game.controller.pack
{
	import com.game.controller.Base;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.PropModel;

	public class PackController extends Base
	{
		public function PackController()
		{
		}
		
	
		
		public function addEquipment(equip:EquipModel) : void
		{
			_controller.data.pack.addEquipment(equip);
		}
		
		public function addProp(prop:PropModel) : void
		{
			_controller.data.pack.addProp(prop);
		}
	}
}
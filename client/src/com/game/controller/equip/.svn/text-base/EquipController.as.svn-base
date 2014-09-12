package com.game.controller.equip
{
	import com.game.controller.Base;
	import com.game.data.db.protocal.Equipment_strengthen;
	import com.game.data.player.structure.EquipInfo;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.PropModel;
	import com.game.data.player.structure.RoleModel;
	import com.game.view.equip.ChangeCountComponent;

	public class EquipController extends Base
	{
		public function EquipController()
		{
		}
		
		public function setEquip(roleModel:RoleModel, equip:EquipModel) : void
		{
			_controller.data.equip.setEquip(roleModel, equip);
		}
		
		public function downEquipment(roleModel:RoleModel, downEquip:EquipModel) : void
		{
			_controller.data.equip.downEquipment(roleModel, downEquip);
		}
		
		public function sellEquipment(roleModel:RoleModel, sellEquip:EquipModel) : void
		{
			_controller.data.equip.sellEquipment(roleModel, sellEquip);
		}
		
		public function getEquipmentLv(equipLv:EquipModel) : Array
		{
			return _controller.data.equip.getEquipLvData(equipLv);
		}
		
		public function decomposeEquip(nowComposeData:Equipment_strengthen, equipNow:EquipModel) : Vector.<PropModel>
		{
			return _controller.data.equip_strengthen.decomposeEquip(nowComposeData, equipNow);
		}
		
		public function composeEquip(equipNow:EquipModel, composeChangeList:Vector.<ChangeCountComponent>, composeData:Object) : void
		{
			_controller.data.equip_strengthen.composeEquip(equipNow, composeChangeList, composeData);
		}
		
		public function strengthenEquip(equipNow:EquipModel, useLuckyCount:int, useEndTalisman:Boolean, equipmentStrengthen:Equipment_strengthen) : int
		{
			return _controller.data.equip_strengthen.strengthenEquip(equipNow, useLuckyCount, useEndTalisman, equipmentStrengthen);
		}
		
		public function clearUpEquip(equipNow:EquipModel, nowComposeData:Equipment_strengthen) :void
		{
			_controller.data.equip_strengthen.clearUp(equipNow, nowComposeData);
		}
		
		public function checkEquip(equipNow:EquipModel) : Boolean
		{
			return _controller.data.equip_strengthen.checkEquip(equipNow);
		}
	}
}
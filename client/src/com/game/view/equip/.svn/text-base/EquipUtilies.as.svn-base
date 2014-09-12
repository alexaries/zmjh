package com.game.view.equip
{
	import com.game.Data;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.player.structure.EquipModel;
	import com.game.template.InterfaceTypes;

	public class EquipUtilies
	{
		private static var _data:Data = Data.instance;
		
		public static function getEquipModel(equipName:String) : EquipModel
		{
			return _data.pack.getEquipModel(equipName);
		}
		
		public static function getEquip(id:int) : Equipment
		{
			var equip:Equipment;
			
			_data.db.interfaces(
				InterfaceTypes.GET_EQUIP_DATA_BY_ID,
				id,
				function (data:Equipment) : void
				{
					equip = data;	
				}
			);
			
			return equip;
		}
		
		public static function getEquipByName(name:String) : Equipment
		{
			var equip:Equipment;
			
			_data.db.interfaces(
				InterfaceTypes.GET_EQUIP_BASE_DATA,
				name,
				function (data:Equipment) : void
				{
					equip = data;	
				}
			);
			
			return equip;
		}
	}
}
package com.game.data.equip
{
	import com.engine.utils.Utilities;
	import com.game.Data;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.player.structure.EquipModel;
	import com.game.template.InterfaceTypes;

	public class EquipUtilies
	{
		private static var _data:Data = Data.instance;
		
		public static function getEquipModel(equipMID:int) : EquipModel
		{
			return _data.pack.getEquipModelByMID(equipMID);
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
		
		public static function getSpaceValue(info:String) : int
		{
			var data:Array = info.split("|");
			
			var value:int;
			if (data.length > 1)
			{
				value = Utilities.GetRandomIntegerInRange(data[0], data[1]);
			}
			else
			{
				value = data[0];
			}
			
			return value;
		}
		
		public static function getWeatherValue(info:String) : Number
		{
			var data:Array = info.split("|");
			var value:Number;
			if(data.length > 1)
			{
				value = Utilities.getRandomNumberInRange(Number(data[0]), Number(data[1]));
			}
			else 
			{
				value = data[0];
			}
			
			return value;
		}
		
		public static function getBalanceValue(info:String) : int
		{
			var data:Array = info.split("|");
			
			var value:int;
			if (data.length > 1)
			{
				value = Utilities.GetBalanceInRange(data[0], data[1]);
			}
			else
			{
				value = data[0];
			}
			
			return value;
		}
	}
}
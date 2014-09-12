package com.game.data.equip
{
	import com.game.Data;
	import com.game.data.Base;
	import com.game.data.player.structure.EquipInfo;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;

	public class EquipData extends Base
	{
		private var _player:Player;
		
		public function EquipData()
		{
		}
		
		public function initEquip() : void
		{
			_player = _data.player.player;
			initData();
		}
		
		private var _lvData:Object
		private function initData() : void
		{
			_lvData = Data.instance.db.interfaces(InterfaceTypes.GET_STRENGTHEN);
		}
		
		/**
		 * 装备 
		 * @param roleModel
		 * @param equip
		 * 
		 */
		public function setEquip(roleModel:RoleModel, upEquip:EquipModel) : void
		{
			var downEquipmentMID:int;
			var downLv:int;
			
			switch (upEquip.config.type)
			{
				case EquipConfig.WEAPON:
					downEquipmentMID = roleModel.info.equip.weapon;
					roleModel.info.equip.weapon = upEquip.mid;
					break;
				case EquipConfig.CLOTHES:
					downEquipmentMID = roleModel.info.equip.cloth;
					roleModel.info.equip.cloth = upEquip.mid;
					break;
				case EquipConfig.THING:
					downEquipmentMID = roleModel.info.equip.thing;
					roleModel.info.equip.thing = upEquip.mid;
					break;
			}
			
			/// 卸下装备
			var equipModel:EquipModel;
			if (downEquipmentMID != -1)
			{
				_data.pack.downEquipment(downEquipmentMID);
			}
			
			upEquip.isEquiped = true;
			_data.pack.upEquipment(upEquip);
		}
		
		/**
		 * 卸下装备 
		 * @param roleModel: 当前角色
		 * @param downEquip: 卸下的装备
		 * 
		 */		
		public function downEquipment(roleModel:RoleModel, downEquip:EquipModel) : void
		{
			_data.pack.downEquipment(downEquip.mid);
			
			switch (downEquip.config.type)
			{
				case EquipConfig.WEAPON:
					roleModel.info.equip.weapon = -1;
					break;
				case EquipConfig.CLOTHES:
					roleModel.info.equip.cloth = -1;
					break;
				case EquipConfig.THING:
					roleModel.info.equip.thing = -1;
					break;
			}
		}
		
		/**
		 * 卖出装备 
		 * @param roleModel
		 * @param downEquip
		 * 
		 */		
		public function sellEquipment(roleModel:RoleModel, sellEquip:EquipModel) : void
		{
			_data.pack.removeEquipment(sellEquip.mid);
			
			// 金币
			var sell_money:int = sellEquip.config.sale_money + sellEquip.lv * sellEquip.config.money_add;
			_player.money += sell_money;
		}
		
		public function getEquipModels(info:EquipInfo) : Vector.<EquipModel>
		{
			var equips:Vector.<EquipModel> = new Vector.<EquipModel>();
			var model:EquipModel;
			if (info.weapon != -1)
			{
				model = EquipUtilies.getEquipModel(info.weapon);
				equips.push(model);
			}
			else
			{
				equips.push(null);
			}
			
			if (info.cloth != -1)
			{
				model = EquipUtilies.getEquipModel(info.cloth);
				equips.push(model);
			}
			else
			{
				equips.push(null);
			}
			
			if (info.thing != -1)
			{
				model = EquipUtilies.getEquipModel(info.thing);
				equips.push(model);
			}
			else
			{
				equips.push(null);
			}
			
			return equips;
		}
		
		public function getEquipLvData(data:EquipModel) : Array
		{
			var equipData:Array = [0, 0, 0];
			if(data.lv == 0)
			{
				return equipData;
			}
			var rate:Number = 0;
			for(var i:int = 0; i < data.lv; i++)
			{
				rate += _lvData[i].strengthen_add;
			}
			if(data.config.type == EquipConfig.WEAPON)
			{
				equipData[0] = Math.ceil(Number((data.atk * rate).toFixed(2)));
			}
			else if(data.config.type == EquipConfig.CLOTHES)
			{
				equipData[1] = Math.ceil(Number((data.def * rate).toFixed(2)));
			}
			else if(data.config.type == EquipConfig.THING)
			{
				equipData[2] = Math.ceil(Number((data.spd * rate).toFixed(2)));
			}
			return equipData;
		}
		
		public function getEquipMaxLvData(count:int, type:String) : Array
		{
			var equipData:Array = [0, 0, 0];
			var rate:Number = 0;
			for(var i:int = 0; i < 20; i++)
			{
				rate += _lvData[i].strengthen_add;
			}
			if(type == EquipConfig.WEAPON)
			{
				equipData[0] = Math.ceil(Number((count * rate).toFixed(2)));
			}
			else if(type == EquipConfig.CLOTHES)
			{
				equipData[1] = Math.ceil(Number((count * rate).toFixed(2)));
			}
			else if(type == EquipConfig.THING)
			{
				equipData[2] = Math.ceil(Number((count * rate).toFixed(2)));
			}
			
			return equipData;
		}
	}
}
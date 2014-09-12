package com.game.data.pack
{
	import com.game.Data;
	import com.game.View;
	import com.game.data.Base;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.equip.EquipUtilies;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.PackInfo;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.PropModel;
	import com.game.data.prop.PropUtilies;
	import com.game.template.InterfaceTypes;
	import com.game.view.equip.EquipUtilies;

	public class PackData extends Base
	{
		private var _player:Player;
		
		private var _pack:PackInfo;
		
		public function PackData()
		{
		}
		
		/**
		 * 初始化背包 
		 * 
		 */		
		public function initPack() : void
		{
			_player = _data.player.player;
			_pack = _player.pack;
			
		}
		
		/**
		 * 搜索道具 
		 * @param propID
		 * @return 
		 * 
		 */		
		public function searchProp(propID:int) : PropModel
		{
			var model:PropModel;
			
			for each(var item:PropModel in _pack.props)
			{
				if (item.id == propID)
				{
					model = item;
					break;
				}
			}
			
			return model;
		}
		
		/**
		 * 搜索装备 
		 * @param equipID
		 * @return 
		 * 
		 */		
		public function searchEquip(equipID:int) : EquipModel
		{
			var model:EquipModel;
			
			for each(var item:EquipModel in _pack.equips)
			{
				if (item.id == equipID)
				{
					model = item;
					break;
				}
			}
			
			return model;
		}
		
		/**
		 * 获取装备数据 
		 * @param equipMID
		 * @return 
		 * 
		 */		
		public function getEquipModelByMID(equipMID:int) : EquipModel
		{
			var model:EquipModel;
			
			for each(var item:EquipModel in _pack.equips)
			{
				if (item.mid == equipMID)
				{
					model = item;
					break;
				}
			}
			
			return model;
		}
		
		/**
		 * 装上装备 (从包裹中移除)
		 * @param item
		 * @return 
		 * 
		 */		
		public function upEquipment(equip:EquipModel) : void
		{
			var index:int = _pack.searchEquipIndexByMid(equip.mid);
			
			if (index != -1)
			{
				_pack.equips[index].isEquiped = true;
			}
			else
			{
				throw new Error("包裹中没有该物品");
			}
		}
		
		/**
		 * 卸下装备 
		 * @param mid
		 * 
		 */		
		public function downEquipment(mid:int) : void
		{
			var index:int = _pack.searchEquipIndexByMid(mid);
			if (index == -1) throw new Error("包裹中没有该物品");
			_pack.equips[index].isEquiped = false;
		}
		
		
		public function initEquipment(model:EquipModel) : void
		{
			if(model.config == null)
			{
				Data.instance.db.interfaces(
				InterfaceTypes.GET_EQUIP_DATA_BY_ID,
				model.id,
				function (config:Equipment) : void
				{	
					model.config = config;
				});
			}
			model.lv = 0;
			model.hp = com.game.data.equip.EquipUtilies.getWeatherValue(model.config.hp);
			model.mp = com.game.data.equip.EquipUtilies.getWeatherValue(model.config.mp);
			model.atk = com.game.data.equip.EquipUtilies.getWeatherValue(model.config.atk_space);
			model.def = com.game.data.equip.EquipUtilies.getWeatherValue(model.config.def_space);
			model.spd = com.game.data.equip.EquipUtilies.getWeatherValue(model.config.spd_space);
			model.evasion = com.game.data.equip.EquipUtilies.getWeatherValue(model.config.evasion);
			model.crit = com.game.data.equip.EquipUtilies.getWeatherValue(model.config.crit);
			model.hp_compose = 0;
			model.mp_compose = 0;
			model.atk_compose = 0;
			model.def_compose = 0;
			model.spd_compose = 0;
			model.evasion_compose = 0;
			model.crit_compose = 0;
			model.isNew = true;
		}
		
		/**
		 * 添加包裹 
		 * @param equip
		 * 
		 */		
		public function addEquipment(equip:EquipModel) : void
		{
			_pack.equips_cur_id += 1;
			equip.mid = _pack.equips_cur_id;
			_pack.equips.push(equip);
		}
		
		/**
		 * 移除装备 
		 * @param mid
		 * 
		 */		
		public function removeEquipment(mid:int) : void
		{
			var index:int = _pack.searchEquipIndexByMid(mid);
			if (index == -1) throw new Error("包裹中没有该物品");
			
			_pack.equips.splice(index, 1);
		}
		
		
		/**
		 * 添加道具 
		 * @param prop
		 * 
		 */
		public function addProp(prop:PropModel) : void
		{
			var num:int;
			for (var i:int = 0; i < _pack.props.length; i++)
			{
				if (_pack.props[i].id == prop.id)
				{
					num = _pack.props[i].num + prop.num;
					_pack.setPropNum(num, prop.id);
					if(num <= 0)
						_pack.props[i].isNew = true;
					break;
				}
			}
			//　没有该道具
			if (i == _pack.props.length)
			{
				prop.isNew = true;
				_pack.props.push(prop);
			}
		}
		
		/**
		 * 增加减少道具数量
		 * @param id
		 * @param count
		 * 
		 */		
		public function changePropNum(id:int, count:Number) : void
		{
			var num:int;
			for (var i:int = 0; i < _pack.props.length; i++)
			{
				if (_pack.props[i].id == id)
				{
					num = _pack.props[i].num + count;
					if(num <= 0)
						num = 0;
					_pack.setPropNum(num, id);
					if(num <= 0)
						_pack.props[i].isNew = true;
					break;
				}
			}
		}
		
		/**
		 * 如果不存在该id的道具，则添加道具，否则不做操作
		 * @param id
		 * 
		 */		
		public function addNoneProp(id:int, count:Number = 0) : void
		{
			var prop:PropModel = new PropModel();
			prop.id = id;
			prop.num = count;
			prop.config = PropUtilies.getPropById(prop.id);
			addProp(prop);
		}
		
		/**
		 * 获得一定数量的符文
		 * @param count
		 * 
		 */		
		public function addUpgradeProp(count:int, showInfo:Boolean = true) : String
		{
			var props:Array = [0, 0, 0, 0, 0, 0];
			var propsName:Array = ["强攻符文", "烈焰符文", "碧水符文", "剧毒符文", "混沌符文", "永生符文"];
			for(var i:uint = 0; i < count; i++)
			{
				props[int(Math.random() * 6)]++;
			}
			
			var info:String = "恭喜你获得";
			for(var j:uint = 0; j < props.length; j++)
			{
				if(props[j] != 0)
				{
					info += propsName[j] + "X" + props[j] + " ";
					if(j == 5)
						addNoneProp(53, props[j]);
					else
						addNoneProp((44 + j), props[j]);
				}
			}
			
			if(count != 0 && showInfo)
				View.instance.tip.interfaces(InterfaceTypes.Show,
					info, null, null, false, true, false);
			
			return info;

		}
	}
}
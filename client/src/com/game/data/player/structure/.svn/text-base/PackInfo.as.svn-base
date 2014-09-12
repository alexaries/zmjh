package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.data.db.protocal.Prop;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;

	public class PackInfo
	{
		private var _anti:Antiwear;	
		
		//public var equips_cur_id:int;
		public function get equips_cur_id() : int
		{
			return 	_anti["equips_cur_id"];
		}
		public function set equips_cur_id(value:int) : void
		{
			_anti["equips_cur_id"] = value;
		}
		
		public var equips:Vector.<EquipModel>;
		
		public var props:Vector.<PropModel>;
		
		public function PackInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			_anti["equips_cur_id"] = 0;
		}
		
		public function setPropNum(value:int, id:int) : void
		{
			if(id >= 14 && id <= 20 || id == 49 || id == 54) 
			{
				if (value > V.PROP_SPECIAL_MAX_NUM) value = V.PROP_SPECIAL_MAX_NUM;
			}
			else
			{
				if (value > V.PROP_MAX_NUM) value = V.PROP_MAX_NUM;
			}
			
			for (var i:int = 0; i < props.length; i++)
			{
				if (props[i].id == id)
				{
					if(props[i].num > value) props[i].isNew = false;
					props[i].num = value;
					break;
				}
			}
		}	
		
		public function getPropById(id:int) : PropModel
		{
			var prop:PropModel;
			for (var i:int = 0; i < props.length; i++)
			{
				if (props[i].id == id)
				{
					prop = props[i];
					break;
				}
			}
			
			if(prop == null)
				prop = returnProp(id);
			
			return prop;
		}
		
		public function getPropNumById(id:int) : int
		{
			var num:int = -1;
			for (var i:int = 0; i < props.length; i++)
			{
				if (props[i].id == id)
				{
					num = props[i].num;
					break;
				}
			}
			
			if (num == -1) num=0;
			
			return num;
		}
		
		public function getXML() : XML
		{
			var xml:XML = <pack></pack>;
			var node:XML;
			var item:XML;
			
			node = <equip></equip>;
			node.@curid = equips_cur_id;
			
			for (var i:int = 0; i < equips.length; i++)
			{
				item = <item mid={equips[i].mid} id={equips[i].id} lv={equips[i].lv} hp={equips[i].hp} mp={equips[i].mp} atk={equips[i].atk} def={equips[i].def} spd={equips[i].spd} evasion={equips[i].evasion} crit={equips[i].crit} hp_compose={equips[i].hp_compose} mp_compose={equips[i].mp_compose} atk_compose={equips[i].atk_compose} def_compose={equips[i].def_compose} spd_compose={equips[i].spd_compose} evasion_compose={equips[i].evasion_compose} crit_compose={equips[i].crit_compose} isEquiped={equips[i].isEquiped} />;
				node.appendChild(item);
			}
			xml.appendChild(node);
			
			node = <prop></prop>;
			for (var j:int = 0; j < props.length; j++)
			{
				//if(props[j].num <= 0) continue;
				item = <item id={props[j].id} num={props[j].num} />;
				node.appendChild(item);
			}
			xml.appendChild(node);
			
			return xml;
		}
		
		public function searchEquipIndexByMid(mid:int) : int
		{
			var index:int = -1;
			
			for (var i:int = 0, len:int = equips.length; i < len; i++)
			{
				if (equips[i].mid == mid)
				{
					index = i;
					break;
				}
			}
			
			return index;
		}
		
		public function getUnEquip() : Vector.<EquipModel>
		{
			var unEquip:Vector.<EquipModel> = new Vector.<EquipModel>();
			
			for each(var equipModel:EquipModel in equips)
			{
				if (!equipModel.isEquiped) unEquip.push(equipModel);
			}
			
			return unEquip;
		}
		
		public function unLoadEquip(mid:int) : void
		{
			if(mid == -1) return;
			for each(var equipModel:EquipModel in equips)
			{
				if(equipModel.mid == mid)
				{
					equipModel.isEquiped = false;
					break;
				}
			}
		}
		
		/**
		 * 卸下角色身上的装备 
		 * @param roleModel
		 * 
		 */		
		public function unLoadRoleEquip(roleModel:RoleModel) : void
		{
			unLoadEquip(roleModel.info.equip.cloth);
			unLoadEquip(roleModel.info.equip.thing);
			unLoadEquip(roleModel.info.equip.weapon);
			roleModel.info.equip.cloth = -1;
			roleModel.info.equip.thing = -1;
			roleModel.info.equip.weapon = -1;
			roleModel.beginCount();
		}
		
		public function getCountProp() : Vector.<PropModel>
		{
			var countProp:Vector.<PropModel> = new Vector.<PropModel>();
			
			for each(var propModel:PropModel in props)
			{
				//道具单个数量上限为1
				if(propModel.config.type == 1 && propModel.config.restrict == 1)
				{
					var counts:int = propModel.num;
					while(counts > 1)
					{
						var newProps:PropModel = createNewProp(propModel, 1);
						countProp.push(newProps);
						counts -= 1;
					}
					if(counts > 0)
					{
						var lastProps:PropModel = createNewProp(propModel, count);
						countProp.push(lastProps);
					}
				}
				//道具单个数量上限为99
				else
				{
					if(propModel.num > 0 && propModel.num <= 99)
					{
						countProp.push(propModel);
					}
					else if(propModel.num > 99)
					{
						var count:int = propModel.num;
						while(count > 99)
						{
							var newProp:PropModel = createNewProp(propModel, 99);
							countProp.push(newProp);
							count -= 99;
						}
						var lastProp:PropModel = createNewProp(propModel, count);
						countProp.push(lastProp);
					}
				}
			}
			
			return countProp;
		}
		
		
		private function createNewProp(propModel:PropModel, count:int) : PropModel
		{
			var newProp:PropModel = new PropModel();
			newProp.id = propModel.id;
			newProp.name = propModel.name;
			newProp.config = propModel.config;
			newProp.num = count;
			
			return newProp;
		}
		
		private function returnProp(id:int) : PropModel
		{
			var data:Prop = Data.instance.db.interfaces(InterfaceTypes.GET_PROP_BY_ID, id);
			var resultProp:PropModel = new PropModel();
			resultProp.id = id;
			resultProp.name = data.name;
			resultProp.config = data;
			resultProp.num = 0;
			
			return resultProp;
		}
	}
}
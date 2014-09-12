package com.game.data.equip
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.View;
	import com.game.data.Base;
	import com.game.data.DataList;
	import com.game.data.db.protocal.Equipment_strengthen;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.PropModel;
	import com.game.data.prop.PropUtilies;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.equip.ChangeCountComponent;

	public class EquipStrengthenData extends Base
	{
		private var _anti:Antiwear;
		private function get strengthenResult() : int
		{
			return _anti["strengthenResult"];
		}
		private function set strengthenResult(value:int) : void
		{
			_anti["strengthenResult"] = value;
		}
		
		private function get useluckyNum() : int
		{
			return _anti["useluckyNum"];
		}
		private function set useluckyNum(value:int) : void
		{
			_anti["useluckyNum"] = value;
		}
		
		private function get endTalisman() : Boolean
		{
			return _anti["endTalisman"];
		}
		private function set endTalisman(value:Boolean) : void
		{
			_anti["endTalisman"] = value;
		}
		
		private function get clearMoney() : int
		{
			return _anti["clearMoney"];
		}
		private function set clearMoney(value:int) : void
		{
			_anti["clearMoney"] = value;
		}
		
		private static const STONENUM:int = 11;
		private static const LUCKYNUM:int = 12;
		private static const ENDNUM:int = 13;
		private static const LUCKYRATE:Number = DataList.littleList[5];
		private var _player:Player;
		private function get player():Player
		{
			_player = _data.player.player;
			return _player;
		}
		
		private var _equipStrengthenData:Object;
		
		public function EquipStrengthenData()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["strengthenResult"] = 0;
			_anti["luckyNum"] = 0;
			_anti["endTalisman"] = false;
			_anti["clearMoney"] = 0;
		}
		
		private function initData() : void
		{
			if(!_equipStrengthenData) _equipStrengthenData = _data.db.interfaces(InterfaceTypes.GET_STRENGTHEN);
		}
		
		public function decomposeEquip(nowComposeData:Equipment_strengthen, equipNow:EquipModel) : Vector.<PropModel>
		{
			_data.pack.removeEquipment(equipNow.mid);
			_data.player.player.fight_soul -= nowComposeData.basic_soul;
			
			var decomposeProp:Vector.<PropModel> = new Vector.<PropModel>();
			var decomposeArr:Array = [EquipUtilies.getWeatherValue(nowComposeData.hp_fragment),
				EquipUtilies.getWeatherValue(nowComposeData.mp_fragment),
				EquipUtilies.getWeatherValue(nowComposeData.atk_fragment),
				EquipUtilies.getWeatherValue(nowComposeData.def_fragment),
				EquipUtilies.getWeatherValue(nowComposeData.eva_fragment),
				EquipUtilies.getWeatherValue(nowComposeData.crt_fragment),
				EquipUtilies.getWeatherValue(nowComposeData.spd_fragment)];
			
			//碎片
			for(var i:int = 0; i < 7; i++)
			{
				_data.pack.addNoneProp((14 + i), decomposeArr[i]);
				if(decomposeArr[i] != 0)
				{
					var prop:PropModel = new PropModel();
					prop.id = 14 + i;
					prop.num = decomposeArr[i];
					prop.config = PropUtilies.getPropById(prop.id);
					decomposeProp.push(prop);
				}
			}
			
			//强化石
			var stone:PropModel = new PropModel();
			stone.id = 11;
			stone.config = PropUtilies.getPropById(stone.id);
			if(equipNow.lv == 0)
			{
				if(equipNow.config.color != "白")
				{
					if(Math.random() <= .1)
					{
						stone.num = 1;
						decomposeProp.push(stone);
						_data.pack.addNoneProp(11, stone.num);
						checkStone();
					}
					else stone.num = 0;
				}
			}
			else 
			{
				stone.num = equipNow.lv;
				decomposeProp.push(stone);
				_data.pack.addNoneProp(11, stone.num);
				checkStone();
			}
			
			
			return decomposeProp;
		}
		
		
		/**
		 * 检测强化石是否达到上限值
		 * 
		 */		
		private function checkStone() : void
		{
			if(player.pack.getPropNumById(STONENUM) >= V.PROP_MAX_NUM)
			{
				View.instance.tip.interfaces(InterfaceTypes.Show, 
					"强化石已达到上限，无法继续获得！",
					null,
					null,
					false,
					true,
					false);
				return;
			}
		}
		
		
		public function composeEquip(equipNow:EquipModel, composeChangeList:Vector.<ChangeCountComponent>, composeData:Object) : void
		{
			var equipArr:Vector.<Number> = new Vector.<Number>();
			equipNow.hp_compose += composeChangeList[0].nowCount * composeData[0].add_value;
			equipNow.mp_compose += composeChangeList[1].nowCount * composeData[1].add_value;
			equipNow.atk_compose += composeChangeList[2].nowCount * composeData[2].add_value;
			equipNow.def_compose += composeChangeList[3].nowCount * composeData[3].add_value;
			equipNow.evasion_compose += composeChangeList[4].nowCount * composeData[4].add_value;
			equipNow.crit_compose += composeChangeList[5].nowCount * composeData[5].add_value;
			equipNow.spd_compose += composeChangeList[6].nowCount * composeData[6].add_value;
			
			//碎片
			for(var i:int = 0; i < 7; i++)
			{
				_data.pack.changePropNum((14 + i), - composeChangeList[i].nowCount * composeData[i].use_value);
			}
		}
		
		public function strengthenEquip(equipNow:EquipModel, useLuckyCount:int, useEndTalisman:Boolean, equipmentStrengthen:Equipment_strengthen) : int
		{
			initData();
			useluckyNum = useLuckyCount;
			endTalisman = useEndTalisman;
			strengthenResult = 0;
			
			//强化石使用
			var stoneNum:int = player.pack.getPropNumById(STONENUM);
			stoneNum -= _equipStrengthenData[equipNow.lv].strengthen_stone;
			player.pack.setPropNum(stoneNum, STONENUM);
			//幸运符使用
			var luckyNum:int = player.pack.getPropNumById(LUCKYNUM);
			luckyNum -= useluckyNum;
			player.pack.setPropNum(luckyNum, LUCKYNUM);
			//保底符使用
			if(endTalisman)
			{
				var endNum:int = player.pack.getPropNumById(ENDNUM);
				endNum--;
				player.pack.setPropNum(endNum, ENDNUM);
			}
			//金钱使用
			player.money -= equipmentStrengthen.basic_money * _equipStrengthenData[equipNow.lv].money_add;
			
			var randomCount:Number = Math.random();
			if(randomCount < _equipStrengthenData[equipNow.lv].strengthen_rate + useluckyNum * LUCKYRATE)
			{
				equipNow.lv++;
				//强化达到20级
				if(equipNow.lv == 20) strengthenResult = 3;
			}
			else 
			{
				strengthenResult = 1;
				if(!endTalisman)
				{
					if(!player.vipInfo.checkLevelThree())
					{
						switch(_equipStrengthenData[equipNow.lv].failure)
						{
							case "无":
								break;
							case "-1":
								equipNow.lv--;
								break;
							case "-5":
								equipNow.lv -= 5;
								break;
							case "0":
								equipNow.lv = 0;
								break;
							case "爆":
								_data.pack.removeEquipment(equipNow.mid);
								strengthenResult = 2;
								break;
						}
					}
				}
			}
			
			return strengthenResult;
		}
		
		private var composeData:Vector.<Object>;
		private const EquipmentComposeProperty:Array = ["hp_compose", "mp_compose", "atk_compose", "def_compose", "evasion_compose", "crit_compose", "spd_compose"];
		public function clearUp(equipNow:EquipModel, nowComposeData:Equipment_strengthen) : void
		{
			if(composeData == null)
			{
				composeData = new Vector.<Object>();
				composeData = _data.db.interfaces(InterfaceTypes.GET_FRAGMENT);
			}
			clearMoney = 0;
			var nowCount:int = -1;
			for each(var newComposeProper:String in EquipmentComposeProperty)
			{
				nowCount++;
				clearMoney += Math.floor(equipNow[newComposeProper] / composeData[nowCount].add_value * composeData[nowCount].use_value);
				equipNow[newComposeProper] = 0;
			}
			player.fight_soul -= nowComposeData.basic_soul;
			player.money += clearMoney * 10;
		}
		
		public function checkEquip(equipNow:EquipModel) : Boolean
		{
			var result:Boolean = false;
			for each(var newComposeProper:String in EquipmentComposeProperty)
			{
				if(equipNow[newComposeProper] != 0)
				{
					result = true;
					break;
				}
			}
			return result;
		}
		
	}
}
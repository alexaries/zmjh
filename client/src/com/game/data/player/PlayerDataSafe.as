package com.game.data.player
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.View;
	import com.game.data.Base;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.db.protocal.Equipment_strengthen;
	import com.game.data.db.protocal.Fragment;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.Player;
	import com.game.data.prop.MultiRewardData;
	import com.game.data.skill.UpgradeSkillDetail;
	import com.game.data.skill.UpgradeSkillInfo;
	import com.game.template.InterfaceTypes;

	public class PlayerDataSafe extends Base
	{
		private var _anti:Antiwear;	
		
		private var _player:Player;
		public function get player() : Player
		{
			_player = View.instance.controller.player.getPlayerData();
			return _player;
		}
		
		public function PlayerDataSafe()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			getBaseData();
		}
		
		/**
		 * 获得基础数据
		 * 
		 */		
		private function getBaseData() : void
		{
			getComposeData();
		}
		
		private var composeData:Vector.<Object>;
		private var equipmentStrengthenData:Vector.<Object>;
		private function getComposeData() : void
		{
			composeData = new Vector.<Object>();
			composeData = Data.instance.db.interfaces(InterfaceTypes.GET_FRAGMENT);
			equipmentStrengthenData = new Vector.<Object>();
			equipmentStrengthenData = Data.instance.db.interfaces(InterfaceTypes.GET_EQUIP_STRENGTHEN_DATA);
		}
		
		/**
		 * 开始检测
		 * 
		 */		
		public function checkSafe() : void
		{
			checkFightAttach();
			checkSkillUp();
			checkEquipment();
			//checkMultiReward();
		}
		
		private function checkSkillUp() : void
		{
			player.upgradeSkill.checkDataSafe();
		}
		
		private const FightAttachProperty:Array = ["hp", "mp", "atk", "def", "spd", "evasion", "crit", "hit", "toughness", "ats", "adf"];
		/**
		 * 战附作弊检测——检测到高于等级一半的时候，设置为等级的一半
		 * 
		 */		
		public function checkFightAttach() : void
		{
			var lvLimit:int = player.mainRoleModel.info.lv * .5;
			for each(var proper:String in FightAttachProperty)
			{
				if(player.fightAttach.front[proper] > lvLimit)
				{
					player.fightAttach.front[proper] = lvLimit;
					player.getMyRoleModel(player.formation.front).beginCount();
				}
				if(player.fightAttach.middle[proper] > lvLimit)
				{
					player.fightAttach.middle[proper] = lvLimit;
					player.getMyRoleModel(player.formation.middle).beginCount();
				}
				if(player.fightAttach.back[proper] > lvLimit)
				{
					player.fightAttach.back[proper] = lvLimit;
					player.getMyRoleModel(player.formation.back).beginCount();
				}
			}
		}
		
		private const EquipmentArchiveProperty:Array = ["hp", "mp", "atk", "def", "spd", "evasion", "crit"];
		private const EquipmentComposeProperty:Array = ["hp_compose", "mp_compose", "atk_compose", "def_compose", "evasion_compose", "crit_compose", "spd_compose"];
		/**
		 * 装备作弊检测——检测装备的属性值是否高于可以出现的最高值，设置为最低值，器灵值大于可充灵的最大值，清空已充灵的器灵值
		 * 
		 */		
		private function checkEquipment() : void
		{
			for each(var equip:EquipModel in _player.pack.equips)
			{
				//基础属性检测
				/*for each(var baseProper:String in EquipmentArchiveProperty)
				{
					if(equip[baseProper] <= 0) continue;
					
					var newProper:String = baseProper;
					if(baseProper == "atk" || baseProper == "def" || baseProper == "spd")
						newProper += "_space";
					
					var newBase:int = (equip.config[newProper].split("|")[1] == ""?0:equip.config[newProper].split("|")[1]);
					if(equip[baseProper] > newBase)
					{
						if(newBase < 0) 
							equip[baseProper] = equip.config[newProper].split("|")[1];
						else 
							equip[baseProper] = equip.config[newProper].split("|")[0];
					}
				}*/
				
				//充灵属性检测
				var nowCompose:int = 0;
				var nowCount:int = -1;
				var allCompose:int = getEquipComposeTotal(equip.id);
				for each(var composeProper:String in EquipmentComposeProperty)
				{
					nowCount++;
					if(equip[composeProper] <= 0) continue;
					nowCompose += Math.floor(equip[composeProper] / composeData[nowCount].add_value * composeData[nowCount].use_value);
				}
				//当前充灵值大于可充灵的最大值时，清空所有充灵值
				if(nowCompose > allCompose)
				{
					for each(var newComposeProper:String in EquipmentComposeProperty)
					{
						equip[newComposeProper] = 0;
					}
				}
			}
		}
		
		/**
		 * 获得该可以充灵的最大值
		 * @param id
		 * @return 
		 * 
		 */		
		private function getEquipComposeTotal(id:int) : int
		{
			var result:int = 0;
			for each(var equipStrengthen:Object in equipmentStrengthenData)
			{
				if(equipStrengthen.id == id)
				{
					result = equipStrengthen.total_value;
				}
			}
			return result;
		}
		
		/**
		 * 双倍经验状态作弊检测——战斗次数超过100场，设置为100场，倍数超过2倍，设置为2倍
		 * 
		 */		
		private function checkMultiReward() : void
		{
			for each(var item:MultiRewardData in _player.multiRewardInfo.multiRewards)
			{
				if(item.lastTime > 100)
					item.lastTime = 100;
				if(item.multiTimes > 2)
					item.multiTimes = 2;
			}
		}
	}
}
package com.game.view.map
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.View;
	import com.game.data.db.protocal.Message_disposition;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.PropModel;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	
	import mx.core.Singleton;
	
	import starling.core.Starling;

	public class HideLVMap
	{
		public static const HIDE_LV:int = 4;
		
		// 玩家数据
		private var _player:Player;
		private function get player() : Player
		{
			return Data.instance.player.player;
		}
		// 关卡配置文件
		private var _lvInfos:Vector.<Object>;
		// 当前场景
		private var _sceneID:int;
		// 当前关卡
		private var _lv:int;
		// 当前难易度
		private var _difficult:int;
		// 当前关卡信息
		private var _curLVInfo:Message_disposition;
		// 原因
		private var _reasonInfo:String;
		
		public function HideLVMap(s:Singleton)
		{
			if (_instance != null)
			{
				throw new Error("HideLVMap 是单例！");
			}
			
			init();
		}
		
		private function init() : void
		{
			_player = View.instance.controller.player.getPlayerData();			
			_lvInfos = Data.instance.db.interfaces(InterfaceTypes.GET_MESSAGE_DISPOSITION);
		}
		
		private var _unPassInfo:String;
		/**
		 * 检测进入隐藏地图，条件是否满足 
		 * 
		 */		
		public function checkEntryConditions(sceneID:int, lv:int, difficult:int) : void
		{
			_sceneID = sceneID;
			_lv = lv;
			_difficult = difficult;
			_curLVInfo = getCurLVInfo();
			
			_reasonInfo = '';
			_unPassInfo = "";
			
			// 关卡
			var lvPass:Boolean = checkLVCondition();
			// 角色
			var rolePass:Boolean = checkRoleCondition();
			// 装备
			var equipPass:Boolean = checkEquipCondition();
			// 道具
			var propPass:Boolean = checkPropCondition();
			
			var isPass:Boolean = true;
			isPass = lvPass && rolePass && equipPass && propPass;
			
			if (isPass)
			{
				// 通过
				onEntryHideMap();
			}
			else
			{
				// 未通过0
				NotEntryHideMap();
			}
		}
		
		/**
		 * 道具 
		 * @return 
		 * 
		 */		
		private function checkPropCondition() : Boolean
		{
			var isPass:Boolean = true;
			
			if (_curLVInfo.level_condition_prop == "无")
			{
				isPass = true;
			}
			else
			{
				var propIDS:Array = _curLVInfo.level_condition_prop.split("|");
				var propNums:Array = _curLVInfo.level_condition_prop_number.split("|");
				var propID:int;
				var propNum:int;
				var propModel:PropModel;
				while (propIDS.length > 0)
				{
					propID = propIDS.pop();
					propNum = propNums.pop();
					
					propModel = Data.instance.pack.searchProp(propID);
					
					var propName:String = (Data.instance.db.interfaces(InterfaceTypes.GET_PROP_BY_ID, propID) as Object).name;
					
					// 是否有此道具
					isPass = isPass && (propModel != null);
					// 数量是否满足
					isPass = isPass && (propModel.num >= propNum);
					
					if(propModel == null)
						_unPassInfo += "缺少道具" + propName + "！";
					else 
					{
						if(propModel.num < propNum)
						{
							if(propModel.num == 0)
								_unPassInfo += "缺少道具" + propName + "！";
							else
								_unPassInfo += "道具" + propName + "数量不足" + propNum + "个！";
						}
					}
				}
				
			}
			
			return isPass;
		}
		
		/**
		 * 装备 
		 * @return 
		 * 
		 */		
		private function checkEquipCondition() : Boolean
		{
			var isPass:Boolean = true;
			
			if (_curLVInfo.level_condition_equipment == "无")
			{
				isPass = true;
			}
			else
			{
				var equipIDs:Array = _curLVInfo.level_condition_equipment.split("|");
				var equipID:int;
				var equipModel:EquipModel;
				while (equipIDs.length > 0)
				{
					equipID = equipIDs.pop();
					equipModel = Data.instance.pack.searchEquip(equipID);
					
					var equipName:String = "";
					Data.instance.db.interfaces(InterfaceTypes.GET_EQUIP_DATA_BY_ID, equipID,
						function (data:Object) : void
						{
							equipName = data.name;
						});
					
					isPass = isPass && (equipModel != null);
					
					if(equipModel == null)
					{
						_unPassInfo += "缺少装备" + equipName + "！";
					}
				}
				
			}
			
			return isPass;
		}
		
		/**
		 * 需要带的角色，以及角色的等级 
		 * @return 
		 * 
		 */		
		private function checkRoleCondition() : Boolean
		{
			var isPass:Boolean = true;
			
			if (_curLVInfo.level_condition_characters == "无")
			{
				isPass = true;
			}
			else
			{
				var characterNames:Array =  _curLVInfo.level_condition_characters.split("|");
				var lvs:Array = _curLVInfo.level_condition_characters_lv.split("|");
				var characterName:String;
				var lv:int;
				var roleModel:RoleModel;
				
				while (characterNames.length > 0)
				{
					var nowPass:Boolean = true;
					characterName = characterNames.pop();
					lv = lvs.pop();
					roleModel = player.getRoleModel(characterName);
					if(!roleModel) roleModel = player.getRoleModel(characterName + "（夜）");
					if(!roleModel) roleModel = player.getRoleModel(characterName + "（雨）");
					if(!roleModel) roleModel = player.getRoleModel(characterName + "（雷）");
					if(!roleModel) roleModel = player.getRoleModel(characterName + "（风）");
					
					_unPassInfo += characterName;
					
					if (!roleModel)
					{
						isPass = false;
						nowPass = false;
						_unPassInfo += "还未获得";
					}
					else
					{
						// 不在队伍中
						if(!(roleModel.position == "none" || roleModel.position == "" || roleModel.position == "无"))
						{
							isPass = isPass && true;
							nowPass = nowPass && true;
						}
						else 
						{
							isPass = isPass && false;
							nowPass = nowPass && false;
							_unPassInfo += "不在队伍中";
						}
						//isPass = isPass && !(roleModel.position == "none" || roleModel.position == "" || roleModel.position == "无");
						
						// 等级
						if(roleModel.info.lv >= lv)
						{
							isPass = isPass && true;
							nowPass = nowPass && true;
						}
						else 
						{
							isPass = isPass && false;
							nowPass = nowPass && false;
							_unPassInfo += "等级不够" + lv + "级";
						}
						//isPass = isPass && (roleModel.info.lv >= lv);
					}
					if(!nowPass)
						_unPassInfo += "！";
					else
						_unPassInfo = _unPassInfo.replace(characterName, "");
				}
			}
			
			return isPass;
		}
		
		
		/**
		 * 需要通过那些关卡 
		 * @return 
		 * 
		 */		
		private function checkLVCondition() : Boolean
		{
			var isPass:Boolean = true;
			
			if (_curLVInfo.level_condition_pass == "无")
			{
				isPass = true;
			}
			else
			{
				var passS:Array =  _curLVInfo.level_condition_pass.split("|");
				var passLV:String;
				var lvBol:Boolean;
				var sceneID:int;
				var LV:int;
				while (passS.length > 0)
				{
					passLV = passS.pop();
					sceneID = passLV.split("_")[0];
					LV = passLV.split("_")[1];
					lvBol = Data.instance.lvSelect.checkLvPass(sceneID, LV);
					isPass = isPass && lvBol;
					if(!lvBol)
						_unPassInfo += passLV.split("_")[0] + "-" + passLV.split("_")[1] + "未通关！";
				}
			}
			
			return isPass;
		}
		
		/**
		 * 进入隐藏地图 
		 * 
		 */		
		protected function onEntryHideMap() : void
		{
			Log.Trace("进入隐藏地图");
			View.instance.prompEffect.play("恭喜你进入隐藏地图");
			View.instance.map.close();
			Starling.juggler.delayCall(function () : void {View.instance.map.interfaces(InterfaceTypes.Show, _sceneID, HIDE_LV, _difficult);}, .2);
		}
		
		/**
		 * 不能进入隐藏地图 
		 * 
		 */		
		protected function NotEntryHideMap() : void
		{
			Log.Trace("无法进入隐藏地图，条件未满足！")
			//View.instance.prompEffect.play("不能进入隐藏地图，条件未满足！");
			View.instance.tip.interfaces(InterfaceTypes.Show,
				"无法进入隐藏地图，条件未满足！\n" + _unPassInfo,
				null,
				null,
				false,
				true,
				false);
		}
		
		/**
		 * 获取当前关卡信息 
		 * @return 
		 * 
		 */		
		protected function getCurLVInfo() : Message_disposition
		{
			var info:Message_disposition;
			
			var curSceneLV:String = _sceneID + "_" + HIDE_LV;
			
			for each(var ms:Message_disposition in _lvInfos)
			{
				if (ms.level_name == curSceneLV && ms.difficulty == _difficult)
				{
					info = ms;
					break;
				}
			}
			
			if (!info)
			{
				throw new Error("没有获取到当前隐藏地图配置信息");
			}
			
			return info;
		}
		
		private static var _instance : HideLVMap;
		public static function get instance () : HideLVMap
		{
			if (null == _instance)
			{
				_instance = new HideLVMap(new Singleton());
			}
			
			return _instance;
		}
	}
}

class Singleton {}
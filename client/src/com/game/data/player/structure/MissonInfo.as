package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.db.protocal.Equipment;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;

	public class MissonInfo
	{
		private var _anti:Antiwear;
		
		/**
		 * 上次每日任务时间 
		 * @return 
		 * 
		 */		
		public function get lastTime() : String
		{
			return _anti["lastTime"];
		}
		public function set lastTime(value:String) : void
		{
			_anti["lastTime"] = value;
		}
		
		/**
		 * 每日任务状况 
		 */		
		public var tasks:Vector.<MissonTask>;
		
		/**
		 * 每日打死的怪物 
		 */		
		public var hurtEnemy:Vector.<HurtEnemyInfo>;
		
		public function MissonInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["lastTime"] = "";
			tasks = new Vector.<MissonTask>();
			hurtEnemy = new Vector.<HurtEnemyInfo>();
		}
		
		public function init(data:XML) : void
		{
			// 上一次任务时间
			lastTime = data.time;
			
			var info:MissonTask;
			for each(var item:XML in data.items[0].item)
			{
				info = new MissonTask();
				info.id = item.@id;
				info.isComplete = item.@isComplete;
				info.equipmentID = item.@equipmentID;
				info.propID = item.@propID;
				
				tasks.push(info);
			}
			
			//1-2|2-3
			var enemys:Array = String(data.enemy).split("|");
			var enemyItem:Array;
			var hurtInfo:HurtEnemyInfo;
			for (var i:int = 0; i < enemys.length; i++)
			{
				hurtInfo = new HurtEnemyInfo();
				enemyItem = enemys[i].split("-");
				hurtInfo.id = enemyItem[0];
				hurtInfo.num = enemyItem[1];
				
				hurtEnemy.push(hurtInfo);
			}
		}
		
		public function getXML() : XML
		{
			var node:XML;
			var item:XML;
			var info:XML = <mission></mission>;
			info.appendChild(<time>{lastTime}</time>);
			
			// 任务
			node = <items></items>;
			for (var i:int = 0; i < tasks.length; i++)
			{
				item = <item id={tasks[i].id} isComplete={tasks[i].isComplete} equipmentID={tasks[i].equipmentID} propID={tasks[i].propID}/>
				node.appendChild(item);
			}
			info.appendChild(node);
			
			// 怪物
			var skillEnemy:String = getKillEnemyInfo();
			info.appendChild(<enemy>{skillEnemy}</enemy>);
			
			return info;
		}
		
		/**
		 * 获取今天所杀死怪物的剩余数量 
		 * @return 
		 * 
		 */		
		protected function getKillEnemyInfo() : String
		{
			var info:String = '';
			
			for (var i:int = 0; i < hurtEnemy.length; i++)
			{
				if (i != 0) info += "|";
				info += hurtEnemy[i].id + "-" + hurtEnemy[i].num;
			}
			
			return info;
		}
		
		public function initTask() : void
		{
			tasks = new Vector.<MissonTask>();
			var missionData:Vector.<Object> = Data.instance.db.interfaces(InterfaceTypes.GET_MISSION_DATA);
			var info:MissonTask;
			for(var i:uint = 0; i < missionData.length; i++)
			{
				info = new MissonTask();
				info.id = missionData[i].id;
				info.isComplete = -1;
				info.equipmentID = getEquipmentID(missionData[i].equipment.toString().split("|"));
				info.propID = (missionData[i].prop.toString().split("|"))[0];
				
				tasks.push(info);
			} 
		}
		
		/**
		 * 新添加的任务
		 * 
		 */		
		public function resetMissionInfo() : void
		{
			var missionData:Vector.<Object> = Data.instance.db.interfaces(InterfaceTypes.GET_MISSION_DATA);
			if(missionData.length > tasks.length)
			{
				var info:MissonTask;
				for(var i:uint = tasks.length; i < missionData.length; i++)
				{
					info = new MissonTask();
					info.id = missionData[i].id;
					info.isComplete = -1;
					info.equipmentID = getEquipmentID(missionData[i].equipment.toString().split("|"));
					info.propID = (missionData[i].prop.toString().split("|"))[0];
					
					tasks.push(info);
				}
			}
		}
		
		private function getEquipmentID(equipmentInfo:Array) : int
		{
			if(equipmentInfo[0] == 0) return 0;
			else
			{
				var grades:Vector.<Equipment> = Data.instance.db.interfaces(InterfaceTypes.GET_EQUIP_DATA_BY_GRADE, equipmentInfo[0], equipmentInfo[1]);
				var randomEquipmentID:int = grades[Math.floor(Math.random() * grades.length)].id;
				return randomEquipmentID;
			}
		}
		
		
		public function getEnemyNum(enemyID:int) : int
		{
			var lastNum:int = 0;
			for(var i:uint = 0; i < hurtEnemy.length; i++)
			{
				if(hurtEnemy[i].id == enemyID)
				{
					lastNum = hurtEnemy[i].num;
					break;
				}
			}
			return lastNum;
		}
		
		public function setTaskComplete(id:int) : void
		{
			for each(var item:MissonTask in tasks)
			{
				if(item.id == id)
				{
					item.isComplete = 1;
					break;
				}
			}
		}
		
		public function returnEquipmentID(id:int) : int
		{
			var result:int = 0;
			for each(var item:MissonTask in tasks)
			{
				if(item.id == id)
				{
					result = item.equipmentID;
					break;
				}
			}
			return result;
		}
		
		public function returnTaskComplete(id:int) : int
		{
			var result:int = 0;
			for each(var item:MissonTask in tasks)
			{
				if(item.id == id)
				{
					result = item.isComplete;
					break;
				}
			}
			return result;
		}
		
		public function checkTaskComplete() : Array
		{
			Log.Trace("TaskCheck Start!");
			var result:Array = new Array();
			var resultBol:Boolean;
			var completeTaskList:Vector.<int> = new Vector.<int>();
			
			var missionData:Vector.<Object> = Data.instance.db.interfaces(InterfaceTypes.GET_MISSION_DATA);
			for(var i:int = 0; i < missionData.length; i++)
			{
				var enemyNameList:Array = missionData[i].mission_rules_enemy.toString().split("|");
				var enemyRequestNum:Array = missionData[i].mission_rules_number.toString().split("|");
				result = checkComplete(enemyNameList, enemyRequestNum);
				if(result[0] && returnTaskComplete(missionData[i].id) != 1) 
				{
					completeTaskList.push(i);
				}
			}
			if(completeTaskList.length > 0)  resultBol = true;
			else resultBol = false;
			
			result.push(resultBol, completeTaskList);
			
			Log.Trace("TaskCheck End!" + resultBol + "  " + completeTaskList);
			return result;
		}
		
		public function checkComplete(enemyName:Array, enemyRequestNum:Array) : Array
		{
			//Log.Trace("TaskCheck Enemy Start!");
			var result:Array = new Array();
			var isTrue:Boolean = false;
			var enemyID:Vector.<int> = new Vector.<int>();
			for(var i:uint = 0; i < enemyName.length; i++)
			{
				Data.instance.db.interfaces(
					InterfaceTypes.GET_ROLE_BASE_DATA, 
					V.ENEMY,
					enemyName[i], 
					function (data:*) : void
					{	
						enemyID.push(data.id);
					});
			}
			for(var j:uint = 0; j<enemyID.length; j++)
			{
				if(getEnemyNum(enemyID[j]) >= enemyRequestNum[j])
				{
					isTrue = true;
				}
					//如果有一个条件未满足，则任务未完成
				else if(getEnemyNum(enemyID[j]) < enemyRequestNum[j])
				{
					isTrue = false;
					break;
				}
			}
			result = [isTrue, enemyID];
			//Log.Trace("TaskCheck Enemy End!" + isTrue + " enemyID:" + enemyID);
			return result;
		}
		
		/**
		 * 每日任务每天完成3次
		 * @return 
		 * 
		 */		
		public function checkIsComplete() : Array
		{
			var result:Boolean = false;
			var count:int = 0;
			for each(var item:MissonTask in tasks)
			{
				if(item.isComplete == 1)
					count++;
				
				if(count >= 3)
				{
					result = true;
					break;
				}
			}
			
			return [result, count];
		}
	}
}
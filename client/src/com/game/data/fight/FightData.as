package com.game.data.fight
{
	import com.engine.core.Log;
	import com.game.View;
	import com.game.data.Base;
	import com.game.data.db.protocal.Battle_disposition;
	import com.game.data.db.protocal.Endless;
	import com.game.data.fight.structure.FightConfigStructure;
	import com.game.data.fight.structure.FightDataEvent;
	import com.game.template.InterfaceTypes;
	
	import starling.events.Event;

	public class FightData extends Base
	{
		private var _countFightValue:CountFightManager;
		
		public function FightData()
		{
			_countFightValue = CountFightManager.instance;
		}
		
		
		/**
		 * 请求获取战斗数据 
		 * 
		 */		
		public function reqFightData(level:String, difficult:int, monster:String) : void
		{
			var structure:FightConfigStructure = getFightInitData(level, difficult, monster);
			
			if (!structure)
			{
				Log.Trace("没有fight值");
				return;
			}
			
			_countFightValue.initData(structure);
		}
		
		protected function getFightInitData(level:String,  difficult:int, monster:String) : FightConfigStructure
		{
			var data:FightConfigStructure = new FightConfigStructure();
			var playerData:Object = _data.player.getPlayerDataForFight();
			data.initMe(playerData);
			
			_data.db.interfaces(
				InterfaceTypes.GET_BATTLE_DISPOSITION_DATA,
				level,
				difficult,
				function (battle:Battle_disposition) : void
				{
					data.initMonster(battle, monster);
				}
			);
			
			return data;
		}
		
		
		/**
		 * 初始数据，及战斗界面的初始数值 
		 * @param callback
		 * 
		 */		
		public function getInitFight(callback:Function) : void
		{
			var model:FightModelStructure = _countFightValue.curModelData;
			callback(model);
			beginCount();
		}
		
		/**
		 * 开始计算 战斗过程
		 * 
		 */		
		private function beginCount() : void
		{
			FightTypeData.fightType = 1;
			_countFightValue.addEventListener(FightDataEvent.FIGHT_COUNT_INIT, onFightCountInit);
			_countFightValue.beginCount();
		}
		
		private function onFightCountInit(e:Event) : void
		{
			var data:Object = e.data;
			_data.control.fight.beginRunFight(data);
		}
		
		
		/**
		 * 无尽闯关
		 * @param level
		 * @param monsterType
		 * 
		 */		
		public function reqEndlessFightData(level:int, monsterType:int) : void
		{
			var structure:FightConfigStructure = getEndlessFightInitData(level, monsterType);
			
			if (!structure)
			{
				Log.Trace("没有fight值");
				return;
			}
			
			_countFightValue.initData(structure);
		}
		
		public function getEndlessFightInitData(level:int, monsterType:int) : FightConfigStructure
		{
			var data:FightConfigStructure = new FightConfigStructure();
			var playerData:Object = _data.player.getPlayerDataForFight();
			data.initMe(playerData);
			
			var endlessData:Object = _data.db.interfaces(InterfaceTypes.GET_ENDLESS_BY_ID, level);
			/*if((endlessData as Endless).time != 0)
			View.instance.endless_fight.startTimeCount();*/
			
			data.initEndlessMonster(endlessData, monsterType);
			
			return data;
		}
		
		public function countEndlessTime(level:int, timeCount:int) : Boolean
		{
			var result:Boolean = false;
			var endlessData:Object = _data.db.interfaces(InterfaceTypes.GET_ENDLESS_BY_ID, level);
			//trace(timeCount * .001);
			if(timeCount * .001 < (endlessData as Endless).time)
				result = true;
			return result;
		}
		
		public function getEndlessInitFight(callback:Function) : void
		{
			var model:FightModelStructure = _countFightValue.curModelData;
			callback(model);
			beginEndlessCount();
		}
		
		private function beginEndlessCount() : void
		{
			FightTypeData.fightType = 2;
			_countFightValue.addEventListener(FightDataEvent.ENDLESS_FIGHT_COUNT_INIT, onEndlessFightCountInit);
			_countFightValue.beginCount();
		}
		
		private function onEndlessFightCountInit(e:Event) : void
		{
			var data:Object = e.data;
			_data.control.fight.beginEndlessRunFight(data);
		}
		
		
		/**
		 * 世界Boss——真假小宝
		 * 
		 */		
		public function reqBossFightData() : void
		{
			var structure:FightConfigStructure = getBossFightInitData();
			
			if (!structure)
			{
				Log.Trace("没有fight值");
				return;
			}
			
			_countFightValue.initData(structure);
		}
		
		private function getBossFightInitData() :FightConfigStructure
		{
			var data:FightConfigStructure = new FightConfigStructure();
			var playerData:Object = _data.player.getPlayerDataForFight();
			data.initMe(playerData);
			data.initBossEnemy();
			
			return data;
		}
		
		public function getBossInitFight(callback:Function) : void
		{
			var model:FightModelStructure = _countFightValue.curModelData;
			callback(model);
			beginBossCount();
		}
		
		private function beginBossCount() : void
		{
			FightTypeData.fightType = 3;
			_countFightValue.addEventListener(FightDataEvent.WORLD_BOSS_COUNT_INIT, onBossFightCountInit);
			_countFightValue.beginCount();
		}
		
		private function onBossFightCountInit(e:Event) : void
		{
			var data:Object = e.data;
			_data.control.fight.beginBossRunFight(data);
		}
	}
}
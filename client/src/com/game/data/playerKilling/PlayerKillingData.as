package com.game.data.playerKilling
{
	import com.engine.core.Log;
	import com.game.View;
	import com.game.data.Base;
	import com.game.data.db.protocal.Battle_disposition;
	import com.game.data.db.protocal.Endless;
	import com.game.data.fight.CountFightManager;
	import com.game.data.fight.FightModelStructure;
	import com.game.data.fight.structure.FightConfigStructure;
	import com.game.data.fight.structure.FightDataEvent;
	import com.game.template.InterfaceTypes;
	
	import starling.events.Event;
	
	public class PlayerKillingData extends Base
	{
		private var _countFightValue:CountPlayerKillingFightManager;
		public function PlayerKillingData()
		{
			_countFightValue = CountPlayerKillingFightManager.instance;
		}
		
		/**
		 * 请求获取战斗数据 
		 * 
		 */		
		public function reqFightData() : void
		{
			var structure:PlayerKillingConfigStructure = getFightInitData();
			
			if (!structure)
			{
				Log.Trace("没有fight值");
				return;
			}
			
			_countFightValue.initData(structure);
		}
		
		protected function getFightInitData() : PlayerKillingConfigStructure
		{
			var data:PlayerKillingConfigStructure = new PlayerKillingConfigStructure();
			
			var playerData:Object = _data.player.getPlayerDataForFight();
			data.initMe(playerData);
			
			//_data.playerKillingPlayer.parseData();
			
			var enemyData:Object = _data.playerKillingPlayer.getEnemyDataForFight();
			data.initEnemy(enemyData);
			
			return data;
		}
		
		/**
		 * 初始数据，及战斗界面的初始数值 
		 * @param callback
		 * 
		 */		
		public function getInitFight(callback:Function) : void
		{
			var model:PlayerKillingFightModelStructure = _countFightValue.curModelData;
			callback(model);
			beginCount();
		}
		
		/**
		 * 开始计算 战斗过程
		 * 
		 */		
		private function beginCount() : void
		{
			_countFightValue.addEventListener(FightDataEvent.PLAYER_KILLING_COUNT_INIT, onFightCountInit);
			_countFightValue.beginCount();
		}
		
		private function onFightCountInit(e:Event) : void
		{
			var data:Object = e.data;
			_data.control.fight.beginPlayerKillingRunFight(data);
		}
	}
}
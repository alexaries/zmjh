package com.game.data.fight
{
	import com.engine.utils.Utilities;
	import com.game.Data;
	import com.game.View;
	import com.game.data.fight.structure.Battle_EnemyModel;
	import com.game.data.fight.structure.Battle_WeModel;
	import com.game.data.fight.structure.FightConfigStructure;
	import com.game.data.fight.structure.FightDataEvent;
	import com.game.data.fight.structure.FightResult;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.V;
	
	import starling.events.EventDispatcher;

	public class CountFightManager extends EventDispatcher
	{
		private var _data:Data = Data.instance;
		
		private var _curInitData:FightConfigStructure;
		public function get curInitData() : FightConfigStructure
		{
			return _curInitData;
		}
		
		private var _curModelData:FightModelStructure;
		public function get curModelData() : FightModelStructure
		{
			return _curModelData;
		}
		
		public function CountFightManager(singleton:Singleton)
		{
			if (_instance)
			{
				throw new Error("此类为单例类!");
			}
			_instance = this;
		}
		
		/**
		 * 初始化数据 
		 * @param data
		 * 
		 */
		public function initData(data:FightConfigStructure) : void
		{
			_curInitData = data;
	
			if (!_curModelData) _curModelData = new FightModelStructure();
			// 解析
			_curModelData.parse(_curInitData);
		}
		
		/**
		 * 开始计算 战斗过程
		 * 
		 */	
		public function beginCount() : void
		{
			if (!_curModelData) throw new Error("战斗数值还没解析");
			
			// 计算过程
			_curModelData.beginInitCountModel();
			var data:Object = FightProcessManager.handle(_curModelData);
			
			var fightResult:FightResult = data["result"];			
			// 结算
			accountResult(fightResult);
			
			if(FightTypeData.fightType == 1)
				this.dispatchEventWith(FightDataEvent.FIGHT_COUNT_INIT, false, data);
			else if(FightTypeData.fightType == 2)
				this.dispatchEventWith(FightDataEvent.ENDLESS_FIGHT_COUNT_INIT, false, data);
			else if(FightTypeData.fightType == 3)
				this.dispatchEventWith(FightDataEvent.WORLD_BOSS_COUNT_INIT, false, data);
		}
		
		// 结算(hp, mp)
		private var _player:Player;
		protected function accountResult(fightResult:FightResult) : void
		{
			_player = _data.player.player;
			
			var roleModel:RoleModel;
			var battle_we_model:Battle_WeModel;
			for (var i:int = 1; i <= 3; i++)
			{
				if (_curModelData.Me[i] && _curModelData.Me[i] is Battle_WeModel)
				{
					battle_we_model = _curModelData.Me[i];
					roleModel = _data.player.player.getRoleModel(battle_we_model.characterConfig.name);
					roleModel.hp = battle_we_model.countCharacterModel.hp;
					roleModel.mp = battle_we_model.characterModel.mp;
				}
			}
			
			if(FightTypeData.fightType == 1)
			{
				fightResult.exp += addMultiExp(fightResult);
				_curModelData.assignExp(fightResult.exp);
			}
		}
		
		private function addMultiExp(fightResult:FightResult) : int
		{
			var result:int = 0;
			//双倍经验
			result += _player.multiRewardInfo.getResult(fightResult.exp, 1);
			//双倍副本
			result += View.instance.double_level.checkDouble(fightResult.exp);
			//vip
			result += _player.vipInfo.checkDoubleExp(fightResult.exp);
			//称号
			result += _player.roleTitleInfo.checkExpTitle(fightResult.exp);
			
			return result;
		}
		
		private static var _instance:CountFightManager;
		public static function get instance() : CountFightManager
		{
			if (!_instance)
			{
				_instance = new CountFightManager(new Singleton);
			}
			
			return _instance;
		}
	}
}

class Singleton {}
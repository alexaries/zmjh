package com.game.data.playerKilling
{
	import com.game.Data;
	import com.game.data.fight.FightModelStructure;
	import com.game.data.fight.FightProcessManager;
	import com.game.data.fight.structure.Battle_WeModel;
	import com.game.data.fight.structure.FightConfigStructure;
	import com.game.data.fight.structure.FightDataEvent;
	import com.game.data.fight.structure.FightResult;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.RoleModel;
	
	import starling.events.EventDispatcher;

	public class CountPlayerKillingFightManager extends EventDispatcher
	{
		private var _data:Data = Data.instance;
		
		private var _curInitData:PlayerKillingConfigStructure;
		public function get curInitData() : PlayerKillingConfigStructure
		{
			return _curInitData;
		}
		
		private var _curModelData:PlayerKillingFightModelStructure;
		public function get curModelData() : PlayerKillingFightModelStructure
		{
			return _curModelData;
		}
		
		public function CountPlayerKillingFightManager(singleton:Singleton)
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
		public function initData(data:PlayerKillingConfigStructure) : void
		{
			_curInitData = data;
			
			if (!_curModelData) _curModelData = new PlayerKillingFightModelStructure();
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
			var data:Object = PlayerKillingFightProcessManager.handle(_curModelData);
			
			var fightResult:FightResult = data["result"];			
			// 结算
			accountResult(fightResult);

			this.dispatchEventWith(FightDataEvent.PLAYER_KILLING_COUNT_INIT, false, data);
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
		}
		
		private static var _instance:CountPlayerKillingFightManager;
		public static function get instance() : CountPlayerKillingFightManager
		{
			if (!_instance)
			{
				_instance = new CountPlayerKillingFightManager(new Singleton);
			}
			
			return _instance;
		}
	}
}

class Singleton {}
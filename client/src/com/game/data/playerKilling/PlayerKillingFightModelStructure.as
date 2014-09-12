package com.game.data.playerKilling
{
	import com.game.Data;
	import com.game.data.db.protocal.Battle_enemy;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.structure.Battle_EnemyModel;
	import com.game.data.fight.structure.Battle_WeModel;
	import com.game.data.fight.structure.FightConfigStructure;
	import com.game.data.player.structure.RoleModel;

	public class PlayerKillingFightModelStructure
	{
		private var _data:Data = Data.instance;
		
		/**
		 * 我方 
		 */		
		public var Me:Object;
		/**
		 * 敌方 
		 */		
		public var Enemy:Object;
		
		/**
		 * 战斗初始数据 
		 */		
		private var _config:PlayerKillingConfigStructure;
		public function get config() : PlayerKillingConfigStructure
		{
			return _config;
		}
		
		public function PlayerKillingFightModelStructure()
		{
			reset();
		}
		
		public function parse(value:PlayerKillingConfigStructure) : void
		{
			reset();
			_config = value;
			
			parseMeConfig();
			parseEnemyConfig();
		}
		
		private function parseMeConfig() : void
		{
			var data:Object = _config.Me;
			
			var model:Battle_WeModel;
			var position:String;
			for (var i:int = 1; i <= 3; i++)
			{
				if (data[i] && data[i] is RoleModel)
				{
					if (i == 1) position = FightConfig.FRONT_POS;
					if (i == 2) position = FightConfig.MIDDLE_POS;
					if (i == 3) position = FightConfig.BACK_POS;
					
					model = new Battle_WeModel();
					model.parse(data[i] as RoleModel, position);
					Me[i] = model;
				}
			}
		}
		
		private function parseEnemyConfig() : void
		{
			var data:Object = _config.Enemy;
			
			var model:Battle_PlayerKillingModel;
			var position:String;
			for (var i:int = 1; i <= 3; i++)
			{
				if (data[i] && data[i] is PlayerKillingModel)
				{
					if (i == 1) position = FightConfig.FRONT_POS;
					if (i == 2) position = FightConfig.MIDDLE_POS;
					if (i == 3) position = FightConfig.BACK_POS;
					
					model = new Battle_PlayerKillingModel();
					model.parse(data[i] as PlayerKillingModel, position);
					Enemy[i] = model;
				}
			}
		}
		
		protected function reset() : void
		{
			Me = {"1":{}, "2":{}, "3":{}};
			Enemy = {"1":{}, "2":{}, "3":{}};
		}
		
		public function beginInitCountModel() : void
		{
			for (var i:int = 1; i <= 3; i++)
			{
				if (this.Me[i] is Battle_WeModel)
				{
					(this.Me[i] as Battle_WeModel).beginInitCountModel();
				}
				
				if (this.Enemy[i] is Battle_PlayerKillingModel)
				{
					(this.Enemy[i] as Battle_PlayerKillingModel).beginInitCountModel();
				}
			}
		}
		
		/**
		 * 打印（调试） 
		 * 
		 */		
		public function printf() : void
		{
			var str:String = "";
			for (var i:int = 1; i <= 3; i++)
			{
				if (Me[i] is Battle_WeModel)
				{
					str += "\n name: " + (this.Me[i] as Battle_WeModel).countCharacterModel.name 
						+ " hp:" + (this.Me[i] as Battle_WeModel).countCharacterModel.hp
						+ " mp:" + (this.Me[i] as Battle_WeModel).countCharacterModel.mp;
				}
				
				if (Enemy[i] is Battle_EnemyModel)
				{
					str += "\n name: " + (this.Enemy[i] as Battle_PlayerKillingModel).countCharacterModel.name 
						+ " hp:" + (this.Enemy[i] as Battle_PlayerKillingModel).countCharacterModel.hp
						+ " mp:" + (this.Enemy[i] as Battle_PlayerKillingModel).countCharacterModel.mp;
				}
			}
			
			trace(str);
		}
	}
}
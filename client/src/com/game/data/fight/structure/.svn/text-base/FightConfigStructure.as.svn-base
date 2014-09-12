package com.game.data.fight.structure
{
	import com.engine.core.Log;
	import com.engine.utils.Utilities;
	import com.game.Data;
	import com.game.View;
	import com.game.data.db.protocal.Battle_disposition;
	import com.game.data.db.protocal.Battle_enemy;
	import com.game.data.db.protocal.Battle_we;
	import com.game.data.db.protocal.Endless;
	import com.game.data.db.protocal.Special_boss;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.structure.Battle_EnemyModel;
	import com.game.template.V;
	
	public class FightConfigStructure
	{
		// 我方
		public var Me:Object;
		// 敌方
		public var Enemy:Object;
		
		// 战斗数据
		private var _data:Battle_disposition;
		public function get data() : Battle_disposition
		{
			return _data;
		}
		
		/**
		 * 怪物类型 
		 */		
		private var _monsterType:String;
		public function get monsterType() : String
		{
			return _monsterType;
		}
		
		public function FightConfigStructure()
		{
			Me = {"1":{}, "2":{}, "3":{}};
			Enemy = {"1":{}, "2":{}, "3":{}};
		}
		
		/**********************我方************************/
		public function initMe(data:Object) : void
		{
			parse(data);	
		}
		
		public function parse(value:Object) : void
		{			
			for (var i:int = 1; i <= 3; i++)
			{
				Me[i] = value[i];
			}
		}
		
		/**********************怪物**********************/
		public function initMonster(data:Battle_disposition, monsterType:String) : void
		{
			_data = data;
			_monsterType = monsterType;
			
			switch (_monsterType)
			{
				// 普通怪
				case FightConfig.COMMON_MONSTER:
					setCommonEnemy(data);
					break;
				// 精英怪
				case FightConfig.ECS_MONSTER:
					setECSEnemy(data);
					break;
				// boss
				case FightConfig.BOSS_MONSTER:
					setBOSSEnemy(data);
					break;
			}
		}
		
		/**
		 * BOSS怪物 
		 * @param data
		 * 
		 */		
		protected function setBOSSEnemy(data:Battle_disposition) : void
		{
			var enemys:Array = data.boss_name.split("|");
			var lvs:Array = data.boss_grade.split("|");
			
			if (enemys.length != lvs.length) throw new Error("BOSS怪物等级");
			
			for (var i:int = 0; i <　enemys.length; i++)
			{
				Enemy[i + 1] = 	getEnemy(lvs[i], enemys[i]);
			}
			
			function getEnemy(lvIndex:int, typeName:String) : Battle_enemy
			{
				var battle_enemy:Battle_enemy = new Battle_enemy();
				battle_enemy.enemy_name = typeName;
				battle_enemy.enemy_lv = lvIndex;
				
				return battle_enemy;
			}
		}
		
		/**
		 * 精英怪物 
		 * @param data
		 * 
		 */		
		protected function setECSEnemy(data:Battle_disposition) : void
		{
			var enemys:Array = data.elite_name.split("|");
			var lvs:Array = data.elite_grade.split("|");
			
			if (enemys.length != lvs.length) throw new Error("精英怪物等级");
			
			for (var i:int = 0; i <　enemys.length; i++)
			{
				Enemy[i + 1] = 	getEnemy(lvs[i], enemys[i]);
			}
			
			function getEnemy(lvIndex:int, typeName:String) : Battle_enemy
			{
				var battle_enemy:Battle_enemy = new Battle_enemy();
				battle_enemy.enemy_name = typeName;
				battle_enemy.enemy_lv = lvIndex;
				
				return battle_enemy;
			}
		}
		
		/**
		 * 普通怪 
		 * @param data
		 * 
		 */		
		protected function setCommonEnemy(data:Battle_disposition) : void
		{
			//中秋兔爷
			if(SpecialEnemyData.checkMoonEnemy())
			{
				isMoonEnemy();
				return;
			}
			
			var enemys:Array = new Array();
			if(View.instance.map.allowBlack)	enemys = data.night_enemy_name.split("|");
			else if(View.instance.map.allowRain)	enemys = data.rain_enemy_name.split("|");
			else if(View.instance.map.allowThunder) 	enemys = data.thunder_enemy_name.split("|");
			else if(View.instance.map.allowWind)	enemys = data.wind_enemy_name.split("|");
			else	enemys = data.enemy_name.split("|");
			
			// 敌人先锋位置的出场概率
			if (Utilities.hitProbability(data.first_in))
			{
				Enemy["1"] = getEnemy();
			}
			
			// 敌人中坚位置的出场概率
			if (Utilities.hitProbability(data.second_in))
			{
				Enemy["2"] = getEnemy();
			}
			
			// 敌人大将位置的出场概率
			if (Utilities.hitProbability(data.third_in))
			{
				Enemy["3"] = getEnemy();
			}
			
			function getEnemy() : Battle_enemy
			{
				var lv:uint = Utilities.GetRandomIntegerInRange(data.lowest_grade, data.highest_grade);
				var typeIndex:uint = Utilities.GetRandomIntegerInRange(0, enemys.length - 1);
				var typeName:String = enemys[typeIndex];
				
				var battle_enemy:Battle_enemy = new Battle_enemy();
				battle_enemy.enemy_name = typeName;
				battle_enemy.enemy_lv = lv;
				
				return battle_enemy;
			}
		}
		
		private function isMoonEnemy() : void
		{
			Enemy["1"] = getEnemy();
			function getEnemy() : Battle_enemy
			{
				var battle_enemy:Battle_enemy = new Battle_enemy();
				battle_enemy.enemy_name = V.MOON_ENEMY;
				battle_enemy.enemy_lv = Data.instance.player.player.mainRoleModel.info.lv;
				
				return battle_enemy;
			}
		}
		
		
		public function initEndlessMonster(data:Object, monsterType:int) : void
		{
			switch (monsterType)
			{
				// 普通怪
				case 1:
					setEndlessCommonEnemy(data);
					break;
				// 精英怪
				case 2:
					setEndlessSpecialEnemy(data);
					break;
				// boss
				case 3:
					//setBOSSEnemy(data);
					break;
			}
		}
		
		public function setEndlessCommonEnemy(data:Object) : void
		{
			var enemys:Array = new Array();
			enemys = (data as Endless).name.split("|");
			var grade:Array = new Array();
			grade = (data as Endless).grade.split("|");
			var up:Number = (data as Endless).up;
			
			Enemy["1"] = getEndlessCommonEnemy(1);
			Enemy["2"] = getEndlessCommonEnemy(2);
			Enemy["3"] = getEndlessCommonEnemy(3);
			
			function getEndlessCommonEnemy(count:int) : Battle_enemy
			{
				var battle_enemy:Battle_enemy = new Battle_enemy();
				battle_enemy.enemy_name = enemys[count - 1];
				battle_enemy.enemy_lv = grade[count - 1];
				battle_enemy.useGlowing = up;
				
				return battle_enemy;
			}
		}
		
		private function setEndlessSpecialEnemy(data:Object) : void
		{
			var enemyName:String = (View.instance.endless_battle.curBoss as Special_boss).name
			var grade:Array = new Array();
			grade = (data as Endless).grade.split("|");
			
			Enemy["1"] = getEndlessCommonEnemy(1);
			
			function getEndlessCommonEnemy(count:int) : Battle_enemy
			{
				var battle_enemy:Battle_enemy = new Battle_enemy();
				battle_enemy.enemy_name = enemyName;
				battle_enemy.enemy_lv = grade[count - 1];
				
				return battle_enemy;
			}
		}
		
		
		public function initBossEnemy() : void
		{
			Enemy["1"] = getBossEnemy();
			
			function getBossEnemy() : Battle_enemy
			{
				var battle_enemy:Battle_enemy = new Battle_enemy();
				battle_enemy.enemy_name = "小桂子";
				battle_enemy.enemy_lv = Data.instance.player.player.mainRoleModel.info.lv;
				
				return battle_enemy;
			}
		}
		
	}
}
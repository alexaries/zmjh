package com.game.data.fight
{
	import com.engine.core.Log;
	import com.engine.utils.Utilities;
	import com.game.Data;
	import com.game.View;
	import com.game.data.db.protocal.Battle_enemy;
	import com.game.data.db.protocal.Battle_we;
	import com.game.data.db.protocal.Characters;
	import com.game.data.fight.structure.Battle_EnemyModel;
	import com.game.data.fight.structure.Battle_WeModel;
	import com.game.data.fight.structure.FightConfigStructure;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.V;

	public class FightModelStructure
	{
		public var allHurt:int;
		
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
		private var _config:FightConfigStructure;
		public function get config() : FightConfigStructure
		{
			return _config;
		}
		
		public function FightModelStructure()
		{
			reset();
		}
		
		public function parse(value:FightConfigStructure) : void
		{
			reset();
			_config = value;
			
			parseMeConfig();
			parseEnemyConfig();
			//parseEnemy();
		}
		
		private function parseEnemy():void
		{
			var nameList:Array = String("妹纸|恶犬|护院|醉汉|流氓|小偷|江湖术士|书童|打手|官兵|乌鸦|武林败类|太监|宫女|大内侍卫|恶魔犬|妖魔|罗刹祭司|罗刹女妖|小强|韦春花|茅十八|双儿|黑龙|京城甲少|京城乙少|京城丙少|京城丁少|小玄子|海大富|建宁|鳌拜|罗刹老祭司|恶魔小强|方怡|沐剑屏|吴家刺客|神龙岛高手|瘦头陀|神龙岛女仆|毒蛙|假太后|小龙人|小桂子|胖头陀|兔爷|僵尸|白龙使|天地会高手|玄真道长").split("|");
			for(var j:int = 0; j < nameList.length; j++)
			{
				for(var i:int = 1; i <= 100; i++)
				{
					var battle:Battle_enemy = new Battle_enemy();
					battle.enemy_name = nameList[j];
					battle.enemy_lv = i;
					
					var model:Battle_EnemyModel = new Battle_EnemyModel();
					model.parse(battle, FightConfig.FRONT_POS);
				}
			}
		}
		
		/**
		 * 正常战斗之外的其他战斗后的经验分配
		 * @param exp
		 * 
		 */		
		public function assignOtherTypeExp(exp:int) : void
		{
			var roleModel:RoleModel;
			var mainRole:RoleModel = Data.instance.player.player.mainRoleModel;
			var teamNum:int = 1;
			for (var j:int = 1; j <= 3; j++)
			{
				if(Me[j] && Me[j] is Battle_WeModel)
				{
					var roleNames:String = (Me[j] as Battle_WeModel).characterConfig.name;
					roleModel = _data.player.player.getRoleModel(roleNames);
					if(roleModel.info.roleName != V.MAIN_ROLE_NAME && roleModel.info.lv == mainRole.info.lv && roleModel.info.exp == (roleModel.nextExp - 1)){}
					else if(roleModel.info.lv == RoleModel.MAX_LV && roleModel.info.exp == (roleModel.nextExp - 1)){}
					else
						teamNum++;
				}
			}
			
			var oneExp:int = exp / (teamNum - 1);
			
			roleModel = _data.player.player.getRoleModel(V.MAIN_ROLE_NAME);
			if(roleModel.info.lv == RoleModel.MAX_LV && roleModel.info.exp == (roleModel.nextExp - 1)){}
			else	roleModel.addExp(oneExp);
			
			for (var i:int = 1; i <= 3; i++)
			{
				if (Me[i] && Me[i] is Battle_WeModel)
				{
					var roleName:String = (Me[i] as Battle_WeModel).characterConfig.name;
					if(roleName == V.MAIN_ROLE_NAME) continue;
					roleModel = _data.player.player.getRoleModel(roleName);
					if(roleModel.info.lv == RoleModel.MAX_LV && roleModel.info.exp == (roleModel.nextExp - 1)){}
					else if(roleModel.info.roleName != V.MAIN_ROLE_NAME && roleModel.info.lv == mainRole.info.lv && roleModel.info.exp == (roleModel.nextExp - 1)){}
					else 	roleModel.addExp(oneExp);
				}
			}
		}
		
		/**
		 * 分配经验 
		 * @param exp
		 * 
		 */		
		public function assignExp(exp:int) : void
		{
			var info:String = "";
			var teamNum:int = getTeamNum();
			if(teamNum <= 0)
			{
				info += "所有角色都已达到最高等级，并且经验已满，无法再获得经验！或者战斗失败！";
				//View.instance.prompEffect.play(info);
				trace(info);
				return;
			}
			var oneExp:int = exp / teamNum;
			
			var mainRole:RoleModel = Data.instance.player.player.mainRoleModel;
			var roleModel:RoleModel;
			for (var i:int = 1; i <= 3; i++)
			{
				if (Me[i] && Me[i] is Battle_WeModel && (Me[i] as Battle_WeModel).countCharacterModel.hp > 0)
				{
					var roleName:String = (Me[i] as Battle_WeModel).characterConfig.name;
					roleModel = _data.player.player.getRoleModel(roleName);
					if(roleModel.info.lv == RoleModel.MAX_LV && roleModel.info.exp == (roleModel.nextExp - 1))
					{
						info += roleModel.info.roleName + "已达到最高等级，并且经验已满，不会再获得经验！\n";
					}
					else if(roleModel.info.roleName != V.MAIN_ROLE_NAME && roleModel.info.lv == mainRole.info.lv && roleModel.info.exp == (roleModel.nextExp - 1)){}
					else 
					{
							roleModel.addExp(oneExp);//trace(roleModel.info.roleName, oneExp);
					}
				}
			}
			//View.instance.prompEffect.play(info);
			trace(info);
		}
		
		/**
		 * 获取我方参加人数 
		 * @return 
		 * 
		 */		
		private function getTeamNum() : int
		{
			var teamNum:int = 0;
			var mainRole:RoleModel = Data.instance.player.player.mainRoleModel;
			var roleModel:RoleModel;
			for (var i:int = 1; i <= 3; i++)
			{
				if (Me[i] && Me[i] is Battle_WeModel && (Me[i] as Battle_WeModel).countCharacterModel.hp > 0)
				{
					var roleName:String = (Me[i] as Battle_WeModel).characterConfig.name;
					roleModel = _data.player.player.getRoleModel(roleName);
					if(roleModel.info.lv == RoleModel.MAX_LV && roleModel.info.exp == (roleModel.nextExp - 1)){}
					else if(roleModel.info.roleName != V.MAIN_ROLE_NAME && roleModel.info.lv == mainRole.info.lv && roleModel.info.exp == (roleModel.nextExp - 1)){}
					else 
						teamNum += 1;
				}
			}
			
			return teamNum;
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
			
			var model:Battle_EnemyModel;
			var position:String;
			for (var i:int = 1; i <= 3; i++)
			{
				if (data[i] && data[i] is Battle_enemy)
				{
					if (i == 1) position = FightConfig.FRONT_POS;
					if (i == 2) position = FightConfig.MIDDLE_POS;
					if (i == 3) position = FightConfig.BACK_POS;
					
					model = new Battle_EnemyModel();
					model.parse(data[i] as Battle_enemy, position);
					Enemy[i] = model;
				}
			}
		}
		
		protected function reset() : void
		{
			allHurt = 0;
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
				
				if (this.Enemy[i] is Battle_EnemyModel)
				{
					(this.Enemy[i] as Battle_EnemyModel).beginInitCountModel();
				}
			}
		}
		
		public function setAllHurt() : void
		{
			if((this.Enemy[1] as Battle_EnemyModel).countEnemyModel.name == "小桂子")
			{
				allHurt = (this.Enemy[1] as Battle_EnemyModel).enemyModel.hp - (this.Enemy[1] as Battle_EnemyModel).countEnemyModel.hp;
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
					str += "\n name: " + (this.Enemy[i] as Battle_EnemyModel).countEnemyModel.name 
						+ " hp:" + (this.Enemy[i] as Battle_EnemyModel).countEnemyModel.hp
						+ " mp:" + (this.Enemy[i] as Battle_EnemyModel).countEnemyModel.mp;
				}
			}
			
			trace(str);
		}
	}
}
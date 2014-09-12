package com.game.data.fight
{
	import com.engine.core.Log;
	import com.engine.utils.Utilities;
	import com.game.Data;
	import com.game.View;
	import com.game.data.db.protocal.Battle_disposition;
	import com.game.data.db.protocal.Skill;
	import com.game.data.fight.structure.BaseModel;
	import com.game.data.fight.structure.Battle_EnemyModel;
	import com.game.data.fight.structure.Battle_WeModel;
	import com.game.data.fight.structure.DefendRoundData;
	import com.game.data.fight.structure.FightResult;
	import com.game.data.fight.structure.FightRound;
	import com.game.data.fight.structure.Hurt;
	import com.game.data.fight.structure.SkillBuff;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.RoleInfo;
	import com.game.data.player.structure.RoleModel;
	import com.game.data.prop.MultiRewardInfo;
	import com.game.template.V;
	
	import mx.core.mx_internal;
	
	public class FightProcessManager
	{
		private static var _data:FightModelStructure;
		
		private static var _fightResult:FightResult;
		
		public static function handle(data:*) : Object
		{
			_data = data;
			
			var process:Vector.<Vector.<FightRound>> = getFightProcess();
			return {"process":process, "result":_fightResult, "model":_data};
		}
		
		// 回合数
		protected static var Count:int = 0;
		protected static function getFightProcess() : Vector.<Vector.<FightRound>>
		{
			var processes:Vector.<Vector.<FightRound>> = new Vector.<Vector.<FightRound>>();
			Count = 0;
			countBigProcess(processes);
			
			return processes;
		}
		
		/**
		 * 计算回合
		 * 
		 */
		// 已经出手
		private static var _curHanded:Vector.<Hand>;
		private static var _smallCount:uint = 0;
		public static function countBigProcess(processes:Vector.<Vector.<FightRound>>) : void
		{
			var result:int = checkFinish();
			
			if (result == 0)
			{
				Count += 1;
				_smallCount = 0;
				processes[Count - 1] = new Vector.<FightRound>();
				_curHanded = new Vector.<Hand>();
				countSmallProcess(processes);
			}
			// 结束
			else
			{
				onComplete(processes, result);
			}
		}
		
		protected static function onComplete(processes:Vector.<Vector.<FightRound>>, result:int) : void
		{
			countResult(result);
			
			Log.Trace("结束");
		}
		
		private static function countResult(result:int) : void
		{
			_fightResult = new FightResult();
			
			_fightResult.result = result;
			
			// 如果战斗失败，则不进行结算
			if (result != V.WIN) return;
			
			var model:Battle_EnemyModel;
			for (var i:int = 0; i <= 3; i++)
			{
				if (_data.Enemy[i] && _data.Enemy[i] is Battle_EnemyModel)
				{
					model = _data.Enemy[i] as Battle_EnemyModel;
					_fightResult.exp += model.enemyModel.exp;
					_fightResult.money += model.enemyModel.money;
					_fightResult.soul += model.enemyModel.soul;
					//Log.Trace(model.enemyModel.name + ": exp=" + model.enemyModel.exp + " lv=" + model.enemyModel.lv);
					
					// 打怪数量录入
					if(FightTypeData.fightType == 1)
						Data.instance.misson.countKillEnemy(model.enemyConfig.id, 1);
				}
			}
			
			// 收服
			if(FightTypeData.fightType == 2 || View.instance.map.curLevel == "1_1")
			{
				
			}
			else
				subdueEnemy();
		}
		
		/**
		 * 收服敌人
		 * 
		 */
		private static function subdueEnemy() : void
		{
			var enemy:Battle_EnemyModel;
			var rate:Number;
			var isHit:Boolean;
			var roleInfo:RoleInfo;
			for (var i:int = 0; i <= 3; i++)
			{
				if (_data.Enemy[i] && _data.Enemy[i] is Battle_EnemyModel)
				{
					enemy = (_data.Enemy[i] as Battle_EnemyModel);
					rate = getEnemyRate(enemy);
					isHit = Utilities.hitProbability(rate);
					
					if(View.instance.map.curLevel == "1_2" && enemy.enemyConfig.name != "小强") continue;
					
					if (isHit)
					{
						roleInfo = new RoleInfo();
						roleInfo.roleName = enemy.enemyConfig.name;
						roleInfo.lv = 1;//enemy.config.enemy_lv;
						// 加入角色
						var roleModel:RoleModel = Data.instance.player.player.addRole(roleInfo);
						if(roleModel) _fightResult.sudueEnemy.push(roleModel);
					}
				}
			}
			
			// boss战的话，还有可能获取额外的人物
			if (_data.config.monsterType == FightConfig.BOSS_MONSTER)
			{
				var info:Battle_disposition = _data.config.data;
				
				if (info.boss_character != "无")
				{
					rate = getBossRate(info);
					isHit = Utilities.hitProbability(rate);
					if (isHit)
					{
						roleInfo = new RoleInfo();
						roleInfo.roleName = info.boss_character;
						roleInfo.lv = 1;
						// 加入角色
						var bossRoleModel:RoleModel = Data.instance.player.player.addRole(roleInfo);
						if(bossRoleModel) _fightResult.sudueEnemy.push(bossRoleModel);
					}
				}
			}
		}
		
		protected static function getBossRate(info:Battle_disposition) : Number
		{
			var rate:Number = 0;
			var _player:Player = Data.instance.player.player;
			
			rate = info.boss_character_rate;
			
			if(rate != 0)
			{
				//RP卡概率
				rate = _player.multiRewardInfo.checkRPRoleRate(rate);
				//双倍副本概率
				rate = View.instance.double_level.checkDoubleRoleRate(rate);
				//vip
				rate = _player.vipInfo.checkRPUp(rate);
			}
			
			return rate;
		}
		
		/**
		 * 获取敌人被捕获的概率
		 * @param enemy
		 * @return
		 * 
		 */		
		protected static function getEnemyRate(enemy:Battle_EnemyModel) : Number
		{
			var rate:Number;
			var _player:Player = Data.instance.player.player;
			
			switch (View.instance.map.kind)
			{
				case 1:
					rate = enemy.enemyConfig.join_rate;
					break;
				case 2:
					rate = enemy.enemyConfig.join_rate_hard;
					break;
				case 3:
					break;
				default:
					rate = 0;
					Log.Trace("错误的关卡难度");
			}
			
			if(rate != 0)
			{
				//RP卡概率
				rate = _player.multiRewardInfo.checkRPRoleRate(rate);
				//双倍副本概率
				rate = View.instance.double_level.checkDoubleRoleRate(rate);
				//vip
				rate = _player.vipInfo.checkRPUp(rate);
			}
			return rate;
		}
		
		protected static function countSmallProcess(processes:Vector.<Vector.<FightRound>>) : void
		{
			var hand:Hand = getFirstHand();
						
			var isComplete:int = checkFinish();
			if (isComplete != 0)
			{
				onComplete(processes, isComplete);
				return;
			}
			
			// 一个大回合结束
			if (!hand)
			{
				countBigProcess(processes);
			}
			// 小回合开始
			else
			{
				_smallCount += 1;
				
				var round:FightRound = new FightRound();
				var attackHand:Hand = getHandIndex(hand);
				
				round.Count = Count;
				round.SmallCount = _smallCount;
				
				// 攻击方目前的状态
				auditAttackStatus(attackHand, round);
				
				processes[processes.length - 1].push(round);
				_curHanded.push(attackHand);
				
				Log.Trace("----------" + Count + "-" + _smallCount + "-----");
				_data.printf();
				_data.setAllHurt();
				
				countSmallProcess(processes);
			}
		}
		
		/**
		 * 计算玩家身上的状态 
		 * @param attackHand
		 * 
		 */
		protected static function auditAttackStatus(attackHand:Hand, round:FightRound) : void
		{		
			round.attack.setBaseInfo(attackHand.index, attackHand.postion, _data);
			// 毒buff
			var isComplete:Boolean = countPosionBuff(attackHand, round);
			
			if (isComplete) return;
			
			// 晕眩状态
			var syncopeBuff:SkillBuff = round.attack.model.getBuff(FightConfig.SYNCOPE);
			if (syncopeBuff)
			{
				// 加入晕眩状态
				if (round.attack.states.indexOf(FightConfig.SYNCOPE) == -1)
				{
					round.attack.states.push(FightConfig.SYNCOPE);
				}
				
				round.attack.attackType = FightConfig.SYNCOPE;
				//round.attack.model.auditBuff();
				round.attack.buffs = round.attack.model.auditBuff();
				round.attack.remainHP = round.attack.countRole.hp;
				round.attack.remainMP = round.attack.countRole.mp;
			}
			else
			{
				// 睡眠状态
				var asleepBuff:SkillBuff = round.attack.model.getBuff(FightConfig.ASLEEP);
				if (asleepBuff)
				{
					// 加入睡眠状态
					if (round.attack.states.indexOf(FightConfig.ASLEEP) == -1)
					{
						round.attack.states.push(FightConfig.ASLEEP);
					}
					
					round.attack.attackType = FightConfig.ASLEEP;
					//round.attack.model.auditBuff();
					round.attack.buffs = round.attack.model.auditBuff();
					round.attack.remainHP = round.attack.countRole.hp;
					round.attack.remainMP = round.attack.countRole.mp;
				}
				else
				{
					//醉酒状态
					var drunkBuff:SkillBuff = round.attack.model.getBuff(FightConfig.DRUNK);
					if(drunkBuff)
					{
						if(round.attack.states.indexOf(FightConfig.DRUNK) == -1)
						{
							round.attack.states.push(FightConfig.DRUNK);
						}
						round.attack.attackType = FightConfig.DRUNK;
					}
					//石灰状态
					var lineBuff:SkillBuff = round.attack.model.getBuff(FightConfig.LINE);
					if(lineBuff)
					{
						if(round.attack.states.indexOf(FightConfig.LINE) == -1)
						{
							round.attack.states.push(FightConfig.LINE);
						}
						round.attack.attackType = FightConfig.LINE;
					}
					
					// 混乱状态
					var confusionBuff:SkillBuff = round.attack.model.getBuff(FightConfig.CONFUSION);
					var bol:Boolean = Utilities.hitProbability(FightConfig.CONFUSION_RATE);
					
					if (confusionBuff)
					{
						// 加入混乱状态
						if (round.attack.states.indexOf(FightConfig.CONFUSION) == -1)
						{
							round.attack.states.push(FightConfig.CONFUSION);
						}
						
						// 混乱攻击
						if (bol) round.attack.attackType = FightConfig.CONFUSION_ATTACK;
					}
					
					if (!syncopeBuff && !asleepBuff)
					{
						// 计算回合
						CountFightRound.getRound(_data, round);
						
						// buff回合
						round.attack.model.auditEffect();
						round.attack.buffs = round.attack.model.auditBuff();
						
						for each(var defend:DefendRoundData in round.defend)
						{
							defend.buffs = defend.model.getCurBuff();
						}
					}
				}
			}
		}
		
		/**
		 * 毒BUff 
		 * 
		 */		
		protected static function countPosionBuff(attackHand:Hand, round:FightRound) : Boolean
		{
			// 毒状态
			var index:int = round.attack.model.searchBuff(FightConfig.POISON);
			
			// 有毒状态
			if (index != -1)
			{
				// 加入毒buff状态
				if (round.attack.states.indexOf(FightConfig.POISON) == -1)
				{
					round.attack.states.push(FightConfig.POISON);
				}
				
				var buffs:Vector.<SkillBuff> = round.attack.model.getBuffs(FightConfig.POISON);
				var posionBuffHurt:Hurt;
				for(var i:int = 0; i < buffs.length; i++)
				{
					posionBuffHurt = new Hurt(FightConfig.POISON, buffs[i].hurt);
					round.attack.hurts.push(posionBuffHurt);
					
					round.attack.countRole.hp -= posionBuffHurt.value;
					if (round.attack.countRole.hp < 0) round.attack.countRole.hp = 0;
				}
			}
			
			var isComplete:Boolean = (round.attack.countRole.hp == 0);
			return isComplete;
		}
		
		
		/**
		 * 混乱选择攻击对象（自己那方）
		 * @param position
		 * @return 
		 * 
		 */		
		public static function getDefendWhenConfusion(position:String) : Hand
		{
			var hand:Hand = new Hand();
			var players:Array;
			var i:int = 0;
			switch (position)
			{
				case V.ME:
					players = [];
					for (i = 1; i <= 3; i++)
					{
						if (_data.Me[i] is Battle_WeModel && (_data.Me[i] as Battle_WeModel).countCharacterModel.hp > 0)
						{
							players.push(i);
						}
					}
					break;
				case V.ENEMY:
					players = [];
					for (i = 1; i <= 3; i++)
					{
						if (_data.Enemy[i] is Battle_EnemyModel  && (_data.Enemy[i] as Battle_EnemyModel).countEnemyModel.hp > 0)
						{
							players.push(i);
						}
					}
					break;
			}
			
			if (players[i] == 0 || !players || players.length == 0) throw new Error("混乱攻击对象");
			
			var index:int = Utilities.GetRandomIntegerInRange(0, players.length - 1);
			
			hand.index = players[index];
			hand.postion = position;
			
			return hand;
		}
		
		/**
		 * 固定被攻击对象 
		 * @param hand
		 * @return 
		 * 
		 */		
		public static function getFixDefendHand(postion:String) : Hand
		{
			var defendHand:Hand;
			
			// 攻击顺序 先锋>中坚>大将
			for (var i:int = 1; i <= 3; i++)
			{
				if (postion == V.ME)
				{
					if (_data.Enemy[i] is Battle_EnemyModel)
					{
						if ((_data.Enemy[i] as Battle_EnemyModel).countEnemyModel.hp > 0)
						{
							defendHand = new Hand();
							defendHand.index = i;
							defendHand.postion = V.ENEMY;
							break;
						}
					}
				}
				else
				{
					if (_data.Me[i] is Battle_WeModel)
					{
						if ((_data.Me[i] as Battle_WeModel).countCharacterModel.hp > 0)
						{
							defendHand = new Hand();
							defendHand.index = i;
							defendHand.postion = V.ME;
							break;
						}
					}
				}
			}
			
			if (!defendHand) throw new Error("获取防御对象错误");
			
			return defendHand;
		}
		
		/**
		 * 随机攻击对象 
		 * @param hand
		 * @return 
		 * 
		 */		
		public static function getRandomDefendHand(postion:String) : Hand
		{
			var defendHand:Hand;
			var defends:Vector.<Hand> = getGroupDefend(postion);
			
			var index:int = Utilities.GetRandomIntegerInRange(0, defends.length-1);			
			defendHand = defends[index];
			
			return defendHand;
		}
		
		/**
		 * 获取加血对象(剩血比例最大的) 
		 * @param postion
		 * @return 
		 * 
		 */		
		public static function getBloodDefendHand(postion:String) : Hand
		{
			var defendHand:Hand;
			var defends:Vector.<Hand> = getGroupDefend(postion);
			
			for (var i:int = 0; i < defends.length; i++)
			{
				if (!defendHand)
				{
					defendHand = defends[i];
					continue;
				}
				
				if (defends[i].hpPer < defendHand.hpPer)
				{
					defendHand = defends[i];
				}
			}
			
			return defendHand;
		}
		
		/**
		 * 是否需要加血，当血量小于80%的时候可以加血
		 * @param position
		 * @return 
		 * 
		 */		
		public static function getBloodRemainHand(position:String) : Boolean
		{
			var releaseSkill:Boolean = false;
			var defends:Vector.<Hand> = getGroupDefend(position);
			
			for (var i:int = 0; i < defends.length; i++)
			{
				if (defends[i].hpPer <= .8)
				{
					releaseSkill = true;
					break;
				}
			}
			
			return releaseSkill;
		}
		
		/**
		 * 获取群体对象 
		 * @param attackHand
		 * @return 
		 * 
		 */		
		public static function getGroupDefend(position:String) : Vector.<Hand>
		{
			var defendHands:Vector.<Hand> = new Vector.<Hand>();
			
			var defendHand:Hand;
			for (var i:int = 1; i <= 3; i++)
			{
				if (position == V.ME)
				{
					if (_data.Enemy[i] is Battle_EnemyModel)
					{
						if ((_data.Enemy[i] as Battle_EnemyModel).countEnemyModel.hp > 0)
						{
							defendHand = new Hand();
							defendHand.index = i;
							defendHand.postion = V.ENEMY;
							defendHand.hpPer = (_data.Enemy[i] as Battle_EnemyModel).countEnemyModel.hp / (_data.Enemy[i] as Battle_EnemyModel).enemyModel.hp;
							defendHands.push(defendHand);
						}
					}
				}
				else
				{
					if (_data.Me[i] is Battle_WeModel)
					{
						if ((_data.Me[i] as Battle_WeModel).countCharacterModel.hp > 0)
						{
							defendHand = new Hand();
							defendHand.index = i;
							defendHand.postion = V.ME;
							defendHand.hpPer = (_data.Me[i] as Battle_WeModel).countCharacterModel.hp / (_data.Me[i] as Battle_WeModel).characterModel.hp;
							defendHands.push(defendHand);
						}
					}
				}
			}
			
			return defendHands;
		}
		
		
		/**
		 * 当前回合先出手的 
		 * @param hand
		 * @return 
		 * 
		 */		
		public static function getHandIndex(hand:Hand) : Hand
		{			
			for (var i:int = 1; i <= 3; i++)
			{				
				// 先检测当前回合是否出手过
				if (indexOf(i, V.ME) == -1 && _data.Me[i] is Battle_WeModel && (_data.Me[i] as Battle_WeModel).countCharacterModel.hp > 0)
				{
					if (hand.spd < (_data.Me[i] as Battle_WeModel).spd)
					{
						hand.index = i;
						hand.postion = V.ME;
						hand.spd = (_data.Me[i] as Battle_WeModel).spd;
					}
				}
				
				// 先检测当前回合是否出手过
				if (indexOf(i, V.ENEMY) == -1 && _data.Enemy[i] is Battle_EnemyModel && (_data.Enemy[i] as Battle_EnemyModel).countEnemyModel.hp > 0)
				{
					if (hand.spd < (_data.Enemy[i] as Battle_EnemyModel).spd)
					{
						hand.index = i;
						hand.postion = V.ENEMY;
						hand.spd = (_data.Enemy[i] as Battle_EnemyModel).spd;
					}
				}
			}
			
			return hand;
		}
		
		/**
		 *  是否还有可出手
		 * @return 
		 * 
		 */		
		private static function getFirstHand() : Hand
		{
			var hand:Hand;
			
			for (var i:int = 1; i <= 3; i++)
			{
				// 先检测当前回合是否出手过
				if (indexOf(i, V.ME) == -1 && _data.Me[i] is Battle_WeModel && (_data.Me[i] as Battle_WeModel).countCharacterModel.hp > 0)
				{
					hand = new Hand();
					hand.index = i;
					hand.postion = V.ME;
					hand.spd = (_data.Me[i] as Battle_WeModel).spd;
					break;
				}
				
				if (indexOf(i, V.ENEMY) == -1 && _data.Enemy[i] is Battle_EnemyModel && (_data.Enemy[i] as Battle_EnemyModel).countEnemyModel.hp > 0)
				{
					hand = new Hand();
					hand.index = i;
					hand.postion = V.ENEMY;
					hand.spd = (_data.Enemy[i] as Battle_EnemyModel).spd;
					break;
				}
			}
			
			return hand;
		}
		
		
		/**
		 * -1：输， 0-战斗未结束，1-胜利 
		 * @return 
		 * 
		 */		
		public static function checkFinish() : int
		{
			var result:int = 0;
			
			var we:Boolean = false;;
			for (var i:int = 1; i <= 3; i++)
			{
				if (_data.Me[i] is Battle_WeModel && (_data.Me[i] as Battle_WeModel).countCharacterModel.hp > 0)
				{
					we = true;
					break;
				}
			}
			
			var enemy:Boolean = false;
			for (var j:int = 1; j <= 3; j++)
			{
				if (_data.Enemy[j] is Battle_EnemyModel && (_data.Enemy[j] as Battle_EnemyModel).countEnemyModel.hp > 0)
				{
					enemy = true;
					break;
				}
			}
			
			if (we)
			{
				result = enemy ? 0 : V.WIN;
			}
			else
			{
				result = enemy ? V.LOSE : 0;
			}
			
			if (!we && !enemy)
			{
				throw new Error("平局");
			}
			
			return result;
		}
		
		protected static function indexOf(key:int, position:String) : int
		{
			var index:int = -1;
			
			var hand:Hand;
			for (var i:int = 0; i <_curHanded.length; i++)
			{
				hand = _curHanded[i];
				
				if (hand.index == key && hand.postion == position)
				{
					index = i;
					break;
				}
			}
			
			return index;
		}
	}
}
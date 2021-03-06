package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.View;
	import com.game.data.DataList;
	import com.game.data.db.protocal.Battle_we;
	import com.game.data.db.protocal.Characters;
	import com.game.data.db.protocal.Fight_soul;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.structure.MaxCharacterUtitiles;
	import com.game.data.fight.structure.WeCharacterUtitiles;
	import com.game.data.player.PlayerEvent;
	import com.game.data.player.PlayerFightDataUtitlies;
	import com.game.template.V;
	
	import starling.events.EventDispatcher;

	public class RoleModel extends EventDispatcher
	{
		private var _anti:Antiwear;	
		/**
		 * 最高等级限制
		 */		
		public static const MAX_LV:int = 130;
		
		private var _info:RoleInfo;
		public function set info(value:RoleInfo) : void
		{
			_info = value;
		}
		public function get info() : RoleInfo
		{
			return _info;
		}
		
		private var _battleWe:Battle_we;
		public function set battleWe(value:Battle_we) : void
		{
			_battleWe = value;
		}
		public function get battleWe() : Battle_we
		{
			if (_battleWe) this.countBattleWe();
			
			return _battleWe;
		}
		
		/**
		 * 战附位置
		 */		
		private var _position:String;
		public function set position(value:String) : void
		{
			_position = value;
		}
		public function get position() : String
		{
			return _position;
		}
		
		/**
		 * 基础 
		 */		
		public var configData:Characters;
		/**
		 * 等级 
		 */		
		public var lvData:Characters;
		/**
		 * 品质 
		 */		
		public var qualityData:Characters;
		/**
		 * 装备基础 
		 */		
		public var equipData:Characters;
		/**
		 * 充灵属性
		 */		
		public var equipComposeData:Characters;
		/**
		 * 装备强化 
		 */
		public var equipLVData:Characters;
		/**
		 * 战附 
		 */		
		public var soulData:Characters;
		/**
		 * 内功
		 */		
		public var neiGongData:Characters;
		
		private var _model:Characters;
		public function get model() : Characters
		{
			return _model;
		}
		
		/**
		 * 下一等级经验 
		 */	
		public function get nextExp() : int
		{
			return _anti["nextExp"];
		}
		public function set nextExp(exp:int) : void
		{
			_anti["nextExp"] = exp;
		}
		
		// hp(维护)
		public function get hp() : int
		{
			return _anti["hp"];
		}
		public function set hp(value:int) : void
		{
			if (value < 0) value = 0;
			if (value > model.hp) value = model.hp;
			
			_anti["hp"] = value;
			
			this.dispatchEventWith(PlayerEvent.ROLE_HP_CHANGE);
		}
		
		// mp(维护)
		public function get mp() : int
		{
			return _anti["mp"];
		}
		public function set mp(value:int) : void
		{
			if (value < 0) value = 0;
			if (value > model.mp) value = model.mp;
			
			_anti["mp"] = value;
		}
		
		public function get fightingNum() : int
		{
			return _anti["fightingNum"];
		}
		public function set fightingNum(value:int) : void
		{
			_anti["fightingNum"] = value;
		}
		
		public function get maxFightingNum() : int
		{
			return _anti["maxFightingNum"];
		}
		public function set maxFightingNum(value:int) : void
		{
			_anti["maxFightingNum"] = value;
		}
		
		public function get nowUseFashion() : String
		{
			return _anti["nowUseFashion"];
		}
		public function set nowUseFashion(value:String) : void
		{
			_anti["nowUseFashion"] = value;
		}
		
		public function RoleModel()
		{
			super();
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["mp"] = 0;
			_anti["hp"] = 0;
			_anti["fightingNum"] = 0;
			_anti["maxFightingNum"] = 0;
			_anti["nowUseFashion"] = "";
			_anti["nextExp"] = 0;
		}
		
		public function getXML() : XML
		{
			var xml:XML = 
			<role>
	            <!-- 角色名 -->
	            <roleName>{this._info.roleName}</roleName>
	            <!-- 等级 -->
	            <lv>{_model.lv}</lv>
	            <!-- 经验 -->
	            <exp>{info.exp}</exp>
	            <!-- 品质 -->
	            <quality>{info.quality}</quality>
	            <!-- 装备 -->
	            <equip>
	                <!-- 武器 -->
	                <weapon>{info.equip.weapon}</weapon>
	                <!-- 衣服 -->
	                <cloth>{info.equip.cloth}</cloth>
	                <!-- 饰品 -->
	                <thing>{info.equip.thing}</thing>
	            </equip>
	            <!-- 技能 -->
	            <skill>
	                <skill1>{info.skill.skill1}</skill1>
	                <skill2>{info.skill.skill2}</skill2>
	                <skill3>{info.skill.skill3}</skill3>
	                <learnedSkill>{info.skill.learnedSkill}</learnedSkill>
	            </skill>
	        </role>;
			
			return xml;
		}
		
		/**
		 * 添加经验 
		 * @param value
		 * 
		 */
		private var _isUpGrade:Boolean;
		public function addExp(value:int) : void
		{
			//限制最高等级
			if(info.lv > MAX_LV) 
			{
				info.lv = MAX_LV;
				info.exp = 0;
				beginCount();
				this.dispatchEventWith(PlayerEvent.ROLE_CHANGE);
				return;
			}
			
			_isUpGrade = false;
			// 升级
			if (info.exp + value >= nextExp)
			{				
				//限制不能达到最高等级
				if(info.lv == MAX_LV)
				{
					info.exp = nextExp - 1;
				}
				else if (info.roleName == V.MAIN_ROLE_NAME || _player.mainRoleModel.info.lv > info.lv)
				{
					info.exp = info.exp + value;
					
					while (info.exp >= nextExp)
					{
						// 其它角色的等级不能超过主角
						if (info.roleName != V.MAIN_ROLE_NAME && _player.mainRoleModel.info.lv <= info.lv)
						{
							info.exp = nextExp - 1;
							continue;
						}
						
						info.exp = info.exp - nextExp;
						info.lv += 1;
						
						//扫荡模式
						/*if(View.instance.map.autoLevel)
						{
							View.instance.auto_fight.addContent(info.roleName + "升到" + info.lv + "级\n\n");
						}*/
						
						// 重新计算
						beginCount();
						
						// 升级hp回满
						hp = _model.hp;
					}

					_isUpGrade = true;
				}
				// 其它角色的等级不能超过主角
				else
				{					
					info.exp = nextExp - 1;				
				}
			}
			else
			{
				info.exp = info.exp + value;
			}
			
			this.dispatchEventWith(PlayerEvent.ROLE_CHANGE);
		}
		
		public function checkGrade(callback:Function, callback_1:Function = null) : void
		{
			if (_isUpGrade)
			{
				_isUpGrade = false;
				
				this.dispatchEventWith(PlayerEvent.ROLE_UPGRADE, false, callback);
			}
			else
			{
				if (callback_1 != null) callback_1();
			}
		}
		
		public function getAllLv(exp:int, lv:int) : Array
		{
			var result:Boolean = false;
			var allExp:int = exp;
			var nowLv:int = lv;
			var nowNextExp:int = WeCharacterUtitiles.getNextExpData(nowLv, info.roleName);
			var startExp:int = info.exp;
			while (info.exp + allExp >= nowNextExp)
			{
				nowLv++;
				allExp -= (nowNextExp - info.exp);
				nowNextExp = WeCharacterUtitiles.getNextExpData(nowLv, info.roleName);
				info.exp = 0;
			}
			if(nowLv > _player.mainRoleModel.info.lv)
			{
				nowLv = _player.mainRoleModel.info.lv;
				result = true;
			}
			info.exp = startExp;
			return [nowLv, result];
		}
		
		private var _player:Player;
		private var _isGlowing:Boolean;
		private var _glowingName:String;
		public function initModel(player:Player, roleInfo:RoleInfo, isGlowing:Boolean = false, name:String = "") : void
		{
			_player = player;
			info = roleInfo;
			_isGlowing = isGlowing;
			_glowingName = name
			beginCount();
		}
		
		// 是否刚开始计算
		private var _isStart:Boolean;
		private var _isEquip:Boolean;
		private var _hpRate:Number;
		private var _mpRate:Number;
		public function beginCount(isStart:Boolean = true, isEquip:Boolean = true) : void
		{
			_isStart = isStart;
			_isEquip = isEquip;
			
			_hpRate = 0;
			_mpRate = 0;
			if(_model) _hpRate = hp / _model.hp;
			if(_model) _mpRate = mp / _model.mp;
			
			soulData = null;
			neiGongData = null;
			
			if(_isGlowing)
				position = _player.getRolePosition(_glowingName);
			else		
				position = _player.getRolePosition(info.roleName);
			configData = WeCharacterUtitiles.getCharacterBaseData(info.roleName);
			Log.Trace("角色技能名称：" + configData.fixedskill_name);
			if (configData.fixedskill_name != "无") info.skill.skill1 = configData.fixedskill_name;
			countBattleWe();
			lvData = WeCharacterUtitiles.getCharacterLVData(_player, info.lv, info.roleName, configData);
			qualityData = WeCharacterUtitiles.getQualityData(info.quality, info.roleName);
			equipData = WeCharacterUtitiles.getTotalEquipBaseData(battleWe);
			equipComposeData = WeCharacterUtitiles.getTotalComposeEquipData(battleWe);
			equipLVData = WeCharacterUtitiles.getTotalEquipLVData(info);
			nextExp = WeCharacterUtitiles.getNextExpData(info.lv, info.roleName);
			
			nowUseFashion = _player.roleFashionInfo.checkFashionUse(info.roleName);
			
			countModel();
			countFightAttack();
			
			countEquip();
			countFightingAll();
		}
		
		public function countFightingAll() : void
		{
			countFighting();
			countMaxFighting();
			if(_player.getRolePosition(info.roleName) != FightConfig.NONE_POS)
				_player.calculateFighting();
		}
		
		/**
		 * 最大战附值
		 */		
		private var _maxfightSoul:Characters;
		private var _maxEquipData:Characters;
		private var _maxEquipLvData:Characters;
		private var _maxEquipComposeData:Characters;
		private var _maxModel:Characters;
		/**
		 * 计算当前角色可达到的最大战斗值
		 * 
		 */		
		private function countMaxFighting() : void
		{
			if(_player.mainRoleModel == null) return;
			var maxLv:int = _player.mainRoleModel.info.lv * .5;
			_maxfightSoul = MaxCharacterUtitiles.getMaxFightSoulLV(maxLv);
			_maxEquipData = MaxCharacterUtitiles.getTotalEquipBaseData(battleWe);
			_maxEquipComposeData = MaxCharacterUtitiles.getTotalComposeEquipData(battleWe);
			_maxEquipLvData = MaxCharacterUtitiles.getTotalEquipLVData(info);
			
			var items:Array = [configData, lvData, _maxfightSoul, _maxEquipData, _maxEquipComposeData, _maxEquipLvData];
			_maxModel = MaxCharacterUtitiles.countCharater(items);
			maxFightingNum = _maxModel.hp + _maxModel.mp * .5 + _maxModel.atk + _maxModel.def + _maxModel.spd + _maxModel.crit * .5 + _maxModel.evasion * .5;
			//Log.Trace(info.roleName + "最大战斗值：" + maxFightingNum);
		}
		
		/**
		 * 计算战斗力
		 * 
		 */		
		private function countFighting() : void
		{
			fightingNum = model.hp + model.mp * .5 + model.atk + model.def + model.spd + model.crit * .5 + model.evasion * .5;
			//Log.Trace(info.roleName + "当前战斗值：" + fightingNum);
		}
		
		/**
		 * 计算装备血量
		 * 
		 */		
		private function countEquip() : void
		{
			if(_hpRate >= 1)	hp = model.hp; 
			else if(_hpRate > 0 && _hpRate < 1)		hp = int(_hpRate * model.hp);
			
			if(_mpRate >= 1)	mp = model.mp; 
			else if(_mpRate > 0 && _mpRate < 1)		mp = int(_mpRate * model.mp);
		}
		
		/**
		 * 卸下战附 
		 * 
		 */		
		protected function downFightAttack() : void
		{
			// 先扣除原先的战附（比例）
			if (soulData)
			{
				// 血量
				hp = int(_anti["hp"] * (model.hp - soulData.hp) / model.hp);
				model.hp -= soulData.hp;
				//if (!_isEquip) hp = model.hp;
				// 元气
				if (configData.mp != 0)
				{
					mp = int(_anti["mp"] * (model.mp - soulData.mp) / model.mp);
					model.mp -= soulData.mp;
				}
				// 外功
				model.atk -= soulData.atk;
				// 根骨
				model.def -= soulData.def;
				// 灵活
				model.evasion -= soulData.evasion;
				// 暴击
				model.crit -= soulData.crit;
			}
			
			soulData = null;
			
			
			//内功
			if(neiGongData)
			{
				model.ats -= neiGongData.ats;
				model.adf -= neiGongData.adf;
			}
			neiGongData = null
		}
		
		/**
		 * 穿上战附 
		 * 
		 */		
		protected function upFightAttack() : void
		{
			// 战附
			soulData = WeCharacterUtitiles.getFightSoulLV(battleWe, position);
			
			// 血量
			if (_isStart) _anti["hp"] = int(_anti["hp"] * (model.hp + soulData.hp) / model.hp);
			model.hp += soulData.hp;
			if (_isStart) hp = _anti["hp"];
			
			//if (!_isEquip) hp = model.hp;
			// 元气
			if (configData.mp != 0)
			{
				if (_isStart) _anti["mp"] = int(_anti["mp"] * (model.mp + soulData.mp) / model.mp);
				model.mp += soulData.mp;
				if (_isStart) mp = _anti["mp"];
			}
			
			// 外功
			model.atk += soulData.atk;
			// 根骨
			model.def += soulData.def;
			// 灵活
			model.evasion += soulData.evasion;
			// 暴击
			model.crit += soulData.crit;
			
			
			//内功
			neiGongData = WeCharacterUtitiles.getNeiGongLV(battleWe, position, info.roleName);
			model.ats += neiGongData.ats;
			model.adf += neiGongData.adf;
			
		}
		
		
		/**
		 * 重新计算战附 
		 * 
		 */		
		public function countFightAttack() : void
		{
			
			countBattleWe();
			
			downFightAttack();
			upFightAttack();
			
			_isStart = true;
		}
		
		/**
		 * 计算战斗battle 
		 * 
		 */		
		public function countBattleWe() : void
		{
			_battleWe = PlayerFightDataUtitlies.getBattleWe(_player, info, position);
		}
		
		public function countModel() : void
		{
			var items:Array = [configData, lvData, qualityData, equipData, equipComposeData, equipLVData];
			_model = WeCharacterUtitiles.countCharater(items, battleWe);
			
			// hp mp
			if (_isStart)
			{
				_anti["mp"] = model.mp;
				_anti["hp"] = model.hp;
			}
		}
	}
}
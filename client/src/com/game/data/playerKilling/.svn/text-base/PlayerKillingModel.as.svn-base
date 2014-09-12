package com.game.data.playerKilling
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.game.data.db.protocal.Battle_we;
	import com.game.data.db.protocal.Characters;
	import com.game.data.fight.structure.WeCharacterUtitiles;
	import com.game.data.player.PlayerFightDataUtitlies;
	import com.game.data.player.structure.RoleInfo;
	
	import starling.events.EventDispatcher;

	public class PlayerKillingModel extends EventDispatcher
	{
		private var _anti:Antiwear;	
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
		private var _nextExp:int;
		public function get nextExp() : int
		{
			return _nextExp;
		}
		public function set nextExp(exp:int) : void
		{
			_nextExp = exp;
		}
		
		// hp(维护)
		public function get hp() : int
		{
			return _anti["hp"];
		}
		public function set hp(value:int) : void
		{
			_anti["hp"] = value;
		}
		
		// mp(维护)
		public function get mp() : int
		{
			return _anti["mp"];
		}
		public function set mp(value:int) : void
		{
			_anti["mp"] = value;
		}
		
		public function get nowUseFashion() : String
		{
			return _anti["nowUseFashion"];
		}
		public function set nowUseFashion(value:String) : void
		{
			_anti["nowUseFashion"] = value;
		}
		
		public function PlayerKillingModel()
		{
			super();
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["mp"] = 0;
			_anti["hp"] = 0;
			_anti["nowUseFashion"] = "";
		}
		
		private var _player:PlayerKillingPlayer;
		public function initModel(player:PlayerKillingPlayer, roleInfo:RoleInfo) : void
		{
			_player = player;
			info = roleInfo;
			beginCount();
		}
		
		public function beginCount() : void
		{
			soulData = null;
			neiGongData = null;
			position = _player.getRolePosition(info.roleName);
			configData = WeCharacterUtitiles.getCharacterBaseData(info.roleName);
			Log.Trace("角色名称：" + configData.fixedskill_name);
			if (configData.fixedskill_name != "无") info.skill.skill1 = configData.fixedskill_name;
			countBattleWe();
			lvData = WeCharacterUtitiles.getCharacterLVData(_player, info.lv, info.roleName, configData);
			qualityData = WeCharacterUtitiles.getQualityData(info.quality, info.roleName);
			equipData = WeCharacterUtitiles.getTotalEquipBaseData(battleWe, true);
			equipComposeData = WeCharacterUtitiles.getTotalComposeEquipData(battleWe,true);
			equipLVData = WeCharacterUtitiles.getTotalEquipLVData(info, true);
			
			nowUseFashion = _player.roleFashionInfo.checkFashionUse(info.roleName);
			
			countModel();
			countFightAttack();
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
			_anti["mp"] = model.mp;
			_anti["hp"] = model.hp;
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
			_anti["hp"] = int(_anti["hp"] * (model.hp + soulData.hp) / model.hp);
			model.hp += soulData.hp;
			hp = _anti["hp"];
			
			//if (!_isEquip) hp = model.hp;
			// 元气
			if (configData.mp != 0)
			{
				_anti["mp"] = int(_anti["mp"] * (model.mp + soulData.mp) / model.mp);
				model.mp += soulData.mp;
				mp = _anti["mp"];
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
	}
}
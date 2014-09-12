package com.game.data.fight.structure
{
	import com.game.data.db.protocal.BaseRole;
	import com.game.data.fight.FightModelStructure;
	import com.game.data.playerKilling.Battle_PlayerKillingModel;
	import com.game.data.playerKilling.PlayerKillingFightModelStructure;
	import com.game.template.V;

	public class BaseRoundData
	{
		protected var _position:String;
		public function get position() : String
		{
			return _position;
		}
		
		protected var _index:int;
		public function get index() : int
		{
			return _index;
		}
		
		/**
		 *  角色基础数值
		 */		
		protected var _roleConfigData:*;
		public function get roleConfigData() : *
		{
			return _roleConfigData;
		}
		
		
		/**
		 * 基准数据 
		 */		
		protected var _model:BaseModel;
		public function get model() : BaseModel
		{
			return _model;
		}
		
		/**
		 * 配置数据 
		 */		
		protected var _configRole:BaseRole;
		public function get configRole() : BaseRole
		{
			return _configRole;
		}
		
		/**
		 * 维护数据 
		 */		
		protected var _baseRole:BaseRole;
		public function get baseRole() : BaseRole
		{
			return _baseRole;
		}
		
		/**
		 * 运算数据 
		 */		
		protected var _countRole:BaseRole;
		public function get countRole() : BaseRole
		{
			return _countRole;
		}
		
		/**
		 * 当前角色身上的buff 
		 */		
		public var buffs:Vector.<SkillBuff>;
		
		/**
		 * 剩余 mp
		 */		
		public var remainMP:int;
		/**
		 * 剩余 hp 
		 * 
		 */
		public var remainHP:int;
		
		/**
		 * 新增加的buff 
		 */		
		public var newBuffs:Vector.<SkillBuff>;
		
		public function BaseRoundData()
		{
			buffs = new Vector.<SkillBuff>();
			newBuffs = new Vector.<SkillBuff>();
		}
		
		/**
		 * 设置基础信息 
		 * @param index
		 * @param position
		 * @param data
		 * 
		 */		
		public function setBaseInfo(index:int, position:String, data:FightModelStructure) : void
		{
			_index = index;
			_position = position;

			// 我方
			if (position == V.ME)
			{
				_model = data.Me[index];
				_roleConfigData = (_model as Battle_WeModel).config;
				_configRole = (_model as Battle_WeModel).characterConfig;
				_baseRole = (_model as Battle_WeModel).characterModel;
				_countRole = (_model as Battle_WeModel).countCharacterModel;
			}
			// 敌方
			else
			{
				_model = data.Enemy[index];
				_roleConfigData = (_model as Battle_EnemyModel).config;
				_configRole = (_model as Battle_EnemyModel).enemyConfig;
				_baseRole = (_model as Battle_EnemyModel).enemyModel;
				_countRole = (_model as Battle_EnemyModel).countEnemyModel;
			}
		}
		
		public function getBuffInfo() : String
		{
			var info:String = '';
			var buff:SkillBuff;
			for (var i:int = 0; i < buffs.length; i++)
			{
				buff = buffs[i];
				info += buff.buff_name + buff.time + " ";
			}
			
			return info;
		}
		
		/**
		 * 设置基础信息 
		 * @param index
		 * @param position
		 * @param data
		 * 
		 */		
		public function setPlayerKillingBaseInfo(index:int, position:String, data:PlayerKillingFightModelStructure) : void
		{
			_index = index;
			_position = position;
			
			// 我方
			if (position == V.ME)
			{
				_model = data.Me[index];
				_roleConfigData = (_model as Battle_WeModel).config;
				_configRole = (_model as Battle_WeModel).characterConfig;
				_baseRole = (_model as Battle_WeModel).characterModel;
				_countRole = (_model as Battle_WeModel).countCharacterModel;
			}
				// 敌方
			else
			{
				_model = data.Enemy[index];
				_roleConfigData = (_model as Battle_PlayerKillingModel).config;
				_configRole = (_model as Battle_PlayerKillingModel).characterConfig;
				_baseRole = (_model as Battle_PlayerKillingModel).characterModel;
				_countRole = (_model as Battle_PlayerKillingModel).countCharacterModel;
			}
		}
	}
}
package com.game.data.fight.structure
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.db.protocal.Characters;
	import com.game.data.db.protocal.Skill;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.SkillEffectProperty;

	public class BaseModel
	{
		protected var _data:Data;
		
		// 技能
		protected var _skills:Vector.<Skill>;
		public function get skills() : Vector.<Skill>
		{
			return _skills;
		}
		
		/**
		 * 当前角色身上的buff(id) 
		 */		
		protected var _curBuffs:Vector.<SkillBuff>;
		public function get curBuffs() : Vector.<SkillBuff>
		{
			return _curBuffs;
		}
		
		protected var _curEffect:Vector.<SkillEffectProperty>;
		public function get curEffect() : Vector.<SkillEffectProperty>
		{
			return _curEffect;
		}
		
		public function BaseModel()
		{
			_data = Data.instance;
			_skills = new Vector.<Skill>();
			_curBuffs = new Vector.<SkillBuff>();
			_curEffect = new Vector.<SkillEffectProperty>();
		}
		
		/*****************************buff***********************************************/
		/**
		 * 添加buff 
		 * @param skill 技能
		 * @param baseHarm 基础外伤害
		 * 
		 */	
		public function addBuff(buff:SkillBuff) : void
		{
			var index:int;
			if (buff.buff_name != FightConfig.POISON)
			{
				index = searchBuff(buff.buff_name);
				
				if (index != -1)
				{
					var oldBuff:SkillBuff = _curBuffs[index];
					if (oldBuff.time > buff.time)
					{
						buff.time = oldBuff.time;
					}
					_curBuffs.splice(index, 1);
				}
				
				_curBuffs.push(buff);
			}
			// 毒的buff，同技能的覆盖
			else if (buff.buff_name == FightConfig.POISON)
			{
				index = searchBuffBySkillName(buff.skill_name);
				if (index != -1) _curBuffs.splice(index, 1);
				_curBuffs.push(buff);
			}
		}
		
		public function removeBuff(name:String) : void
		{
			var index:int = searchBuff(name);
			
			if (index != -1)
			{
				_curBuffs.splice(index, 1);
			}
			else
			{
				Log.Trace("没有找到相关的buff");
			}
		}
		
		public function searchBuff(buff_name:String) : int
		{
			var index:int = -1;
			
			var buff:SkillBuff;
			for (var i:int = 0; i < _curBuffs.length; i++)
			{
				buff = _curBuffs[i];
				if (buff.buff_name == buff_name)
				{
					index = i;
					break;
				}
			}
			
			return index;
		}
		
		public function getBuff(name:String) : SkillBuff
		{
			var index:int = searchBuff(name);
			
			if (index == -1)
			{
				return null;
			}
			else
			{
				return _curBuffs[index];
			}
		}
		
		/**
		 * 通过技能名称寻找buff（主要是用于毒） 
		 * @param skillName
		 * @return 
		 * 
		 */		
		public function searchBuffBySkillName(skillName:String) : int
		{
			var index:int = -1;
			
			var buff:SkillBuff;
			for (var i:int = 0; i < _curBuffs.length; i++)
			{
				buff = _curBuffs[i];
				if (buff.skill_name == skillName)
				{
					index = i;
					break;
				}
			}
			
			return index;
		}
		
		/**
		 * 技能伤害 
		 * @param name
		 * @return 
		 * 
		 */		
		public function getBuffHurt(buff_name:String) : int
		{
			var hurt:int = 0;
			
			var buff:SkillBuff;
			for (var i:int = 0; i < _curBuffs.length; i++)
			{
				buff = _curBuffs[i];
				if (buff.buff_name == buff_name)
				{
					hurt += buff.hurt;
				}
			}
			
			return hurt;
		}
		
		/**
		 * 获取非覆盖buff 
		 * @param buff_name
		 * @return 
		 * 
		 */		
		public function getBuffs(buff_name:String) : Vector.<SkillBuff>
		{
			var buffs:Vector.<SkillBuff> = new Vector.<SkillBuff>();
			
			var buff:SkillBuff;
			for (var i:int = 0; i < _curBuffs.length; i++)
			{
				buff = _curBuffs[i];
				if (buff.buff_name == buff_name)
				{
					buffs.push(buff);
				}
			}

			return buffs;
		}
		
		/*****************************status******************************/
		/**
		 * 效果 
		 * @param effect
		 * 
		 */		
		public function addEffect(effect:SkillEffectProperty) : void
		{
			_curEffect.push(effect);
		}
		
		/**
		 * 获取特定buff加成 
		 * @param status_type
		 * @return 
		 * 
		 */		
		public function countSpecificOfEffect(effect_type:String) : Number
		{
			var value:Number = 0;
			
			var effect:SkillEffectProperty;
			for (var i:int = 0; i < _curEffect.length; i++)
			{
				effect = _curEffect[i];
				if (effect[effect_type])
				{
					value += effect[effect_type];
				}
				else
				{
					Log.Error("错误的buff属性");
				}
			}
			
			return value;
		}		
		
		// 角色身上影响角色属性状态
		public function auditEffect() : void
		{
			var newEffects:Vector.<SkillEffectProperty> = new Vector.<SkillEffectProperty>();
			
			var effect:SkillEffectProperty;
			for (var i:int = 0; i < _curEffect.length; i++)
			{
				effect = _curEffect[i];
				effect.status_time -= 1;
				if (effect.status_time < 0) effect.status_time = 0;
				if (effect.status_time > 0) newEffects.push(effect);
			}
			
			while (_curEffect.length > 0) _curEffect.pop();
			
			_curEffect = newEffects;
		}
		
		
		/**
		 *行动结束判断，先将角色身上存在的状态的持续回合数-1，然后判断角色身上的状态回合数是否为0，为0的话这个状态就消失，不为0就继续存在。 
		 * 
		 */		
		public function auditBuff() : Vector.<SkillBuff>
		{
			var newBuffs:Vector.<SkillBuff> = new Vector.<SkillBuff>();
			var buff:SkillBuff;
			for (var i:int = 0; i < _curBuffs.length; i++)
			{
				buff = _curBuffs[i];
				//昏厥状态、睡眠状态
				if(buff.buff_name == FightConfig.SYNCOPE || buff.buff_name == FightConfig.ASLEEP)	buff.time -= 2;
				//其他状态
				else	buff.time -= 1;
				if (buff.time < 0) buff.time = 0;
				if (buff.time > 0) newBuffs.push(buff);
			}
			while (_curBuffs.length > 0) _curBuffs.pop();
			
			_curBuffs = newBuffs;
			
			var copyBuffs:Vector.<SkillBuff> = new Vector.<SkillBuff>();
			for (var j:int = 0; j < newBuffs.length; j++)
			{
				buff = _curBuffs[j];
				copyBuffs.push(buff.copy());
			}
			
			return copyBuffs;
		}
		
		public function getCurBuff() : Vector.<SkillBuff>
		{
			var buff:SkillBuff;
			var copyBuffs:Vector.<SkillBuff> = new Vector.<SkillBuff>();
			for (var j:int = 0; j < _curBuffs.length; j++)
			{
				buff = _curBuffs[j];
				copyBuffs.push(buff.copy());
			}
			
			return copyBuffs;
		}
	}
}
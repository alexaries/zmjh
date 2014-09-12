package com.game.data.skill
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.data.db.protocal.Skill;
	import com.game.data.db.protocal.Skill_up;
	import com.game.template.InterfaceTypes;

	public class UpgradeSkillInfo
	{
		private var _upgradeSkillList:Vector.<UpgradeSkillDetail>;
		
		private var _learnSkillList:Vector.<String>;
		public function get learnSkillList() : Vector.<String>
		{
			return _learnSkillList;
		}
		
		private var _skillUpData:Vector.<Object>;
		
		public function UpgradeSkillInfo()
		{
			_upgradeSkillList = new Vector.<UpgradeSkillDetail>();
			_learnSkillList = new Vector.<String>();
			
			_skillUpData = new Vector.<Object>();
			_skillUpData = Data.instance.db.interfaces(InterfaceTypes.GET_SKILL_UP_DATA);
		}
		
		public function init(data:XML) : void
		{
			var skills:Array = String(data.skills).split("|");
			var skillItem:Array;
			var skillInfo:UpgradeSkillDetail;
			for (var i:int = 0; i < skills.length; i++)
			{
				skillInfo = new UpgradeSkillDetail();
				skillItem = skills[i].split("-");
				skillInfo.skillID = skillItem[0];
				skillInfo.skillLevel = skillItem[1];
				
				_upgradeSkillList.push(skillInfo);
			}
			
			var learnSkills:Array = String(data.learnSkills).split("|");
			var learnSkillInfo:String;
			for each(var item:String in learnSkills)
			{
				if(item != "")
					_learnSkillList.push(item);
			}
		}
		
		public function getXML() : XML
		{
			var item:XML;
			var info:XML = <upgradeSkill></upgradeSkill>;
			
			var skillInfo:String = getAllSkill();
			info.appendChild(<skills>{skillInfo}</skills>);
			
			var learnSkillInfo:String = getAllLearnSkill();
			info.appendChild(<learnSkills>{learnSkillInfo}</learnSkills>);
			
			return info;
		}
		
		private function getAllLearnSkill():String
		{
			var info:String = "";
			for (var i:int = 0; i < _learnSkillList.length; i++)
			{
				if (i != 0) info += "|";
				info += _learnSkillList[i];
			}
			return info;
		}
		
		public function addSkillName(name:String) : void
		{
			if(!checkSkillName(name))
			{
				_learnSkillList.push(name);
			}
		}
		
		private function checkSkillName(name:String) : Boolean
		{
			var result:Boolean = false;
			for each(var skillName:String in _learnSkillList)
			{
				if(name == skillName)
				{
					result = true;
					break;
				}
			}
			return result;
		}
		
		private function getAllSkill() :String
		{
			var info:String = "";
			
			for (var i:int = 0; i < _upgradeSkillList.length; i++)
			{
				if (i != 0) info += "|";
				info += _upgradeSkillList[i].skillID + "-" + _upgradeSkillList[i].skillLevel;
			}
			
			return info;
		}
		
		/**
		 * 返回技能等级
		 * @param skill
		 * @return 
		 * 
		 */		
		public function returnSkillLevel(skill:Skill) : int
		{
			var result:int = 0;
			for each(var item:UpgradeSkillDetail in _upgradeSkillList)
			{
				if(item.skillID == skill.id)
				{
					result = item.skillLevel;
					break;
				}
			}
			
			return result;
		}
		
		/**
		 * 返回增加的伤害
		 * @param skill
		 * @return 
		 * 
		 */		
		public function isUpgradeSkill(skill:Skill) : int
		{
			var result:int = 0;
			for each(var item:UpgradeSkillDetail in _upgradeSkillList)
			{
				if(item.skillID == skill.id)
				{
					result = calculateSkill(item.skillLevel);
					break;
				}
			}
			
			return result;
		}
		
		/**
		 * 计算技能等级伤害
		 * @param count
		 * @return 
		 * 
		 */		
		private function calculateSkill(count:int) : int
		{
			var result:int = 0;
			for(var i:uint = 0; i < count; i++)
			{
				if(i >= 100) continue;
				result += ((_skillUpData[i] as Skill_up).up * 100);
			}
			
			return result;
		}
		
		/**
		 * 根据id返回技能升级信息
		 * @param id
		 * @return 
		 * 
		 */		
		public function checkUpgradeSkill(id:int) : UpgradeSkillDetail
		{
			var result:UpgradeSkillDetail;
			for each(var item:UpgradeSkillDetail in _upgradeSkillList)
			{
				if(item.skillID == id)
				{
					result = item;
					break;
				}
			}
			
			return result;
		}
		
		/**
		 * 添加技能升级信息
		 * @param id
		 * 
		 */		
		public function addUpgradeSkill(id:int) : void
		{
			var result:UpgradeSkillDetail = checkUpgradeSkill(id);
			if(result == null)
			{
				var item:UpgradeSkillDetail = new UpgradeSkillDetail();
				item.skillID = id;
				item.skillLevel = 1;
				
				_upgradeSkillList.push(item);
			}
			else
			{
				result.skillLevel++;
			}
		}
		
		public function checkDataSafe() : void
		{
			for each(var item:UpgradeSkillDetail in _upgradeSkillList)
			{
				if(item.skillLevel > 100)
					item.skillLevel = 100;
			}
		}
	}
}
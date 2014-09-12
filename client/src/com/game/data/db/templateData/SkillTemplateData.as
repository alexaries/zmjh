package com.game.data.db.templateData
{
	import com.engine.core.Log;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Skill;
	import com.game.data.player.SkillUtitiles;
	import com.game.data.player.structure.RoleInfo;
	import com.game.data.player.structure.SkillModel;
	import com.game.template.InterfaceTypes;
	
	public class SkillTemplateData extends TDBase implements IDBData
	{
		public function SkillTemplateData()
		{
			_XMLFileName = "skill.xml";
			CS = Skill;
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.INIT;
			
			switch (type)
			{
				case InterfaceTypes.INIT:
					init();
					break;
				case InterfaceTypes.GET_DATA:
					this.getData(args);
					break;
				case InterfaceTypes.GET_SKILL_ALL_DATA:
					getAllData(args);
					break;
				case InterfaceTypes.GET_SKILL_DATA_BY_iD:
					getSkillDataByID(args);
					break;
				case InterfaceTypes.GET_SKILL_ID:
					return getSkillID(args);
					break;
			}
		}
		
		private function getSkillID(args:Array) : int
		{
			var skillName:String = args[0];
			var data:Object = this.searchForKey("skill_name", skillName);
			
			if(data) return data.id;
			else return 0;
		}
		
		protected function getSkillDataByID(args:Array) : void
		{
			var id:int = args[0];
			var callback:Function = args[1];
			
			var data:Object = this.searchForKey("id", id);
			
			callback(data);
		}
		
		protected function getAllData(args:Array) : void
		{
			var info:RoleInfo = args[0];
			var callback:Function = args[1];
			
			var skills:Vector.<SkillModel> = SkillUtitiles.getAllSkills(info, _data);
			
			callback(skills);
		}
		
		override protected function getData(args:Array) : void
		{
			var name:String = args[0];
			var callback:Function = args[1];
			
			var data:Object = this.searchForKey("skill_name", name);
			
			if (!data) Log.Error("没有找到相关的基础信息");
			
			callback(data);
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
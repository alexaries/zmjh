package com.game.data.db.templateData
{
	import com.engine.core.Log;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Characters;
	import com.game.template.InterfaceTypes;

	public class CharactersTemplateData extends TDBase implements IDBData
	{
		
		public function CharactersTemplateData()
		{
			_XMLFileName = "characters.xml";
			CS = Characters;
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
					getData(args);
					break;
				case InterfaceTypes.GET_GRADE_BY_NAME:
					return getGrade(args);
					break;
				case InterfaceTypes.GET_ROLE_DATA_BY_NAME:
					return getRoleDataByName(args);
					break;
			}
		}
		
		private function getRoleDataByName(args:Array) : Characters
		{
			var name:String = args[0];
			var obj:Characters = searchForKey("name", name) as Characters;
			return obj;
		}
		
		private function getGrade(args:Array) : String
		{
			var name:String = args[0];
			var obj:Characters = searchForKey("name", name) as Characters;
			return obj.grade;
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
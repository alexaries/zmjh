package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Skill_up;
	import com.game.template.InterfaceTypes;

	public class Skill_upTemplateData extends TDBase implements IDBData
	{
		public function Skill_upTemplateData()
		{
			_XMLFileName = "skill_up.xml";
			CS = Skill_up;
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.INIT;
			
			switch (type)
			{
				case InterfaceTypes.INIT:
					init();
					break;
			}
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
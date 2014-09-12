package com.game.data.db.templateData
{
	import com.game.DataBase;
	import com.game.data.db.IDBData;
	import com.game.template.InterfaceTypes;
	
	public class Smallgame_runTemplateData extends TDBase implements IDBData
	{
		public function Smallgame_runTemplateData()
		{
			_XMLFileName = "smallgame_run.xml";
			CS = Smallgame_ru;
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


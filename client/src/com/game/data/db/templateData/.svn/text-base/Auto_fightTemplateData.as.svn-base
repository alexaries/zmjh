package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Auto_fight;
	import com.game.template.InterfaceTypes;

	public class Auto_fightTemplateData extends TDBase implements IDBData
	{
		public function Auto_fightTemplateData()
		{
			_XMLFileName = "auto_fight.xml";
			CS = Auto_fight;
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
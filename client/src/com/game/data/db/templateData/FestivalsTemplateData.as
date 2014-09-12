package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Festivals;
	import com.game.template.InterfaceTypes;

	public class FestivalsTemplateData extends TDBase implements IDBData
	{
		public function FestivalsTemplateData()
		{
			_XMLFileName = "festivals.xml";
			CS = Festivals;
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
package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Strengthen;
	import com.game.template.InterfaceTypes;

	public class StrengthenTemplateData extends TDBase implements IDBData
	{
		public function StrengthenTemplateData()
		{
			_XMLFileName = "strengthen.xml";
			CS = Strengthen;
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
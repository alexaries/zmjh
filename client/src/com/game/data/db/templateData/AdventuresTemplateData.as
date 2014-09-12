package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Adventures;
	import com.game.template.InterfaceTypes;

	public class AdventuresTemplateData extends TDBase implements IDBData
	{
		public function AdventuresTemplateData()
		{
			_XMLFileName = "adventures.xml";
			CS = Adventures;
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
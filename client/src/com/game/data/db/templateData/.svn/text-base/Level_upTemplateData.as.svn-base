package com.game.data.db.templateData
{
	import com.engine.core.Log;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Level_up;
	import com.game.template.InterfaceTypes;

	public class Level_upTemplateData extends TDBase implements IDBData
	{
		public function Level_upTemplateData()
		{
			_XMLFileName = "level_up.xml";
			CS = Level_up;
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
			}
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
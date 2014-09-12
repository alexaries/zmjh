package com.game.data.db.templateData
{
	import com.engine.core.Log;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Quality_up;
	import com.game.template.InterfaceTypes;

	public class Quality_upTemplateData extends TDBase implements IDBData
	{
		public function Quality_upTemplateData()
		{
			_XMLFileName = "quality_up.xml";
			CS = Quality_up;
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
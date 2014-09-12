package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.SkyEarth;
	import com.game.template.InterfaceTypes;

	public class SkyEarthTemplateData extends TDBase implements IDBData
	{
		public function SkyEarthTemplateData()
		{
			_XMLFileName = "skyearth.xml";
			CS = SkyEarth;
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
package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Mission;
	import com.game.template.InterfaceTypes;

	public class MissionTemplateData extends TDBase implements IDBData
	{
		public function MissionTemplateData()
		{
			_XMLFileName = "mission.xml";
			CS = Mission;
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
package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Online_bonus;
	import com.game.template.InterfaceTypes;

	public class OnlineBonusTemplateData extends TDBase implements IDBData
	{
		public function OnlineBonusTemplateData()
		{
			_XMLFileName = "online_bonus.xml";
			CS = Online_bonus;
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
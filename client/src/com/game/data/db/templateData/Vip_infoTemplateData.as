package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Vip_info;
	import com.game.template.InterfaceTypes;

	public class Vip_infoTemplateData extends TDBase implements IDBData
	{
		public function Vip_infoTemplateData()
		{
			_XMLFileName = "vip_info.xml";
			CS = Vip_info;
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
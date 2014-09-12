package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Vip_mall;
	import com.game.template.InterfaceTypes;

	public class Vip_mallTemplateData extends TDBase implements IDBData
	{
		public function Vip_mallTemplateData()
		{
			_XMLFileName = "vip_mall.xml";
			CS = Vip_mall;
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
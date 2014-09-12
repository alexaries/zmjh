package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Mall;
	import com.game.template.InterfaceTypes;

	public class MallTemplateData extends TDBase implements IDBData
	{
		public function MallTemplateData()
		{
			_XMLFileName = "mall.xml";
			CS = Mall;
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
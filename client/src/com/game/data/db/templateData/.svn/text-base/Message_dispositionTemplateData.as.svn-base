package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Message_disposition;
	import com.game.template.InterfaceTypes;

	public class Message_dispositionTemplateData extends TDBase implements IDBData
	{
		public function Message_dispositionTemplateData()
		{
			_XMLFileName = "message_disposition.xml";
			CS = Message_disposition;
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
package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Title;
	import com.game.template.InterfaceTypes;

	public class TitleTemplateData extends TDBase implements IDBData
	{
		public function TitleTemplateData()
		{
			_XMLFileName = "title.xml";
			CS = Title;
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
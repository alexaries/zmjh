package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Daily_work;
	import com.game.template.InterfaceTypes;

	public class Daily_workTemplateDate extends TDBase implements IDBData
	{
		public function Daily_workTemplateDate()
		{
			_XMLFileName = "daily_work.xml";
			CS = Daily_work;
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
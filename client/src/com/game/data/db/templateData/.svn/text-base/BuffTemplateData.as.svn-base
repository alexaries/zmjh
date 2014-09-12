package com.game.data.db.templateData
{
	import com.engine.utils.Utilities;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Buff;
	import com.game.template.InterfaceTypes;
	
	public class BuffTemplateData extends TDBase implements IDBData
	{
		public function BuffTemplateData()
		{
			_XMLFileName = "buff.xml";
			CS = Buff;
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
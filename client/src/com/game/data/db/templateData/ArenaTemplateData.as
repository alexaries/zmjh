package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Arena;
	import com.game.template.InterfaceTypes;

	public class ArenaTemplateData extends TDBase implements IDBData
	{
		public function ArenaTemplateData()
		{
			_XMLFileName = "arena.xml";
			CS = Arena;
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
package com.game.data.db.templateData
{
	import com.game.DataBase;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Smallgame_link;
	import com.game.template.InterfaceTypes;

	public class Smallgame_linkTemplateData extends TDBase implements IDBData
	{
		public function Smallgame_linkTemplateData()
		{
			_XMLFileName = "smallgame_link.xml";
			CS = Smallgame_link;
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
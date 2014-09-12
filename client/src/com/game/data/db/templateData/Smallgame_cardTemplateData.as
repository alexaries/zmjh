package com.game.data.db.templateData
{
	import com.game.DataBase;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Smallgame_card;
	import com.game.template.InterfaceTypes;

	public class Smallgame_cardTemplateData extends TDBase implements IDBData
	{
		public function Smallgame_cardTemplateData()
		{
			_XMLFileName = "smallgame_card.xml";
			CS = Smallgame_card;
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
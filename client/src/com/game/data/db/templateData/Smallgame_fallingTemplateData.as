package com.game.data.db.templateData
{
	import com.game.DataBase;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Smallgame_falling;
	import com.game.template.InterfaceTypes;

	public class Smallgame_fallingTemplateData extends TDBase implements IDBData
	{
		public function Smallgame_fallingTemplateData()
		{
			_XMLFileName = "smallgame_falling.xml";
			CS = Smallgame_falling;
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
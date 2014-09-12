package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Characters;
	import com.game.data.db.protocal.Level_up_enemy;
	import com.game.template.InterfaceTypes;

	public class Level_up_enemyTemplateData extends TDBase implements IDBData
	{
		public function Level_up_enemyTemplateData()
		{
			_XMLFileName = "level_up_enemy.xml";
			CS = Level_up_enemy;
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.INIT;
			
			switch (type)
			{
				case InterfaceTypes.INIT:
					init();
					break;
				case InterfaceTypes.GET_DATA:
					getData(args);
					break;
			}
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
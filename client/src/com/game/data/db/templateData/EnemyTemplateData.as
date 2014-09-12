package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Enemy;
	import com.game.template.InterfaceTypes;

	public class EnemyTemplateData extends TDBase implements IDBData
	{
		public function EnemyTemplateData()
		{
			_XMLFileName = "enemy.xml";
			CS = Enemy;
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
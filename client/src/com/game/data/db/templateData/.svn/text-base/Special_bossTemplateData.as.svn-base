package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Special_boss;
	import com.game.template.InterfaceTypes;

	public class Special_bossTemplateData extends TDBase implements IDBData
	{
		public function Special_bossTemplateData()
		{
			_XMLFileName = "special_boss.xml";
			CS = Special_boss;
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
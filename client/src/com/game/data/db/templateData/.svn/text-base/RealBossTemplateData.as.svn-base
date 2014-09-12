package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Real_Boss;
	import com.game.template.InterfaceTypes;

	public class RealBossTemplateData extends TDBase implements IDBData
	{
		public function RealBossTemplateData()
		{
			_XMLFileName = "real_boss.xml";
			CS = Real_Boss;
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
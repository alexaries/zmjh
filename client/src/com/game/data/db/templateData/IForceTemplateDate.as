package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.I_force;
	import com.game.template.InterfaceTypes;

	public class IForceTemplateDate extends TDBase implements IDBData
	{
		public function IForceTemplateDate()
		{
			_XMLFileName = "i_force.xml";
			CS = I_force;
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
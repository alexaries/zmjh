package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Exclusive_equipment;
	import com.game.template.InterfaceTypes;

	public class Exclusive_equipmentTemplateData extends TDBase implements IDBData
	{
		public function Exclusive_equipmentTemplateData()
		{
			_XMLFileName = "exclusive_equipment.xml";
			CS = Exclusive_equipment;
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
package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Fragment;
	import com.game.template.InterfaceTypes;

	public class FragmentTemplateData extends TDBase implements IDBData
	{
		public function FragmentTemplateData()
		{
			_XMLFileName = "fragment.xml";
			CS = Fragment;
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
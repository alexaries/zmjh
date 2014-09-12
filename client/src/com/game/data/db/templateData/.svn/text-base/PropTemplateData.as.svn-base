package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Prop;
	import com.game.template.InterfaceTypes;

	public class PropTemplateData extends TDBase implements IDBData
	{
		public function PropTemplateData()
		{
			_XMLFileName = "prop.xml";
			CS = Prop;
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
				case InterfaceTypes.GET_PROP_BY_ID:
					return getPropData(args);
					break;
				case InterfaceTypes.GET_PROP_BY_NAME:
					return getPropByName(args);
					break;
			}
		}
		
		private function getPropByName(args:Array) : Prop
		{
			var name:String = args[0];
			
			var prop:Prop = searchForKey("name", name) as Prop;
			
			return prop;
		}
		
		private function getPropData(args:Array) : Prop
		{
			var id:int = args[0];
			
			var prop:Prop = searchForKey("id", id) as Prop;
			
			return prop;
		}
		
		override protected function getData(args:Array) : void
		{
			var id:int = args[0];
			var callback:Function = args[1];
			
			var prop:Prop = searchForKey("id", id) as Prop;
			callback(prop);
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
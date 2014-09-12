package com.game.data.db.templateData
{
	import com.engine.core.Log;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Endless;
	import com.game.template.InterfaceTypes;

	public class EndlessTemplateData extends TDBase implements IDBData
	{
		public function EndlessTemplateData()
		{
			_XMLFileName = "endless.xml";
			CS = Endless;
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.INIT;
			
			switch (type)
			{
				case InterfaceTypes.INIT:
					init();
					break;
				case InterfaceTypes.GET_ENDLESS_BY_ID:
					return getEndlessByID(args);
					break;
			}
		}
		
		private function getEndlessByID(args:Array) : Object
		{
			var id:int = args[0];
			
			var data:Object = this.searchForKey("id", id);
			
			if(!data) Log.Error("没有找到相关的无尽关卡信息");
			
			return data;
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
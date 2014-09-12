package com.game.data.db.templateData
{
	import com.engine.core.Log;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Level_up_exp;
	import com.game.template.InterfaceTypes;

	public class Level_up_expTemplateData extends TDBase implements IDBData
	{
		public function Level_up_expTemplateData()
		{
			_XMLFileName = "level_up_exp.xml";
			CS = Level_up_exp;
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
					return getLvData(args);
					break;
			}
		}
		
		private function getLvData(args:Array) : Object
		{
			var lv:int = args[0];
			
			var data:Object = this.searchForKey("lv", lv);
			
			if(!data) Log.Error("没有找到相关的无尽关卡信息");
			
			return data;
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
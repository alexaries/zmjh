package com.game.data.db.templateData
{
	import com.engine.core.Log;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Gift_package;
	import com.game.template.InterfaceTypes;

	public class GiftPackageTemplateData extends TDBase implements IDBData
	{
		public function GiftPackageTemplateData()
		{
			_XMLFileName = "gift_package.xml";
			CS = Gift_package;
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
					return getDataByID(args);
					break;
			}
		}
		
		private function getDataByID(args:Array) : Object
		{
			var id:int = args[0];
			var data:Object = this.searchForKey("id", id);
			
			if(!data) Log.Error("没有找到相关的信息");
			
			return data;
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
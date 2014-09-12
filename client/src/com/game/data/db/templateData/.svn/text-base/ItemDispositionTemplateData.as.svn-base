package com.game.data.db.templateData
{
	import com.engine.core.Log;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Item_disposition;
	import com.game.template.InterfaceTypes;

	public class ItemDispositionTemplateData extends TDBase implements IDBData
	{
		public function ItemDispositionTemplateData()
		{
			_XMLFileName = "item_disposition.xml";
			CS = Item_disposition;
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
		
		override protected function getData(args:Array):void
		{
			var levelName:String = args[0];
			var difficult:int = args[1];
			var callback:Function = args[2];
			
			var data:Object = searchFightData(levelName, difficult);
			
			if (!data) Log.Error("没有找到相关的基础信息");
			
			callback(data);
		}
		
		private function searchFightData(level_name:String, difficult:int) : Object
		{
			var obj:Object;
			
			for each(var item:Object in  _data)
			{
				if (item["name"] == level_name && item["difficulty"] == difficult)
				{
					obj = item;
					break;
				}
			}
			
			return obj;
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
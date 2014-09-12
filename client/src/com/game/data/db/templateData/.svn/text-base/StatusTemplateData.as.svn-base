package com.game.data.db.templateData
{
	import com.engine.core.Log;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Status;
	import com.game.template.InterfaceTypes;

	public class StatusTemplateData extends TDBase implements IDBData
	{
		public function StatusTemplateData()
		{
			_XMLFileName = "status.xml";
			CS = Status;
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
			var status_name:String = args[0];
			var callback:Function = args[1];
			var data:Object = this.searchForKey("status_name", status_name);
			
			if (!data) Log.Error("没有找到相关的基础信息");
			
			callback(data);
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
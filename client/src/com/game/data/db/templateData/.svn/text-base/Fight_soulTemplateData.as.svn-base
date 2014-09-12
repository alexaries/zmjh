package com.game.data.db.templateData
{
	import com.engine.core.Log;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Fight_soul;
	import com.game.template.InterfaceTypes;

	public class Fight_soulTemplateData extends TDBase implements IDBData
	{
		public function Fight_soulTemplateData()
		{
			_XMLFileName = "fight_soul.xml";
			CS = Fight_soul;
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
			var type:String = args[0];
			
			var callback:Function = args[1];
			
			var data:Object = this.searchForKey("type", type);
			
			if (!data) Log.Error("没有找到相关的基础信息");
			
			callback(data);
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
package com.game.data.db.templateData
{
	import com.engine.core.Log;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Battle_disposition;
	import com.game.template.InterfaceTypes;

	public class BattleDispositionTemplateData extends TDBase implements IDBData
	{
		public function BattleDispositionTemplateData()
		{
			_XMLFileName = "battle_disposition.xml";
			CS = Battle_disposition;
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
		
		override protected function getData(args:Array) : void
		{
			var name:String = args[0];
			var difficult:int = args[1];
			var callback:Function = args[2];
			
			var data:Object = searchFightData(name, difficult);
			
			if (!data) Log.Error("没有找到相关的基础信息");
			
			callback(data);
		}
		
		/**
		 * 战斗怪物配置 
		 * @param level_name
		 * @param difficult
		 * @return 
		 * 
		 */		
		private function searchFightData(level_name:String, difficult:int) : Object
		{
			var obj:Object;
			
			for each(var item:Object in  _data)
			{
				if (item["level_name"] == level_name && item["difficulty"] == difficult)
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
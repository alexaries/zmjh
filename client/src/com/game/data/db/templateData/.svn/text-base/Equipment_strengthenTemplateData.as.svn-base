package com.game.data.db.templateData
{
	import com.engine.core.Log;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Equipment_strengthen;
	import com.game.template.InterfaceTypes;

	public class Equipment_strengthenTemplateData extends TDBase implements IDBData
	{
		public function Equipment_strengthenTemplateData()
		{
			_XMLFileName = "equipment_strengthen.xml";
			CS = Equipment_strengthen;
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
				case InterfaceTypes.GET_EQUIP_LV_DATA:
					return getEquipStrengthen(args);
					break;
			}
		}
		
		private function getEquipStrengthen(args:Array) : Object
		{
			var id:String = args[0];
			
			var data:Object = this.searchForKey("id", id);

			if(!data) Log.Error("没有找到相关的装备基础信息");
			
			return data;
		}
		
		override protected function getData(args:Array) : void
		{
			var type:String = args[0];
			var callback:Function = args[1];
			
			var data:Object = this.searchForKey("type", type);
			
			if (!data) Log.Error("没有找到相关的装备基础信息");
			
			callback(data);
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
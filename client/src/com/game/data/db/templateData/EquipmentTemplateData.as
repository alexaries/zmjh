package com.game.data.db.templateData
{
	import com.engine.core.Log;
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Equipment;
	import com.game.template.InterfaceTypes;

	public class EquipmentTemplateData extends TDBase implements IDBData
	{
		public function EquipmentTemplateData()
		{
			_XMLFileName = "equipment.xml";
			CS = Equipment;
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
				case InterfaceTypes.GET_EQUIP_DATA_BY_ID:
					getDataById(args);
					break;
				case InterfaceTypes.GET_EQUIP_DATA_BY_GRADE:
					return getDataByGrade(args);
					break;
			}
		}
		
		protected function getDataById(args:Array) : void
		{
			var id:String = args[0];
			var callback:Function = args[1];
			
			var data:Object = this.searchForKey("id", id);
			
			if (!data) Log.Error("没有找到相关的基础信息");
			
			callback(data);
		}
		
		protected function getDataByGrade(args:Array) : Vector.<Equipment>
		{
			var grade:int = args[0];
			var quality:String = args[1];
			var grades:Vector.<Equipment> = new Vector.<Equipment>();
			
			for each(var item:Equipment in _data)
			{
				if (item.grade_limit == grade && item.color == quality)
				{
					grades.push(item);
				}
			}
			
			return grades;
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
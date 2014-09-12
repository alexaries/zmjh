package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Daily_attendance;
	import com.game.template.InterfaceTypes;

	public class Daily_attendanceTemplateData extends TDBase implements IDBData
	{
		public function Daily_attendanceTemplateData()
		{
			_XMLFileName = "daily_attendance.xml";
			CS = Daily_attendance;
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.INIT;
			
			switch (type)
			{
				case InterfaceTypes.INIT:
					init();
					break;
			}
		}
		
		protected function init() : void
		{
			assign();
		}
	}
}
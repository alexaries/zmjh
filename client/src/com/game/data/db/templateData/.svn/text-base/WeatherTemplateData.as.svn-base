package com.game.data.db.templateData
{
	import com.game.data.db.IDBData;
	import com.game.data.db.protocal.Weather;
	import com.game.template.InterfaceTypes;

	public class WeatherTemplateData extends TDBase implements IDBData
	{
		public function WeatherTemplateData()
		{
			_XMLFileName = "weather.xml";
			CS = Weather;
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
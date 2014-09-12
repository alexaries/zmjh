package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Weather extends Object
	{
		private var _anti:Antiwear
		
		/**
		 * ID
		 * @return 
		 * 
		 */		
		public var id:int;
		
		/**
		 * 天气名称
		 * @return 
		 * 
		 */		
		public var wea_name:String;
		
		
		public function get wea_start_rate() : Number
		{
			return _anti["wea_start_rate"];
		}
		public function set wea_start_rate(value:Number) : void
		{
			_anti["wea_start_rate"] = value;
		}
		
		public function get wea_inside_rate() : Number
		{
			return _anti["wea_inside_rate"];
		}
		public function set wea_inside_rate(value:Number) : void
		{
			_anti["wea_inside_rate"] = value;
		}
		
		public function get wea_rain_rate() : Number
		{
			return _anti["wea_rain_rate"];
		}
		public function set wea_rain_rate(value:Number) : void
		{
			_anti["wea_rain_rate"] = value;
		}
		
		public function get wea_night_rate() : Number
		{
			return _anti["wea_night_rate"];
		}
		public function set wea_night_rate(value:Number) : void
		{
			_anti["wea_night_rate"] = value;
		}
		
		/**
		 * 天气持续时间
		 * @return 
		 * 
		 */		
		public function get wea_time() : int
		{
			return _anti["wea_time"];
		}
		public function set wea_time(value:int) : void
		{
			_anti["wea_time"] = value;
		}
		
		/**
		 * 天气描述
		 * @return 
		 * 
		 */		
		public var wea_message:String;
		
		public function Weather()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["wea_start_rate"] = 0;
			_anti["wea_inside_rate"] = 0;
			_anti["wea_rain_rate"] = 0;
			_anti["wea_night_rate"] = 0;
			_anti["wea_time"] = 0;
		}
		
		public function assign(data:XML) : void
		{
			id = data.@id;
			
			wea_name = data.@wea_name;
			
			wea_start_rate = data.@wea_start_rate;
			
			wea_inside_rate = data.@wea_inside_rate;
			
			wea_rain_rate = data.@wea_rain_rate;
			
			wea_night_rate = data.@wea_night_rate;
			
			wea_time = data.@wea_time;
			
			wea_message = data.@wea_message;
		}
		
		public function copy() : Weather
		{
			var target:Weather = new Weather();
			
			target.id = this.id;
			
			target.wea_name = this.wea_name;
			
			target.wea_start_rate = this.wea_start_rate;
			
			target.wea_inside_rate = this.wea_inside_rate;
			
			target.wea_rain_rate = this.wea_rain_rate;
			
			target.wea_night_rate = this.wea_night_rate;
			
			target.wea_time = this.wea_time;
			
			target.wea_message = this.wea_message;
			
			return target;
		}
	}
}
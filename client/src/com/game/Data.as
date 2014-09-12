package com.game
{
	import mx.core.Singleton;

	public class Data extends DataBase
	{
		public function Data()
		{
			if (_instance)
			{
				throw new Error("单例类！");
			}

			_instance = this;
		}
		
		override public function init(controller:Controller):void
		{
			super.init(controller);
		}
		
		private static var _instance:Data;
		public static function get instance() : Data
		{
			if (!_instance)
			{
				throw new Error("Data 还没有实例化");
			}
			
			return _instance;
		}
	}
}
package com.game
{
	public class View extends ViewBase
	{
		public function View()
		{
			if (_instance)
			{
				throw new Error("单例类！");
			}
			
			_instance = this;
		}
		
		override public function init(controller:Controller, lang:Lang):void
		{
			super.init(controller, lang);
		}
		
		private static var _instance:View;
		public static function get instance() : View
		{
			if (!_instance)
			{
				throw new Error("Data 还没有实例化");
			}
			
			return _instance;
		}
	}
}
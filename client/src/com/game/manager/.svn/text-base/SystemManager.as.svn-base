package com.game.manager
{
	import flash.system.System;
	public class SystemManager
	{
		public function SystemManager(s : Singleton)
		{
			if (_instance != null)
			{
				throw new Error("DebugManager 是单例！");
			}
		}
		
		public function show() : void
		{
			trace(Number(System.totalMemory * .000001).toFixed(2) + "M");
		}
		
		private static var _instance : SystemManager;
		public static function get instance () : SystemManager
		{
			if (null == _instance)
			{
				_instance = new SystemManager(new Singleton());
			}
			
			return _instance;
		}
	}
}

class Singleton {}
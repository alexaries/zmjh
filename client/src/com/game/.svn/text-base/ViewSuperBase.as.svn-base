package com.game
{
	import com.game.manager.DebugManager;
	import com.game.manager.FontManager;
	import com.game.manager.LayerManager;
	import com.game.manager.ResCacheManager;
	import com.game.manager.SoundPlayerManager;

	public class ViewSuperBase extends SuperBase
	{
		protected var _controller:Controller;
		public function get controller() : Controller
		{
			return _controller;
		}
		
		protected var _lang:Lang;
		public function get lang() : Lang
		{
			return _lang;
		}
		
		protected var _layer:LayerManager;
		public function get layer() : LayerManager
		{
			return _layer;
		}
		
		protected var _res : ResCacheManager;
		public function get res () : ResCacheManager
		{
			return _res;
		}
		
		protected var _font:FontManager;
		public function get font() : FontManager
		{
			return _font;
		}
		
		protected var _debug:DebugManager;
		public function get debug() : DebugManager
		{
			return _debug;
		}
		
		protected var _sound:SoundPlayerManager;
		public function get sound() : SoundPlayerManager
		{
			return _sound;
		}
		
		protected function createObject (C:Class) : Object
		{
			var instanceName:String = (C as Class).toString();
			instanceName = instanceName.replace(/View\]/, "").replace(/^\[class /, "").toLowerCase();
			
			return createObjectBase(C, instanceName);
		}
		
		public function ViewSuperBase()
		{
			super();
		}
	}
}
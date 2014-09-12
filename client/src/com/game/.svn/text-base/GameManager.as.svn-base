package com.game
{
	import com.engine.core.Log;
	import com.engine.net.ReqDataStructure;
	import com.engine.net.ServerEventType;
	import com.engine.utils.SPInput;
	import com.game.manager.FontManager;
	import com.game.manager.LayerManager;
	import com.game.manager.ResCacheManager;
	import com.game.manager.URIManager;
	
	import starling.events.Event;

	public class GameManager
	{
		private var _ctrl:Controller;
		private var _data:Data;
		private var _view:View;
		private var _lang:Lang;
		
		public function GameManager()
		{
			_data = new Data();
			_ctrl = new Controller();
			_view = new View();
			_lang = new Lang();
		}
		
		public function init() : void
		{
			// 日志
			Log.init();
			// 地址
			URIManager.analyze();
			// 资源
			ResCacheManager.instance.init(null);
			//　层级
			LayerManager.instance.init();
			// 输入
		
			SPInput.enable();
			
			_data.init(_ctrl);
			_ctrl.init(_data, _view, _lang);
			_view.init(_ctrl, _lang);
			
			start();
		}
		
		public function timeProcess() : void
		{
			_data.timeProcess();
			_ctrl.timeProcess();
			_view.timeProcess();
		}
		
		public function frameProcess() : void
		{
			_data.frameProcess();
			_ctrl.frameProcess();
			_view.frameProcess();
		}
		
		/**
		 * 开始 
		 * 
		 */		
		public function start() : void
		{
			_view.load.interfaces();
			//_data.registerCallback(new ReqDataStructure("getuserdatalist", null));
		}
	}
}
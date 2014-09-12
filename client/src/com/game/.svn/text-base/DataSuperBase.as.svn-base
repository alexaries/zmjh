package com.game
{
	import com.engine.core.Log;
	import com.engine.net.GameServerFor4399;
	import com.engine.net.ReqDataStructure;
	import com.engine.net.ServerEvent;
	import com.engine.net.ServerEventType;
	import com.game.data.time.HackChecker;
	import com.game.manager.DebugManager;
	import com.game.manager.LayerManager;
	import com.game.manager.ResCacheManager;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Base;
	import com.game.view.BaseView;
	import com.game.view.save.SaveConfig;
	
	import flash.events.Event;
	import flash.utils.describeType;
	
	import starling.core.Starling;

	public class DataSuperBase extends SuperBase
	{
		protected var _server:GameServerFor4399;
		public function get server() : GameServerFor4399
		{
			return _server;
		}
		
		private var _callbackList:Object;
		private var _reqStatus:Object;
		
		protected var _control:Controller;
		public function get control() : Controller
		{
			return _control;
		}
		
		protected var _res : ResCacheManager;
		public function get res () : ResCacheManager
		{
			return _res;
		}
		
		protected var _debug:DebugManager;
		public function get debug() : DebugManager
		{
			return _debug;
		}
		
		
		protected function createObject (C:Class) : Object
		{
			var instanceName:String = (C as Class).toString();
			instanceName = instanceName.replace(/Data\]/, "").replace(/^\[class /, "").toLowerCase();
			return createObjectBase(C, instanceName);
		}
		
		public function DataSuperBase()
		{
			super();
			
			_server = GameServerFor4399.instance;
			_callbackList = {};
			
			// true 正在请求中, false 空闲
			_reqStatus = {
				"logreturn" : false,
				"getuserdata" : false,
				"saveuserdata" : false,
				"getuserdatalist" : false,
				"StoreStateEvent" : false,
				"netSaveError" : false
			};
			
			initEvent();
		}
		
		private function initEvent() : void
		{
			_server.addEventListener("getuserdata", 			onServerEvent);
			_server.addEventListener("netGetError", 	onServerEvent);
			_server.addEventListener("saveuserdata", 			onServerEvent);
			_server.addEventListener("netSaveError", 	onServerEvent);
			_server.addEventListener("getuserdatalist", 		onServerEvent);
			_server.addEventListener("multipleError", 	onServerEvent);
			_server.addEventListener("StoreStateEvent", onServerEvent);
			_server.addEventListener("saveBackIndex", 	onServerEvent);
			_server.addEventListener("userLoginOut", 	onServerEvent);
			_server.addEventListener("MVC_CLOSE_PANEL", 		onServerEvent);
			_server.addEventListener("logreturn", 				onServerEvent);
			_server.addEventListener("saveUnMatch", 	onServerEvent);
		}
		
		private function onServerEvent(e:ServerEvent) : void
		{
 			Log.Trace("onServerEvent:" + e.type);
			
			switch (e.type)
			{
				// 读档
				case "getuserdata":
					_reqStatus["getuserdata"] = false;
					handleServerDataReturn("getuserdata", e);
					break;
				// 存档
				case "saveuserdata":
					_reqStatus["saveuserdata"] = false;
					handleServerDataReturn("saveuserdata", e);
					break;
				// 存档失败
				case "netSaveError":
					_reqStatus["netSaveError"] = false;
					handleServerDataReturn("netSaveError", e);
					saveError();
				// 取存档列表
				case "getuserdatalist":
					_reqStatus["getuserdatalist"] = false;
					handleServerDataReturn(e.type, e);
					break;
				// 游戏多开
				case "multipleError":
					handleServerDataReturn(e.type, e);
					onMultiple();
					break;
				//调用获取游戏是否多开的状态接口时，返回状态值
				case "StoreStateEvent":
					_reqStatus["StoreStateEvent"] = false;
					handleServerDataReturn(e.type, e);
					break;
				// 调用4399存档界面，进行存档时，返回的档索引
				case "saveBackIndex":
					_reqStatus["saveBackIndex"] = false;
					handleServerDataReturn(e.type, e);
					break;
				case "userLoginOut":
					handleServerDataReturn(e.type, e);
					onLogOut();
					break;
				case "MVC_CLOSE_PANEL":
					removeAllReq();
					break;
				case "logreturn":
					_reqStatus["logreturn"] = false;
					handleServerDataReturn(e.type, e);
					Starling.juggler.delayCall(onLogged, .5);
					break;
				case "netGetError":
					getError();
					break;
			}
		}
		
		private function getError() : void
		{
			Starling.juggler.delayCall(
				function () : void
				{
					View.instance.tip.interfaces(InterfaceTypes.Show,
						"当前游戏帐号不是最新的游戏帐号，请重新登录",
						null,
						null,
						true);
					View.instance.prompEffect.removeText();
				},
				.01);
		}
		
		public function saveError() : void
		{
			Log.Trace("存档失败！");
			Starling.juggler.delayCall(
				function () : void
				{
					View.instance.tip.interfaces(InterfaceTypes.Show,
						"您的网络不是很好，保存游戏失败，请重新保存！",
						onSaveReset,
						null,
						false,
						true,
						false);
					View.instance.prompEffect.removeText();
				},
				.01);
		}
		
		private function onSaveReset() : void
		{
			View.instance.toolbar.onSaveInit();
		}
		
		/**
		 * 玩家登出 
		 * 
		 */		
		private function onLogOut() : void
		{
			/*View.instance.toolbar.onComeBackLogin();
			View.instance.shop.delayFun = true;
			View.instance.prompEffect.play("成功退出游戏！");*/
			
			
			View.instance.shop.delayFun = true;
			
			View.instance.prompEffect.play("成功退出游戏！");
			
			HackChecker.hackHandler = null;
			HackChecker.resetHandler = null;
			
			View.instance.tip.interfaces(
				InterfaceTypes.Show,
				"你已退出游戏，请刷新当前网页！",
				null,
				null,
				true);
			
			//暂停游戏
			Starling.juggler.delayCall(
				function () : void 
				{
					LayerManager.instance.cpu_stage.frameRate = 0;
				},
				1);
		}
		
		private function onMultiple() : void
		{
			View.instance.controller.save.isMultiple = true;
		}
		
		private function onLogged() : void
		{
			if(DebugManager.instance.gameMode == V.DEVELOP) return;
			if(View.instance.save.saveType == SaveConfig.NEW_PLAYER_SAVE)
			{
				Log.Trace("new player!!!");
				View.instance.save.interfaces(InterfaceTypes.Show, SaveConfig.NEW_PLAYER_SAVE);
			}
			else
			{
				Log.Trace("get list!!!");
				View.instance.save.interfaces(InterfaceTypes.Show, SaveConfig.GET);
			}
		}
		
		protected function handleServerDataReturn(type:String, e:ServerEvent) : void
		{
			var list:Vector.<ReqDataStructure> = _callbackList[type];

			if (!list || list.length == 0) return;
			
			var req:ReqDataStructure = list.pop();
			
			if ((req.callback as Function)) req.callback(e.targetData);
			
			checkReqList();
		}
		
		/**
		 * 注册事件监听 
		 * @param req
		 * 
		 */		
		public function registerCallback(req:ReqDataStructure) : void
		{
			if (!_callbackList[req.type]) _callbackList[req.type] = new Vector.<ReqDataStructure>();
			
			(_callbackList[req.type] as Vector.<ReqDataStructure>).push(req);
			
			checkReqList();
		}
		
		/**
		 * 删除特定类型的事件监听列表 
		 * @param type
		 * 
		 */		
		public function removeCallback(type:String) : void
		{
			delete _callbackList[type];
			
			checkReqList();
		}
		
		/**
		 * 检测请求列表 
		 * 
		 */		
		protected function checkReqList() : void
		{
			var listReq:Vector.<ReqDataStructure>;
			var req:ReqDataStructure;
			for (var key:String in _callbackList)
			{
				listReq = _callbackList[key];
				
				if (!listReq || listReq.length == 0) continue;
				
				req = listReq[listReq.length - 1];
				call(key, req);
			}
		}
		
		/**
		 * 请求数据 
		 * 
		 */		
		protected function call(type:String, req:ReqDataStructure) : void
		{
			Log.Trace("DataSuperBase:" + type);
			
			switch (type)
			{
				// 读档
				case "getuserdata":
					if (req.args.length != 2) throw new Error("读档参数不对");
					_reqStatus[type] = true;
					_server.getData(req.args[0], req.args[1]);
					break;
				// 读档列表
				case "getuserdatalist":
					_reqStatus[type] = true;
					_server.getList();
					break;
				// 存档
				case "saveuserdata":
					if (req.args.length != 4) throw new Error("存档参数不对");
					_reqStatus[type] = true;
					_server.saveData(req.args[0], req.args[1], req.args[2], req.args[3]);
					break;
				//存档失败
				case "netSaveError":
					_reqStatus[type] = true;
					break;
				// 获取游戏是否多开的状态 
				case "StoreStateEvent":
					_reqStatus[type] = true;
					_server.getStoreState();
					break;
				// 退出游戏
				case "userLoginOut":
					_reqStatus[type] = true;
					_server.quitGame();
					break;
				case "logreturn":
					_reqStatus[type] = true;
					break;
			}
		}
		
		/**
		 * 移除所有的请求 
		 * 
		 */		
		public function removeAllReq() : void
		{
			for (var key:String in _callbackList)
			{
				delete _callbackList[key];
				_callbackList[key] = null;
			}
			
			_callbackList = {};
			
			View.instance.save.hide();
		}
		
	}
}
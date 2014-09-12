package com.game.data.save
{
	import com.engine.core.Log;
	import com.engine.net.GameServerFor4399;
	import com.engine.net.ReqDataStructure;
	import com.engine.net.ServerEventType;
	import com.game.data.Base;
	import com.game.data.player.structure.Player;
	import com.game.manager.DebugManager;
	import com.game.template.GameConfig;
	import com.game.template.V;
	
	import flash.utils.ByteArray;

	public class SaveData extends Base
	{
		// 回调方法
		private var _callback:Function;
		
		// 平台服务
		public function get serviceHold() : *
		{
			return GameServerFor4399.instance.serviceHold;
		}
		
		// 当前回调方法
		private var _curCallback:Function;
		public function set curCallback(cb:Function) : void
		{
			_curCallback = cb;
		}
		
		// 存档数据
		private var _saveData:XML;
		public function get saveData() : XML
		{
			return _saveData;
		}
		
		// 存档索引
		private var _saveIndex:int;
		public function get saveIndex() : int
		{
			return _saveIndex;
		}
		
		// 存档时间
		private var _saveTime:String;
		public function get saveTime() : String
		{
			return _saveTime;
		}
		
		/**
		 * 新玩家 
		 * 
		 */
		private var _isNewPlayer:Boolean = false;
		public function get isNewPlayer() : Boolean
		{
			return _isNewPlayer;
		}
		public function set isNewPlayer(value:Boolean) : void
		{
			_isNewPlayer = value;
		}
		
		/**
		 * 是否登录 
		 * @return 
		 * 
		 */		
		public function get logged() : Boolean
		{
			var logInfo:Object;
			
			if(GameServerFor4399.instance.isLocal)
				logInfo = serviceHold.isLogin();
			else
				logInfo = serviceHold.isLog;
			
			var bol:Boolean = (logInfo != null);
			
			return bol;
		}
		
		public function SaveData()
		{
			
		}
		
		/**
		 * 取存储列表 
		 * @param callback
		 * 
		 */		
		public function getSaveList(callback:Function) : void
		{
			_callback = callback;
			
			var req:ReqDataStructure = new ReqDataStructure("getuserdatalist", onGetSaveListReturn, true, 0);
			_data.registerCallback(req);
		}
		
		private function onGetSaveListReturn(data:Array) : void
		{
			_callback(data);
		}
		
		public function getLogged() : void
		{
			var req:ReqDataStructure = new ReqDataStructure("logreturn", null, null);
			_data.registerCallback(req);
		}
		
		/**
		 * 获取存档数据 
		 * 
		 */		
		public function getSaveGet(callback:Function, index:int = 0, ui:Boolean = false) : void
		{
			_callback = callback;
			
			var req:ReqDataStructure = new ReqDataStructure("getuserdata", onSaveGetReturn, ui, index);
			_data.registerCallback(req);
		}
		
		private function onSaveGetReturn(data:*) : void
		{
			_saveData = XML(data["data"]);
			_saveIndex = data["index"];
			_saveTime = data["datetime"];
			
			Log.Trace(_saveData.toString());
			_callback(data);
		}
		
		/**
		 * 新玩家 
		 * @param callback
		 * @param index
		 * 
		 */		
		public function newPlayerSetData(callback:Function, index:int) : void
		{
			_isNewPlayer = true;
			_callback = callback;
			
			var newPlayer:XML = this.getXMLData(V.LOAD, GameConfig.LOAD_RES, "NewPlayer");
			_saveData = newPlayer;
			var title:String = "造梦小宝 LV.1";
			saveSet(_callback, newPlayer, index, title);
		}
		
		/**
		 * 存数据 
		 * 
		 */
		public function saveSet(callback:Function, data:XML, index:int, title:String, ui:Boolean = false) : void
		{
			_callback = callback;
			_saveIndex = index;
			
			var req:ReqDataStructure = new ReqDataStructure("saveuserdata", onSaveSetReturn, title, data, ui, index);
			_data.registerCallback(req);
		}
		
		public function saveError(callback:Function) : void
		{
			var req:ReqDataStructure = new ReqDataStructure("netSaveError", callback);
			_data.registerCallback(req);
		}
		
		private function onSaveSetReturn(data:*) : void
		{
			_callback(data);
		}
		
		/**
		 * 退出游戏 
		 * @param callback
		 * 
		 */		
		public function quitGame(callback:Function) : void
		{
			Log.Trace("StartData:quitGame");
			var req:ReqDataStructure = new ReqDataStructure("userLoginOut", callback);
			_data.registerCallback(req);
		}
		
		/**
		 * 多开判断
		 * @param callback
		 * 
		 */		
		public function multipleState(callback:Function) : void
		{
			Log.Trace("StartData:multipleState");
			var req:ReqDataStructure = new ReqDataStructure("StoreStateEvent", callback);
			_data.registerCallback(req);
		}
		
		/**
		 * 打开登录窗口 
		 * 
		 */		
		public function showLogPanel() : void
		{
			if(serviceHold){
				serviceHold.showLogPanel();
			}
		}
	}
}
package com.engine.net
{	
	import com.engine.core.Log;
	import com.game.View;
	import com.game.manager.DebugManager;
	import com.game.manager.LayerManager;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	
	import flash.display.Stage;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import unit4399.events.SaveEvent;

	public class GameServerFor4399 extends EventDispatcher
	{
		public var serviceHold:*;
		
		public var isLocal:Boolean;
		
		private var _stage:Stage;
		public function get stage() : Stage
		{
			return _stage;
		}
		public function set stage(value:Stage) : void
		{
			_stage = value;
			
			serviceHold = Main.serviceHold;
			initEvent();
		}
		
		private static var _instance : GameServerFor4399;
		public static function get instance() : GameServerFor4399
		{
			if (!_instance)
			{
				_instance = new GameServerFor4399();
			}
			
			return _instance;
		}
		
		public function GameServerFor4399()
		{
			if (_instance) throw new Error("该类只能为单例");
		}
		
		private function initEvent() : void
		{
			stage.addEventListener("logreturn",saveProcess);
			
			stage.addEventListener("getuserdata",saveProcess);
			
			stage.addEventListener("saveuserdata",saveProcess);
			
			stage.addEventListener("getuserdatalist",saveProcess);
			//调用4399存档界面，进行存档时，返回的档索引
			stage.addEventListener("saveBackIndex",saveProcess);
			//网络存档失败
			stage.addEventListener("netSaveError", netSaveErrorHandler, false, 0, true);
			//网络取档失败
			stage.addEventListener("netGetError", netGetErrorHandler, false, 0, true);
			//游戏防多开
			stage.addEventListener("multipleError", multipleErrorHandler, false, 0, true);
			//调用获取游戏是否多开的状态接口时，返回状态值
			stage.addEventListener("StoreStateEvent", getStoreStateHandler, false, 0, true);
			//玩家退出登陆
			stage.addEventListener("userLoginOut", onUserLogOutHandler, false, 0, true);
			// 关闭登陆框
			stage.addEventListener("MVC_CLOSE_PANEL", closePanelHandler);
		}
		
		/**
		 * 关闭面板 
		 * @param e
		 * 
		 */		
		private function closePanelHandler(e:Event) : void
		{
			Log.Trace("closePanelHandler");
			/*
			if(serviceHold)
			{    
				serviceHold.showLogPanel();
			}*/
			this.dispatchEvent(new ServerEvent("MVC_CLOSE_PANEL", []));
		}
		
		/**
		 * 用户登出 
		 * @param evt
		 * 
		 */		
		private function onUserLogOutHandler(e:Event):void
		{
			this.dispatchEvent(new ServerEvent("userLoginOut", []));
			//LayerManager.instance.cpu_stage.removeChild(View.instance.load.loader);
		}
		
		private function saveProcess(e:*) : void
		{
			switch(e.type)
			{ 
				case "getuserdata":
					//读档完成发出的事件
					//index:存档的位置
					//data:存档内容
					//datetime:存档时间
					//title:存档标题
					//e.ret = {"index":0,"data":"abc","datetime":"2010-11-02 16:30:59","title":"标题"}
					Log.Trace(e.ret);
					this.dispatchEvent(new ServerEvent("getuserdata", e.ret));
					break;
				case "saveuserdata":
					if(e.ret as Boolean == true)
					{
						Log.Trace(e.ret + "   SaveSuccess");
						this.dispatchEvent(new ServerEvent("saveuserdata", e.ret, true));
					}
					else
					{
						Log.Trace(e.ret + "   SaveFailure");
						this.dispatchEvent(new ServerEvent("saveuserdata", e.ret, false));
					}
					break;
				case "saveBackIndex":
					var tmpObj:Object = e.ret as Object;
					var result:Boolean;
					if(tmpObj == null || int(tmpObj.idx) == -1)
					{
						trace("返回的存档索引值出错了");
						this.dispatchEvent(new ServerEvent("saveBackIndex", tmpObj, false));
						break;
					}
					trace("返回的存档索引值(从0开始算)："+tmpObj.idx);
					this.dispatchEvent(new ServerEvent("saveBackIndex", tmpObj, true));
					break;
				case "getuserdatalist":
					var data:Array = e.ret as Array;
					Log.Trace("SAVE_LIST");
					if(data == null) 
					{
						this.dispatchEvent(new ServerEvent("getuserdatalist", [], true));
						break;
					}
					for(var i:* in data)
					{
						var obj:Object = data[i];
						if(obj == null) continue;
						var tmpStr:String = "存档的位置:" + obj.index + "存档时间:" + obj.datetime +"存档标题:"+ obj.title;
						trace(tmpStr);
					}
					
					
					this.dispatchEvent(new ServerEvent("getuserdatalist", data, true));
					break;
				case "logreturn":
					this.dispatchEvent(new ServerEvent("logreturn", data, true));
					break;
			}
		}
		
		private function netSaveErrorHandler(evt:Event) : void
		{
			var tmpStr:String = "网络存档失败了！";
			trace(tmpStr);
			this.dispatchEvent(new ServerEvent("netSaveError", tmpStr, false));
		}
		
		private function netGetErrorHandler(evt:DataEvent) : void
		{
			var tmpStr:String = "网络取"+ evt.data +"档失败了！";
			trace(tmpStr);
			this.dispatchEvent(new ServerEvent("netGetError", tmpStr, false));
		}
		
		private function multipleErrorHandler(evt:Event) : void
		{
			var tmpStr:String = "游戏多开了！";
			trace(tmpStr);
			this.dispatchEvent(new ServerEvent("multipleError", tmpStr, false));
		}
		
		private function getStoreStateHandler(evt:DataEvent) : void
		{
			//0:多开了，1：没多开，-1：请求数据出错了，-2：没添加存档API的key，-3：未登录不能取状态
			trace(evt.data);		
			this.dispatchEvent(new ServerEvent("StoreStateEvent", evt.data, false));
			//getMultiple(evt.data);
		}
		
		
		private function getMultiple(e:String) : void
		{
			if(e == "1")  shopCallBack();
			else View.instance.tip.interfaces(InterfaceTypes.Show, 
				"游戏多开了，无法保存游戏存档，请关闭该页面！", 
				null,
				null, 
				true);
		}
		
		/**
		 * 读档参数类型：
		 * @param   ui      是否打开读档UI  默认为 true （类型：Boolean）
		 * @param   index   如果不开启UI，指定读档的位置（0-7）默认为0(类型:int)
		 */
		public function getData(ui:Boolean, index:int) : void
		{
			serviceHold.getData(ui,index);
			//读取存档列表操作完成 stage发出 "getuserdatalist"事件
		}
		
		/**
		* 存档参数类型：
		* @param   title   存档标题(类型为String)
		* @param   data    存档数据（类型 Object,Array,String,Number,XML）
		*                  Object,Array类型只能由String,Number,Array,Object 三种组合
		* @param   ui      是否打开存档UI  默认为 true(类型：Boolean)
		* @param   index   如果不开启UI，指定存档的位置（0-7）默认为0 (类型: int)
		*/
		public function saveData(title:String, data:*, ui:Boolean, index:int) : void
		{
			Log.Trace("saveData");
			serviceHold.saveData(title,data,ui,index);
			return;
			if (DebugManager.instance.gameMode == V.RELEASE)
			{
				Log.Trace("saveData");
				serviceHold.saveData(title,data,ui,index);
				//存档操作完成 stage发出 "saveuserdata"事件
			}
			else
			{
				this.dispatchEvent(new ServerEvent("saveuserdata", {}, true));
			}
		}
		
		/**
		 *  读取存档列表
		 * 
		 */		
		public function getList() : void
		{
			Log.Trace("getList");
			
			serviceHold.getList(); 
			return;
			
			if (DebugManager.instance.gameMode == V.RELEASE)
			{
				serviceHold.getList(); 
				//读取存档列表操作完成 stage发出 "getuserdatalist"事件
			}
			else
			{
				this.dispatchEvent(new ServerEvent("getuserdatalist", [], true));
			}
		}
		
		/**
		* 开启存读档UI（可以保存，又可以读取）
		* @param   title   存档标题
		* @param   data    存档数据（类型 Object,Array,String,Number,XML）
		*                  Object,Array类型只能由： String,Number,Array,Object 三种组合
		*/
		public function openSaveUI(title:String, data:Object) : void
		{
			serviceHold.openSaveUI(title,data);
			//玩家选择存档操作 stage发出 "saveuserdata"事件
			//玩家选择读档操作 stage发出 "getuserdata"事件
		}
		
		private var shopCallBack:Function;
		/**
		 * 获取游戏是否多开的状态 
		 * 
		 */		
		public function getStoreState() : void
		{
			serviceHold.getStoreState(); 
			//获取状态操作完成 stage发出 "StoreStateEvent"事件
		}
		
		/**
		 * 退出游戏 
		 * 
		 */
		public function quitGame() : void
		{
			Log.Trace("server quitGame");
			serviceHold.userLogOut();
		}
	}
}
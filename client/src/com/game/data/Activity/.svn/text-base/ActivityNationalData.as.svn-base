package com.game.data.Activity
{
	import com.adobe.crypto.MD5;
	import com.game.Data;
	import com.game.View;
	import com.game.data.Base;
	import com.game.manager.DebugManager;
	import com.game.template.V;
	
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class ActivityNationalData extends Base
	{
		private static const URLNAME:String = "http://huodong.4399.com/2013/huanqiu/api.php?";
		private var _view:View = View.instance;
		private var _successFun:Function;
		public function set successFun(value:Function) : void
		{
			_successFun = value;
		}
		private var _resetFun:Function;
		public function set resetFun(value:Function) : void
		{
			_resetFun = value;
		}
		
		public function ActivityNationalData()
		{
			initURL();
		}
		
		private var _urlLoader:URLLoader;
		private function initURL() : void
		{
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			_urlLoader.addEventListener(flash.events.Event.COMPLETE, urlCompleteHandler);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, urlErrorHandler);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, urlErrorHandler);
		}
		
		private function urlCompleteHandler(e:flash.events.Event) : void
		{
			if(_resetFun != null) _resetFun();
			switch(e.target.data)
			{
				//传递的参数不完整
				case "006":
					_view.prompEffect.play("传递的参数不完整！");
					break;
				//激活码格式不正确
				case "005":
					_view.prompEffect.play("激活码格式不正确！");
					break;
				//没有登录游戏
				case "004":
					_view.prompEffect.play("没有登录游戏！");
					break;
				//没有领取激活码
				case "003":
					_view.prompEffect.play("没有领取激活码！");
					break;
				//激活码输入有误
				case "002":
					_view.prompEffect.play("激活码输入有误！");
					break;
				//激活成功
				case "1":
					_successFun();
					break;
				default:
					_view.prompEffect.play("激活失败！");
					break;
			}
		}
		
		/**
		 * 加载异常
		 * @param e
		 * 
		 */		
		private function urlErrorHandler(e:IOErrorEvent) : void
		{
			_view.prompEffect.play("网络异常，请重新输入激活码！");
			if(_resetFun != null) _resetFun();
		}
		
		/**
		 * url数据发送
		 * 
		 */		
		public function urlData(activityStr:String) : void
		{
			var str:String = "code=" + activityStr + "&gametype=4&uid=" + Data.instance.pay.userID;
			var urlRequest:URLRequest = new URLRequest(URLNAME + str);
			urlRequest.method = URLRequestMethod.POST;
			
			_urlLoader.load(urlRequest);
		}
	}
}
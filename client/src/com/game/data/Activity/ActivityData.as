package com.game.data.Activity
{
	import com.adobe.crypto.MD5;
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

	public class ActivityData extends Base
	{
		private static const KEYS:String = "0228acacd1c0ad3470a72e5f4e3847c3";
		private static const URLNAME:String = "http://my.4399.com/jifen/activation?";
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
		
		public function ActivityData()
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
			var checkList:Array = new Array();
			checkList = dataAnalysis(e.target.data);
			trace(checkList[0], checkList[1]);
			switch(checkList[0])
			{
				//未知错误
				case "99":
					_view.prompEffect.play("激活失败！");
					break;
				//激活成功
				case "100":
					if(_successFun != null) _successFun(checkList[1]);
					break;
				//参数错误
				case "101":
					_view.prompEffect.play("激活失败！");
					break;
				//激活码不存在
				case "102":
					_view.prompEffect.play("激活码不存在！");
					break;
				//激活码还没被兑换
				case "103":
					_view.prompEffect.play("激活码还没被兑换！");
					break;
				//激活码被使用过了哦
				case "104":
					_view.prompEffect.play("激活码被使用过了哦！");
					break;
				//激活码只能被领取者使用
				case "105":
					_view.prompEffect.play("激活码只能被领取者使用！");
					break;
				//您的账号已经使用此礼包的激活码，不能再使用咯~
				case "106":
					_view.prompEffect.play("您的账号已经使用此礼包的激活码，不能再使用咯！");
					break;
				//token无效
				case "107":
					//_view.prompEffect.play("token无效！");
					_view.prompEffect.play("激活失败！");
					break;
				//激活码失效了
				case "108":
					_view.prompEffect.play("激活码失效了！");
					break;
				//激活失败
				case "109":
					_view.prompEffect.play("激活失败！");
					break;
				//您的账号已经今天使用过激活码，不能再使用咯~
				case "110":
					_view.prompEffect.play("您的账号已经今天使用过激活码，不能再使用咯~！");
					break;
				default:
					_view.prompEffect.play("激活失败！");
					break;
			}
			if(DebugManager.instance.gameMode == V.DEVELOP)
			{
				_data.pack.addNoneProp(42, 1);
			}
		}
		
		/**
		 * 分析从网页返回的数据
		 * @param str
		 * @return 
		 * 
		 */		
		private function dataAnalysis(str:String) : Array
		{
			var lastList:Array = new Array();
			var newStr:String = str.slice(1, str.length - 1);
			var arrList:Array = newStr.split(","); 
			for(var i:int = 0; i < arrList.length; i++)
			{
				var newList:Array = arrList[i].split(":");
				lastList[i] = newList[1];
			}
			lastList[1] = String(lastList[1]).slice(1, String(lastList[1]).length - 1);
			return lastList;
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
			var gameID:int = _data.pay.gameID;
			var userID:int = _data.pay.userID;
			
			var urlVariables:URLVariables = new URLVariables();
			urlVariables.uniqueId = gameID;
			urlVariables.activation = activityStr;
			urlVariables.uid = userID;
			var token:String = MD5.hash(urlVariables.activation + "-" + urlVariables.uid + "-" + urlVariables.uniqueId + "-" + KEYS);
			urlVariables.token = token;
			
			var urlRequest:URLRequest = new URLRequest(URLNAME + Math.random());
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = urlVariables;
			
			_urlLoader.load(urlRequest);
		}
	}
}
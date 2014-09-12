package com.game.manager
{
	import com.game.template.V;

	public class URIManager
	{
		// 首页地址
		private static var _index : String;
		public static function get index () : String
		{
			return _index;
		}
		
		// 资源地址
		private static var _assetsUrl : String;
		public static function get assetsUrl () : String
		{
			return _assetsUrl;
		}
		
		// 平台时间
		private static var _timeURL:String;
		public static function get timeURL() : String
		{
			return _timeURL;
		}
		
		// 论坛地址
		private static var _forumURL:String;
		public static function get forumURL() : String
		{
			return _forumURL;
		}
		
		// 反馈地址
		private static var _bugURL:String;
		public static function get bugURL() : String
		{
			return _bugURL;
		}
		
		// 主站中秋活动
		private static var _midAutumnURL:String;
		public static function get midAutumnURL() : String
		{
			return _midAutumnURL;
		}
		
		private static var _scoreURL:String
		public static function get scoreURL() : String
		{
			return _scoreURL;
		}
		private static var _nationalURL:String
		public static function get nationalURL() : String
		{
			return _nationalURL;
		}
		
		private static var _integrationURL:String;
		
		private static var _tanabataURL:String;
		
		private static var _dataURL:String;
		
		public function URIManager(s : Singleton) {}
		
		// 解析地址
		public static function analyze () : void
		{
			var client:String = '';
			if (DebugManager.instance.gameMode == V.DEVELOP)
			{
				client = "";
				//client = "http://192.168.54.223/zmld/trunk/src/";
				//client = "http://192.168.54.223/webgame/";
				//client = "http://127.0.0.1/webgame/";
				//client = "http://127.0.0.1/zmld/src/";
				//client = "http://192.168.54.223/zmld/trunk/doc/webgame/";
				//client = "http://www.4399api.com/system/attachment/100/02/27/100022759/";
				//client = "http://www.4399api.com/system/attachment/100/02/30/100023042/";
			}
			else
			{
				//client = "http://www.4399api.com/system/attachment/100/02/27/100022759/";
				//client = "http://www.4399api.com/system/attachment/100/02/30/100023042/";
			}
			
			_assetsUrl   = client + 'assets/';
			
			_timeURL = "http://save.api.4399.com/?ac=get_time";
			_forumURL = "http://my.4399.com/forums-mtag-tagid-81862.html";
			_bugURL = "http://my.4399.com/forums-thread-tagid-81862-id-33551128.html";
			_integrationURL = "http://my.4399.com/jifen/yx-zmjh";
			_tanabataURL = "http://my.4399.com/forums-thread-tagid-81862-id-36402647.html";
			_dataURL = "http://app.my.4399.com/r.php?app=feedback";
			_midAutumnURL = "http://huodong.4399.com/2013/zhongqiu/";
			_scoreURL = "http://my.4399.com/forums-thread-tagid-81862-id-37202401.html";
			_nationalURL = "http://huodong.4399.com/2013/huanqiu/";
		}
		
		public static function openForumURL() : void
		{
			SendURL.sendURL(_forumURL);
		}
		
		public static function openDebugURL() : void
		{
			SendURL.sendURL(_bugURL);
		}
		
		public static function openIntegrationURL() : void
		{
			SendURL.sendURL(_integrationURL);
		}
		
		public static function openTanabataURL() : void
		{
			SendURL.sendURL(_tanabataURL);
		}
		
		public static function openDataURL() : void
		{
			SendURL.sendURL(_dataURL);
		}
		
		public static function openMidAutumnURL() : void
		{
			SendURL.sendURL(_midAutumnURL);
		}
		
		public static function openScoreURL() : void
		{
			SendURL.sendURL(_scoreURL);
		}
		
		public static function openNationURL() : void
		{
			SendURL.sendURL(_nationalURL);
		}
	}
}

class Singleton {}
package com.game.manager
{
	import com.engine.core.Log;
	
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class SendURL
	{
		public function SendURL()
		{
		}
		
		public static function sendURL(url:String) : void
		{
			var broswer:String = ExternalInterface.call("function getBrowser(){return navigator.userAgent}") as String;
			Log.Trace(broswer);
			if (broswer && (broswer.indexOf("Firefox") != -1 || broswer.indexOf("MSIE") != -1)){
				Log.Trace("window");
				ExternalInterface.call('window.open("' + url + '","_blank")');
			}else{
				navigateToURL(new URLRequest(url), "_blank");
				Log.Trace("url");
			}
		}
	}
}
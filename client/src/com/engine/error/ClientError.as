package com.engine.error
{
	import com.engine.core.Log;
	
	import flash.events.ErrorEvent;
	import flash.events.UncaughtErrorEvent;

	public class ClientError
	{
		public function ClientError()
		{
		}
		
		/**
		 * 未捕获的错误 
		 * @param e
		 * 
		 */		
		public static function OnUncaughtError(e:UncaughtErrorEvent) : void
		{
			var reason:String;
			var error:Error;
			var info:String;
			var errorEvent:ErrorEvent;
			if (e.error is Error)
			{
				error = e.error as Error;
				reason = "未捕获[" + error.errorID + "]:" + error.name + " : " + error.message;
				info = error.getStackTrace();
			}
			else if (e.error is ErrorEvent)
			{
				errorEvent = e.error as ErrorEvent;
				reason = "未捕获[" + errorEvent.errorID + "] : " + errorEvent.text;
				info = null;
			}
			else
			{
				reason = "未捕获: " + e.error.toString();
				info = null;
			}
			
			Log.Error(reason, info);
			
			if (info)
			{
				reason = reason + "\n" + info;
			}
			
			reason = "当前客户端发生一个错误。请刷新浏览器！\n" + reason;
			
			showAlert(reason);
		}
		
		private static function showAlert(info:String) : void
		{
			Log.Trace(info);
		}
	}
}
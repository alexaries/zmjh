package com.engine.core
{
	import com.engine.utils.Utilities;
	import com.game.manager.DebugManager;
	import com.game.manager.ResCacheManager;
	
	import flash.utils.*;
	
	import mx.resources.ResourceManager;
	
	public class Log extends Object
	{
		public static const TRACE:int = 0;
		public static const DEBUG:int = 1;
		public static const INFO:int = 2;
		public static const WARNING:int = 3;
		public static const ERROR:int = 4;
		public static const NUM_LEVELS:int = 5;
		
		private static var s_logLevel:int = 0;
		private static var s_listeners:Vector.<Function> = new Vector.<Function>;
		private static var s_listenerLevels:Vector.<int> = new Vector.<int>;
		private static var s_limiter:Object = new Object();
		private static const s_levelStrings:Array = ["TRACE", "DEBUG", "INFO", "WARN", "ERROR"];
		
		public static function init() : void
		{
			for (var i:int = 0; i < NUM_LEVELS; i++)
			{
				AddListener(DebugManager.instance.debugOutput, i);
			}
		}
		
		public static function AddListener(listener:Function, level:int) : void
		{
			s_listeners.push(listener);
			s_listenerLevels.push(level);
		}
		
		public static function SetLevel(fun:Function, level:int) : void
		{
			var index:int = s_listeners.indexOf(fun);
			s_listenerLevels[index] = level;
		}
		
		public static function GetLevel(fun:Function) : int
		{
			var index:int = s_listeners.indexOf(fun);
			return s_listenerLevels[index];
		}
		
		public static function GetLevelString(index:int) : String
		{
			return s_levelStrings[index];
		}
		
		public static function Error(key:String, stack:String = null,  bol:Boolean = false) : void
		{
			if (s_limiter[key] != null)
			{
				return;
			}
			s_limiter[key] = true;
			if (stack == null)
			{
				stack = CallStack.GetStack();
				if (stack != null)
				{
					stack = CallStack.RemoveTopFunction(stack);
				}
			}
			
			InternalReport(ERROR, key, stack, bol);
		}
		
		public static function Trace(info:String) : void
		{
			InternalReport(TRACE, info);
		}
		
		public static function Warning(key:String, stack:String = null, bol:Boolean = false) : void
		{
			if (s_limiter[key] != null)
			{
				return;
			}
			
			s_limiter[key] = true;
			
			if (stack == null)
			{
				stack = CallStack.GetStack();
				if (stack != null)
				{
					stack = CallStack.RemoveTopFunction(stack);
				}
			}
			
			InternalReport(WARNING, key, stack, bol);
		}
		
		public static function Info(key:String, bol:Boolean = false) : void
		{
			InternalReport(INFO, key, null, bol);
		}
		
		public static function Debug(key:String) : void
		{
			InternalReport(DEBUG, key);
		}
		
		private static function InternalReport(error:int, key:String, stack:String=null, bol:Boolean=false) : void
		{
			var fun:Function;
			var level:int;
			var time:String = Utilities.ConvertToReadableTime(getTimer());
			
			var i:int;
			while (i < s_listeners.length)
			{
				fun = s_listeners[i];
				level = s_listenerLevels[i];
				if (error >= level)
				{
					fun(formatOutput(error, key, time));
				}
				
				i++;
			}
		}
		
		private static function formatOutput(error:int, key:String, time:String) : String
		{
			var result:String = '';
			
			var type:String = s_levelStrings[error];
			result += type + ': ';		
			result += "verison:" + ResCacheManager.instance.onVersion() + "--消息：" + key;
			
			return result;
		}
	}
}

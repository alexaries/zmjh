package com.engine.core
{
	
	public class CallStack
	{
		
		public function CallStack()
		{
		}
		
		public static function GetStack() : String
		{
			var error:Error = new Error();
			var stack:String = error.getStackTrace();
			if (stack != null)
			{
				stack = ReformatStack(stack);
				stack = RemoveTopFunction(stack);
				return stack;
			}
			
			return null;
		}
		
		public static function RemoveTopFunction(stack:String) : String
		{
			var str:Array = stack.split("\n");
			str.shift();
			
			return str.join("\n");
		}
		
		public static function ReformatStack(info:String) : String
		{
			var index:String = null;
			
			if (!info) { return info;}
			
			var arr:Array = info.split(/ |\	t|\$|::|\/|\[|\]|\n"" |\t|\$|::|\/|\[|\]|\n/);
			var str:String = "";
			while (arr.length > 0)
			{
				while (arr.length > 0)
				{	
					if (arr[0] == "at") break;
					arr.shift();
				}
				
				if (arr.length > 0)
				{
					str = str + "\tat ";
					arr.shift();
				}
				
				while (arr.length > 0 && arr[0] == "")
				{
					arr.shift();
				}
				
				if (arr.length > 0)
				{
					str = str + arr.shift();
				}
				
				while (arr.length > 0 && arr[0] == "")
				{
					arr.shift();
				}
				
				if (arr.length > 0)
				{
					if (arr[0].indexOf("(") == -1)
					{
						str = str + "." + arr.shift();
					}
				}
				
				while (arr.length > 0 && arr[0] == "")
				{
					
					arr.shift();
				}
				
				if (arr.length > 0)
				{
					str = str + "." + arr.shift();
				}
				
				while (arr.length > 0 && arr[0] == "")
				{
					arr.shift();
				}
				
				if (arr.length > 0 && arr[0] != "at")
				{
					index = arr.shift();
					var i:int = 0;
					var j:int = 0;
					var k:int = 0;
					i = index.lastIndexOf("\\");
					j = index.lastIndexOf("/");
					k = i > j ? i : j;
					index = index.substr(k + 1);
					str = str + (" [" + index + "]");
				}
				
				if (arr.length > 0)
				{
					str = str + "\n";
				}
			}
			
			return str;
		}
	}
}
package com.game
{
	public class Lang extends SuperBase
	{
		public var lang : String = 'zh-CN';
		
		
		protected function createObject (C:Class, path:String) : Object
		{
			var modelname:String = C + "";
			modelname = path.replace(/View\]/, "").replace(/^\[class /, "").toLowerCase();
			
			if (this[modelname] == null)
			{
				this[modelname] = new C;
			}
			
			return this[modelname]; 
		}
	}
}
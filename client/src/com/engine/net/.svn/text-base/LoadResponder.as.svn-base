package com.engine.net
{
	public class LoadResponder
	{
		public var callback : Function;
		public var progress : Function;
		
		public function LoadResponder(callback : Function = null, progress : Function = null)
		{
			this.callback = callback;
			this.progress = progress;
		}
		
		public function lCallback () : void
		{
			callback();
		}
		
		public function lProgress (name : String, percent : int) : void
		{
			if (null != this['progress'])
			{
				progress(name, percent);
			}
		}
	}
}
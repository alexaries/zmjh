package com.game
{
	import flash.utils.getQualifiedClassName;
	
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	
	public class SuperSubBase extends EventDispatcher
	{
		public function get sign() : String
		{
			return getQualifiedClassName(this);
		}
		
		public function settle(instanceName:String, s:SuperBase) : void {};
	}
}
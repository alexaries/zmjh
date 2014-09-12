package com.engine.net
{
	import flash.events.Event;

	public class RankEvent extends Event
	{
		private var _targetData:*;
		
		public function RankEvent(type:String, dataOb:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_targetData = dataOb;
		}
		
		public function get data():Object{
			return _targetData;
		}
		
		override public function clone():Event{
			return new RankEvent(type, data, bubbles, cancelable);
		}
	}
}
package com.game
{
	import flash.utils.Dictionary;
	
	import starling.events.Event;

	public class SuperBase
	{
		private var _modelList:Dictionary = new Dictionary();
		public function get modelList() : Dictionary
		{
			return _modelList;
		}
		
		protected function createObjectBase(C:Class, instanceName:String) : Object
		{
			var instance:* = _modelList[instanceName];
			
			if (null == instance)
			{
				var Base : SuperSubBase  = new C();
				Base.settle(instanceName, this);
				
				_modelList[instanceName] = Base;
			}
			
			return _modelList[instanceName];
		}
		
		public function destroyObject(instanceName:String) : void
		{
			delete _modelList[instanceName];
		}
		
		private var _timeProcessList:Object = {};		
		public function addToTimeProcessList(sign:String, routine:Function) : void
		{
			_timeProcessList[sign] = routine; 
		}		
		public function removeFromTimeProcessList(sign:String) : void
		{
			delete _timeProcessList[sign];
		}
		
		public function timeProcess() : void
		{
			for (var sign:String in _timeProcessList)
			{
				_timeProcessList[sign]();
			}
		}
		
		private var _frameProcessList:Object = {};
		public function addToFrameProcessList(sign:String, routine:Function) : void
		{
			_frameProcessList[sign] = routine;
		}
		public function removeFromFrameProcessList(sign:String) : void
		{
			delete _frameProcessList[sign];
		}
		
		public function frameProcess() : void
		{
			for (var sign:String in _frameProcessList)
			{
				_frameProcessList[sign]();
			}
		}
		
		public function SuperBase()
		{
			
		}
	}
}
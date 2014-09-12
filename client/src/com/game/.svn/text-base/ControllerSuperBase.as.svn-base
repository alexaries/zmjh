package com.game
{
	public class ControllerSuperBase extends SuperBase
	{
		protected var _data:Data;
		public function get data() : Data
		{
			return _data;
		}
		
		protected var _view:View;
		public function get view() : View
		{
			return _view;
		}
		
		protected var _lang:Lang;
		public function get lang() : Lang
		{
			return _lang;
		}
		
		protected function createObject (C:Class) : Object
		{
			var instanceName:String = (C as Class).toString();
			instanceName = instanceName.replace(/Controller\]/, "").replace(/^\[class /, "").toLowerCase();
			return createObjectBase(C, instanceName);
		}
		
		public function ControllerSuperBase()
		{
			super();
		}
	}
}
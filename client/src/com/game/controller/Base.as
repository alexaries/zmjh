package com.game.controller
{
	import com.game.Controller;
	import com.game.SuperBase;
	import com.game.SuperSubBase;

	public class Base extends SuperSubBase
	{
		protected var _instanceName:String;
		protected var _controller:Controller;
		
		public function Base()
		{
		}
		
		override public function settle(instanceName:String, s:SuperBase):void
		{
			if (null == _controller)
			{
				_instanceName = instanceName;
				_controller = s as Controller;
			}
		}
		
		public function destroy() : void
		{
			_controller.destroyObject(_instanceName);
		}
	}
}
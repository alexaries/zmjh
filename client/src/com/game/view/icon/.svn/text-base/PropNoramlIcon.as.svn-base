package com.game.view.icon
{
	import com.game.view.equip.PropTip;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class PropNoramlIcon
	{
		private var _mssage:Object;
		private var _disp:DisplayObject;
		private var _propTip:PropTip;
		public function PropNoramlIcon(obj:Object,propTip:PropTip)
		{
			this._propTip=propTip;
			_mssage=obj.m;
			_disp=(obj.o);
			_disp.addEventListener(TouchEvent.TOUCH,onDispTouch);
		}
		
		private function onDispTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_disp);
			 
				if (touch&&touch.phase==TouchPhase.HOVER) 
				{
					 
					this._propTip.setData2(_mssage);
					this._propTip.x = touch.globalX+20;
					this._propTip.y = touch.globalY + 20;
					Starling.current.stage.addChild(this._propTip);
				}else 
				{
					this._propTip.hide(); 
				}
		}
	}
}
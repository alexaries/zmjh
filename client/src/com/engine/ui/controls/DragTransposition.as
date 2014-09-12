package com.engine.ui.controls
{
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class DragTransposition extends EventDispatcher
	{
		public static const TRANSPOSITION:String = "drag_transposition";
		
		private var _sourceItem:Array;
		
		public function DragTransposition(sourceItem:Array)
		{
			_sourceItem = sourceItem;
			
			initEvent();
		}
		
		public function addItem(item:DisplayObject) : void
		{
			if (search(item.name) == -1)
			{
				_sourceItem.push(item);
			}
		}
		
		public function search(name:String) : int
		{
			var index:int = -1;
			
			for (var i:int = 0, len:int = _sourceItem.length; i < len; i++)
			{
				if (_sourceItem[i].name == name)
				{
					index = i;
					break;
				}
			}
			
			return index;
		}
		
		protected function initEvent() : void
		{
			for each(var item:DisplayObject in _sourceItem)
			{
				item.addEventListener(TouchEvent.TOUCH, onTouch);
			}
		}
		
		private var startX:int;
		private var startY:int;
		private var sPoint:Point;
		private var movePoint:Point;
		private function onTouch(e:TouchEvent) : void
		{
			var target:DisplayObject = e.currentTarget as DisplayObject;
			var touch:Touch = e.getTouch(target);
			
			if (!sPoint) sPoint = new Point();
			
			if (!touch)
			{
				return;
			}
			
			switch (touch.phase)
			{
				case TouchPhase.BEGAN:
					movePoint = touch.getLocation(target.parent);
					startX = target.x;
					startY = target.y;
					sPoint = new Point(startX - movePoint.x, startY - movePoint.y);
					break;
				case TouchPhase.MOVED:
					movePoint = touch.getLocation(target.parent);
					target.x = movePoint.x + sPoint.x;
					target.y = movePoint.y + sPoint.y;
					break;
				case TouchPhase.ENDED:
					checkStatus(target);
					break;
			}
		}
		
		private function checkStatus(target:DisplayObject) : void
		{
			var index:int = -1;
			var item:DisplayObject;
			for (var i:int = 0; i < _sourceItem.length; i++)
			{
				item = _sourceItem[i];
				
				if (item.name == target.name) continue;
				
				var bol:Boolean = hitTest(item, target);
				
				if (bol)
				{
					index = i;
					break;
				}
			}
			
			resetImage(target);
			
			var sIndex:int = getIndex(target.name);
			
			if (index != -1) this.dispatchEventWith(TRANSPOSITION, false, {"sIndex":sIndex, "tIndex":index});
		}
		
		private function resetImage(target:DisplayObject) : void
		{
			target.x = startX;
			target.y = startY;
		}
		
		protected function hitTest(sItem:DisplayObject, TarItem:DisplayObject) : Boolean
		{
			var bol:Boolean;
			
			var dis:int = getDis(sItem, TarItem);
			var minLen:int = getNorm(sItem, TarItem);
			bol = (dis <= minLen);
			
			return bol;
		}
		
		protected function getNorm(sItem:DisplayObject, TarItem:DisplayObject) : int
		{
			var X:int = (TarItem.width + sItem.width)/2;
			var Y:int = (TarItem.height + sItem.height)/2;
			
			var dis:int = Math.sqrt(X*X + Y*Y);
			
			return dis;
		}
		
		protected function getDis(sItem:DisplayObject, TarItem:DisplayObject) : int
		{
			var sPoint:Point = sItem.parent.localToGlobal(new Point(sItem.x, sItem.y));
			var tPoint:Point = TarItem.parent.localToGlobal(new Point(TarItem.x, TarItem.y));
			
			var offX:int = sPoint.x - tPoint.x;
			var offY:int = sPoint.y - tPoint.y;
			var dis:int = Math.sqrt(offX*offX + offY*offY);
			return dis;
		}
		
		protected function getIndex(tname:String) : int
		{
			var index:int = -1;
			var item:DisplayObject;
			for (var i:int = 0; i < _sourceItem.length; i++)
			{
				item = _sourceItem[i];
				
				if (item.name == tname)
				{
					index = i;
					break;
				}
			}
			
			if (index == -1) throw new Error("Drag 没找到相关");
			
			return index;
		}
	}
}
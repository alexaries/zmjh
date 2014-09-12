package com.engine.ui.controls
{
	import com.game.template.V;
	
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class DragOut extends EventDispatcher
	{
		public static const DRAG_OUT:String = "drag_out";
		public static const PUT_TOWER:String = "put_tower";
		
		private var _sourceItem:Array;
		
		public function DragOut(sourceItem:Array)
		{
			_sourceItem = sourceItem;
			
			initEvent();
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
					//putTower(target)
					checkStatus(target);
					break;
			}
		}
		
		private function putTower(target:DisplayObject) : void{
			this.dispatchEventWith(PUT_TOWER, false, target);
			target.x=startX;
			target.y=startY;
		}
		
		private function checkStatus(target:DisplayObject) : void
		{
			var index:int = -1;
			var item:DisplayObject;
			var bol:Boolean;
			for (var i:int = 0; i < _sourceItem.length; i++)
			{
				item = _sourceItem[i];
				
				if (item["newData"] && item["newData"]["name"] == target["newData"]["name"]) continue;
				
				bol = hitTest(item, target);
				
				if (bol)
				{
					index = i;
					break;
				}
			}			
			
			if (index != -1)
			{
				resetImage(target);
				var sIndex:int = getIndex(target["newData"]["name"]);			
				this.dispatchEventWith(DragTransposition.TRANSPOSITION, false, {"sIndex":sIndex, "tIndex":index});
			}
			else
			{
				checkDragOutStatus(target);
			}
		}
		
		
		/*********************************是否交换***********************************/
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
		
		/**************************是否移出******************************/
		private function checkDragOutStatus(target:DisplayObject) : void
		{
			var bol:Boolean = hitDragOutTest(target);
			resetImage(target);
			
			if (bol)
			{
				 this.dispatchEventWith(DRAG_OUT, false, [target["newData"]["name"], target["newData"]["position"]]);
			}
		}
		
		protected function hitDragOutTest(sItem:DisplayObject) : Boolean
		{
			var bol:Boolean;
			
			if (sItem["newData"]["name"] == V.MAIN_ROLE_NAME) return false;
			
			var dis:int = getDragOutDis(sItem);
			var minLen:int = getDragOutNorm(sItem);
			bol = (dis > minLen);
			
			return bol;
		}
		
		protected function getDragOutNorm(sItem:DisplayObject) : int
		{
			var X:int = sItem.width;
			var Y:int = sItem.height;
			
			var dis:int = Math.sqrt(X*X + Y*Y);
			
			return dis;
		}
		
		protected function getDragOutDis(sItem:DisplayObject) : int
		{
			var sPoint:Point = sItem.parent.localToGlobal(new Point(sItem.x, sItem.y));
			var tPoint:Point = sItem.parent.localToGlobal(new Point(startX,startY));
			
			var offX:int = sPoint.x - tPoint.x;
			var offY:int = sPoint.y - tPoint.y;
			var dis:int = Math.sqrt(offX*offX + offY*offY);
			return dis;
		}
		
		/********************************公用********************************/
		private function resetImage(target:DisplayObject) : void
		{
			target.x = startX;
			target.y = startY;
		}
		
		protected function getIndex(tname:String) : int
		{
			var index:int = -1;
			var item:DisplayObject;
			for (var i:int = 0; i < _sourceItem.length; i++)
			{
				item = _sourceItem[i];
				
				if (item["newData"] && item["newData"]["name"] == tname)
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
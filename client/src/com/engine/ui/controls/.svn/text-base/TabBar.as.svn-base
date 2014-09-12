package com.engine.ui.controls
{
	import com.engine.ui.core.BaseSprite;
	import com.game.view.Component;
	import com.game.view.Role.RoleLabelComponent;
	
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class TabBar extends BaseSprite
	{
		public static const TYPE_SELECT_CHANGE:String = "select_index_change";
		public static const ROLE_SELECT_CHANGE:String = "role_select_change";
		
		
		private var _items:Array;
	    
		private var _selectIndex:int;
		public function set selectIndex(value:int) : void
		{
			//if (_selectIndex == value) return;
			
			_selectIndex = value;	
			setItemsStatus();
			this.dispatchEventWith(TabBar.TYPE_SELECT_CHANGE, false, _selectIndex);
		}
		
		protected function setItemsStatus() : void
		{
			var mc:*;
			for (var i:int = 0, len:int = _items.length; i < len; i++)
			{
				mc = _items[i];
				
				if (i != _selectIndex)
				{
					mc.currentFrame = 1;
					if (mc is Component) mc = mc.panel;
					mc.touchable = true;
				}
				else
				{
					mc.currentFrame = 0;
					if (mc is Component) mc = mc.panel;
					mc.touchable = false;
				}
			}
		}
		
		public function TabBar(items:Array)
		{
			_items = items;
			_selectIndex = -1;
			
			init();
		}
		
		private function init() : void
		{
			var mc:*;
			for (var i:int = 0, len:int = _items.length; i < len; i++)
			{
				mc = _items[i];
				if (mc is Component) mc = mc.panel;
				
				(mc as DisplayObject).useHandCursor = true;
				
				mc.mName = i.toString();
	
				mc.addEventListener(TouchEvent.TOUCH, onTouch);
			}
			
			if (_items[0] is DisplayObject)
			{
				this.x = (_items[0] as DisplayObject).x;
				this.y = (_items[0] as DisplayObject).y;
			}
			else if (_items[0] is Component)
			{
				this.x = (_items[0] as Component).panel.x;
				this.y = (_items[0] as Component).panel.y;
			}
		}
		
		private function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(e.currentTarget as DisplayObject);

			if (touch && touch.phase == TouchPhase.ENDED)
			{
				selectIndex = parseInt(e.currentTarget["mName"]);
			}
		}
		
		override public function destroy() : void
		{
			var mc:MovieClip;
			
			while(_items.length > 0) 
			{
				mc = _items.pop();
				mc.removeEventListeners();
				mc.dispose();
			}
			
			super.destroy();
		}
	}
}
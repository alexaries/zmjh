package com.game.view.effect
{
	import com.game.View;
	import com.game.template.GameConfig;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.toolbar.ToolBarView;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;

	public class FlyEffect
	{
		private var _tweenList:Vector.<Tween>;
		private var _viewNow:BaseView;
		public function set viewNow(value:BaseView) : void
		{
			_viewNow = value;
			analysis();
		}
		private var _startXML:XML;
		private var _endXML:XML;
		public function FlyEffect(startXML:XML, endXML:XML)
		{
			_startXML = startXML;
			_endXML = endXML;
		}
		
		public function analysis() : void
		{
			_tweenList = new Vector.<Tween>();
			for each(var end:XML in _endXML.item)
			{
				var count:int = 1;
				for each(var start:XML in _startXML.item)
				{
					count++;
					if (start.@name == end.@name)
					{
						var item:* = _viewNow.getObj(start.@name);
						if(item is Component) break;
						item.x = start.@x;
						item.y = start.@y;
						var t:Tween = new Tween(item, 1.5, Transitions.EASE_OUT_BOUNCE);
						t.animate("x", end.@x);
						t.animate("y", end.@y);
						t.onComplete = removeAll;
						t.onCompleteArgs = [t];
						//Starling.juggler.add(t);
						_tweenList.push(t);
						break;
					}
					if(count == _startXML.item.length())
					{
						var items:* = _viewNow.getObj(end.@name);
						if(items is Component) break;
						items.visible = true;
						items.x = int(GameConfig.CAMERA_WIDTH * .5);
						items.y = int(GameConfig.CAMERA_HEIGHT * .5 + items.height * .5 - 90);
						var tt:Tween = new Tween(items, 1.5, Transitions.EASE_OUT);
						tt.animate("x", end.@x);
						tt.animate("y", end.@y);
						tt.onComplete = removeAll;
						tt.onCompleteArgs = [tt];
						//Starling.juggler.add(tt);
						_tweenList.push(tt);
					}
				}
			} 
			
			//Starling.juggler.delayCall(starts, 3);
		}
		
		public function starts() : void
		{
			for each(var t:Tween in _tweenList)
			{
				Starling.juggler.add(t);
			}
		}
		
		private function removeAll(t:Tween) : void
		{
			Starling.juggler.remove(t);
			t = null;
		}
	}
}
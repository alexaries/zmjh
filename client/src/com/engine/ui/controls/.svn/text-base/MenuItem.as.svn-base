package com.engine.ui.controls
{
	import com.engine.ui.core.BaseSprite;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class MenuItem extends BaseSprite
	{
		public static const ITEM_SELECTED:String = "item_selected";
		
		public static const UP:String = "up";
		
		public static const DOWN:String = "down";
		
		private var _upTexture:Texture;
		
		private var _up:Image;
		
		private var _overTexture:Texture;
		
		private var _down:Image;
		
		private var _tf:TextField;
		
		public function MenuItem()
		{
			this.useHandCursor = true;
			
			initUI();
			initEvent();
		}
		
		private function initUI() : void
		{
			_upTexture = getTexture(35, 18, 0);
			_up = new Image(_upTexture);
			_up.alpha = 0;
			addChild(_up);
			
			_overTexture = getTexture(35, 18, 1, 0x4b4c4a);
			_down = new Image(_overTexture);
			_down.alpha = 1;
			addChild(_down);
			_down.visible = false;
			
			_tf = new TextField(35, 18, "");
			_tf.color = 0xffffff;
			addChild(_tf);
		}
		
		private var _type:String;
		public function initRender(name:String) : void
		{
			_tf.text = name;
			_type = name;
		}
		
		private function initEvent() : void
		{
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this);
			
			if (!touch)
			{
				_down.visible = false;
				return;
			}
			
			switch (touch.phase)
			{
				case TouchPhase.HOVER:
					_down.visible = true;
					break;
				case TouchPhase.ENDED:
					this.dispatchEventWith(ITEM_SELECTED, false, _type);
					break;
			}
		}
		
		public function setStatus(type:String) : void
		{
			switch (type)
			{
				case MenuItem.UP:
					_up.visible = true;
					_down.visible = false;
					break;
				case MenuItem.DOWN:
					_up.visible = false;
					_down.visible = true;
					break;
			}
		}
		
		
		private function getTexture(w:int, h:int, alpha:int = 1, color:uint = 0x000000) : Texture
		{
			var tx:Texture;
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(color, alpha);
			shape.graphics.drawRoundRect(0, 0, w, h, 8, 8);
			shape.graphics.endFill();
			
			var bitmapData:BitmapData = new BitmapData(w, h, true, 0xffffff);
			bitmapData.draw(shape);
			
			tx = Texture.fromBitmapData(bitmapData);
			
			return tx;
		}
	}
}
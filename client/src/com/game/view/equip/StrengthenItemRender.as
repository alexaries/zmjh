package com.game.view.equip
{
	import com.engine.ui.controls.IGrid;
	import com.game.View;
	import com.game.data.player.structure.EquipModel;
	import com.game.template.InterfaceTypes;
	import com.game.view.ui.UIConfig;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.GrayscaleFilter;
	import starling.textures.Texture;

	public class StrengthenItemRender extends Sprite implements IGrid
	{
		public var _equip:EquipModel;
		public var _isStrengthen:Boolean;
		private var _image:Image;
		private var _view:View = View.instance;
		
		public function StrengthenItemRender()
		{
			_isStrengthen = false;
			
			getUI();
		}
		private var _equipUI:EquipTip;
		private function getUI() : void
		{
			if (!_equipUI)
			{
				_equipUI = _view.ui.interfaces(UIConfig.GET_EQUIP_TIP);
			}
		}
		
		private var _newImage:Image;
		public function setData(equip:*) : void
		{
			if (!equip) return;
			
			_equip = equip;
			
			var skillFileName:String = "equip_" + _equip.id;
			var texture:Texture = _view.equip.interfaces(InterfaceTypes.GetTexture, skillFileName);
			
			if (!_image)	_image = new Image(texture);
			
			if(_image.parent == null)	addChild(_image);
			
			_image.width = _image.height = 42;
			_image.texture = texture;
			
			this.removeEventListener(TouchEvent.TOUCH, onTouch);
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			if(!_equip.isNew)
			{
				if(_newImage && _newImage.parent) _newImage.parent.removeChild(_newImage);
				return;
			}
			var newTexture:Texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "NewLabel");
			
			if(!_newImage)
			{
				_newImage = new Image(newTexture);
				_newImage.x = -3;
				_newImage.y = -5;
			}
			addChild(_newImage);
		}
		
		public function setNull() : void
		{
			if(_image != null && _image.parent != null)
			{
				_image.parent.removeChild(_image);
			}
		}
		
		private var startX:int;
		private var startY:int;
		private var sPoint:Point;
		private var movePoint:Point;
		protected function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this);
			
			var equipTipTouch:Touch = e.getTouch(_equipUI);
			
			// 划出
			if (!touch)
			{
				if (_equipUI && !equipTipTouch) _equipUI.hide();
				return;
			}
			
			switch (touch.phase)
			{
				case TouchPhase.ENDED:
					if (touch && touch.tapCount == 2 && touch.phase == TouchPhase.ENDED && !_isStrengthen)	addEquip();
					else	checkState();
					
					this.x = startX;
					this.y = startY;
					if (_equipUI) _equipUI.hide();
					break;
				case TouchPhase.HOVER: 
					if (!_equipUI.data || _equip) _equipUI.setData(_equip);
					this.parent.parent.addChild(_equipUI);
					
					_equipUI.x = touch.globalX - this.parent.parent.x + 10;
					_equipUI.y = touch.globalY - this.parent.parent.y + 10;
					break;
				case TouchPhase.BEGAN:
					this.parent.setChildIndex(this, this.parent.numChildren - 1);
					if (_equipUI) _equipUI.hide();
					movePoint = touch.getLocation(this.parent);
					startX = this.x;
					startY = this.y;
					sPoint = new Point(startX - movePoint.x, startY - movePoint.y);
					break;
				case TouchPhase.MOVED:
					movePoint = touch.getLocation(this.parent);
					this.x = movePoint.x + sPoint.x;
					this.y = movePoint.y + sPoint.y;
					break;
			}
		}
		
		private function checkState() : void
		{
			if(_isStrengthen)
			{
				if(this.x < 310)	View.instance.equip_strengthen.unStrengthen();
			}
			else
			{
				if(this.x > 350 && this.x < 433 && this.y > 10 && this.y < 93)	addEquip();
			}
		}
		
		private function addEquip() : void
		{
			View.instance.equip_strengthen.onSelectEquip(this);
		}
		
		public function addColorChange() : void
		{
			if(_newImage && _newImage.parent) _newImage.parent.removeChild(_newImage);
			this.filter = new GrayscaleFilter();
			this.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function addTouchEvent() : void
		{
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function removeTouchEvent() : void
		{
			this.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function clear() : void
		{			
			this.removeEventListeners();
			this.dispose();
		}
	}
}
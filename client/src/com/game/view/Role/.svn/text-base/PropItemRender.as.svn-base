package com.game.view.Role
{
	import com.engine.ui.controls.IGrid;
	import com.game.Data;
	import com.game.View;
	import com.game.data.player.structure.PropModel;
	import com.game.template.InterfaceTypes;
	import com.game.view.prop.PropsTip;
	import com.game.view.ui.UIConfig;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.VAlign;

	public class PropItemRender extends Sprite
	{
		private var _image:Image;
		private var _propsNumBg:Image;
		private var _propsTF:TextField;
		public var _props:PropModel;
		private var _view:View = View.instance;
		
		public function PropItemRender()
		{
			getUI();
		}
		
		private var _propsUI:PropsTip;
		private function getUI() : void
		{
			if (!_propsUI)
			{
				_propsUI = _view.ui.interfaces(UIConfig.GET_PROPS_TIP);
			}
		}
		
		private var _newImage:Image;
		public function setData(id:int, image:Image) : void
		{
			_props = Data.instance.player.player.pack.getPropById(id);
			_image = image;
		
			_image.removeEventListener(TouchEvent.TOUCH, onTouch);
			_image.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		protected function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_image);
			
			var equipTipTouch:Touch = e.getTouch(_propsUI);
			
			// 划出
			if (!touch)
			{
				if (_propsUI && !equipTipTouch) _propsUI.hide();
				return;
			}
			
			switch (touch.phase)
			{
				case TouchPhase.HOVER: 
					if (!_propsUI.data || _props) _propsUI.setData(_props);
					this.parent.parent.addChild(_propsUI);
					_propsUI.x = touch.globalX - this.parent.parent.x + 10;
					_propsUI.y = touch.globalY - this.parent.parent.y + 10;
					break;
			}
		}
		
		public function clear() : void
		{			
			this.removeEventListeners();
			this.dispose();
		}
	}
}
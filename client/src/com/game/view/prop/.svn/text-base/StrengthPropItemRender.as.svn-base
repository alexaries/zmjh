package com.game.view.prop
{
	import com.engine.ui.controls.IGrid;
	import com.engine.ui.controls.MenuItem;
	import com.engine.ui.controls.ShortCutMenu;
	import com.game.View;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.player.structure.PropModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.equip.EquipTip;
	import com.game.view.equip.PropTip;
	import com.game.view.ui.UIConfig;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.VAlign;
	
	public class StrengthPropItemRender extends Sprite implements IGrid
	{
		private var _image:Image;
		private var _propsNumBg:Image;
		private var _propsTF:TextField;
		public var _props:PropModel;
		private var _isProp:Boolean;
		public function get isProp() : Boolean
		{
			return _isProp;
		}
		public function set isProp(value:Boolean) : void
		{
			_isProp = value;
		}
		
		private var _view:View = View.instance;
		
		public function StrengthPropItemRender()
		{
			_isProp = false;
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
		public function setData(props:*) : void
		{
			if (!props) return;
			
			_props = props;
			
			var propsFileName:String = "props_" + _props.id;
			var texture:Texture = _view.props.interfaces(InterfaceTypes.GetTexture, propsFileName);
			
			if (!_image)
			{
				_image = new Image(texture);
				addChild(_image);
			}
			
			_image.width = _image.height = 42;
			_image.texture = texture;
			
			var bgTexture:Texture = _view.props.interfaces(InterfaceTypes.GetTexture, "LittleBg");
			if(!_propsNumBg)
			{
				_propsNumBg = new Image(bgTexture);
				addChild(_propsNumBg);
			}
			
			_propsNumBg.x = 25;
			_propsNumBg.y = 25;
			_propsNumBg.texture = bgTexture;
			
			if(!_propsTF)
			{
				_propsTF = new TextField(25, 20, "");
				_propsTF.color = 0xFFFFFF;
				_propsTF.vAlign = VAlign.CENTER;
				_propsTF.fontSize = 12;
				_propsTF.kerning = true;
				_propsTF.fontName = "宋体";
				addChild(_propsTF);
			}
			
			_propsTF.x = 22;
			_propsTF.y = 25;
			_propsTF.text = _props.num.toString();
			
			this.removeEventListener(TouchEvent.TOUCH, onTouch);
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			//如果道具可用，去除数量显示
			if(_props.config.type == 1 && _props.config.restrict == 1)
			{
				_propsNumBg.visible = false;
				_propsTF.visible = false;
			}
			
			//添加New标签
			if(!_props.isNew)
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
		
		protected function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this);
			
			//var menuTouch:Touch = e.getTouch(_shortCutMenu);
			var equipTipTouch:Touch = e.getTouch(_propsUI);
			
			// 划出
			if (!touch)
			{
				//if (_shortCutMenu &&　!menuTouch)　_shortCutMenu.hide();
				if (_propsUI && !equipTipTouch) _propsUI.hide();
				return;
			}
			
			switch (touch.phase)
			{
				case TouchPhase.ENDED:
					//if (touch && touch.tapCount == 2 && touch.phase == TouchPhase.ENDED && _isProp)	addProp();
					if (_propsUI) _propsUI.hide();
					break;
				case TouchPhase.HOVER: 
					//if (_shortCutMenu && _shortCutMenu.parent && _shortCutMenu.visible) return;
					
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
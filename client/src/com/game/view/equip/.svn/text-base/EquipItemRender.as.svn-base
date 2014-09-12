package com.game.view.equip
{
	import com.engine.ui.controls.IGrid;
	import com.engine.ui.controls.MenuItem;
	import com.engine.ui.controls.ShortCutMenu;
	import com.game.View;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.player.structure.EquipModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.ui.UIConfig;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class EquipItemRender extends Sprite implements IGrid
	{
		private var _image:Image;
		private var _equip:EquipModel;
		
		private var _view:View = View.instance;
		
		public static const EQUIPED_MENU:Array = ["卸下"];
		public static const PACK_MENU:Array = ["装备", "卖出"];
		
		public function EquipItemRender()
		{
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
			
			if (!_image)
			{
				_image = new Image(texture);
				addChild(_image);
			}
			
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
		
		protected function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this);
			
			var menuTouch:Touch = e.getTouch(_shortCutMenu);
			var equipTipTouch:Touch = e.getTouch(_equipUI);
			
			// 划出
			if (!touch)
			{
				if (_shortCutMenu &&　!menuTouch)　_shortCutMenu.hide();
				if (_equipUI && !equipTipTouch) _equipUI.hide();
				return;
			}
			
			switch (touch.phase)
			{
				case TouchPhase.ENDED:
					onClick();
					
					if (_equipUI) _equipUI.hide();
					break;
				case TouchPhase.HOVER: 
					if (_shortCutMenu && _shortCutMenu.parent && _shortCutMenu.visible) return;
					
					if (!_equipUI.data || _equip) _equipUI.setData(_equip);
					this.parent.parent.addChild(_equipUI);
					_equipUI.x = touch.globalX - this.parent.parent.x + 10;
					_equipUI.y = touch.globalY - this.parent.parent.y + 10;
					break;
			}
		}
		
		private var _shortCutMenu:ShortCutMenu;
		protected function onClick() : void
		{
			if (!_shortCutMenu) _shortCutMenu = _view.ui.interfaces(UIConfig.GET_SHORT_CUT_MENU);
			
			_shortCutMenu.show();
			this.parent.addChild(_shortCutMenu);
			_shortCutMenu.x = int(this.x + this.width/2);
			_shortCutMenu.y = int(this.y + this.height/2);
			
			var menu:Array = _equip.isEquiped ? EQUIPED_MENU : PACK_MENU;
			_shortCutMenu.setData(menu, V.EQUIP, _equip);
		}
		
		public function clear() : void
		{			
			this.removeEventListeners();
			this.dispose();
		}
	}
}
package com.engine.ui.controls
{
	import com.engine.ui.core.BaseSprite;
	import com.engine.ui.core.Scale9Image;
	import com.engine.ui.core.Scale9Textures;
	import com.game.View;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.textures.Texture;

	public class ShortCutMenu extends BaseSprite
	{
		public static const startX:int = 4;
		public static const startY:int = 4;		
		public static const offsetY:int = 20;
		
		private var _bg:Image;		
		private var _uiPool:Vector.<MenuItem>;
		private var _view:View = View.instance;
			
		public function ShortCutMenu()
		{
			_uiPool = new Vector.<MenuItem>();
		}
		
		private var _texture:Texture;
		public function init(bgTexture:Texture) : void
		{
			_texture = bgTexture;
			
			initUI();
		}
		
		private function initUI() : void
		{
			if (!_bg)
			{
				const textures:Scale9Textures = new Scale9Textures(_texture, new Rectangle(7, 6, 29, 36));
				_bg = new Image(_texture);
				_bg.width = 42;
				this.addChild(_bg);
			}
			
			initEvent();
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
				hide();
			}
		}
		
		private var _data:Array;
		private var _type:String;
		private var _itemData:*;
		public function setData(data:Array, type:String, itemData:*) : void
		{
			_data = data;
			_type = type;
			_itemData = itemData;
			
			checkData();
		}
		
		protected function checkData() : void
		{
			hideItems();
			
			var item:MenuItem;
			for (var i:int = 0, len:int = _data.length; i < len; i++)
			{
				item = getItem(i);
				item.initRender(_data[i]);
				item.visible = true;
			}
			
			_bg.height = startY + i * offsetY + 2;
		}
		
		protected function onItemSelected(e:Event) : void
		{
			// 技能
			if (_type== V.SKILL)
			{
				switch (e.data)
				{
					case "装备":
						_view.role.equipSkill(_itemData);
						break;
					case "卸下":
						_view.role.downSkill(_itemData);
						break;
				}
			}
			
			// 装备
			else if (_type == V.EQUIP)
			{
				switch (e.data)
				{
					case "装备":
						_view.role.equipEquipment(_itemData);
						break;
					case "卸下":
						_view.role.downEquipment(_itemData);
						break;
					case "卖出":
						onCheckEquipColor();
						break;
				}
			}
			//道具
			else if(_type == V.PROPS)
			{
				switch (e.data)
				{
					case "合成":
					case "使用":
						_view.role.useProps(_itemData);
						break;
					case "丢弃":
						break;
					case "装备":
					case "卸下":
						_view.role.useProps(_itemData);
						break;
					case "金钱":
						exChangeGold(_itemData);
						break;
					case "战魂":
						exChangeSoul(_itemData);
						break;
				}
			}
			
			hide();
		}
		
		private function exChangeSoul(prop:*):void
		{
			_view.vip_shop.interfaces(InterfaceTypes.GET_MALL, 2, prop);
		}
		
		private function exChangeGold(prop:*):void
		{
			_view.vip_shop.interfaces(InterfaceTypes.GET_MALL, 1, prop);
		}
		
		/**
		 * 装备为蓝装，提示是否出售
		 * 
		 */		
		private function onCheckEquipColor() : void
		{
			if(_itemData.config.color != "白" && _itemData.config.color != "绿")
			{
				_view.tip.interfaces(InterfaceTypes.Show, 
					"该装备为稀有装备，是否出售？", 
					function onSellEquipment() : void
					{
						_view.role.sellEquipment(_itemData);
					},
					null, false);
			}
			else
			{
				_view.role.sellEquipment(_itemData);
			}
			
		}
		
		protected function getItem(index:int) : MenuItem
		{
			var item:MenuItem;
			
			if (index >= _uiPool.length)
			{
				item = new MenuItem();
				item.x = startX;
				item.y = startY + index * offsetY;
				addChild(item);
				item.addEventListener(MenuItem.ITEM_SELECTED, onItemSelected);
				_uiPool.push(item);
			}
			
			item = _uiPool[index];
			
			return item;
		}
		
		protected function hideItems() : void
		{
			for each(var item:MenuItem in _uiPool)
			{
				item.visible = false;
			}
		}
		
		public function show() : void
		{
			this.visible = true;
		}
		
		public function hide() : void
		{
			this.visible = false;
			
			for each(var item:MenuItem in _uiPool)
			{
				item.visible = false;
				item.setStatus(MenuItem.UP);
			}
		}
	}
}
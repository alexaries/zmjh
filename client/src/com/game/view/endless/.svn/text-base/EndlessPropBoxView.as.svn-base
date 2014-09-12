package com.game.view.endless
{
	import com.game.data.player.structure.PropModel;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.LevelEvent.ItemBoxUititlies;
	import com.game.view.LevelEvent.ItemComponent;
	import com.game.view.ViewEventBind;
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class EndlessPropBoxView extends BaseView implements IView
	{
		public function EndlessPropBoxView()
		{
			_moduleName = V.ENDLESS_PROP_BOX;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		private var _curData:Object;
		private var _callback:Function;
		public function interfaces(type:String = "", ...args) : *
		{
			_view.icon.interfaces();
			
			if (type == "") type = InterfaceTypes.Show;
			switch (type)
			{
				case InterfaceTypes.Show:
					_curData = args[0];
					_callback = args[1];
					this.show();
					break;
				case InterfaceTypes.ITEM_SELECTED:
					onItemSelected(args[0], args[1]);
					break;
			}
		}
		
		/**
		 * 已选择卡牌 
		 * @param selectedName
		 * 
		 */
		private var _info:String;
		protected function onItemSelected(selectedName:String, data:*) : void
		{
			var targetButton:EndlessItemComponent = this.searchOf(selectedName);
			_getItemBtn.x = targetButton.panel.x - 18;
			_getItemBtn.visible = true;
			
			var propModel:PropModel = data as PropModel;
			_view.controller.pack.addProp(propModel);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_info = "获得道具" + propModel.config.name + "X" + propModel.num;
			
			initRender("FrontSence");
		}
		
		override protected function init() : void
		{
			if (!isInit)
			{
				isInit = true;
				super.init();
				
				initXML();
				initTexture();
				initComponent();
				initUI();
				initEvent();
			}
			
			getUI();
			getRandomData();
			initRender("BackSence");
		}
		
		private var _items:*;
		private function getRandomData() : void
		{
			_boxType.currentFrame = _world.currentFrame = 2;
			_items = ItemBoxUititlies.getEndlessPropItems(_curData);
			
			if (!_items) throw new Error("错误 打开宝箱");
		}
		
		private var itemList:Vector.<EndlessItemComponent>;
		// 开始选择
		protected function initRender(layer:String) : void
		{
			itemList = new Vector.<EndlessItemComponent>();
			for(var i:int = 0; i <　_uiLibrary.length; i++)
			{
				if (_uiLibrary[i] is EndlessItemComponent)
				{
					var name:String = (_uiLibrary[i] as EndlessItemComponent).name;
					var index:int = ItemBoxUititlies.getBoxIndex(name);
					(_uiLibrary[i] as EndlessItemComponent).setReward(_items[index]);
					(_uiLibrary[i] as EndlessItemComponent).setStatus(layer);
					itemList.push(_uiLibrary[i]);
				}
			}
			
			this.display();
			
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.LEVEL_EVENT, GameConfig.LE_RES, "EndlessItemBoxPosition");
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.LEVEL_EVENT, GameConfig.LE_RES, "LevelEvent");			
				obj = getAssetsObject(V.LEVEL_EVENT, GameConfig.LE_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
			}
		}
		
		private function initComponent() : void
		{
			var name:String;
			var cp:Component;
			var layerName:String;
			for each(var items:XML in _positionXML.component.Items)
			{
				name = items.@name;
				if (!this.checkInComponent(name))
				{
					switch (name)
					{
						case "Card":
							cp = new EndlessItemComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
					}
				}	
			}
		}
		
		private function initUI() : void
		{
			var name:String;
			var obj:*;
			var layerName:String;
			for each(var items:XML in _positionXML.layer)
			{
				layerName = items.@layerName;
				for each(var element:XML in items.item)
				{
					name = element.@name;
					
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						obj["layerName"] = layerName;
						_uiLibrary.push(obj);
					}
				}
			}
			
			_view.layer.setCenter(panel);
		}
		
		private var _getItemBtn:Button;
		private var _world:MovieClip;
		private var _boxType:MovieClip;
		private function getUI() : void
		{
			if (!_getItemBtn) _getItemBtn = this.searchOf("GetItemButton");
			_getItemBtn.visible = false;
			
			if (!_world) _world = this.searchOf("WordType");
			if (!_boxType) _boxType = this.searchOf("ImageType");
		}	
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "GetItemButton":
					_view.prompEffect.play(_info);
					if(_callback != null) _callback();
					this.hide();
					break;
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			textures = _titleTxAtlas.getTextures(name);
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			
			texture = _titleTxAtlas.getTexture(name);
			
			return texture;
		}
		
		override public function update() : void
		{
			super.update();
		}
		
		override public function close() : void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
package com.game.view.activity
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.manager.LayerManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class MoonCakeView extends BaseView implements IView
	{
		public function MoonCakeView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.MOONCAKE_PROP;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
			}
		}
		
		override protected function init() : void
		{
			if (!this.isInit)
			{
				super.init();
				isInit = true;
				
				this.hide();
				initXML();
				initTexture();
				initUI();
				getUI();
				initEvent();
				initBeginEvent();
			}
		}
		
		private var _callback:Function;
		public function pass(callback:Function) : void
		{
			Log.Trace("MoonCake Show!");
			_callback = callback;
			render();
			this.display();
			LayerManager.instance.addKeyDowns(this.panel, comfireFun);
		}
		
		private function render() : void
		{
			var texture:Texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "props_49");
			Data.instance.pack.addNoneProp(49, 1);
			_itemNameTF.text = "月饼";
			_itemImage.texture = texture;
		}
		
		override protected function onClickBeginHandle(e:ViewEventBind) : void
		{
			this.panel.touchable = false;
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "OkBt":
					comfireFun();
					break;
			}
		}
		
		private function comfireFun() : void
		{
			LayerManager.instance.removeKeyDowns();
			this.hide();
			if (_callback != null) _callback();
			this.panel.touchable = true;
		}
		
		private var _itemImage:Image;
		private var _itemNameTF:TextField;
		private var _itemTitle:TextField;
		private function getUI() : void
		{
			_itemTitle = this.searchOf("Tx_Tip");
			_itemTitle.text = "恭喜您获得道具";
			_itemImage = this.searchOf("Item");
			_itemNameTF = this.searchOf("Tx_ItemTip");
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
			
			_view.layer.setCenter(this.panel);
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "GainEquipPosition");
		}
		
		// 初始化纹理
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				_titleTxAtlas = _view.roleRes.titleTxAtlas;
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else
			{
				textures = _titleTxAtlas.getTextures(name);
			}
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			if (type == "public")
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			
			return texture;
		}
		
		override public function display():void
		{
			super.display();
			var type:String = "add" + _layer + "Child";
			_view.layer[type](panel, sign);
		}
		
		override public function close():void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
		
	}
}
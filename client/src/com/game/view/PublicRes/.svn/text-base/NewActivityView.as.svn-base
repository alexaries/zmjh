package com.game.view.PublicRes
{
	import com.game.Data;
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

	public class NewActivityView extends BaseView implements IView
	{
		public function NewActivityView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.ACTIVITY;
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
				
				initXML();
				initTexture();
				initUI();
				getUI();
				initEvent();
				
				_view.toolbar.panel.touchable = false;
				_view.world.panel.touchable = false;
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Submit":
					player.dice += 100;
					player.fight_soul += 10000;
					_view.toolbar.panel.touchable = true;
					_view.world.panel.touchable = true;
					_view.controller.save.onCommonSave(false, 1, false);
					_view.prompEffect.play("获得骰子100，战魂10000");
					this.hide();
					if(player.dice >= V.DICE_MAX_NUM)
					{
						_view.tip.interfaces(InterfaceTypes.Show, 
							"骰子数量已达到上限值！",
							null, null, false, true, false);
						return;
					}
					break;
			}
		}
		
		private var _itemImage:Image;
		private var _itemNameTF_1:TextField;
		private var _itemNameTF_2:TextField;
		private function getUI() : void
		{
			_itemImage = this.searchOf("Item");
			_itemNameTF_1 = this.searchOf("Tx_ItemTip_1");
			_itemNameTF_1.text = "骰子100";
			_itemNameTF_2 = this.searchOf("Tx_ItemTip_2");
			_itemNameTF_2.text = "战魂10000";
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
		
		// xml
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "ActivityPosition");
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
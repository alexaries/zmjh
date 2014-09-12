
package com.game.view.fight
{
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import feathers.controls.ScrollText;
	import feathers.events.FeathersEventType;
	
	import flash.display.Bitmap;
	import flash.text.TextFormat;
	
	import starling.display.Button;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class AutoFightView extends BaseView implements IView
	{
		private var _callback:Function;
		private var _positionXML:XML;
		private var _titleTxAtlas:TextureAtlas;
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		
		private var _detailText:TextField;
		public function get detailContent() : TextField
		{
			return _detailText;
		}
		
		public function set detailContent(value:TextField) : void
		{
			_detailText = value;
		}
		
		private var okButton:Button;
		
		public function AutoFightView()
		{
			_moduleName = V.AUTO_FIGHT;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.AUTO_FIGHT;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch (type)
			{
				case InterfaceTypes.Show:
					_callback = args[0];
					this.show();
					break;
			}
		}
		
		override protected function init():void
		{
			if (!isInit)
			{
				super.init();
				isInit = true;
				
				initData();
				initTextures();
				initUI();
				getUI();
				initEvent();
			}
			resetDetail();
			
			if(_callback!=null) _callback();
			_view.layer.setCenter(panel);
		}
		
		private function initData() : void
		{
			if (!_positionXML)
			{
				_positionXML = getXMLData(_loaderModuleName, GameConfig.AUTO_FIGHT_RES, "AutoFightPosition");
			}
		}
		
		private function initTextures() : void
		{
			var obj:*;
			
			var textureXML:XML = getXMLData(_loadBaseName, GameConfig.AUTO_FIGHT_RES, "AutoFight");			
			obj = getAssetsObject(_loadBaseName, GameConfig.AUTO_FIGHT_RES, "Textures");
			var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
			
			_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
			(obj as Bitmap).bitmapData.dispose();
			obj = null;
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
		}
		
		private function getUI() : void
		{
			okButton = this.searchOf("DiceOkBt");
			
			addShowText();
		}
		
		private var _scrollText:ScrollText
		private function addShowText() : void
		{
			_scrollText = new ScrollText();
			_scrollText.width = 700;
			_scrollText.height = 300;
			_scrollText.x = 150;
			_scrollText.y = 200;
			_scrollText.text = "";
			_scrollText.textFormat = setTextFormat();
			this.panel.addChild(_scrollText);
		}
		
		private function setTextFormat() : TextFormat
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = "宋体";
			textFormat.size = 15;
			textFormat.color = 0xFFFFFF;
			textFormat.leading = 5;
			return textFormat;
		}
		
		private function resetDetail() : void
		{
			_scrollText.text = "";
			okButton.touchable = false;
			okButton.filter = new GrayscaleFilter();
		}
		
		public function addContent(value:String) : void
		{
			_scrollText.text += value;
			_scrollText.verticalScrollPosition = _scrollText.maxVerticalScrollPosition;
		}
		
		public function contentOver() : void
		{
			_scrollText.verticalScrollPosition = _scrollText.maxVerticalScrollPosition;
			okButton.touchable = true;
			okButton.filter = null;
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "DiceOkBt":
					this.hide();
					break;
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
		
		override public function hide() : void
		{
			super.hide();
			if(_scrollText != null) _scrollText.text = "";
		}
		
	}
}
package com.game.view.martial
{
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	
	import flash.display.Bitmap;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class MartialView extends BaseView implements IView
	{
		public function MartialView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.MARTIAL;
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
				initComponent();
				initUI();
				getUI();
				initEvent();
			}
			
			display();
			_view.layer.setCenter(panel);
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.MARTIAL, GameConfig.MARTIAL_RES, "MartialPosition");
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
						/*case "RoleLabel":
							cp = new RoleLabelComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;*/
					}
				}
			}
		}
		
		private function initUI() : void
		{
			
		}
		
		// 初始化纹理
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.MARTIAL, GameConfig.MARTIAL_RES, "Martial");			
				obj = getAssetsObject(V.MARTIAL, GameConfig.MARTIAL_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
			}
		}
		
		private function getUI() : void
		{
			
		}
	}
}
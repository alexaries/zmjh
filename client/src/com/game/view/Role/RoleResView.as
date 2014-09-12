package com.game.view.Role
{
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class RoleResView extends BaseView implements IView
	{
		public function RoleResView()
		{
			_moduleName = V.ROLE_RES;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					if (isInit) return;
					isInit = true;
					this.show();
					break;
				case InterfaceTypes.GetTexture:
					return getTexture(args[0], "");
					break;
				case InterfaceTypes.GetTextures:
					return getTextures(args[0], "");
					break;
			}
		}
		
		override protected function show():void
		{
			initLoad();
		}
		
		override protected function init():void
		{
			initTexture();
		}
		
		private var _titleTxAtlas:TextureAtlas;
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		protected function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var textureXML:XML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "Role");
				var obj:* = getAssetsObject(V.ROLE, GameConfig.ROLE_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
			}
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			return _titleTxAtlas.getTexture(name);
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var vec:Vector.<Texture>;
			
			vec = _titleTxAtlas.getTextures(name);
			
			return vec;
		}
	}
}
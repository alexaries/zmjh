package com.game.view.Role
{
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class RoleBigView extends BaseView implements IView
	{
		public function RoleBigView()
		{
			_moduleName = V.ROLE_BIG;
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
		protected function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var textureXML:XML = getXMLData(V.ROLE_BIG, GameConfig.ROLE_BIG_RES, "RoleBig");
				var obj:ByteArray = getAssetsObject(V.ROLE_BIG, GameConfig.ROLE_BIG_RES, "Textures") as ByteArray;
				var textureTitle:Texture = Texture.fromAtfData(obj);
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				/*obj.clear();
				obj = null*/
			}
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			return _titleTxAtlas.getTexture(name);
		}
		
	}
}
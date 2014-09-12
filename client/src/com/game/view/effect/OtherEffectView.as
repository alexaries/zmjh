package com.game.view.effect
{
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Base;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.effect.protocol.FightEffectConfigData;
	import com.game.view.effect.protocol.FightEffectUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class OtherEffectView extends BaseView implements IView
	{
		private var _titleTxAtlas:TextureAtlas;
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		
		public function OtherEffectView()
		{
			_moduleName = V.OTHER_EFFECT;
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
					return _titleTxAtlas.getTexture(args[0]);
					break;
				case InterfaceTypes.GetTextures:
					return _titleTxAtlas.getTextures(args[0]);
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
		
		protected function initTexture() : void
		{
			var textureXML:XML;
			var obj:ByteArray;
			var textureTitle:Texture;
			
			if (!_titleTxAtlas)
			{
				textureXML = getXMLData(V.OTHER_EFFECT, GameConfig.OTHER_EFFECT_RES, "OtherEffect");
				obj = getAssetsObject(V.OTHER_EFFECT, GameConfig.OTHER_EFFECT_RES, "Textures") as ByteArray;
				textureTitle = Texture.fromAtfData(obj);
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				/*obj.clear();
				obj = null;*/
			}
		}

	}
}
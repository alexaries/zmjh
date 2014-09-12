package com.game.view.instruction
{
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	
	import flash.display.Bitmap;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class InstructionView extends BaseView implements IView
	{
		public function InstructionView()
		{
			_moduleName = V.INSTRUCTION;
			_loaderModuleName = V.INSTRUCTION;
			
			super();
		}
		
		private var _callback:Function;
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_callback = args[0];
					if (isInit)
					{
						if(_callback != null) _callback();
						return;
					}
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
			if(_callback != null) _callback();
		}
		
		private var _titleTxAtlas:TextureAtlas;
		protected function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var textureXML:XML = getXMLData(V.INSTRUCTION, GameConfig.INSTRUCTION_RES, "instruction");
				var obj:* = getAssetsObject(V.INSTRUCTION, GameConfig.INSTRUCTION_RES, "Textures");
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
	}
}
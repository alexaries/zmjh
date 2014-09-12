package com.game.view.guide
{
	import com.game.template.InterfaceTypes;
	import com.game.view.Component;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class GuideComponent extends Component
	{
		public function GuideComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			getUI();
		}
		
		
		private var _guideBg:Image;
		private var _wordContent:TextField;
		private function getUI() : void
		{
			_guideBg = this.searchOf("GuideBg");
			_wordContent = this.searchOf("WordContent");
			this.panel.touchable = false;
		}
		
		public function setData(words:String) : void
		{
			_wordContent.text = words;
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			textures = _view.guide.interfaces(InterfaceTypes.GetTextures, name);
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			texture = _view.guide.interfaces(InterfaceTypes.GetTexture, name);
			return texture;
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new GuideComponent(_configXML, _titleTxAtlas);
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			super.destroy();
		}
	}
}
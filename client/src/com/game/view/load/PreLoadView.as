package com.game.view.load
{
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	
	import flash.display.Bitmap;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class PreLoadView extends BaseView implements IView
	{
		[Embed(source = '../resources/load/preloading/preloading.xml', mimeType = 'application/octet-stream')]
		private var PRELOADXML:Class;
		[Embed(source = '../resources/load/preloading/preloading.png')]
		private var PRELOADPNG:Class;
		
		// 播放动画
		private var _animation:MovieClip;
		
		public function PreLoadView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.PRELOAD;
			_loaderModuleName = V.PUBLIC;
		
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					show();
					break;
			}
		}
		
		override protected function init():void
		{
			if (!this.isInit)
			{
				super.init();
				this.isInit = true;
				
				this.hide();
				initUI();
			}
			
			_view.layer.setCenter(panel);
		}
		
		private function initUI() : void
		{
			var configXML:XML = XML(new PRELOADXML());
			var png:Bitmap = new PRELOADPNG();
			var texture:Texture = Texture.fromBitmap(png);
			var textureAtlas:TextureAtlas = new TextureAtlas(texture, configXML);
			var textures:Vector.<Texture> = textureAtlas.getTextures("preloading_");
			
			_animation = new MovieClip(textures);
			panel.addChild(_animation);
			_animation.loop = true;
			Starling.juggler.add(_animation);
			
			// clear
			configXML = null;
			png.bitmapData.dispose();
			png = null;
			
			while (textures.length)
			{
				textures.pop().dispose();
			}
		}
		
		/**
		 * 播放 
		 * 
		 */		
		public function play() : void
		{
			this.display();
			_animation.play();
		}
		
		/**
		 * 每帧调用 
		 * 
		 */
		override public function update():void
		{
			super.update();
		}
		
		override public function close():void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
			
			if(_animation) _animation.stop();
		}
	}
}
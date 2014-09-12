package com.game.view.load
{
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.Texture;

	public class LoadDataView extends BaseView implements IView
	{
		public function LoadDataView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.LOAD_DATA;
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
		}
		
		private var _loadCartoon:MovieClip;
		private function initUI() : void
		{			
			var textures:Vector.<Texture> = _view.load.titleTxAtlas.getTextures("LoadCartoon");
			_loadCartoon = new MovieClip(textures, 6);
			panel.addChild(_loadCartoon);
			_view.layer.setCenter(_loadCartoon);
		}
		
		/**
		 * 数据加载 
		 * 
		 */		
		public function loadDataPlay() : void
		{
			if (!_loadCartoon) init();
			
			this.display();			
			Starling.juggler.add(_loadCartoon);
		}
		
		/**
		 * 素材资源加载 
		 * 
		 */		
		public function loadResPlay() : void
		{
			
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
			
			if (_loadCartoon) Starling.juggler.remove(_loadCartoon);
		}
		
		public function hideOnly() : void
		{
			if (_loadCartoon) Starling.juggler.remove(_loadCartoon);
		}
	}
}
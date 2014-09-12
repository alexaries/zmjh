package com.game.view.map
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class Prop extends Sprite
		
	{
		/**
		 * id
		 */		
		public var id:int;
		/**
		 * 文件名 
		 */		
		public var file:String;
		/**
		 * 类型 
		 */		
		public var type:String;
		/**
		 * 格子索引X 
		 * 
		 */
		public var ix:int;
		/**
		 * 格子索引Y
		 * 
		 */	
		public var iy:int;
		
		/**
		 * 参数 
		 */		
		public var args:Object;
		
		private var _imageTexture:Texture;
		public function set imageTexture(value:Texture) : void
		{
			_imageTexture = value;
			initImage();
		}
		
		private var _view:MapView;
		public function Prop(view:MapView)
		{
			_view = view;
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			this.x = ix * _view.mapInfo.titleWidth + _view.mapInfo.titleWidth/2 + _view.mapInfo.mpx;
			this.y = iy * _view.mapInfo.titleHeight + _view.mapInfo.titleHeight/2 + _view.mapInfo.mpy;
		}
		
		private var _image:Image;
		
		public function get PropImage():Image{
			return _image;
		}
		private function initImage() : void
		{
			_image = new Image(_imageTexture);
			this.addChild(_image);
			
		}
		
		
		override public function set x(value:Number):void
		{
			var rx:int = value - this.width/2;
			super.x = rx;
		}
		
		override public function set y(value:Number):void
		{
			var ry:int = value - this.height/2;
			super.y = ry;
		}
		
		public function destroy() : void
		{
			_imageTexture.dispose();
			_imageTexture = null;
			
			_image.texture.dispose();
			_image.dispose();
			
			super.dispose();
		}
		
		public function resetImage() : void
		{
			this.removeChild(_image);
			//destroy();
		}
	}
}
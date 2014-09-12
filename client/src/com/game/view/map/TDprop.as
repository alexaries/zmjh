package com.game.view.map
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class TDprop extends Sprite
		
	{
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
		

		
		protected var _imageTexture:Texture;
		public function set imageTexture(value:Texture) : void
		{
			_imageTexture = value;
			initImage();
		}
		
		private var _view:TowerDefenceView;
		public function TDprop(view:TowerDefenceView)
		{
			_view = view;
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
/*			this.x = ix * _view.mapInfo.titleWidth - this.width/2;
			this.y = iy * _view.mapInfo.titleHeight  - this.height/2;*/
			
			
			this.x = ix * _view.mapInfo.titleWidth + _view.mapInfo.titleWidth/2 + _view.mapInfo.mpx - this.width/2;
			this.y = iy * _view.mapInfo.titleHeight + _view.mapInfo.titleHeight/2 + _view.mapInfo.mpy - this.height/2;
		}
		
		protected var _image:Image;
		
		public function get PropImage():Image{
			return _image;
		}
		private function initImage() : void
		{
			_image = new Image(_imageTexture);
			this.addChild(_image);
			
		}
		

		
/*		override public function set x(value:Number):void
		{
			var rx:int = value - this.width/2;
			super.x = rx;
		}
		
		override public function set y(value:Number):void
		{
			var ry:int = value - this.height/2;
			super.y = ry;
		}*/
		
		public function destroy() : void
		{
			_imageTexture.dispose();
			_imageTexture = null;
			
			_image.texture.dispose();
			_image.dispose();
			
			super.dispose();
		}
	}
}
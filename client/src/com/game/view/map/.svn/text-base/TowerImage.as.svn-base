package com.game.view.map
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class TowerImage extends Image
	{

		private var _view:TowerDefenceView;
		
		public function TowerImage(texture:Texture,view:TowerDefenceView)
		{
			super(texture);
			_view = view;
		}
		

		
		
		public function set ix(value:Number):void
		{
			var rx:int = value * _view.mapInfo.titleWidth + _view.mapInfo.titleWidth/2 + _view.mapInfo.mpx - this.width/2;
			super.x = rx;
		}
		
	    public function set iy(value:Number):void
		{
			var ry:int = value * _view.mapInfo.titleHeight + _view.mapInfo.titleHeight/2 + _view.mapInfo.mpy - this.height/2;
			super.y = ry;
		}
	}
}
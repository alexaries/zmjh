package com.game.view
{
	import starling.display.Sprite;
	
	public class Entity extends Sprite
	{
		private var _view:Base;
		public function get view() : Base
		{
			return _view;
		}
		public function set view(value:Base) : void
		{
			_view = value;
		}
		
		private var _type:String;
		public function get type() : String
		{
			return _type;
		}
		public function set type(value:String) : void
		{
			_type = value;
		}
		
		public function Entity(x:Number = 0, y:Number = 0, type:String = '')
		{
			this.x = x;
			this.y = y;
			this._type = type;
		}
		
		
		/**
		 * 必须重写的api 
		 * 
		 */	
		public function update() : void {};
		
		public function added() : void {};
		
		public function removed() : void {};
		
		public function destroy() : void {};
	}
}
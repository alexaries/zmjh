package com.game.view.dialog
{
	public class CartoonDialogData extends BaseSceneItemDialogData
	{
		private var _texture_name:String;
		public function get texture_name() : String
		{
			return _texture_name;
		}
		
		public function CartoonDialogData()
		{
			super();
		}
		
		override public function initData(config:XML) : void
		{
			super.initData(config);
			
			_texture_name = _config.@texture_name;
		}
	}
}
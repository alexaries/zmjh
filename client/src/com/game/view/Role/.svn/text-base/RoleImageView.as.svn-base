package com.game.view.Role
{
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	
	import flash.display.BitmapData;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class RoleImageView extends BaseView implements IView
	{
		public function RoleImageView()
		{
			_moduleName = V.ROLE_IMAGE;
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
		}
		
		private var _titleTxAtlas:TextureAtlas;
		protected function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				_titleTxAtlas = _view.roleRes.titleTxAtlas;
			}
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			return _titleTxAtlas.getTexture(name);
		}
	}
}
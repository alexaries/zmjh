package com.game.view.equip
{
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	
	import flash.display.BitmapData;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class EquipView extends BaseView implements IView
	{
		public function EquipView()
		{
			_moduleName = V.EQUIP;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.GetTexture:
					return getTexture(args[0], "");
					break;
			}
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			return _view.icon.interfaces(InterfaceTypes.GetTexture, name);
		}
	}
}
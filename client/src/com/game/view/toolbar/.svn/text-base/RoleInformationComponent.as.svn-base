package com.game.view.toolbar
{
	import com.game.View;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class RoleInformationComponent extends BaseRoleInformationComponent
	{

		public function RoleInformationComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
		}
		
		override protected function renderImage():void
		{
			_mainRainCircle.visible = false;
			_mainNightCircle.visible = false;
			_mainThunderCircle.visible = false;
			_mainWindCircle.visible = false;
			if(_roleName.indexOf(V.NIGHT_TYPE) != -1)  _mainNightCircle.visible = true;
			if(_roleName.indexOf(V.RAIN_TYPE) != -1)	_mainRainCircle.visible = true;
			if(_roleName.indexOf(V.THUNDER_TYPE) != -1)	_mainThunderCircle.visible = true;
			if(_roleName.indexOf(V.WIND_TYPE) != -1)	_mainWindCircle.visible = true;
			
			var roleName:String = _roleName;
			if(_roleName.indexOf("（") != -1) roleName = _roleName.substring(0, _roleName.indexOf("（"));
			
			var imageName:String;
			if(roleName == V.MAIN_ROLE_NAME.split("（")[0])
			{
				imageName = player.returnNowFashion("RoleImage_Small_", roleName);
				/*var roleUseFashion:String = player.getTypeRoleModel(roleName).nowUseFashion;
				if(roleUseFashion == "")
					imageName = "RoleImage_Small_" + roleName;
				else
					imageName = "RoleImage_Small_" + roleName + "_" + roleUseFashion;*/
			}
			else
				imageName = "RoleImage_Small_" + roleName;
			
			//var imageName:String = "RoleImage_Small_" + roleName;			
			var texture:Texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, imageName);	
			_roleImage.texture = texture;
			_roleImage.width = texture.width;
			_roleImage.height = texture.height;
		}
		
	}
}
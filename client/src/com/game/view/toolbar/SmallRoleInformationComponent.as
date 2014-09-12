package com.game.view.toolbar
{
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class SmallRoleInformationComponent extends BaseRoleInformationComponent
	{
		public function SmallRoleInformationComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
		}
		
		override protected function renderImage():void
		{
			_nightCircle.visible = false;
			_rainCircle.visible = false;
			_thunderCircle.visible = false;
			_windCircle.visible = false;
			if(_roleName.indexOf(V.NIGHT_TYPE) != -1)  _nightCircle.visible = true;
			if(_roleName.indexOf(V.RAIN_TYPE) != -1)	_rainCircle.visible = true;
			if(_roleName.indexOf(V.THUNDER_TYPE) != -1)	_thunderCircle.visible = true;
			if(_roleName.indexOf(V.WIND_TYPE) != -1)	_windCircle.visible = true;
			
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
			_roleImage.readjustSize();
			_roleImage.width = texture.width;
			_roleImage.height = texture.height;
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new SmallRoleInformationComponent(_configXML, _titleTxAtlas);
		}
	}
}
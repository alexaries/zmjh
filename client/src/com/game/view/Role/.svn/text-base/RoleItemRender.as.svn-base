package com.game.view.Role
{
	import com.engine.ui.controls.IGrid;
	import com.game.Data;
	import com.game.View;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.equip.RoleTip;
	import com.game.view.ui.UIConfig;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class RoleItemRender extends Sprite implements IGrid
	{
		public static const DOUBLE_CLICK:String = "double_click";
		
		private var _roleModel:RoleModel;
		public function get roleModel() : RoleModel
		{
			return _roleModel;
		}
		private var _image:Image;
		
		private var _view:View = View.instance;
		private var _roleTip:RoleTip;
		public function get roleName() : String
		{
			return _roleModel.info.roleName;
		}
		
		public function RoleItemRender()
		{
			_roleTip=_view.ui.interfaces( UIConfig.GET_ROLE_TIP);
		}
		
		private var _roleType:Image;
		private var _roleGrade:Image;
		private var _glass:Image;
		public function setData(roleModel:*) : void
		{
			_roleModel = roleModel;
			
			var lastRoleName:String = _roleModel.info.roleName;
			if(_roleModel.info.roleName.indexOf("（") != -1) lastRoleName = _roleModel.info.roleName.substring(0, _roleModel.info.roleName.indexOf("（"));
			
			
			var roleImageName:String;
			if(lastRoleName == V.MAIN_ROLE_NAME.split("（")[0])
				roleImageName = Data.instance.player.player.returnNowFashion("RoleImage_Rect_", lastRoleName);
			else
				roleImageName = "RoleImage_Rect_" + lastRoleName;
			
			//var roleImageName:String = "RoleImage_Rect_" + lastRoleName;
			var texture:Texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, roleImageName);
			
			if (!_image)
			{
				_image = new Image(texture);
				_image.useHandCursor = true;
				addChild(_image);
				_image.addEventListener(TouchEvent.TOUCH, onTouch);
			}
			
			_image.width = _image.height = 68;
			_image.texture = texture;
			
			checkType(_roleModel.info.roleName);
			checkGrade(_roleModel.info.roleName);
			
			if(!_glass)
			{
				var glassTexture:Texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "Glass");
				_glass = new Image(glassTexture);
				_glass.touchable = false;
				_glass.x = 2;
				_glass.y = 1;
				addChild(_glass);
			}
		}
		
		/**
		 * 检测角色类型
		 * @param name
		 * 
		 */		
		private function checkType(name:String) : void
		{
			if(_roleType) return;
			var texture:Texture;
			if(name.indexOf(V.NIGHT_TYPE) != -1)
			{
				texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "RoleImage_Rect_Night");
				_roleType = new Image(texture);
				_roleType.visible = true;
			}
			else if(name.indexOf(V.RAIN_TYPE) != -1)
			{
				texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "RoleImage_Rect_Rain");
				_roleType = new Image(texture);
				_roleType.visible = true;
			}
			else if(name.indexOf(V.THUNDER_TYPE) != -1)
			{
				texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "RoleImage_Rect_Thunder");
				_roleType = new Image(texture);
				_roleType.visible = true;
			}
			else if(name.indexOf(V.WIND_TYPE) != -1)
			{
				texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "RoleImage_Rect_Wind");
				_roleType = new Image(texture);
				_roleType.visible = true;
			}
			else 
			{
				texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "RoleImage_Rect_Night");
				_roleType = new Image(texture);
				_roleType.visible = false;
			}
			_roleType.touchable = false;
			_roleType.x = -7;
			_roleType.y = -5;
			addChild(_roleType);
		}
		
		/**
		 * 检测角色品质
		 * 
		 */		
		private function checkGrade(name:String) : void
		{
			if(_roleGrade) return;
			var grade:String = Data.instance.db.interfaces(InterfaceTypes.GET_GRADE_BY_NAME, name);
			var textureName:String = "";
			switch(grade)
			{
				case "极":
					textureName = "RoleGrade_Ji";
					break;
				case "甲+":
					textureName = "RoleGrade_JiaJia";
					break;
				case "甲":
					textureName = "RoleGrade_Jia";
					break;
				case "乙":
					textureName = "RoleGrade_Yi";
					break;
				case "丙":
					textureName = "RoleGrade_Bing";
					break;
				case "丁":
					textureName = "RoleGrade_Ding";
					break;
			}
			var texture:Texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, textureName);
			_roleGrade = new Image(texture);
			_roleGrade.touchable = false;
			_roleGrade.x = 35;
			addChild(_roleGrade);
		}
		
		private function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_image);
			
			if (touch && touch.tapCount == 2 && touch.phase == TouchPhase.ENDED)
			{
				if(_view.get_role_guide.isGuide)
					_view.get_role_guide.setFunc();
				_view.roleSelect.onDoubleClick(_roleModel);
			}
			if (touch&&touch.phase==TouchPhase.HOVER) 
			{
				_roleTip.x=touch.globalX+10;
				_roleTip.y=touch.globalY+10;
				Starling.current.stage.addChild(_roleTip);
				_roleTip.setData(_roleModel)
			}else
			{
				if (_roleTip) _roleTip.hide();
			}
		}
		
		public function clear() : void
		{
			if(_image) _image.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
	}
}
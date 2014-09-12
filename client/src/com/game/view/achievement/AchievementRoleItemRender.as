package com.game.view.achievement
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
	import starling.filters.GrayscaleFilter;
	import starling.textures.Texture;

	public class AchievementRoleItemRender extends Sprite implements IGrid
	{
		private var _image:Image;
		
		private var _view:View = View.instance;
		private var _roleTip:RoleTip;
		
		public function AchievementRoleItemRender()
		{
			_roleTip=_view.ui.interfaces( UIConfig.GET_ROLE_TIP);
		}
		
		private var _roleType:Image;
		private var _roleGrade:Image;
		private var _glass:Image;
		private var _isGet:Boolean;
		private var _result:Boolean;
		private var _roleName:String;
		public function setData(roleName:*) : void
		{
			_roleName = roleName;
			_isGet = Data.instance.player.player.upgradeRole.checkRole(_roleName);
			if(_isGet == false)
				this.filter = new GrayscaleFilter();
			else
				this.filter = null;
			
			var lastRoleName:String = roleName;
			if(roleName.indexOf("（") != -1) lastRoleName = roleName.substring(0, roleName.indexOf("（"));
			
			var roleImageName:String = "RoleImage_Rect_" + lastRoleName;
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
			
			checkType(roleName);
			checkGrade(roleName);
			
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
			
			if (touch && touch.phase==TouchPhase.HOVER && _isGet) 
			{
				/*_roleTip.x=touch.globalX+10;
				_roleTip.y=touch.globalY+10;
				Starling.current.stage.addChild(_roleTip);
				_roleTip.setData(_roleModel);*/
			}
			else if(touch && touch.phase == TouchPhase.ENDED)
			{
				onClick();
			}
			else
			{
				if (_roleTip) _roleTip.hide();
			}
		}
		
		private function onClick():void
		{
			_view.upgrade.setRoleDetail(_roleName);
		}
		
		public function clear() : void
		{
			if(_image) _image.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
	}
}
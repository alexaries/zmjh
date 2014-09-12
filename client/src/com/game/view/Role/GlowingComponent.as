package com.game.view.Role
{
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.equip.PropTip;
	import com.game.view.equip.RoleTip;
	import com.game.view.ui.UIConfig;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class GlowingComponent extends Component
	{
		public var callbackFun:Function;

		public function GlowingComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			init();
		}
		
		override protected function init() : void
		{
			super.init();
			
			getUI();
			initEvent();
		}
		
		private var _roleImage:Image;
		private var _roleNight:Image;
		private var _roleRain:Image;
		private var _roleWind:Image;
		private var _roleThunder:Image;
		private var _roleTip:RoleTip;
		private var _roleModel:RoleModel;
		public function get roleModel() : RoleModel
		{
			return _roleModel;
		}
		public function get roleName() : String
		{
			if(_roleModel !=null)
				return _roleModel.info.roleName;
			else 
				return "";
		}
		private var _hasRole:Boolean;
		public function get hasRole() : Boolean
		{
			return _hasRole;
		}
		private var _unDoubleClick:Boolean;
		public function set unDoubleClick(value:Boolean) : void
		{
			_unDoubleClick = value;
		}
		private function getUI() : void
		{
			_roleImage = this.searchOf("RoleImage");
			_roleNight = this.searchOf("Night_Circle");
			_roleRain = this.searchOf("Rain_Circle");
			_roleWind = this.searchOf("Wind_Circle");
			_roleThunder = this.searchOf("Thunder_Circle");
			
			_roleImage.visible = false;
			_roleNight.visible = false;
			_roleRain.visible = false;
			_roleWind.visible = false;
			_roleThunder.visible = false;
			
			_roleImage.touchable = true;
			_roleNight.touchable = false;
			_roleRain.touchable = false;
			_roleWind.touchable = false;
			_roleThunder.touchable = false;
			
			_hasRole = false;
			_unDoubleClick = true;
			_roleTip=_view.ui.interfaces(UIConfig.GET_ROLE_TIP);
			panel.addEventListener(TouchEvent.TOUCH, resetSelectRole);
		}
		private function resetSelectRole(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(panel);
			if(touch && touch.tapCount == 2 && touch.phase == TouchPhase.ENDED && _unDoubleClick)
			{
				this.setImage();
				if(callbackFun != null) callbackFun();
			}
			
			if (touch&&touch.phase==TouchPhase.HOVER && _hasRole) 
			{
				_roleTip.x=touch.globalX+10;
				_roleTip.y=touch.globalY+10;
				Starling.current.stage.addChild(_roleTip);
				_roleTip.setData(_roleModel);
			}
			else
			{
				if (_roleTip) _roleTip.hide();
			}
		}
		
		public function setImage(roleModel:RoleModel = null) : void
		{
			_roleModel = roleModel;
			if (!_roleModel)
			{
				_roleImage.visible = false;
				_roleNight.visible = false;
				_roleRain.visible = false;
				_roleWind.visible = false;
				_roleThunder.visible = false;
				_hasRole = false;
			}
			else
			{
				_hasRole = true;
				setRoleType(roleName);
			}
		}
		
		private var _roleNameTip:PropTip;
		public function setShowImage(roleName:String = "") : void
		{
			if(panel.hasEventListener(TouchEvent.TOUCH))
				panel.removeEventListener(TouchEvent.TOUCH, resetSelectRole);
			
			if (roleName == "")
			{
				_roleImage.visible = false;
				_roleNight.visible = false;
				_roleRain.visible = false;
				_roleWind.visible = false;
				_roleThunder.visible = false;
			}
			else
			{
				setRoleType(roleName);
			}
			
			if(!_roleNameTip) _roleNameTip = _view.ui.interfaces(UIConfig.PROP_TIP);
			_roleNameTip.removeProp(roleName);
			_roleNameTip.add({o:_roleImage,m:{name:roleName,message:""}}); 
		}
		
		private function setRoleType(roleName:String) : void
		{
			_roleNight.visible = false;
			_roleRain.visible = false;
			_roleWind.visible = false;
			_roleThunder.visible = false;
			var name:String = roleName.split("（")[1];
			switch(name)
			{
				case "夜）":
					_roleNight.visible = true;
					break;
				case "雨）":
					_roleRain.visible = true;
					break;
				case "风）":
					_roleWind.visible = true;
					break;
				case "雷）":
					_roleThunder.visible = true;
					break;
			}
			checkSmallImage(roleName.split("（")[0], _roleImage);
		}
		
		private function checkSmallImage(name:String, img:Image) : void
		{
			var imageName:String;
			if(name == V.MAIN_ROLE_NAME.split("（")[0])
				imageName = player.returnNowFashion("RoleImage_Small_", name);
			else
				imageName = "RoleImage_Small_" + name;
			img.texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, imageName);
			_roleImage.visible = true;
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else
			{
				textures = _titleTxAtlas.getTextures(name);
			}
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			if (type == "public")
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			return texture;
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new GlowingComponent(_configXML, _titleTxAtlas);
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			super.destroy();
		}
	}
}
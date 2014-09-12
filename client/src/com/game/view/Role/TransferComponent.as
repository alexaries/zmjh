package com.game.view.Role
{
	import com.game.Data;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.equip.RoleTip;
	import com.game.view.ui.UIConfig;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureAtlas;

	public class TransferComponent extends Component
	{
		public var callbackFun:Function;
		
		public function TransferComponent(item:XML, titleTxAtlas:TextureAtlas)
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
		private var _roleType:Image;
		private var _roleGrade:Image;
		private var _roleGlass:Image;
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
			_roleGlass = this.searchOf("Glass");
			_roleImage = this.searchOf("TransferRoleImage");
			_roleType = this.searchOf("TransferRoleType");
			_roleGrade = this.searchOf("TransferRoleGrade");
			_roleImage.visible = false;
			_roleType.visible = false;
			_roleGrade.visible = false;
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
				_roleTip.setData(_roleModel)
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
				_roleType.visible = false;
				_roleGrade.visible = false;
				_hasRole = false;
			}
			else
			{
				_hasRole = true;
				_roleGrade.visible = true;
				_roleImage.visible = true;
				_roleType.visible = true;
				
				checkGrade(_roleModel.info.roleName, _roleGrade);
				checkType(_roleModel.info.roleName, _roleType);
				checkImage(_roleModel.info.roleName, _roleImage);
			}
		}
		
		
		public function setShowImage(roleName:String = "") : void
		{
			if(panel.hasEventListener(TouchEvent.TOUCH))
				panel.removeEventListener(TouchEvent.TOUCH, resetSelectRole);
			
			if (roleName == "")
			{
				_roleImage.visible = false;
				_roleType.visible = false;
				_roleGrade.visible = false;
			}
			else
			{
				_roleGrade.visible = true;
				_roleImage.visible = true;
				_roleType.visible = true;
				
				checkGrade(roleName, _roleGrade);
				checkType(roleName, _roleType);
				checkImage(roleName, _roleImage);
			}
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new TransferComponent(_configXML, _titleTxAtlas);
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
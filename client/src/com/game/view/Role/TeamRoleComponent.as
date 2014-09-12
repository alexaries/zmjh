package com.game.view.Role
{
	import com.game.Data;
	import com.game.View;
	import com.game.data.fight.FightConfig;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	import com.game.view.equip.RoleTip;
	import com.game.view.ui.UIConfig;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class TeamRoleComponent extends Component
	{
		public const HAVE_MEMEBER_LAYER:String = "OneMember";
		public const NO_MEMEBER_LAYER:String = "NoMember";
		
		private var _curStatus:String = NO_MEMEBER_LAYER;
		private var _roleModel:RoleModel;
		
		public function TeamRoleComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			panel.useHandCursor = true;
			init();
		}
		
		override protected function init() : void
		{
			super.init();
			
			getUI();
			initEvent();
		}
		
		private var _roleImage:Image;
		public function get roleImage() : Image
		{
			return _roleImage;
		}
		
		private var _glass:Image;
		private var _roleType:Image;
		private var _roleGrade:Image;
		private var _panelContain:Sprite;
		public function get panelContain() : Sprite
		{
			return _panelContain;
		}
		private function getUI() : void
		{
			_roleImage = searchOf("RoleImage");
			_roleType = searchOf("RoleType");
			_roleType.touchable = false;
			_roleGrade = searchOf("RoleGrade");
			_roleGrade.touchable = false
			_glass = searchOf("Glass");
			_glass.touchable = false;
			
			_panelContain = new Sprite();
			this.panel.addChild(_panelContain);
			
			_panelContain.addChild(_roleImage);
			_panelContain.addChild(_roleType);
			_panelContain.addChild(_roleGrade);
			_panelContain.width = 77;
			_panelContain.height = 76;
			
			_roleTip = _view.ui.interfaces(UIConfig.GET_ROLE_TIP);
			
			this.panel.addChildAt(_glass, this.panel.numChildren - 1);
		}
		
		private var _position:String;
		private var _roleTip:RoleTip;
		public function get position() : String
		{
			return _position;
		}
		
		public function setData(roleModel:RoleModel, isLock:Boolean, position:String) : void
		{
			_position = position;
			_roleModel = roleModel;
			_curStatus = isLock ? NO_MEMEBER_LAYER : HAVE_MEMEBER_LAYER;
			
			checkStatus();
		}
		
		private function checkStatus() : void
		{
			for each(var item:* in _uiLibrary)
			{
				item.visible = (item["layerName"] == _curStatus || item["layerName"] == "BackGround"); 
			}
			
			if (_roleModel) 
			{
				_roleGrade.visible = true;
				_roleImage.visible = true;
				_roleType.visible = true;
				
				checkGrade(_roleModel.info.roleName, _roleGrade);
				checkType(_roleModel.info.roleName, _roleType);
				checkImage(_roleModel.info.roleName, _roleImage);
				
				_roleImage.data = {"name":_roleModel.info.roleName, "position":_position};
				_roleImage.visible = true;
				_roleImage.addEventListener(TouchEvent.TOUCH, onTouchEvent);
				_panelContain.newData = _roleImage.data;
			}
			else
			{
				_roleImage.data = {"name":'', "position":_position};
				_roleImage.visible = false;
				_panelContain.newData = _roleImage.data;
				_roleType.visible = false;
				_roleGrade.visible = false;
			}
		}
		
		private function onTouchEvent(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_roleImage);
			
			if (touch && touch.phase == TouchPhase.BEGAN)
			{
				this.panel.parent.addChildAt(panel, panel.parent.numChildren - 1);
			}
			
			if (touch && touch.tapCount == 2 && touch.phase == TouchPhase.ENDED && _roleModel.info.roleName != V.MAIN_ROLE_NAME)
			{
				//向导
				if(_view.get_role_guide.isGuide) return;
				_view.controller.formation.removeTransposition(_roleModel.info.roleName, position);
				_view.roleSelect.initRender();
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
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "FormationSoul":
					onFormationSoul();
					break;
			}
		}
		
		private function onFormationSoul() : void
		{
			_view.append_attribute.interfaces(
				InterfaceTypes.Show,
				position
			);
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new TeamRoleComponent(_configXML, _titleTxAtlas);
		}
	}
}
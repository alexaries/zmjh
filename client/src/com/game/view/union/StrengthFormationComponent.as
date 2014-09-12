package com.game.view.union
{
	import com.game.Data;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class StrengthFormationComponent extends Component
	{
		private var _glass:Image;
		
		public function StrengthFormationComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
			initEvent();
		}
		
		private var _roleImage:Image;
		public function get roleImage() : Image
		{
			return 	_roleImage;
		}
		private var _panelContain:Sprite;
		public function get panelContain() : Sprite
		{
			return _panelContain;
		}
		
		private var _bg:Image;
		public function get bg() : Image
		{
			return _bg;
		}
		
		private var _roleType:Image;
		private var _roleGrade:Image;
		protected function getUI() : void
		{
			_bg = this.searchOf("FormationBg");
			
			_glass = this.searchOf("Glass");
			_glass.touchable = false;
			
			_roleImage = this.searchOf("FormationRoleHead");
			_roleImage.useHandCursor = true;
			_roleImage.addEventListener(TouchEvent.TOUCH, onRoleImageTouch);
			
			_roleType = this.searchOf("FormationRoleType");
			_roleType.touchable = false
			_roleGrade = this.searchOf("FormationRoleGrade");
			_roleGrade.touchable = false;
			
			_panelContain = new Sprite();
			this.panel.addChild(_panelContain);
			
			_panelContain.addChild(_roleImage);
			_panelContain.addChild(_roleType);
			_panelContain.addChild(_roleGrade);
			_panelContain.width = 77;
			_panelContain.height = 76;
			
			this.panel.addChildAt(_glass, this.panel.numChildren - 1);
		}
		
		private function onRoleImageTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_roleImage);
			
			if (touch && touch.phase == TouchPhase.ENDED)
			{
				_view.strength.setComponent(this.name);
			}
		}
		
		// 角色名称
		private var _curRoleName:String;
		public function setFormation(roleName:String) : void
		{
			_curRoleName = roleName;
			_roleImage.name = _curRoleName;
			_bg.name = _curRoleName;
			
			if (!_curRoleName || _curRoleName == "")
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
				
				checkGrade(_curRoleName, _roleGrade);
				checkType(_curRoleName, _roleType);
				checkImage(_curRoleName, _roleImage);
				
				_panelContain.name = _roleImage.name;
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			var position:String;
			
			switch (this.name)
			{
				// 先锋
				case "FormationFront":
					position = "front";
					break;
				// 中坚
				case "FormationMiddle":
					position = "middle";
					break;
				// 大将
				case "FormationBack":
					position = "back";
					break;
			}
			
			switch (e.target.name)
			{
				case "FormationSoul":
					/*
					_view.tip.interfaces(
						InterfaceTypes.Show,
						"该功能未开启！",
						null,
						null);*/
					_view.append_attribute.interfaces(
						InterfaceTypes.Show,
						position
					);
					break;
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else if(type == "role")
			{
				textures = _view.roleRes.interfaces(InterfaceTypes.GetTextures, name);
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
			else if(type == "role")
			{
				texture = _view.roleRes.interfaces(InterfaceTypes.GetTexture, name);
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
			return new StrengthFormationComponent(_configXML, _titleTxAtlas);
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
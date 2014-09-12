package com.game.view.skill
{
	import com.engine.ui.controls.IGrid;
	import com.engine.ui.controls.MenuItem;
	import com.engine.ui.controls.ShortCutMenu;
	import com.game.View;
	import com.game.data.db.protocal.Skill;
	import com.game.data.player.structure.SkillModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.ui.UIConfig;
	
	import flash.display.BitmapData;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.GrayscaleFilter;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class SkillItemRender extends Sprite implements IGrid
	{
		public static const EQUIPED_MENU:Array = ["卸下"];
		public static const PACK_MENU:Array = ["装备"];
		
		private var _image:Image;		
		private var _skillModel:SkillModel;
		private var _glassImage:Image;
		
		private var _view:View = View.instance;
		
		public function SkillItemRender()
		{
			getUI();
		}
		
		private var _skillTip:SkillTip;
		private function getUI() : void
		{
			if (!_skillTip)
			{
				_skillTip = _view.ui.interfaces(UIConfig.GET_SKILL_TIP);
			}
		}
		
		public function setData(skillModel:*) : void
		{
			if (!skillModel) return;
			
			_skillModel = skillModel;
			
			var skillFileName:String = "skill_" + _skillModel.skill.id;
			var texture:Texture = _view.skill.interfaces(InterfaceTypes.GetTexture, skillFileName);
			
			if (!texture) texture = Texture.empty();
			
			if (!_image)
			{
				_image = new Image(texture);
				addChild(_image);
			}
			
			_image.width = _image.height = 42;
			_image.texture = texture;
			
			if (!_skillModel.isLearned)
			{
				this.filter = new GrayscaleFilter();
				this.touchable = false;
			}
			else
			{
				this.filter = null;
				this.touchable = true;
			}
			
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			addGlass();
		}
		
		private function addGlass():void
		{
			var skillTypeList:Array = new Array();
			if (!_skillModel.skill.water && !_skillModel.skill.fire && !_skillModel.skill.chaos && !_skillModel.skill.poison)
			{
				if(_skillModel.skill.hp_up == 0)
					skillTypeList.push(1);
				else
					skillTypeList.push(6);
			}
			if(_skillModel.skill.water == 1)
				skillTypeList.push(2);
			if(_skillModel.skill.chaos == 1)
				skillTypeList.push(3);
			if(_skillModel.skill.poison == 1)
				skillTypeList.push(4);
			if(_skillModel.skill.fire == 1)
				skillTypeList.push(5);
			
			var texture:Texture;
			if(skillTypeList.length == 1)
			{
				texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "SkillType_" + skillTypeList[0]);
			}
			else
			{
				if(skillTypeList[0] == 4 || skillTypeList[1] == 4)
					texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "SkillType_7");
				else 
					texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "SkillType_8");
			}
			
			if (!_glassImage)
			{
				_glassImage = new Image(texture);
				_glassImage.x = -2;
				_glassImage.y = -2;
				_glassImage.touchable = false;
				addChild(_glassImage);
			}
			
			_glassImage.texture = texture;
		}
		
		protected function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this);
			
			var menuTouch:Touch = e.getTouch(_shortCutMenu);
			var skillTouch:Touch = e.getTouch(_skillTip);
			
			// 划出
			if (!touch)
			{
				if (_shortCutMenu && !menuTouch) _shortCutMenu.hide();
				
				if (_skillTip && !skillTouch) _skillTip.hide();
				return;
			}
			
			switch (touch.phase)
			{
				case TouchPhase.ENDED:
					onClick();
					if (_skillTip) _skillTip.hide();
					break;
				case TouchPhase.HOVER:
					if (_shortCutMenu && _shortCutMenu.parent && _shortCutMenu.visible) return;
					
					if (!_skillTip.data || _skillTip.data.skill.id != _skillModel.skill.id) _skillTip.setData(_skillModel);
					this.parent.parent.addChild(_skillTip);
					_skillTip.x = touch.globalX - this.parent.parent.x + 10;
					_skillTip.y = touch.globalY - this.parent.parent.y + 10;
					break;
			}		
		}
		
		private var _shortCutMenu:ShortCutMenu;
		protected function onClick() : void
		{
			if (!_shortCutMenu) _shortCutMenu = _view.ui.interfaces(UIConfig.GET_SHORT_CUT_MENU);
			
			_shortCutMenu.show();
			parent.addChild(_shortCutMenu);
			_shortCutMenu.x = this.x + this.width/2;
			_shortCutMenu.y = this.y + this.height/2;
			
			var menu:Array = (this._skillModel.isEquiped ? EQUIPED_MENU : PACK_MENU);
			_shortCutMenu.setData(menu, V.SKILL, _skillModel);
		}
		
		public function clear() : void
		{			
			this.removeEventListeners();
			this.dispose();
		}
	}
}
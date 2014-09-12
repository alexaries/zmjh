package com.game.view.union
{
	import com.engine.ui.controls.IGrid;
	import com.engine.ui.controls.ShortCutMenu;
	import com.game.View;
	import com.game.data.player.structure.SkillModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.skill.SkillTip;
	import com.game.view.ui.UIConfig;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.GrayscaleFilter;
	import starling.textures.Texture;
	
	public class TdhSkillItemRender extends Sprite implements IGrid
	{
		public function TdhSkillItemRender()
		{
			getUI();
		}
		
		private var _image:Image;		
		private var _skillModel:SkillModel;
		
		
		public function get skillModel():SkillModel
		{
			return _skillModel;
		}
		
		private var _view:View = View.instance;
		

		
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
			

			
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			addGlass();
		}
		
		
		private var _glassImage:Image;
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
			
			var skillTouch:Touch = e.getTouch(_skillTip);
			
			// 划出
			if (!touch)
			{	
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
					
					if (!_skillTip.data || _skillTip.data.skill.id != _skillModel.skill.id) _skillTip.setData(_skillModel);
					this.parent.parent.addChild(_skillTip);
					_skillTip.x = touch.globalX - this.parent.parent.x + 10;
					_skillTip.y = touch.globalY - this.parent.parent.y + 10;
					break;
			}		
		}
		
		protected function onClick() : void
		{
			if(!_skillModel.isTdhEquiped){
				_view.tdhPrepare.equipSkill(_skillModel);
			}else{
				_view.tdhPrepare.downSkill(_skillModel);
			}
			
		}
		
		public function clear() : void
		{			
			this.removeEventListeners();
			this.dispose();
		}
	}
}
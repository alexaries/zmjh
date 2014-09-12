package com.game.view.union
{
	import com.engine.ui.controls.IGrid;
	import com.game.View;
	import com.game.data.player.structure.SkillModel;
	import com.game.template.InterfaceTypes;
	import com.game.view.skill.SkillTip;
	import com.game.view.ui.UIConfig;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class MatchItemRender extends Sprite implements IGrid
	{
		
		public function MatchItemRender()
		{
			getUI();
		}
		
		private var _image:Image;		
		private var _skillModel:SkillModel;
		
		public var skillTypeArray:Array;
		
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
			var tempSkillTypeList:Array = new Array();
			skillTypeArray = new Array();
			if (!_skillModel.skill.water && !_skillModel.skill.fire && !_skillModel.skill.chaos && !_skillModel.skill.poison)
			{
				if(_skillModel.skill.hp_up == 0){
					tempSkillTypeList.push(1);
					skillTypeArray.push("common");
				}
				else{
					tempSkillTypeList.push(6);
					skillTypeArray.push("hp_up");
				}
			}
			if(_skillModel.skill.water == 1){
				tempSkillTypeList.push(2);
				skillTypeArray.push("water");
			}
			if(_skillModel.skill.chaos == 1){
				tempSkillTypeList.push(3);
				skillTypeArray.push("chaos");
			}
				
			if(_skillModel.skill.poison == 1){
				tempSkillTypeList.push(4);
				skillTypeArray.push("poison");
			}
				
			if(_skillModel.skill.fire == 1){
				tempSkillTypeList.push(5);
				skillTypeArray.push("fire");
			}
				
			
			var texture:Texture;
			if(tempSkillTypeList.length == 1)
			{
				texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "SkillType_" + tempSkillTypeList[0]);
			}
			else
			{
				if(tempSkillTypeList[0] == 4 || tempSkillTypeList[1] == 4)
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
				case TouchPhase.HOVER:
					if (!_skillTip.data || _skillTip.data.skill.id != _skillModel.skill.id) _skillTip.setData(_skillModel);
					this.parent.parent.addChild(_skillTip);
					_skillTip.x = touch.globalX - this.parent.parent.x + 10;
					_skillTip.y = touch.globalY - this.parent.parent.y + 10;
					break;
			}		
		}
		
		
		public function clear() : void
		{			
			this.removeEventListeners();
			this.dispose();
		}

	}
}
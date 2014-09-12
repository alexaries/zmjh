package com.game.view.upgrade
{
	import com.engine.ui.controls.IGrid;
	import com.game.Data;
	import com.game.View;
	import com.game.data.db.protocal.Skill;
	import com.game.data.player.structure.Player;
	import com.game.template.InterfaceTypes;
	import com.game.view.ui.UIConfig;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import com.game.view.skill.SkillTip;

	public class UpgradeSkillItemRender extends Sprite implements IGrid
	{
		private var _image:Image;		
		private var _view:View = View.instance;
		public var canClick:Boolean;
		private static function get player() : Player
		{
			return Data.instance.player.player;
		}
		
		public function UpgradeSkillItemRender()
		{
			getUI();
			canClick = true;
		}
		
		private var _skillTip:SkillTip;
		private function getUI() : void
		{
			if (!_skillTip)
			{
				_skillTip = _view.ui.interfaces(UIConfig.GET_SKILL_TIP);
			}
		}
		
		private var _skill:Skill;
		public function get skillData() : Skill
		{
			return _skill;
		}
		public function setData(skill:*) : void
		{
			if (!skill) return;
			_skill = skill;
			var skillFileName:String = "skill_" + _skill.id;
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
			if (!_skill.water && !_skill.fire && !_skill.chaos && !_skill.poison)
			{
				if(_skill.hp_up == 0)
					skillTypeList.push(1);
				else
					skillTypeList.push(6);
			}
			if(_skill.water == 1)
				skillTypeList.push(2);
			if(_skill.chaos == 1)
				skillTypeList.push(3);
			if(_skill.poison == 1)
				skillTypeList.push(4);
			if(_skill.fire == 1)
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
					if(touch.tapCount == 2)
						onClick();
					if (_skillTip) _skillTip.hide();
					break;
				case TouchPhase.HOVER:
					
					if (!_skillTip.data || _skillTip.data.skill.id != _skill.id) _skillTip.setOtherData(_skill);
					this.parent.parent.addChild(_skillTip);
					_skillTip.x = touch.globalX - this.parent.parent.x + 10;
					_skillTip.y = touch.globalY - this.parent.parent.y + 10;
					break;
			}		
		}
		
		private function onClick() : void
		{
			//player.upgradeSkill.addUpgradeSkill(_skill.id);
			if(canClick)
			{
				_view.upgrade.setUpgradeSkill(_skill);
				_skillTip.setOtherData(_skill);
			}
			else
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"还未获得该技能，无法升级",
					null, null, false, true, false);
			}
		}
		
		public function clear() : void
		{			
			this.removeEventListeners();
			this.dispose();
		}
	}
}
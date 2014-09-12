package com.game.view.skill
{
	import com.engine.ui.controls.TipTextField;
	import com.engine.ui.core.BaseSprite;
	import com.engine.ui.core.Scale9Image;
	import com.engine.ui.core.Scale9Textures;
	import com.game.Data;
	import com.game.View;
	import com.game.data.db.protocal.Skill;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.SkillModel;
	import com.game.manager.FontManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class SkillTip extends BaseSprite
	{
		private var _bg:Scale9Image;
		private static const LEFT_GAP:Number=11;
		private static const TEXT_HGAP:Number=4;
		private static const TEXT_VGAP:Number=-1;
		private var _view:View = View.instance;
		private var _data:SkillModel;
		private static function get player() : Player
		{
			return Data.instance.player.player;
		}
		
		public function SkillTip()
		{
			
		}
		
		private var _texture:Texture;
		private var _lineTexture:Texture;
		public function init(bgTexture:Texture, lineTexture:Texture) : void
		{
			_texture = bgTexture;
			_lineTexture = lineTexture;
			
			initUI();
			initEvent();
		}
		
		private function initEvent() : void
		{
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this);
			
			if (!touch)
			{
				hide();
			}
		}
		
		private var _skillName:TipTextField;
		private var _skillUpgrade:TipTextField;
		private var _skillHarm:TipTextField;
		private var _skillDescribe:TipTextField;
		private var _skillExpend:TipTextField;
		private var _skillScope:TipTextField;
		
		private var _skillAttribute:TipTextField;
		private var _skillTime:TipTextField;
		private var _skillProbability:TipTextField;		
		private var _skillImage:Image;
		private var _skillHarm2:TipTextField;
		private var _skillExpend2:TipTextField;
		private var _skillTime2:TipTextField;
		private var _skillAttribute2:TipTextField;
		private var _skillScope2:TipTextField;
		private var _skillDescribe2:TipTextField;
		
		private var _skillOwner:TipTextField;
		private var _skillOwnerDetail:TipTextField;

		private var _lineImag:Image;
		
		private function initUI() : void
		{
			var textures:Scale9Textures = new Scale9Textures(_texture, new Rectangle(20, 20, 50, 50));
			_bg = new Scale9Image(textures);
			_bg.alpha = 0.8;
			_bg.width = 206;
			this.addChild(_bg);
			
			_lineImag=new Image(_lineTexture);
			addChild(_lineImag);
			_lineImag.x=_bg.width/2-_lineImag.width/2;
			
			// 技能名称
			_skillName = createTextField(180, 20, 0x66cc33);
			_skillName.hAlign = HAlign.LEFT;
			this.addChild(_skillName);
			_skillName.x =LEFT_GAP
			_skillName.y = 5;
			
			_skillUpgrade = createTextField(100, 20, V.BLUE_COLOR);
			_skillUpgrade.hAlign = HAlign.LEFT;
			this.addChild(_skillUpgrade);
			_skillUpgrade.x = LEFT_GAP;
			_skillUpgrade.y = 5;
			
			// 技能图标
			_skillImage = new Image(_texture);
			_skillImage.width = _skillImage.height = 36;
			this.addChild(_skillImage);
			_skillImage.x =145;
			_skillImage.y = 39;
			
			// 技能形容
			_skillDescribe = createTextField(133,20,0xffff00);
			this.addChild(_skillDescribe);
			_skillDescribe.x = LEFT_GAP;
			_skillDescribe2 = createTextField(133);
			_skillDescribe2.x = LEFT_GAP;
			this.addChild(_skillDescribe2);
			_skillDescribe2.x = LEFT_GAP;
			
			// 伤害
			_skillHarm = createTextField(150,20,0xffff00);
			this.addChild(_skillHarm);
			_skillHarm.x = LEFT_GAP;
			_skillHarm2 = createTextField();
			this.addChild(_skillHarm2);
			_skillHarm2.x = LEFT_GAP;
			
			
			// 技能消耗
			_skillExpend = createTextField(150,20,0xffff00);
			this.addChild(_skillExpend);
			_skillExpend.x = LEFT_GAP;
			_skillExpend2 = createTextField();
			this.addChild(_skillExpend2);
			_skillExpend2.x = LEFT_GAP;
			
			// 技能范围
			_skillScope = createTextField(150,20,0xffff00);
			this.addChild(_skillScope);
			_skillScope.x = LEFT_GAP;
			_skillScope2 = createTextField();
			this.addChild(_skillScope2);
			_skillScope2.x = LEFT_GAP;
			
			// 技能属性
			_skillAttribute = createTextField(150,20,0xffff00);
			this.addChild(_skillAttribute);
			_skillAttribute.x = LEFT_GAP;
			_skillAttribute2 = createTextField(180, 30);
			this.addChild(_skillAttribute2);
			_skillAttribute2.x = LEFT_GAP;
			
			//状态持续时间
			_skillTime = createTextField(150,20,0xffff00);
			_skillTime.x = LEFT_GAP;
			this.addChild(_skillTime);
			
			_skillTime2 = createTextField();
			_skillTime2.x = LEFT_GAP;
			this.addChild(_skillTime2);
			
			//技能拥有者
			_skillOwner = createTextField(150, 20, 0xffff00);
			this.addChild(_skillOwner);
			_skillOwner.x = LEFT_GAP;
			_skillOwnerDetail = createTextField(180, 30);
			this.addChild(_skillOwnerDetail);
			_skillOwnerDetail.x = LEFT_GAP;
		}
		
		
		
		public function get data() : SkillModel
		{
			return _data;
		}
		public function setData(data:SkillModel) : void
		{
			_data = data;
			
			initRender();
		}
		
		public function setOtherData(data:Skill) : void
		{
			_data = new SkillModel();
			_data.skill = data;
			
			initRender();
		}
		
		private function initRender() : void
		{
			_skillName.text = _data.skill.skill_name;
			
			var skillUpgradeInfo:String = (player.upgradeSkill.returnSkillLevel(_data.skill) == 0?"":" +" + player.upgradeSkill.returnSkillLevel(_data.skill));
			_skillUpgrade.text = skillUpgradeInfo;
			
			var skillImageName:String = "skill_" + _data.skill.id;
			_skillImage.texture = _view.skill.interfaces(InterfaceTypes.GetTexture, skillImageName);
			
			if(_data.skill.damage_ratio == 0)
			{
				_skillHarm.text = "技能恢复：";
				_skillHarm2.text= "" + (int(_data.skill.hp_up * 100) + player.upgradeSkill.isUpgradeSkill(_data.skill)) + "% 体力";
			}
			else
			{
				_skillHarm.text = "技能伤害：";
				_skillHarm2.text= "" + (int(_data.skill.damage_ratio * 100) + player.upgradeSkill.isUpgradeSkill(_data.skill)) + "% 攻击伤害";
			}
			
			_skillDescribe.text = "技能描述："  ;
			_skillDescribe2.text = "" + _data.skill.description;
			 
			
			_skillExpend.text = "技能消耗：" ;
			_skillExpend2.text = "" + (_data.skill.item_name==null||_data.skill.item_name=="无" ? _data.skill.skill_mp+" 元气" : _data.skill.item_name+" "+_data.skill.item_number+" 个");
			
			_skillScope.text = "技能范围：";
			_skillScope2.text = "" + _data.skill.range;
			
			_skillAttribute.text = "技能属性："
			_skillAttribute2.text = getSkillAttribute();
			
			_skillTime.text = "状态持续时间："  ;
			_skillTime2.text =  _data.skill.status_time+" 回合";
			
			_skillOwner.text = "技能拥有者：";
			_skillOwnerDetail.text = _data.skill.master;
			
			resetCompose();
		}
		
		private function resetCompose() : void
		{
			var tipsHeight:Number=0;
			// 技能名称
			_skillName.y = 5;
			_skillUpgrade.x = _skillName.x+_skillName.textBounds.width+TEXT_HGAP;
			
			
			// 技能形容
			_skillDescribe.y = _skillName.y + _skillName.height + TEXT_VGAP;
			_skillDescribe2.y = _skillDescribe.y+ _skillDescribe.height + TEXT_VGAP;;
			
			// 技能图标
			//_skillImage.x = (_bg.width-_skillImage.width)/2;
			_skillImage.y = _skillDescribe.y;

			_lineImag.y=_skillDescribe2.y+_skillDescribe2.height+TEXT_VGAP+6;
			 
			
			// 伤害
			_skillHarm.y = _lineImag.y +10;
			_skillHarm2.x = _skillHarm.x+_skillHarm.textBounds.width+TEXT_HGAP;
			_skillHarm2.y = _skillHarm.y;
			
			// 技能消耗
			/*if(_data.skill.damage_ratio == 0)
			{
				_skillExpend.y = _lineImag.y + 10;
				_skillExpend2.x = _skillExpend.x+_skillExpend.textBounds.width+TEXT_HGAP;
				_skillExpend2.y = _skillExpend.y
			}
			else
			{*/
				_skillExpend.y = _skillHarm.y + _skillHarm.height + TEXT_VGAP;
				_skillExpend2.x = _skillExpend.x+_skillExpend.textBounds.width+TEXT_HGAP;
				_skillExpend2.y = _skillExpend.y
			/*}*/
			// 技能范围
			_skillScope.y = _skillExpend.y + _skillExpend.height + TEXT_VGAP;
			_skillScope2.x=_skillScope.x+_skillScope.textBounds.width+TEXT_HGAP;
			_skillScope2.y=_skillScope.y
			// 技能属性
			_skillAttribute.y = _skillScope.y + _skillScope.height + TEXT_VGAP;
			_skillAttribute2.x=_skillAttribute.x+_skillAttribute.textBounds.width+TEXT_HGAP;
			_skillAttribute2.y=_skillAttribute.y
			
			tipsHeight= _skillAttribute.y + _skillAttribute.height + TEXT_VGAP;
			//状态持续时间
			_skillTime.y =tipsHeight;
			_skillTime2.x=_skillTime.x+_skillTime.textBounds.width+TEXT_HGAP-2;
			_skillTime2.y=_skillTime.y;
			if (_data.skill.status_time==0) 
			{
				_skillTime.visible = _skillTime2.visible = false;
			}else
			{
				_skillTime.visible=_skillTime2.visible = true;
				tipsHeight = _skillTime.y + _skillTime.height;
			}
			
			//技能拥有者
			_skillOwner.y = tipsHeight;
			_skillOwnerDetail.x = _skillOwner.x + _skillOwner.textBounds.width + TEXT_HGAP;
			_skillOwnerDetail.y = _skillOwner.y;
			
			_bg.height = _skillOwner.y + _skillOwner.height + TEXT_VGAP + 6;
		}
		
		private function getSkillAttribute() : String
		{
			 
			var info:String = "";
			if(_data.skill.water == 1)
			{
				info += "水属性  ";
			}
			
			if(_data.skill.fire == 1)
			{
				info += "火属性  ";
			}
			
			if(_data.skill.chaos == 1)
			{
				info += "混沌属性  ";
			}
			
			if(_data.skill.poison == 1)
			{
				info += "毒属性  ";
			}
			
			if (!_data.skill.water && !data.skill.fire && !_data.skill.chaos && !_data.skill.poison)
			{
				info += "无";
			}
			
			return info;
		}
		
		protected function createTextField(W:int=180, H:int=20, Col:Number=0Xffffff, Str:String='', Size:uint=12, HAl:String=HAlign.LEFT, Auto:Boolean=true, Wor:Boolean=true) : TipTextField
		{
			var mytext:TipTextField = new TipTextField(W,H,Str);
			mytext.color=Col;
			mytext.fontSize=Size;
			mytext.hAlign=HAl;
			//mytext.fontName = FontManager.instance.font.fontName;
			return mytext;
		}
		
		public function hide():void
		{
			if (this.parent) this.parent.removeChild(this);
		}
		
		override public function set y(value:Number):void
		{
			if(value+this.height+this.parent.y>GameConfig.CAMERA_HEIGHT + 5)
			{
				value=GameConfig.CAMERA_HEIGHT - this.height - this.parent.y + 5;
			}
			super.y = value;
		}
	}
}
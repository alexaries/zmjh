package com.game.view.equip
{
	import com.engine.ui.controls.TipTextField;
	import com.engine.ui.core.BaseSprite;
	import com.engine.ui.core.Scale9Image;
	import com.engine.ui.core.Scale9Textures;
	import com.game.View;
	import com.game.data.equip.EquipConfig;
	import com.game.data.player.structure.RoleModel;
	import com.game.manager.FontManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class RoleTip extends BaseSprite
	{
		private var _bg:Scale9Image;
		private var _line:Image;
		private var _money:Image;
		private static const LEFT_GAP:Number=11;
		private static const TXT2_X:Number=45;
		private static const TEXT_VGAP:Number=-1;
		private var _view:View = View.instance;
		private static const TEXT_HGAP:Number=4;
		private var _data:RoleModel;
		public function get data() : RoleModel
		{
			return _data;
		}
		
		public function RoleTip()
		{
		}
		
		private var _bgTexture:Texture;
		private var _moneyTexture:Texture;
		private var _lineTexture:Texture;
		public function init(bgTexture:Texture, moneyTx:Texture, line:Texture) : void
		{
			_bgTexture = bgTexture;
			_moneyTexture = moneyTx;
			_lineTexture = line;
			
			initUi();
			initEvent();
		}
		
		private var _nameTxt:TipTextField;
		private var _lvTxt:TipTextField;
		private var _abilityTxt:TipTextField;
		private var _qualificationsTxt:TipTextField;
		private var _locationTxt:TipTextField;
		private var _hpTxt:TipTextField;
		
		private var _mpTxt:TipTextField;
		private var _mpTxt2:TipTextField;
		private var _addAttribute:TipTextField;
		private var _belongAttribute:TipTextField;
		private var _atkTxt:TipTextField;
		private var _lineImag:Image;
		private var _defTxt:TipTextField;
		private var _evasionTxt:TipTextField;
		private var _critTxt:TipTextField;
		private var _spdTxt:TipTextField;
		private var _skillTxt:TipTextField;
		private var _lvTxt2:TipTextField;
		private var _abilityTxt2:TipTextField;
		private var _qualificationsTxt2:TipTextField;
		private var _locationTxt2:TipTextField;
		private var _hpTxt2:TipTextField;
		private var _atkTxt2:TipTextField;
		private var _defTxt2:TipTextField;
		private var _evasionTxt2:TipTextField;
		private var _critTxt2:TipTextField;
		private var _spdTxt2:TipTextField;
		private var _skillTxt2:TipTextField;
		private var _skillRangeTxt:TipTextField;
		private var _skillRangeTxt2:TipTextField;
		private function initUi() : void
		{
			// 底图
			var textures:Scale9Textures = new Scale9Textures(_bgTexture, new Rectangle(20, 20, 50, 50));
			_bg = new Scale9Image(textures);
			_bg.alpha = 0.8;
			_bg.width = 134;
			this.addChild(_bg);
			
			//名称
			_nameTxt = createTextField(120,19,0xff9900,"",15);
			_nameTxt.x = LEFT_GAP
			_nameTxt.y = 10;
			this.addChild(_nameTxt);
			
			// 等级
			_lvTxt = createTextField(60);
			_lvTxt.x = LEFT_GAP
			_lvTxt.y = 10;
			_lvTxt.color=0xffff00;
			_lvTxt.text="等级：";
			this.addChild(_lvTxt);
			_lvTxt2 = createTextField(60);
			this.addChild(_lvTxt2);
			_lvTxt2.x=  TXT2_X;
			
			_abilityTxt = createTextField(60);
			_abilityTxt.x = LEFT_GAP
			_abilityTxt.y = 10;
			_abilityTxt.color=0xffff00;
			_abilityTxt.text="品质：";
			this.addChild(_abilityTxt);
			_abilityTxt2 = createTextField(60);
			this.addChild(_abilityTxt2);
			_abilityTxt2.x=  TXT2_X;
			
			
			//资质
			_qualificationsTxt = createTextField();
			_qualificationsTxt.x = LEFT_GAP
			_qualificationsTxt.color=0xffff00;
			_qualificationsTxt.text="资质："
			this.addChild(_qualificationsTxt);
			_qualificationsTxt2 = createTextField();
			this.addChild(_qualificationsTxt2);
			_qualificationsTxt2.x=  TXT2_X;
			
			//定位
			_locationTxt = createTextField();
			_locationTxt.x = LEFT_GAP;
			_locationTxt.color = 0xffff00;
			_locationTxt.text = "定位：";
			this.addChild(_locationTxt);
			_locationTxt2 = createTextField();
			this.addChild(_locationTxt2);
			_locationTxt2.x = TXT2_X;
			
			// 体力
			_hpTxt = createTextField(60);
			_hpTxt.x = LEFT_GAP;
			_hpTxt.color=0xffff00;
			_hpTxt.y = _qualificationsTxt.y;
			_hpTxt.text="体力：";
			this.addChild(_hpTxt);
			_hpTxt2 = createTextField(60);
			_hpTxt2.y = _qualificationsTxt.y;
			this.addChild(_hpTxt2);
			_hpTxt2.x=  TXT2_X
			
			
			//元气
			_mpTxt = createTextField(180, 35);
			_mpTxt.x = LEFT_GAP
			_mpTxt.color=0xffff00;
			_mpTxt.text="元气：";
			this.addChild(_mpTxt);
			_mpTxt2 = createTextField(180, 35);
			this.addChild(_mpTxt2);
			_mpTxt2.x= TXT2_X
			
			
			//外功
			_atkTxt=createTextField();
			_atkTxt.color=0xffff00;
			_atkTxt.text="外功：";
			_atkTxt.x = LEFT_GAP;
			this.addChild(_atkTxt);
			_atkTxt2=createTextField();
			this.addChild(_atkTxt2);
			_atkTxt2.x=  TXT2_X
			
			
			// 根骨
			 _defTxt=createTextField();
			 _defTxt.color=0xffff00;
			 _defTxt.text="根骨：";
			 _defTxt.x = LEFT_GAP;
			 this.addChild(_defTxt);
			 _defTxt2=createTextField();
			 this.addChild(_defTxt2);
			 _defTxt2.x= TXT2_X
			 
			 
			 //灵活
			 _evasionTxt=createTextField();
			 _evasionTxt.color=0xffff00;
			 _evasionTxt.text="灵活：";
			 _evasionTxt.x = LEFT_GAP;
			 this.addChild(_evasionTxt);
			 _evasionTxt2=createTextField();
			 this.addChild(_evasionTxt2);
			 _evasionTxt2.x= TXT2_X
			 
			 
			 //暴击
			 _critTxt=createTextField();
			 _critTxt.color=0xffff00;
			 _critTxt.text="暴击：";
			 _critTxt.x = LEFT_GAP;
			 this.addChild(_critTxt);
			 _critTxt2=createTextField();
			 this.addChild(_critTxt2);
			 _critTxt2.x= TXT2_X
			 
			
			 
			 //步法
			 _spdTxt=createTextField();
			 _spdTxt.color=0xffff00;
			 _spdTxt.text="步法：";
			 _spdTxt.x = LEFT_GAP;
			 this.addChild(_spdTxt);
			 _spdTxt2=createTextField();
			 this.addChild(_spdTxt2);
			 _spdTxt2.x= TXT2_X
			 
			 
			 //技能
			 _skillTxt=createTextField();
			 _skillTxt.color=0xffff00;
			 _skillTxt.text="技能：";
			 _skillTxt.x = LEFT_GAP;
			 this.addChild(_skillTxt);
			 _skillTxt2=createTextField();
			 this.addChild(_skillTxt2);
			 _skillTxt2.x=  TXT2_X;
				 
		
			 //技能
			 _skillRangeTxt=createTextField();
			 _skillRangeTxt.color=0xffff00;
			 _skillRangeTxt.text="技能效果：";
			 _skillRangeTxt.x = LEFT_GAP;
			 this.addChild(_skillRangeTxt);
			 _skillRangeTxt2=createTextField();
			 this.addChild(_skillRangeTxt2);
			 _skillRangeTxt2.x=  TXT2_X + 25;
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
		
		public function setData(data:RoleModel) : void
		{
			_data = data;
			
			initRender();
		}
		
		private function initRender() : void
		{
			_nameTxt.text = _data.configData.name;
			//强化
			if (_data.configData.lv != 0) _lvTxt2.text = "" + _data.model.lv;
			else _lvTxt2.text = "";
			
			_abilityTxt2.text = _data.configData.grade;
			_qualificationsTxt2.text=_data.configData.qualifications;
			_locationTxt2.text = _data.configData.location;
			_hpTxt2.text = _data.model.hp.toString();
			_mpTxt2.text =  _data.model.mp.toString();
			_atkTxt2.text = _data.model.atk.toString();
			_defTxt2.text = _data.model.def.toString();
			_evasionTxt2.text = _data.model.evasion.toString();
			_critTxt2.text = _data.model.crit.toString();
			_spdTxt2.text = _data.model.spd.toString();
			_skillTxt2.text = _data.configData.fixedskill_name==""|| _data.configData.fixedskill_name=="无"?"": _data.configData.fixedskill_name;
			_skillRangeTxt2.text = _data.configData.skill_info;
			
			resetCompose();
		}
		
		private function resetCompose() : void
		{
			//装备名称
			_nameTxt.y = 10;
			 
			_lvTxt.y = _nameTxt.y +_nameTxt.height+TEXT_VGAP;
			_lvTxt2.y = _lvTxt.y;
			
			_abilityTxt.y = _lvTxt.y +_lvTxt.height+TEXT_VGAP;
			_abilityTxt2.y = _abilityTxt.y;

			_qualificationsTxt.y = _abilityTxt.y +_abilityTxt.height+TEXT_VGAP;
			_qualificationsTxt2.y = _qualificationsTxt.y;	
			
			_locationTxt.y = _qualificationsTxt.y+_qualificationsTxt.height+TEXT_VGAP;
			_locationTxt2.y = _locationTxt.y;
			 
			_hpTxt.y = _locationTxt.y+_locationTxt.height+TEXT_VGAP;
			_hpTxt2.y = _hpTxt.y;
			  
			_mpTxt.y = _hpTxt.y + _hpTxt.height+TEXT_VGAP;
			_mpTxt2.y = _mpTxt.y;
			
			_atkTxt.y = _mpTxt.y + _mpTxt.height+TEXT_VGAP;
			_atkTxt2.y = _atkTxt.y;		
			
			_defTxt.y = _atkTxt.y + _atkTxt.height+TEXT_VGAP;
			_defTxt2.y = _defTxt.y;	
			
			_evasionTxt.y = _defTxt.y + _defTxt.height+TEXT_VGAP;
			_evasionTxt2.y = _evasionTxt.y;
			
			
			
			_critTxt.y = _evasionTxt.y + _evasionTxt.height+TEXT_VGAP;
			_critTxt2.y = _critTxt.y;
			
			_spdTxt.y = _critTxt.y + _critTxt.height+TEXT_VGAP;
			_spdTxt2.y = _spdTxt.y;
			
			var yy:Number= _spdTxt.y + _spdTxt.height+TEXT_VGAP;
			if (_skillTxt2.text=="") 
			{
				_skillTxt.y = yy;
				_skillTxt2.y = _skillTxt.y;
				_skillTxt.visible=false;
				
				_skillRangeTxt.y = yy;
				_skillRangeTxt2.y = _skillTxt.y;
				_skillRangeTxt.visible = false;
				_skillRangeTxt2.visible = false;
				
				_bg.height = yy + 10;
				
			}else
			{
				_skillTxt.y = yy;
				_skillTxt2.y = _skillTxt.y;
				_skillTxt.visible=true;
				yy= _skillTxt.y + _skillTxt.height;
					
				_skillRangeTxt.visible=true;
				_skillRangeTxt2.visible = true;
				_skillRangeTxt.y = _skillTxt2.y + _skillTxt.height + TEXT_VGAP;
				_skillRangeTxt2.y = _skillRangeTxt.y;
				
				_bg.height = _skillRangeTxt.y + _skillRangeTxt.height + 10;
			}
			
			
			 
			
		}
		
/*		private function getBaseAttributeStr() : String
		{
			var str:String = "";
			if(_data.config.type == EquipConfig.WEAPON)
			{
				str = ""+"外功  "+_data.atk;
			}
			else if(_data.config.type == EquipConfig.CLOTHES)
			{
				str = "" + "根骨  " + _data.def;
			}
			else if(_data.config.type == EquipConfig.THING)
			{
				str = "" + "步法  " + _data.spd;
			}
			
			return str;
		}*/
		
		protected function createTextField(W:int=90, H:int=19, Col:Number=0Xffffff, Str:String='', Size:uint=12, HAl:String=HAlign.LEFT, Auto:Boolean=true, Wor:Boolean=true) : TipTextField
		{
			var mytext:TipTextField=new TipTextField(W,H,Str);
			mytext.color=Col;
			//mytext.fontName = FontManager.instance.font.fontName;
			mytext.fontSize=Size;
			mytext.hAlign=HAl;
			return mytext;
		}
		
		public function hide():void
		{
			if (this.parent) this.parent.removeChild(this);
		}
		
		override public function set y(value:Number):void
		{
			if(value+this.height>GameConfig.CAMERA_HEIGHT)
			{
				value=GameConfig.CAMERA_HEIGHT-this.height-4;
			}
			super.y = value;
		}
	}
}
package com.game.view.ui
{
	import com.engine.ui.controls.ShortCutMenu;
	import com.game.Data;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.AppendAttribute.AppendAttributeTip;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.effect.DeformTip;
	import com.game.view.equip.EquipTip;
	import com.game.view.equip.PropTip;
	import com.game.view.equip.RoleTip;
	import com.game.view.prop.PropsTip;
	import com.game.view.skill.SkillTip;
	import com.game.view.vip.SpecialTip;
	
	import starling.textures.Texture;

	public class UIView extends BaseView implements IView
	{
		// 背景位图
		private var _bgTexture:Texture;
		// 金钱纹理
		private var _moneyTexture:Texture;
		// 分隔符
		private var _lineTexture:Texture;
		// 战魂
		private var _fightSoulTexture:Texture;
		
		public function UIView()
		{
			_moduleName = V.UI;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					show();
					break;
				case UIConfig.GET_SHORT_CUT_MENU:
					return _shortCutMenu;
					break;
				case UIConfig.GET_SKILL_TIP:
					return _skillTip;
					break;
				case UIConfig.GET_EQUIP_TIP:
					return this._equipTip;
					break;
				case UIConfig.GET_ROLE_TIP:
					return this._roleTip;
					break;
				case UIConfig.GET_PROPS_TIP:
					return _propsTip;
					break;
				case UIConfig.PROP_TIP:
					return this._propTip;
					break;
				case UIConfig.GET_APD_ATTRIBUTE_TIP:
					return this._appAttributeTip;
					break;
				case UIConfig.DEFORM_TIP:
					return this._deformTip;
					break;
				case UIConfig.GET_SPECIAL_TIP:
					return this._specialTip;
					break;
			}
		}
		
		override protected function show():void
		{
			this.initLoad();
		}
		
		override protected function init() : void
		{
			if (!this.isInit)
			{
				super.init();
				isInit = true;
				
				initUI();
			}
		}
		
		private function initUI() : void
		{
			_bgTexture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, "ToolTipBg");
			_moneyTexture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, "moneyImage");
			_lineTexture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, "line");
			_fightSoulTexture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, "Toolbar_WarValue");
			
			initShortCutMenu();
			initSkillTip();
			initEquipTip();
			initRoleTip();
			initPropTip();
			initPropsTip();
			initSpecialTip();
			initAppendAttributeTip();
			initDeformTip();
		}
		
		private var _shortCutMenu:ShortCutMenu;
		protected function initShortCutMenu() : void
		{
			if (!_shortCutMenu)
			{
				_shortCutMenu = new ShortCutMenu();
				_shortCutMenu.init(_bgTexture);
			}
		}
		
		private var _skillTip:SkillTip;
		protected function initSkillTip() : void
		{
			if (!_skillTip)
			{
				_skillTip = new SkillTip();
				_skillTip.init(_bgTexture, _lineTexture);
			}
		}
		
		private var _equipTip:EquipTip;
		protected function initEquipTip() : void
		{
			if (!_equipTip)
			{
				_equipTip = new EquipTip();
				_equipTip.init(_bgTexture, _moneyTexture, _lineTexture);
			}
		}
		
		private var _roleTip:RoleTip;
		protected function initRoleTip() : void
		{
			if (!_roleTip)
			{
				_roleTip = new RoleTip();
				_roleTip.init(_bgTexture, _moneyTexture, _lineTexture);
			}
		}
		
		
		
		private var _propTip:PropTip;
		protected function initPropTip() : void
		{
			if (!_propTip)
			{
				_propTip = new PropTip();
				_propTip.init(_bgTexture, _moneyTexture, _lineTexture);
			}
		}
		
		private var _propsTip:PropsTip;
		protected function initPropsTip() : void
		{
			if(!_propsTip)
			{
				_propsTip = new PropsTip();
				_propsTip.init(_bgTexture, _moneyTexture, _lineTexture);
			}
		}
		
		private var _specialTip:SpecialTip;
		protected function initSpecialTip() : void
		{
			if(!_specialTip)
			{
				_specialTip = new SpecialTip();
				_specialTip.init(_bgTexture, _moneyTexture, _lineTexture);
			}
		}
		
		private var _appAttributeTip:AppendAttributeTip;
		protected function initAppendAttributeTip() : void
		{
			if (!_appAttributeTip)
			{
				_appAttributeTip = new AppendAttributeTip();
				_appAttributeTip.init(_bgTexture, _fightSoulTexture, _lineTexture);
			}
		}
		
		private var _deformTip:DeformTip
		protected function initDeformTip() : void
		{
			if(!_deformTip)
			{
				_deformTip = new DeformTip();
			}
		}
	}
}
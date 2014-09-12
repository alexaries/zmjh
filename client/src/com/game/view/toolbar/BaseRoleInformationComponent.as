package com.game.view.toolbar
{
	import com.game.Data;
	import com.game.data.player.PlayerEvent;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class BaseRoleInformationComponent extends Component
	{
		public static const LEG_ID:int = 3;
		
		public function BaseRoleInformationComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
			initEvent();
		}
		
		private var _lv:TextField;
		private var _hp:TextField;
		private var _hpBar:Image;
		private var _hpW:int;
		private var _mp:TextField;
		private var _mpBar:Image;
		private var _mpW:int;
		private var _exp:TextField;
		private var _expBar:Image;
		private var _expW:int;
		private var _revive:Button;
		private var _help:Image;
		protected var _rainCircle:Image;
		protected var _nightCircle:Image;
		protected var _thunderCircle:Image;
		protected var _windCircle:Image;
		protected var _mainRainCircle:Image;
		protected var _mainNightCircle:Image;
		protected var _mainThunderCircle:Image;
		protected var _mainWindCircle:Image;
		private function getUI() : void
		{
			_lv = (searchOf("LV") as TextField);
			_lv.fontName = V.SONG_TI;
			_lv.bold = true;
			_hp = (searchOf("HP") as TextField);
			_hp.fontName = V.SONG_TI;
			_hp.bold = true;
			_mp = (searchOf("MP") as TextField);
			_mp.fontName = V.SONG_TI;
			_mp.bold = true;
			_exp = (searchOf("EXP") as TextField);
			_exp.fontName = V.SONG_TI;
			_exp.bold = true;
			
			_hpBar = (searchOf("Toolbar_World_RoleHp") as Image);
			_hpW = _hpBar.width;			
			_mpBar = (searchOf("Toolbar_World_RoleMp") as Image);
			_mpW = _mpBar.width;			
			_expBar = (searchOf("Toolbar_World_RoleExp") as Image);
			_expW = _expBar.width;
			_revive = (searchOf("Revive") as Button);
			_help = (searchOf("Help") as Image);
			
			_rainCircle = (searchOf("Rain_Circle") as Image);
			_nightCircle = (searchOf("Night_Circle") as Image);
			_thunderCircle = (searchOf("Thunder_Circle") as Image);
			_windCircle = (searchOf("Wind_Circle") as Image);
			
			if(_rainCircle != null)
			{
				_rainCircle.touchable = false;
				_rainCircle.visible = false;
			}
			if(_nightCircle != null) 
			{
				_nightCircle.touchable = false;
				_nightCircle.visible = false;
			}
			if(_thunderCircle != null)
			{
				_thunderCircle.touchable = false;
				_thunderCircle.visible = false;
			}
			if(_windCircle != null)
			{
				_windCircle.touchable = false;
				_windCircle.visible = false;
			}
			
			_mainRainCircle = (searchOf("Main_Rain_Circle") as Image);
			_mainNightCircle = (searchOf("Main_Night_Circle") as Image);
			_mainThunderCircle = (searchOf("Main_Thunder_Circle") as Image);
			_mainWindCircle = (searchOf("Main_Wind_Circle") as Image);
			
			if(_mainRainCircle != null)
			{
				_mainRainCircle.touchable = false;
				_mainRainCircle.visible = false;
			}
			if(_mainNightCircle != null) 
			{
				_mainNightCircle.touchable = false;
				_mainNightCircle.visible = false;
			}
			if(_mainThunderCircle != null)
			{
				_mainThunderCircle.touchable = false;
				_mainThunderCircle.visible = false;
			}
			if(_mainWindCircle != null)
			{
				_mainWindCircle.touchable = false;
				_mainWindCircle.visible = false;
			}
		}
		
		protected var _roleName:String;
		protected var _roleModel:RoleModel;
		protected var _roleImage:Image;
		public function setRoleName(roleName:String) : void
		{
			_roleName = roleName;
			
			if (_roleModel) _roleModel.removeEventListener(PlayerEvent.ROLE_HP_CHANGE, onRoleHpChange);
			
			_roleModel = player.getRoleModel(roleName);
			_roleModel.addEventListener(PlayerEvent.ROLE_HP_CHANGE, onRoleHpChange);
			
			renderImage();
			onRoleHpChange(null);
		}
		
		/**
		 * hp改变 
		 * @param e
		 * 
		 */		
		private function onRoleHpChange(e:Event) : void
		{
			renderUI();
			
			// 死亡
			if (_roleModel.hp <= 0)
			{
				_roleImage.filter = new GrayscaleFilter();
				_revive.visible = true;
				_help.visible = true;
			}
			else
			{
				_roleImage.filter = null;
				_revive.visible = false;
				_help.visible = false;
			}
		}
		
		private function renderUI() : void
		{
			_lv.text = _roleModel.info.lv.toString();
			_hp.text = _roleModel.hp + "/" + _roleModel.model.hp;
			_hpBar.width = (_roleModel.hp / _roleModel.model.hp) * _hpW;
			_mp.text = _roleModel.mp + "/" + _roleModel.model.mp;
			_mpBar.width = (_roleModel.mp / _roleModel.model.mp) * _mpW;
			_exp.text = _roleModel.info.exp + "/" + _roleModel.nextExp;
			_expBar.width = (_roleModel.info.exp / _roleModel.nextExp) * _expW;
			
			this.panel.visible = true;
		}
		
		protected function renderImage() : void
		{
			throw new Error("需重写");
		}
		
		override protected function initEvent():void
		{
			super.initEvent();
			
			if (!_roleImage) 
			{
				_roleImage = (searchOf("Toolbar_World_Role") as Image);
				_roleImage.useHandCursor = true;
			}
			_roleImage.addEventListener(TouchEvent.TOUCH, onImageTouch);
		}
		
		private function onImageTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_roleImage);
			
			if(touch && touch.phase == TouchPhase.BEGAN)
			{
				_view.toolbar.interfaces(InterfaceTypes.LOCK);
			}
			if (touch && touch.phase == TouchPhase.ENDED)
			{
				_view.role.interfaces(InterfaceTypes.Show, _roleName);
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				// 复活
				case "Revive":
					onRevive();
					break;
			}
		}
		
		/**
		 * 复活 
		 * 
		 */		
		private function onRevive() : void
		{
			var num:int = player.pack.getPropNumById(LEG_ID);
			var content:String;
			if (num > 0)
			{
				content = "复活" + _roleModel.info.roleName + "需要消耗一个雪山人参,是否复活该角色？";
				
				_view.tip.interfaces(InterfaceTypes.Show,
					content,
					okCallback, cancelCallback);
			}
			else
			{
				content = "你的雪山人参不足,无法复活该角色，是否移步到商城购买？";
				_view.tip.interfaces(InterfaceTypes.Show,
					content,
					gotoMall, null);
			}
		}
		
		private function gotoMall() : void
		{
			_view.tip.hide();
			_view.shop.interfaces(InterfaceTypes.GET_MALL, "雪山人参", resetRender);
		}
		
		private function resetRender() : void
		{
			_view.tip.hide();
			_view.layer.setTipMaskHide();
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
		
		private function okCallback() : void
		{
			var num:int = player.pack.getPropNumById(LEG_ID);
			player.pack.setPropNum(num-1, LEG_ID);
			// 复活原hp值的50%
			_roleModel.hp = _roleModel.model.hp * 0.5;
			
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
		
		private function cancelCallback() : void
		{
			
		}
		
		public function removeFromStage() : void
		{
			if (this.panel.parent) panel.parent.removeChild(this.panel);
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new RoleInformationComponent(_configXML, _titleTxAtlas);
		}
	}
}
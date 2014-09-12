package com.game.view.LevelEvent
{
	import com.game.data.db.protocal.Equipment;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.PropModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	import com.game.view.effect.GlowAnimationEffect;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class ItemComponent extends Component
	{
		public function ItemComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			init();
		}
		
		override protected function init() : void
		{
			super.init();
			
			initEvent();
			initBeginEvent();
			getUI();
			initUI();
		}
		
		private var _reward:TextField;
		private var _image:Image;
		private function getUI() : void
		{
			if (!_reward) _reward = this.searchOf("Tx_Reward");
			
			if (!_image) _image = this.searchOf("Image");
		}
		
		
		private var _glowAnimation:GlowAnimationEffect;
		private function initUI() : void
		{
			if (!_glowAnimation) _glowAnimation = new GlowAnimationEffect(this.panel, 0xff0000);
		}
		
		/**
		 * 物品数量 
		 * @param value
		 * 
		 */
		private var _data:*;
		private var _type:String;
		public function setReward(value:*, type:String) : void
		{
			_data = value;
			_type = type;
			
			_glowAnimation.stop();
			
			switch (type)
			{
				case V.MONEY_ITEMBOX:
					_reward.text = value;
					_image.texture = _titleTxAtlas.getTexture("Money");
					break;
				case V.EQUIP_ITEMBOX:
					var equipName:String = "equip_" + (value as EquipModel).config.id;
					_reward.text = (value as EquipModel).config.name;
					_image.texture = _view.equip.interfaces(InterfaceTypes.GetTexture, equipName);
					break;
				case V.PROP_ITEMBOX:
					var propName:String = "props_" + (value as PropModel).config.id;
					_reward.text = (value as PropModel).config.name;
					_image.texture = _view.icon.interfaces(InterfaceTypes.GetTexture, propName);
					break;
			}
			
			_image.readjustSize();
			
			
			switch (type)
			{
				case V.PROP_ITEMBOX:
					_image.width = _image.height = 38;
					break;
				case V.EQUIP_ITEMBOX:
					_image.width = _image.height = 42;
					break;
				case V.MONEY_ITEMBOX:
					_image.width = 26;
					_image.height = 30;
					break;
			}
				
			_image.pivotX = _image.texture.width * _image.pX;
			_image.pivotY = _image.texture.height * _image.pY;
		}
		
		// 选择卡牌了
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			_view.openItemBox.interfaces(InterfaceTypes.ITEM_SELECTED, this.name, _data, _type);
			_glowAnimation.play();
		}
		
		
		override protected function onClickBeginHandle(e:ViewEventBind) : void
		{
			_view.openItemBox.interfaces(InterfaceTypes.LOCK);
		}
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new ItemComponent(_configXML, _titleTxAtlas);
		}
		
		public function setStatus(layer:String) : void
		{
			for (var i:int = 0; i <　this._uiLibrary.length; i++)
			{
				if (_uiLibrary[i]["layerName"] == "BackSence")
				{
					_uiLibrary[i].visible = (layer == "BackSence");
				}
				else
				{
					_uiLibrary[i].visible = (layer == "FrontSence");
				}
			}
		}
	}
}
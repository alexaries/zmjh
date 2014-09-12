package com.game.view.endless
{
	import com.game.data.player.structure.PropModel;
	import com.game.template.InterfaceTypes;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	import com.game.view.effect.GlowAnimationEffect;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class EndlessItemComponent extends Component
	{
		public function EndlessItemComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			init();
		}
		
		override protected function init() : void
		{
			super.init();
			
			initEvent();
			getUI();
			initUI();
		}
		
		private var _reward:TextField;
		private var _image:Image;
		private var _rewardNum:TextField;
		private function getUI() : void
		{
			if (!_reward) _reward = this.searchOf("Tx_Reward");
			
			if (!_image) _image = this.searchOf("Image");
			
			if (!_rewardNum) _rewardNum = this.searchOf("Tx_Num");
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
		private var _isEndless:Boolean;
		public function setReward(value:*) : void
		{
			_data = value;
			
			_glowAnimation.stop();
			
			var propName:String = "props_" + (value as PropModel).config.id;
			_reward.text = (value as PropModel).config.name;
			_image.texture = _view.icon.interfaces(InterfaceTypes.GetTexture, propName);
			
			_image.readjustSize();
			
			_image.width = _image.height = 38;
			
			_image.pivotX = _image.texture.width * _image.pX;
			_image.pivotY = _image.texture.height * _image.pY;
			
			_rewardNum.text = (value as PropModel).num.toString();
		}
		
		// 选择卡牌了
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			_view.endless_prop_box.interfaces(InterfaceTypes.ITEM_SELECTED, this.name, _data);
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new EndlessItemComponent(_configXML, _titleTxAtlas);
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
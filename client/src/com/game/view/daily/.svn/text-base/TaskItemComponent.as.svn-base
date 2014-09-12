package com.game.view.daily
{
	import com.game.data.db.protocal.Equipment;
	import com.game.data.player.structure.PropModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	import com.game.view.effect.GlowAnimationEffect;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class TaskItemComponent extends Component
	{
		public function TaskItemComponent(item:XML, titleTxAtlas:TextureAtlas)
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

		private var _name:String;
		public function setReward(img:Image) : void
		{
			resetPosition(_configXML.layer[1]);
			
			_image.texture = img.texture;
			_name = img.name;
			
			_glowAnimation.stop();
			_image.readjustSize();
			resetImage(_image);
			
			setRewardName(img);
		}
		
		private function setRewardName(img:Image) : void
		{
			switch(_name)
			{
				case "dice":
					_reward.text = "骰子";
					_image.x -= 2;
					_image.y -= 4;
					break;
				case "equip":
					_reward.text = img.data[0].toString();
					break;
				case "prop":
					_reward.text = img.data[0].toString();
					break;
				case "money":
					_reward.text = "金币";
					_image.x -= 2;
					break;
				case "war":
					_reward.text = "战魂";
					_image.x += 4;
					_image.y -= 1;
					break;
			}
		}
		
		// 选择卡牌了
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			var comp:TaskItemComponent = this;
			_view.controller.save.onlineStatus(continueSave);
			
			function continueSave() : void
			{
				_view.task_box.interfaces(InterfaceTypes.ITEM_SELECTED, _name, comp);
				_glowAnimation.play();
			}
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new TaskItemComponent(_configXML, _titleTxAtlas);
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
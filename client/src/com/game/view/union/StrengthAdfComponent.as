package com.game.view.union
{
	import com.game.data.DataList;
	import com.game.data.strength.StrengthDetail;
	import com.game.template.InterfaceTypes;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	import com.game.view.effect.EffectShow;
	import com.game.view.effect.TextColorEffect;
	import com.game.view.effect.TweenEffect;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class StrengthAdfComponent extends Component
	{
		public function StrengthAdfComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			init();
		}
		
		override protected function init() : void
		{
			super.init();
			getUI();
			initEvent();
		}
		
		private var _expTF:TextField;
		private var _expBar:Image;
		private var _levelTF_1:TextField;
		private var _levelTF_2:TextField;
		private var _upgradeTF_1:TextField;
		private var _upgradeTF_2:TextField;
		private var _soulTF:TextField;
		private var _textEffect_1:TextColorEffect;
		private var _textEffect_2:TextColorEffect;
		private var _martialBtn:Button;
		private var _tweenEffect:TweenEffect;
		private var _effect:MovieClip;
		private var _effectShow:EffectShow;
		private function getUI():void
		{
			_expTF = this.searchOf("NeedDetail");
			_expBar = this.searchOf("RoleExpBar");
			_levelTF_1 = this.searchOf("LevelDetail_1");
			_levelTF_2 = this.searchOf("LevelDetail_2");
			_upgradeTF_1 = this.searchOf("UpgradeDetail_1");
			_upgradeTF_2 = this.searchOf("UpgradeDetail_2");
			_soulTF = this.searchOf("SoulDetail");
			_martialBtn = this.searchOf("MartialBtn");
			_textEffect_1 = new TextColorEffect(_soulTF, 0xFFFF00, 0xFF0000, 0xFF0000, .6);
			_tweenEffect = new TweenEffect();
			
			if(_effect == null)
			{
				_effectShow = new EffectShow(this.panel);
				var textures:Vector.<Texture> = _view.other_effect.interfaces(InterfaceTypes.GetTextures, "light_00");
				_effect = new MovieClip(textures);
				_effect.x = -100;
				_effect.y = -150;
			}
		}
		
		private var _info:StrengthDetail;
		private var _position:String;
		public function setStrengthData(position:String, info:StrengthDetail) : void
		{
			_position = position;
			_info = info;
			
			render()
		}
		
		public function render():void
		{
			if(_info == null) return;
			renderTF();
			renderButton();
			renderEffect();
		}
		
		private function renderButton():void
		{
			if(_info.adf >= _view.strength.strengthData.length)
				removeTouchable(_martialBtn);
			else
				addTouchable(_martialBtn);
			/*if(player.fight_soul <  DataList.list[2000] * 10 || player.strength_exp < _strengthData.exp_add)
				removeTouchable(_martialBtn);
			else
				addTouchable(_martialBtn);*/
		}
		
		private var _strengthData:Object;
		private function renderTF():void
		{
			//内功达到满级
			if(_info.adf >= _view.strength.strengthData.length)
			{
				_strengthData = _view.strength.strengthData[_info.adf - 1];
				_levelTF_1.text = _info.adf.toString();
				_levelTF_2.text = "无";
				_upgradeTF_1.text = _strengthData.adf.toString();
				_upgradeTF_2.text = "无";
				_expTF.text = _strengthData.exp_all + "/" + _strengthData.exp_all;
				_expBar.width = 104;
				_info.adf_exp = DataList.list[0];
				return;
			}
			
			_strengthData = _view.strength.strengthData[_info.adf];
			
			_levelTF_1.text = _info.adf.toString();
			_levelTF_2.text = (_info.adf + 1).toString();
			_upgradeTF_1.text = (_info.adf == 0?"0":_view.strength.strengthData[_info.adf - 1].adf.toString());
			_upgradeTF_2.text = _strengthData.adf.toString();
			
			_expTF.text = _info.adf_exp + "/" + _strengthData.exp_all;
			
			_expBar.width = _info.adf_exp / _strengthData.exp_all * 104;
		}
		
		private function renderEffect() : void
		{
			if(player.fight_soul <  DataList.list[20] * DataList.list[1000])
				_textEffect_1.play();
			else
				_textEffect_1.stop();
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "MartialBtn":
					upgradeStrength();
					break;
			}
		}
		
		private function upgradeStrength():void
		{
			if(!checkEnough())	return;
			
			_info.adf_exp += _strengthData.exp_add;
			player.fight_soul -= DataList.list[20] * DataList.list[1000];
			player.strength_exp -= _strengthData.exp_add;
			
			tweenEffect();
		}
		
		private function tweenEffect() : void
		{
			this.panel.touchable = false;
			if(_info.adf_exp >= _strengthData.exp_all)
			{
				_tweenEffect.setStart(_expBar, "width", 104, .5, 
					function () : void
					{
						_effectShow.addShowObj(_effect);
						_effectShow.start();
						if(_info.adf == (_view.strength.strengthData.length - 1))
						{
							tweenComplete();
						}
						else
						{
							_expBar.width = 0;
							_expTF.text = (_info.adf_exp - _strengthData.exp_all) + "/" + _view.strength.strengthData[_info.adf + 1].exp_all;
							_tweenEffect.setStart(_expBar, "width", (_info.adf_exp - _strengthData.exp_all) / _view.strength.strengthData[_info.adf + 1].exp_all * 104, .25, tweenComplete);
						}
					}
				);
			}
			else
			{
				_tweenEffect.setStart(_expBar, "width", _info.adf_exp / _strengthData.exp_all * 104, .5, tweenComplete);
			}
		}
		
		private function tweenComplete() : void
		{
			this.panel.touchable = true;
			if(_info.adf_exp >= _strengthData.exp_all)
			{
				showInfo();
				_info.adf_exp -= _strengthData.exp_all;
				_info.adf++;
				player.getMyRoleModel(player.formation[_position]).countFightAttack();
				_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			}
			_view.strength.renderTF();
		}
		
		private function checkEnough() : Boolean
		{
			var result:Boolean = true;
			var str:String = "";
			if(player.fight_soul < DataList.list[20] * DataList.list[1000])
			{
				str += "战魂不足！";
				result = false;
			}
			if(player.strength_exp < _strengthData.exp_add)
			{
				str += "修为不足！";
				result = false;
			}
			if(!result)
				_view.tip.interfaces(InterfaceTypes.Show,
					str, null, null, false, true, false);
			return result;
		}
		
		private function showInfo() : void
		{
			var info:String = "";
			switch(_position)
			{
				case "front":
					info += "前锋的"; 
					break;
				case "middle":
					info += "中坚的";
					break;
				case "back":
					info += "大将的";
					break;
			} 
			info += ("的罡气等级从" + _info.adf + "级提升到" + (_info.adf + 1) + "级"); 
			_view.prompEffect.play(info);
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else if(type == "role")
			{
				textures = _view.roleRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else
			{
				textures = _titleTxAtlas.getTextures(name);
			}
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			if (type == "public")
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else if(type == "role")
			{
				texture = _view.roleRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else if(type == "icon")
			{
				texture = _view.icon.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			return texture;
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new StrengthAdfComponent(_configXML, _titleTxAtlas);
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			super.destroy();
		}
	}
}
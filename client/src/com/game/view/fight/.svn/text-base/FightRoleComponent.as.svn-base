package com.game.view.fight
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.db.protocal.BaseRole;
	import com.game.data.db.protocal.Characters;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.FightModelStructure;
	import com.game.data.fight.structure.AttackRoundData;
	import com.game.data.fight.structure.BaseModel;
	import com.game.data.fight.structure.BaseRoundData;
	import com.game.data.fight.structure.Battle_EnemyModel;
	import com.game.data.fight.structure.Battle_WeModel;
	import com.game.data.fight.structure.DefendRoundData;
	import com.game.data.fight.structure.Hurt;
	import com.game.data.fight.structure.SkillBuff;
	import com.game.data.playerKilling.Battle_PlayerKillingModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.effect.FightEffectConfig;
	import com.game.view.effect.play.PlayHPMPNumber;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.filters.GrayscaleFilter;
	import starling.filters.IdentityFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class FightRoleComponent extends Component
	{
		public static const NIGHT_FRAME:String = "Night_00";
		public static const RAIN_FRAME:String = "Rain_00";
		public static const THUNDER_FRAME:String = "Thunder_00";
		public static const MP_HP_COMPLETE:String = "mp_hp_complete";
		//public static const MP_HP_PLAY_TIME:Number = 0.3;
		
		public var mpAndHpDelayTime:Number = 0.3;
		
		// 初始数据
		private var _initData:BaseModel;
		public function get initData() : BaseModel
		{
			return _initData;
		}
		
		// 立场（敌人还是我方）
		private var _stand:String;
		public function get stand() : String
		{
			return _stand;
		}
		
		private var _roleImage:Image;
		public function get roleImage() : Image
		{
			return _roleImage;
		}
		
		// 当前角色维护数值
		private var _modelRole:BaseRole;
		
		/**
		 * 当前hp 
		 */		
		private var _curHp:int;
		public function get killHp() : int
		{
			return (_modelRole.hp - _curHp);
		}
		/**
		 * 当前mp 
		 */		
		private var _curMp:int;
		
		public function FightRoleComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
		}
		
		/**
		 * 开始 
		 * 
		 */
		
		override public function initRender(model:BaseModel, stand:String, isPlayerKilling:Boolean = false) : void
		{
			initUI();
			
			_initData = model;
			_stand = stand;
			
			switch (_stand)
			{
				case V.ME:
					_modelRole = (_initData as Battle_WeModel).characterModel;
					_curHp = (_initData as Battle_WeModel).roleModel.hp;
					_curMp = (_initData as Battle_WeModel).roleModel.mp;					
					break;
				case V.ENEMY:
					if(!isPlayerKilling)
					{
						_modelRole = (_initData as Battle_EnemyModel).enemyModel;
						_curHp = _modelRole.hp;
						_curMp = _modelRole.mp;
					}
					else
					{
						_modelRole = (_initData as Battle_PlayerKillingModel).characterModel;
						_curHp = _modelRole.hp;
						_curMp = _modelRole.mp;
						break;
					}
					break;
			}
			
			render();
		}
		
		protected function render() : void
		{
			var roleName:String = _modelRole.name;
			if(_modelRole.name.indexOf("（") != -1) roleName = _modelRole.name.substring(0, _modelRole.name.indexOf("（"));
			
			var specialName:String = "";
			if(_modelRole.name.indexOf("（") != -1)  specialName = _modelRole.name.substring(_modelRole.name.indexOf("（"), _modelRole.name.length);
			
			_nameTf.text = roleName;
			_nameTypeTf.text = specialName;
			_LVTF.text = "LV." + _modelRole.lv;
			_HPTF.text = _curHp + "/" + _modelRole.hp.toString();
			_MPTF.text = _curMp + "/" + _modelRole.mp.toString();
			
			var roleFileName:String;
			switch (_stand)
			{
				case V.ME:
					_bg.texture = this.getTexture("FightCardBg1", "");
					if(roleName == V.MAIN_ROLE_NAME.split("（")[0])
						roleFileName = player.returnNowFashion("RoleImage_Big_", roleName);
					else
						roleFileName = "RoleImage_Big_" + roleName;
					break; 
				case V.ENEMY:
					_bg.texture = this.getTexture("FightCardBg2", "");
					if(roleName == V.MAIN_ROLE_NAME.split("（")[0])
						roleFileName = Data.instance.playerKillingPlayer.player.returnNowFashion("RoleImage_Big_", roleName);
					else
						roleFileName = "RoleImage_Big_" + roleName;
					break;
			}	
			
			_roleImage.texture = _view.role_big.interfaces(InterfaceTypes.GetTexture, roleFileName);
			_roleImage.readjustSize();
			_roleImage.pivotX = int(_roleImage.texture.width * _roleImage.pX);
			_roleImage.pivotY = int(_roleImage.texture.height * _roleImage.pY);
			_roleImage.scaleX = V.FIGHT_SCALE * (_stand == V.ME ? -1 : 1);
			_roleImage.scaleY =  V.FIGHT_SCALE;

			var hpPer:Number = _curHp / _modelRole.hp;
			_hpBar.scaleX = hpPer;
			var mpPer:Number = _curMp / _modelRole.mp;
			_mpBar.scaleY = mpPer;
			
			if (_buffContain) panel.removeChild(_buffContain, true);
			
			if (Starling.context.driverInfo == "Disposed") return;
			
			// 死亡变灰
			if (hpPer == 0) 
			{
				_roleImage.filter = new GrayscaleFilter();
				if (_buffContain && _buffContain.parent) _buffContain.parent.removeChild(_buffContain, true);
			}
			else
			{
				_roleImage.filter = null;
			}
			
			setWeatherEffect()
		}
		
		private function setWeatherEffect() : void
		{
			removeEffect();
			var nameType:String = "";
			var nameCount_1:int = _modelRole.name.indexOf("（");
			var nameCount_2:int = _modelRole.name.indexOf("）");
			if(_modelRole.name.indexOf("（") != -1)  nameType = _modelRole.name.substring(nameCount_1 + 1, nameCount_2);
			if(nameType == V.NIGHT_TYPE)
			{
				addBlackEffect();
			}
			else if(nameType == V.RAIN_TYPE)
			{
				addRainEffect();
			}
			else if(nameType == V.THUNDER_TYPE)
			{
				addThunderEffect();
			}
			else if(nameType == V.WIND_TYPE)
			{
				addWindEffect();
			}
			else
			{
				removeEffect();
			}
		}
		
		private function addBlackEffect() : void
		{
			addMovieClip(panel, _blackBg);
		}
		
		private function addRainEffect() : void
		{
			addMovieClip(panel, _rainBg_1);
			addMovieClip(panel, _rainBg_2);
			addMovieClip(panel, _rainBg_3);
			_rainBg_1.currentFrame = 0;
			_rainBg_2.currentFrame = int(_rainBg_1.numFrames / 3 * 1);
			_rainBg_3.currentFrame = int(_rainBg_1.numFrames / 3 * 2);
		}
		
		private function addThunderEffect() : void
		{
			addMovieClip(panel, _thunderBg);
		}
		
		private function addWindEffect() : void
		{
			addMovieClip(panel, _windBg);
		}
		
		private function removeEffect() : void
		{
			removeMovieClip(_blackBg);
			removeMovieClip(_rainBg_1);
			removeMovieClip(_rainBg_2);
			removeMovieClip(_rainBg_3);
			removeMovieClip(_thunderBg);
			removeMovieClip(_windBg);
		}
		
		/**
		 * 设置buff 
		 * @param buffs
		 * 
		 */
		private var _buffContain:Sprite;
		public function setBuffs(buffs:Vector.<SkillBuff>) : void
		{
			if (_buffContain) panel.removeChild(_buffContain, true);
			
			// 死亡
			if (_curHp <= 0)	return;
			
			_buffContain = new Sprite();
			panel.addChild(_buffContain);
			_buffContain.x = 20;
			_buffContain.y = 126;
			
			while (buffs.length > 0)
			{
				var buff:SkillBuff = buffs.shift();
				var textureName:String;
				switch (buff.buff_name)
				{
					case FightConfig.POISON:
						textureName = "Poison";
						break;
					case FightConfig.SYNCOPE:
						textureName = "Vertigo";
						break;
					case FightConfig.DRUNK:
						textureName = "Drunken";
						break;
					case FightConfig.LINE:
						textureName = "Lime";
						break;
					case FightConfig.ASLEEP:
						textureName = "Sleep";
						break;
					case FightConfig.CONFUSION:
						textureName = "Confusion";
						break;
					default:
						throw new Error(buff.buff_name);
				}
				
				var texture:Texture = getTexture(textureName, "");
				var image:Image = new Image(texture);
				_buffContain.addChild(image);
				image.x = _buffContain.width;
			}
		}
		
		/**
		 * 设置hp和mp 
		 * @param model
		 * 
		 */
		private var _callback:Function;
		public function setHPAndMP(model:BaseRoundData, callback:Function) : void
		{
			_callback = callback;
			
			_hpComplete = false;
			_mpComplete = false;
			
			onHP(model);
			onMP(model);
			
			// 防止角色偏移
			_roleImage.x = _roleImage.y = 80;
		}
		
		/// hp
		private var _hpComplete:Boolean;
		private function onHP(model:BaseRoundData) : void
		{
			var dis:int = model.remainHP - _curHp;
			
			/*
			// hp没有改变
			if (dis == 0) 
			{
				onHPComplete();
				return;
			}*/	
			
			_curHp = model.remainHP;
			
			var hpPer:Number = model.remainHP / _modelRole.hp;
			_HPTF.text = model.remainHP + "/" + _modelRole.hp;
			
			// 死亡变灰
			if (hpPer == 0) 
			{
				if (Starling.context.driverInfo == "Disposed") return;

				_roleImage.filter = new GrayscaleFilter();
				
				removeEffect();
			}
			
			// 进度条
			if (model is DefendRoundData)
			{
				neiGongHpTween(_hpBar, hpPer, (model as DefendRoundData));
				//onHPTween(_hpBar, hpPer, -(model as DefendRoundData).hurtHPValue);
			}
			else if (model is AttackRoundData && (model as AttackRoundData).hurts.length > 0)
			{
				var hurtTotal:int = 0;
				/*
				for each(var hurt:Hurt in (model as AttackRoundData).hurts)
				{
					hurtTotal += hurt.value;
				}*/
				var hurt:Hurt;
				while ((model as AttackRoundData).hurts.length)
				{
					hurt = (model as AttackRoundData).hurts.pop();
					hurtTotal += hurt.value;
				}
				
				onHPTween(_hpBar, hpPer, -hurtTotal, true);
			}
			else
			{
				onHPComplete();
			}
		}
		
		private var _neiGongHpNumber:PlayHPMPNumber;
		private function neiGongHpTween(target:Image, per:Number, model:DefendRoundData) : void
		{
			_hpTween = new Tween(target, mpAndHpDelayTime * 2);
			_hpTween.animate("scaleX", per);
			_hpTween.onComplete = onHPComplete;
			_view.fightEffect.addAnimatable(_hpTween);
			
			if(model.NeiGongHurtValue == 0)
			{
				onHPTween(target, per, -model.hurtHPValue);
				return;
			}
			if(!_neiGongHpNumber) _neiGongHpNumber = new PlayHPMPNumber();
			_neiGongHpNumber.initNumber(this, model.NeiGongHurtValue, FightEffectConfig.NEIGONG_HP, mpAndHpDelayTime);
			
			Starling.juggler.delayCall(onHPTween, mpAndHpDelayTime, target, per, -model.hurtHPValue);
		}
		
		private var _hpTween:Tween;
		private var _hpNumber:PlayHPMPNumber;
		private function onHPTween(target:Image, per:Number, dis:int, isAttack:Boolean = false) : void
		{
			// 伤害值为0, 闪避
			if (dis == 0)
			{
				onHPComplete();
				return;
			}
			
			if(isAttack)
			{
				_hpTween = new Tween(target, mpAndHpDelayTime * 2);
				_hpTween.animate("scaleX", per);
				_hpTween.onComplete = onHPComplete;
				_view.fightEffect.addAnimatable(_hpTween);
			}
			
			// 数字
			if (!_hpNumber) _hpNumber = new PlayHPMPNumber();
			_hpNumber.initNumber(this, dis, FightEffectConfig.HP, mpAndHpDelayTime);
		}
		
		private function onHPComplete() : void
		{
			Log.Trace("onHPComplete:" + _modelRole.name + "stand:" + _stand);
			_hpComplete = true;
			checkComplete();
		}
		
		/// mp
		private var _mpComplete:Boolean;
		private function onMP(model:BaseRoundData) : void
		{
			var dis:int = model.remainMP - _curMp;
			
			// mp没有改变
			if (dis == 0)
			{
				onMPComplete();
				return;
			}
			
			_curMp = model.remainMP;
			
			var mpPer:Number = model.remainMP / _modelRole.mp;
			_MPTF.text = model.remainMP + "/" + _modelRole.mp;
			
			// 进度条
			onMPTween(model, _mpBar, mpPer, dis);
		}

		private var _mpTween:Tween;
		private var _mpNumber:PlayHPMPNumber;
		private function onMPTween(model:BaseRoundData, target:Image, per:Number, dis:int) : void
		{
			_mpTween = new Tween(target, mpAndHpDelayTime);
			_mpTween.animate("scaleX", per);
			_mpTween.onComplete = onMPComplete;
			//Starling.juggler.add(_mpTween);
			_view.fightEffect.addAnimatable(_mpTween);
			
			if (model is DefendRoundData)
			{
				if (!_mpNumber) _mpNumber = new PlayHPMPNumber();
				_mpNumber.initNumber(this, dis, FightEffectConfig.MP, mpAndHpDelayTime);
			}
		}
		
		private function onMPComplete() : void
		{
			Log.Trace("onMPComplete:" + _modelRole.name + "stand:" + _stand);
			_mpComplete = true;
			checkComplete();
		}
		
		private function checkComplete() : void
		{
			Log.Trace("FightRole checkComplete:" + _modelRole.name + "stand:" + _stand);
			
			if (_hpComplete && _mpComplete)
			{
				_callback();
			}
		}
		
		/**
		 * 设置攻击状态 
		 * @param value
		 * 
		 */		
		public function setOnAttack(value:Boolean) : void
		{
			if (_attackSign) _attackSign.visible = value;
		}
		
		// 获取元件
		private var _bg:Image;
		private var _nameTf:TextField;
		private var _nameTypeTf:TextField;
		private var _LVTF:TextField;
		private var _HPTF:TextField;
		private var _MPTF:TextField;
		private var _hpBar:Image;
		private var _mpBar:Image;
		private var _hpWidth:int;
		private var _mpWidth:int;
		private var _attackSign:Image;
		private var _blackBg:MovieClip;
		private var _rainBg_1:MovieClip;
		private var _rainBg_2:MovieClip;
		private var _rainBg_3:MovieClip;
		private var _thunderBg:MovieClip;
		private var _windBg:MovieClip;
		protected function initUI() : void
		{
			if (!_bg)
			{
				_bg = this.searchOf("BackGround");
			}
			
			if (!_nameTf) 
			{
				_nameTf = this.searchOf("Tx_RoleName");
				_nameTf.color = 0xffff33;
			}
			
			if (!_nameTypeTf)
			{
				_nameTypeTf = this.searchOf("Tx_RoleNameType");
				_nameTypeTf.color = 0xffff33;
			}
			
			if (!_LVTF)
			{
				_LVTF = this.searchOf("Tx_RoleLevel");
				_LVTF.color = 0xffffff;
			}
			
			if (!_HPTF) _HPTF = this.searchOf("Tx_Hp");
			
			if (!_MPTF) _MPTF = this.searchOf("Tx_Mp");
			
			if (!_roleImage) 
			{
				_roleImage = this.searchOf("RoleImage");
			}
			_roleImage.filter = null;
			
			if (!_hpBar) 
			{
				_hpBar = this.searchOf("RoleHpBar");
				_hpWidth = _hpBar.width;
			}
			_hpBar.width = _hpWidth;
			
			if (!_mpBar)
			{
				_mpBar = this.searchOf("RoleMpBar");
				_mpWidth = 	_mpBar.width;
			}
			_mpBar.width = _mpWidth;
			
			if (!_attackSign)
			{
				_attackSign = this.searchOf("CardRect");
				_attackSign.visible = false;
			}
			
			if(!_blackBg)
			{
				_blackBg = this.searchOf("Night");
				_blackBg.touchable = false;
				removeMovieClip(_blackBg);
			}
			
			if(!_rainBg_1)
			{
				_rainBg_1 = this.searchOf("Rain_1");
				_rainBg_1.touchable = false;
				removeMovieClip(_rainBg_1);
				
				_rainBg_2 = this.searchOf("Rain_2");
				_rainBg_2.touchable = false;
				removeMovieClip(_rainBg_2);
				
				_rainBg_3 = this.searchOf("Rain_3");
				_rainBg_3.touchable = false;
				removeMovieClip(_rainBg_3);
			}
			
			if(!_thunderBg)
			{
				_thunderBg = this.searchOf("Thunder");
				_thunderBg.touchable = false;
				_thunderBg.addFrameAt(4, _thunderBg.getFrameTexture(3));
				_thunderBg.addFrameAt(4, _thunderBg.getFrameTexture(2));
				_thunderBg.addFrameAt(4, _thunderBg.getFrameTexture(1));
				_thunderBg.addFrameAt(4, _thunderBg.getFrameTexture(0));
				_thunderBg.setFrameDuration(8, 1);
				removeMovieClip(_thunderBg);
			}
			
			if(!_windBg)
			{
				_windBg = this.searchOf("Wind");
				_windBg.touchable = false;
				removeMovieClip(_windBg);
			}
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new FightRoleComponent(_configXML, _titleTxAtlas);
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			super.destroy();
		}
		
		/**
		 * 跳过战斗设置HP
		 * @param countHp
		 * 
		 */		
		public function setLastHp(countHp:int) : void
		{
			_HPTF.text = countHp + "/" + _modelRole.hp;
			var hpPer:Number = countHp / _modelRole.hp;
			_hpBar.scaleX = hpPer;
			
			// 死亡变灰
			if (countHp == 0) 
			{
				_roleImage.filter = new GrayscaleFilter();
				if (_buffContain && _buffContain.parent) _buffContain.parent.removeChild(_buffContain, true);
			}
			else
			{
				_roleImage.filter = null;
			}
		}
		
		/**
		 * 跳过战斗设置MP
		 * @param countMp
		 * 
		 */		
		public function setLastMp(countMp:int) : void
		{
			_MPTF.text = countMp + "/" + _modelRole.hp;
			var mpPer:Number = countMp / _modelRole.mp;
			_mpBar.scaleX = mpPer;
		}
	}
}
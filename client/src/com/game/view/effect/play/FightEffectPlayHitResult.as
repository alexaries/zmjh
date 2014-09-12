package com.game.view.effect.play
{
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.structure.DefendRoundData;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.effect.FightEffectConfig;
	import com.game.view.effect.protocol.FightEffectConfigData;
	import com.game.view.effect.protocol.FightEffectPlayer;
	import com.game.view.fight.FightRoleComponent;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class FightEffectPlayHitResult extends BasePlay implements IPlay
	{
		public static const ROLE_IMAGE_DELAY_TIME:Number = 0.2;
		public static const DOGE_FONT_DELAY_TIME:Number = 0.5;
		public static const HURT_DELAY_TIME:Number = 0.4;
		public static const PLAY_DELAY_TIME:int = 10;
		
		public var roleImageDelayTime:Number = 0.2;
		public var dogeFontDelayTime:Number = 0.5;
		public var hurtDelayTime:Number = 0.4;
		public var playDelayTime:int = 10;
		
		public function FightEffectPlayHitResult()
		{
			super();
		}
		
		private var _callback:Function;
		// 被攻击对象总数
		private var _curDefendNum:int;
		public function onPlay(callback:Function) : void
		{
			_callback = callback;
			
			// 被攻击者（有可能没有如攻击者处于晕阙 睡眠）
			if (!_fightEffectView.fightRound.defend || _fightEffectView.fightRound.defend.length == 0)
			{
				_callback();
				return;
			}
			
			_curDefendNum = _fightEffectView.fightRound.defend.length;
			
			_hitPlayNum = 0;
			
			var defendItem:FightRoleComponent;
			var defend:DefendRoundData;
			for (var i:int = 0; i < _fightEffectView.fightRound.defend.length; i++)
			{
				defendItem = _fightEffectView.defends[i];
				defend = _fightEffectView.fightRound.defend[i];
				hitResult(defendItem, defend);
			}
			
			trace("_hitPlayNum:", _hitPlayNum);
			if (_hitPlayNum == 0)
			{
				_callback();
			}
		}
		
		// hit数目
		private var _hitPlayNum:int = 0;
		private function onCheckHitComplete() : void
		{			
			_hitPlayNum -= 1;
			
			if (_hitPlayNum == 0)
			{
				_callback();
			}
		}
		
		private function hitResult(target:FightRoleComponent, data:DefendRoundData) : void
		{			
			switch (data.hurtType)
			{
				// 闪避
				case FightConfig.DODGE:
					_hitPlayNum += 1;
					onDodge(target, data);
					break;
				// 正常伤害
				case FightConfig.COMMON_HURT:
					_hitPlayNum += 1;
					onCommon(target);
					break;
				// 格挡
				case FightConfig.BLOCK_HURT:
					_hitPlayNum += 1;
					onBlock(target);
					_hitPlayNum += 1;
					onCommon(target);
					break;
				// 暴击
				case FightConfig.CRIT_HURT:
					_hitPlayNum += 1;
					onCrit(target);
					break;
				// 技能伤害
				case FightConfig.SKILL_ATTACK:
					onSkill(target, data);
					break;
				default:
					break;
			}
			//技能伤害暴击效果显示
			if(data.skillCrit)
			{
				onCrit(target);
			}
			
			// 补血
			if (data.hurtType == FightConfig.SKILL_ATTACK && data.skill.hp_up != 0)
			{
				play(target, FightEffectConfig.ADDBLOOD);
			}
			// 伤害
			else if(data.hurtType != FightConfig.DODGE) 
			{
				onHurtRed(target);
			}
		}
		
		/// 技能伤害
		private function onSkill(target:FightRoleComponent, data:DefendRoundData) : void
		{
			var effect:String = data.skill.effect;
			
			if (effect == "无")
			{
				return;
			}
			
			var arr:Array = effect.split("|");
			// effect
			for (var i:int = 0; i < arr.length; i++)
			{
				_hitPlayNum += 1;
				play(target, arr[i]);
			}
			
			// 水属性
			if (data.skill.water == 1)
			{
				_hitPlayNum += 1;
				play(target, FightEffectConfig.WATER);
			}
			
			// 火属性
			if (data.skill.fire == 1)
			{
				_hitPlayNum += 1;
				play(target, FightEffectConfig.FIRE);
			}
			
			// 混沌属性
			if (data.skill.chaos == 1)
			{
				_hitPlayNum += 1;
				play(target, FightEffectConfig.CHAOS);
			}
			
			// 毒属性
			if (data.skill.poison == 1)
			{
				_hitPlayNum += 1;
				play(target, FightEffectConfig.POSION_HURT);
			}
		}
		
		/// 格挡
		private function onBlock(target:FightRoleComponent) : void
		{
			play(target, FightEffectConfig.BLOCK);
		}
			
		
		/// 暴击
		private function onCrit(target:FightRoleComponent) : void
		{
			play(target, FightEffectConfig.CRIT);
		}
		
		/// 正常伤害
		private function onCommon(target:FightRoleComponent) : void
		{
			play(target, FightEffectConfig.SMALL_HIT);
		}
		
		
		private function play(component:Component, type:String) : void
		{
			var texture_index:int = FightEffectConfig.TEXTURE_INDEX[type] || 1;
			var atlas:TextureAtlas = (texture_index == 2 ? _fightEffectView.titleTxAtlas2 : _fightEffectView.titleTxAtlas1);
			
			var itemData:FightEffectConfigData = _fightEffectView.getFightEffectData(type);
			var posion:FightEffectPlayer = new FightEffectPlayer();
			posion.initData(itemData, atlas, playDelayTime);
			posion.addEventListener(Event.COMPLETE, onPlayComplete);
			component.panel.addChild(posion);
			
			posion.x = itemData.X;
			posion.y = itemData.Y;
		}
		
		private function onPlayComplete(e:Event) : void
		{
			var target:FightEffectPlayer = e.target as FightEffectPlayer;
			target.parent.removeChild(target);
			target.removeEventListeners();
			target.dispose();
			
			target = null;
			
			onCheckHitComplete();
		}
		
		/// 闪避
		public static const DIS:int = 20;
		private var _tween:Tween;
		private function onDodge(target:FightRoleComponent, data:DefendRoundData) : void
		{
			var roleImage:Image = target.roleImage;
			var dis:int;
			var stand:String = data.position;
			if (stand == V.ME) dis = -DIS;
			else dis = DIS;
			
			// 后退
			_tween = new Tween(roleImage, roleImageDelayTime, Transitions.EASE_IN_OUT);
			_tween.moveTo(roleImage.x + dis, roleImage.y);
			_tween.onComplete = function () : void
			{
				_tween = new Tween(roleImage, roleImageDelayTime, Transitions.EASE_IN_OUT);
				_tween.moveTo(roleImage.x - dis, roleImage.y);
				_tween.onComplete = onCheckHitComplete;
				_view.fightEffect.addAnimatable(_tween);
			};
			_view.fightEffect.addAnimatable(_tween);
			
			playDodgeFont(target);
		}
		
		// 闪避字体
		private var _dogeFontTween:Tween;
		private var _dogeFont:Image;
		private function playDodgeFont(target:FightRoleComponent) : void
		{
			if (!_dogeFont)
			{
				var texture:Texture;
				if(_view.fightEffect.fightType == V.FIGHT)
					texture = _view.fight.titleTxAtlas.getTexture("Evasion");
				else if(_view.fightEffect.fightType == V.ENDLESS_FIGHT)
					texture = _view.endless_fight.titleTxAtlas.getTexture("Evasion");
				else if(_view.fightEffect.fightType == V.PLAYER_KILLING_FIGHT)
					texture = _view.player_killing_fight.titleTxAtlas.getTexture("Evasion");
				else if(_view.fightEffect.fightType == V.BOSS_FIGHT)
					texture = _view.boss_fight.titleTxAtlas.getTexture("Evasion");
				_dogeFont = new Image(texture);
				_dogeFont.pivotX = _dogeFont.width/2;
				_dogeFont.pivotY = _dogeFont.height/2;
			}
			
			target.panel.addChild(_dogeFont);
			_dogeFont.alpha = 1;
			_dogeFont.x = target.panel.width/2;
			_dogeFont.y = target.panel.height/2;
			
			_dogeFontTween = new Tween(_dogeFont, dogeFontDelayTime);
			_dogeFontTween.moveTo(_dogeFont.x, -_dogeFont.height);
			_dogeFontTween.fadeTo(0);
			_dogeFontTween.onComplete = function () : void
			{
				if (_dogeFont.parent) _dogeFont.parent.removeChild(_dogeFont);
			};
			_view.fightEffect.addAnimatable(_dogeFontTween);
		}
		
		// 闪红
		private function onHurtRed(target:FightRoleComponent) : void
		{
			var redHurtComponent:HurtComponent = new HurtComponent();
			redHurtComponent.initData(
				target.roleImage,
				hurtDelayTime,
				function () : void
				{
					
				},
				1);
		}
	}
}
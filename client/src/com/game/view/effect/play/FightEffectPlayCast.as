package com.game.view.effect.play
{
	import com.game.data.fight.FightConfig;
	import com.game.manager.FontManager;
	import com.game.template.V;
	import com.game.view.fight.FightResultComponent;
	import com.game.view.fight.FightRoleComponent;
	
	import flash.geom.Point;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class FightEffectPlayCast extends BasePlay implements IPlay
	{
		public static const ROLE_IMAGE_DELAY_TIME:Number = 0.2;
		public static const SKILL_START_DELAY_TIME:Number = 0.2;
		public static const SKILL_END_DELAY_TIME:Number = 0.5;
		public static const PLAYING_IMAGE_DELAY_TIME:Number = 0.5;
		
		public var roleImageDelayTime:Number = 0.2;
		public var skillStartDelayTime:Number = 0.2;
		public var skillEndDelayTime:Number = 0.5;
		public var playingImageDelayTime:Number = 0.5	
		
		public function FightEffectPlayCast()
		{
			super();
		}
		
		private var _callback:Function;
		private var _effectNum:int;
		public function onPlay(callback:Function) : void
		{
			_callback = callback;
			
			switch (_fightEffectView.fightRound.attack.attackType)
			{
				// 技能攻击
				case FightConfig.SKILL_ATTACK:
					_effectNum = 2;
					onCommonAttackEffect(_fightEffectView.attackTarget);
					onSkillAttack();
					onSkillName();
					break;
				// 普通攻击
				case FightConfig.COMMON_HURT:
				// 暴击
				case FightConfig.BLOCK_HURT:
					_effectNum = 1;
					onCommonAttackEffect(_fightEffectView.attackTarget);
					break;
				default:
					_callback();
			}
		}
		
		private function checkPlayComplete() : void
		{
			_effectNum -= 1;
			
			if (_effectNum == 0)
			{
				_callback();
			}
		}
		
		public static const DIS:int = 20;
		private static var _tween:Tween;
		private function onCommonAttackEffect(target:FightRoleComponent) : void
		{
			var roleImage:Image = target.roleImage;
			var dis:int;
			var stand:String = _fightEffectView.fightRound.attack.position;
			if (stand == V.ME) dis = DIS;
			else dis = -DIS;
			
			_tween = new Tween(roleImage, roleImageDelayTime, Transitions.EASE_IN_OUT);
			_tween.moveTo(roleImage.x + dis, roleImage.y);			
			_tween.onComplete = function () : void
			{
				_tween = new Tween(roleImage, roleImageDelayTime, Transitions.EASE_IN_OUT);
				_tween.moveTo(roleImage.x - dis, roleImage.y);
				_tween.onComplete = checkPlayComplete;
				_view.fightEffect.addAnimatable(_tween);
			};
			_view.fightEffect.addAnimatable(_tween);
		}
		
		/**
		 * 技能名称 
		 * 
		 */
		private function onSkillName() : void
		{
			var skillName:TextField = createSkillTF();
			skillName.text = _fightEffectView.fightRound.attack.skill.skill_name;
			
			var tween:Tween = new Tween(skillName, skillStartDelayTime);
			tween.moveTo(skillName.x, -skillName.height);
			tween.onComplete = function () : void
			{
				tween = new Tween(skillName, 0);
				tween.delay = skillEndDelayTime;
				tween.onComplete = function () : void
				{
					if (skillName.parent) skillName.parent.removeChild(skillName);
					skillName.dispose();
					skillName = null;
				}
				_view.fightEffect.addAnimatable(tween);
			};
			_view.fightEffect.addAnimatable(tween);
		}
		
		private function createSkillTF() : TextField
		{
			var skillName:TextField;
			skillName = new TextField(130, 40, "");
			skillName.fontName = FontManager.instance.font ? FontManager.instance.font.fontName : "宋体";
			skillName.vAlign = VAlign.CENTER;
			skillName.hAlign = HAlign.CENTER;
			skillName.color = 0xffffff;
			skillName.fontSize = 25;
			
			_fightEffectView.attackTarget.panel.addChild(skillName);
			skillName.x  = 22;
			skillName.y = 5;
			
			return skillName;
		}
		
		/**
		 * 技能攻击动画 
		 * 
		 */		
		private function onSkillAttack() : void
		{
			switch (_fightEffectView.fightRound.attack.skill.id)
			{
				// 丢石子
				case 1:
					onPlayStone();
					break;
				// 扔酒罐
				case 2:
					onPlayBottle();
					break;
				// 扔石灰
				case 3:
					onPlayLime();
					break;
				// 扔毒镖
				case 4:
					onPlayPoisonDart();
					break;
				// 扔蒙汉药
				case 5:
					onPlaySleepDrug();
					break;
				// 丢炸弹
				case 6:
					onPlayBomb();
					break;
				// 扔化尸毒
				case 7:
					onPlayChangePtomaine();
					break;
				// 丢课本
				case 13:
					onPlayBook();
					break;
				// 波板甜心
				case 41:
					onPlaySugar();
					break;
				case 50:
					onPlayMoonCake();
					break;
				default:
					checkPlayComplete();
					break;
			}
		}
		
		private var _defendNum:int;
		private function onPlaying(texture:Texture) : void
		{
			if (!_fightEffectView.fightRound.defend || _fightEffectView.fightRound.defend.length == 0)
			{
				checkPlayComplete();
				return;
			}
			
			_defendNum = _fightEffectView.fightRound.defend.length;			
			var defend:FightRoleComponent;
			for (var i:int = 0; i <　_fightEffectView.fightRound.defend.length; i++)
			{
				defend = _fightEffectView.defends[i];
				onImage(defend, texture);
			}
		}
		
		private function onImage(defend:FightRoleComponent, texture:Texture) : void
		{
			var attack:FightRoleComponent = _fightEffectView.attackTarget;
			var startPoint:Point = new Point(
				attack.panel.x,
				attack.panel.y
			);
			
			var endPoint:Point = new Point(
				defend.panel.x,
				defend.panel.y
			);
			
			var image:Image = new Image(texture);
			attack.panel.parent.addChild(image);
			image.pivotX = image.pivotY = 0.5;
			image.x = startPoint.x;
			image.y = startPoint.y;
			image.readjustSize();
			var tween:Tween = new Tween(image, playingImageDelayTime);
			tween.moveTo(endPoint.x, endPoint.y);
			tween.onComplete = function () : void
			{
				attack.panel.parent.removeChild(image, true);
				image = null;
				checkDefendComplete();
			};
			_view.fightEffect.addAnimatable(tween);;
		}
		
		private function checkDefendComplete() : void
		{
			_defendNum -= 1;
			
			if (_defendNum == 0)
			{
				checkPlayComplete();
			}
		}
		
		/**
		 *  丢石子
		 * 
		 */
		private var _stoneTexture:Texture;
		private function onPlayStone() : void
		{
			if (!_stoneTexture) _stoneTexture = _fightEffectView.titleTxAtlas2.getTexture("Stone");
			
			onPlaying(_stoneTexture);
		}
		
		/**
		 * 扔酒罐  
		 * 
		 */
		private var _bottleTexture:Texture;
		private function onPlayBottle() : void
		{
			if (!_bottleTexture) _bottleTexture = _fightEffectView.titleTxAtlas2.getTexture("BeerPot_1");
			
			onPlaying(_bottleTexture);	
		}
		
		/**
		 * 扔石灰
		 * 
		 */
		private var _limeTexture:Texture;
		private function onPlayLime() : void
		{
			if (!_limeTexture) _limeTexture = _fightEffectView.titleTxAtlas2.getTexture("Lime");
			
			onPlaying(_limeTexture);
		}
		
		/**
		 *  扔毒镖
		 * 
		 */
		private var _poisonDartTexture:Texture;
		private function onPlayPoisonDart() : void
		{
			if (!_poisonDartTexture) _poisonDartTexture = _fightEffectView.titleTxAtlas2.getTexture("Dart");
			
			onPlaying(_poisonDartTexture);
		}
		
		/**
		 * 蒙汗药
		 * 
		 */
		private var _sleepDrugTexture:Texture;
		private function onPlaySleepDrug() : void
		{
			if (!_sleepDrugTexture) _sleepDrugTexture = _fightEffectView.titleTxAtlas2.getTexture("Sleep");
			
			onPlaying(_sleepDrugTexture);
		}
		
		/**
		 * 丢炸弹 
		 * 
		 */
		private var _bompTexture:Texture;
		private function onPlayBomb() : void
		{
			if (!_bompTexture) _bompTexture = _fightEffectView.titleTxAtlas2.getTexture("Bomb");
			
			onPlaying(_bompTexture);
		}
		
		/**
		 *  化尸毒
		 * 
		 */
		private var _ChangePtomaineTexture:Texture;
		private function onPlayChangePtomaine() : void
		{
			if (!_ChangePtomaineTexture) _ChangePtomaineTexture = _fightEffectView.titleTxAtlas2.getTexture("Poison_1");
			
			onPlaying(_ChangePtomaineTexture);
		}
		
		/**
		 * 丢课本 
		 * 
		 */
		private var _bookTexture:Texture;
		private function onPlayBook() : void
		{
			if (!_bookTexture) _bookTexture = _fightEffectView.titleTxAtlas2.getTexture("Book");
			onPlaying(_bookTexture);
		}
		
		/**
		 * 波板甜心
		 */		
		private var _sugarTexture:Texture;
		private function onPlaySugar() : void
		{
			if (!_sugarTexture) _sugarTexture = _fightEffectView.titleTxAtlas2.getTexture("Sugar");
			onPlaying(_sugarTexture);
		}
		
		/**
		 * 人间月饼
		 */		
		private var _moonCakeTexture:Texture;
		private function onPlayMoonCake():void
		{
			if(!_moonCakeTexture) _moonCakeTexture = _fightEffectView.titleTxAtlas2.getTexture("MoonCake");
			onPlaying(_moonCakeTexture);
		}
	}
}
package com.game.view.effect
{
	import com.engine.core.Log;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.structure.DefendRoundData;
	import com.game.data.fight.structure.FightRound;
	import com.game.data.fight.structure.Hurt;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.Base;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.effect.play.FightEffectPlayCast;
	import com.game.view.effect.play.FightEffectPlayHitResult;
	import com.game.view.effect.play.FightEffectPlayNumbers;
	import com.game.view.effect.play.FightEffectPlaySkillBuff;
	import com.game.view.effect.play.FightEffectPlayStatus;
	import com.game.view.effect.protocol.FightEffectConfigData;
	import com.game.view.effect.protocol.FightEffectPlayer;
	import com.game.view.effect.protocol.FightEffectUtils;
	import com.game.view.fight.FightEffect;
	import com.game.view.fight.FightRoleComponent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import starling.animation.IAnimatable;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class FightEffectView extends BaseView implements IView
	{
		// 状态特效
		private var _playStatus:FightEffectPlayStatus;
		// 释放特效
		private var _playCast:FightEffectPlayCast;
		// 攻击造成效果
		private var _playHitResult:FightEffectPlayHitResult;
		// 数字
		private var _playNumbers:FightEffectPlayNumbers;
		// buff
		private var _playSkillBuff:FightEffectPlaySkillBuff;
		
		private var _titleTxAtlas1:TextureAtlas;
		public function get titleTxAtlas1() : TextureAtlas
		{
			return _titleTxAtlas1;
		}
		
		private var _titleTxAtlas2:TextureAtlas;
		public function get titleTxAtlas2() : TextureAtlas
		{
			return _titleTxAtlas2;
		}
		
		private var _fightRound:FightRound;
		public function get fightRound() : FightRound
		{
			return _fightRound;
		}
		
		private var _attackTarget:FightRoleComponent;
		public function get attackTarget() : FightRoleComponent
		{
			return _attackTarget;
		}
		
		private var _defends:Vector.<FightRoleComponent>;
		public function get defends() : Vector.<FightRoleComponent>
		{
			return _defends;
		}
		
		private var _callback:Function;
		public function get callback() : Function
		{
			return _callback;
		}
		
		private var _fightType:String;
		public function get fightType() : String
		{
			return _fightType;
		}
		
		public function FightEffectView()
		{
			_moduleName = V.FIGHT_EFFECT;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					if (isInit) return;
					isInit = true;
					this.show();
					break;
				case FightEffectConfig.PLAY:
					onPlay(args);
					break;
			}
		}
		
		override protected function show() : void
		{
			initLoad();
		}
		
		override protected function init():void
		{
			initPlay();
			initTexture();
			initData();
		}
		
		private function initPlay() : void
		{
			_playStatus = new FightEffectPlayStatus();
			_playCast = new FightEffectPlayCast();
			_playHitResult = new FightEffectPlayHitResult();
			_playNumbers = new FightEffectPlayNumbers();
			_playSkillBuff = new FightEffectPlaySkillBuff();
		}
		
		/**
		 * 设置加速功能
		 * 
		 */		
		public function setSpeed() : void
		{
			var _allowChange:Number = 1 / _view.world.allowChange;
			
			_playStatus.playDelayTime = FightEffectPlayStatus.PLAY_DELAY_TIME * _view.world.allowChange;
			_playStatus.skillStartDelayTime = FightEffectPlayStatus.SKILL_START_DELAY_TIME * _allowChange;
			_playStatus.skillEndDelayTime = FightEffectPlayStatus.SKILL_END_DELAY_TIME * _allowChange;
			
			_playCast.playingImageDelayTime = FightEffectPlayCast.PLAYING_IMAGE_DELAY_TIME * _allowChange;
			_playCast.roleImageDelayTime = FightEffectPlayCast.ROLE_IMAGE_DELAY_TIME * _allowChange;
			_playCast.skillEndDelayTime = FightEffectPlayCast.SKILL_END_DELAY_TIME * _allowChange;
			_playCast.skillStartDelayTime = FightEffectPlayCast.SKILL_START_DELAY_TIME * _allowChange;
			
			_playHitResult.dogeFontDelayTime = FightEffectPlayHitResult.DOGE_FONT_DELAY_TIME * _allowChange;
			_playHitResult.hurtDelayTime = FightEffectPlayHitResult.HURT_DELAY_TIME * _allowChange;
			_playHitResult.roleImageDelayTime = FightEffectPlayHitResult.ROLE_IMAGE_DELAY_TIME * _allowChange;
			_playHitResult.playDelayTime = FightEffectPlayHitResult.PLAY_DELAY_TIME * _view.world.allowChange;
			
			_playNumbers.hpAndMpDelayTime = FightEffectPlayNumbers.HP_AND_MP_DELAY_TIME * _allowChange;
			
			_playSkillBuff.playDelayTime = FightEffectPlaySkillBuff.PLAY_DELAY_TIME * _view.world.allowChange;
			_playSkillBuff.skillStartDelayTime = FightEffectPlaySkillBuff.SKILL_START_DELAY_TIME * _allowChange;
			_playSkillBuff.skillEndDelayTime = FightEffectPlaySkillBuff.SKILL_END_DELAY_TIME * _allowChange;
		}
		
		private var _configXML:XML;
		private var _fightEffectDatas:Vector.<FightEffectConfigData>;
		protected function initTexture() : void
		{
			var textureXML:XML;
			var obj_1:ByteArray;
			var obj_2:Bitmap;
			var textureTitle:Texture;
				
			if (!_titleTxAtlas1)
			{
				textureXML = getXMLData(V.FIGHT_EFFECT, GameConfig.FE_RES, "FightEffect1");
				obj_1 = getAssetsObject(V.FIGHT_EFFECT, GameConfig.FE_RES, "Textures1") as ByteArray;
				textureTitle = Texture.fromAtfData(obj_1);
				_titleTxAtlas1 = new TextureAtlas(textureTitle, textureXML);
				/*obj_1.clear();
				obj_1 = null;*/
			}
			
			if (!_titleTxAtlas2)
			{
				textureXML = getXMLData(V.FIGHT_EFFECT, GameConfig.FE_RES, "FightEffect2");
				obj_2 = getAssetsObject(V.FIGHT_EFFECT, GameConfig.FE_RES, "Textures2") as Bitmap;
				//textureTitle = Texture.fromAtfData(obj as ByteArray);
				textureTitle = Texture.fromBitmap(obj_2);
				_titleTxAtlas2 = new TextureAtlas(textureTitle, textureXML);
				/*obj_2.clear();
				obj_2 = null;*/
			}
			
			if (!_configXML)
			{
				_configXML = getXMLData(V.FIGHT_EFFECT, GameConfig.FE_RES, "FightEffectConfig");
			}
		}
		
		protected function initData() : void
		{
			_fightEffectDatas = FightEffectUtils.parseXML(_configXML);
		}
		
		private function onPlay(args:Array) : void
		{
			_fightRound = args[0];
			_attackTarget = args[1];
			_defends = args[2];
			_callback = args[3];
			_fightType = (args.length >= 5?args[4]:V.FIGHT);
			
			// 状态
			onSetAttackStatus();
			onPlayStatus();
		}
		
		/**
		 *设置攻击状态 
		 * 
		 */		
		private function onSetAttackStatus() : void
		{
			if(_fightType == V.FIGHT)
				_view.fight.setFightRoleStatus();
			else if(_fightType == V.ENDLESS_FIGHT)
				_view.endless_fight.setFightRoleStatus();
			else if(_fightType == V.PLAYER_KILLING_FIGHT)
				_view.player_killing_fight.setFightRoleStatus();
			else if(_fightType == V.BOSS_FIGHT)
				_view.boss_fight.setFightRoleStatus();
			
			_attackTarget.setOnAttack(true);
		}
		
		public static const DELAY_TIME:Number = 0.2;
		//状态
		private function onPlayStatus() : void
		{
			Log.Trace("onPlayStatus");
			_playStatus.onPlay(onCast);
			//_playStatus.onPlay(function () : void {Starling.current.juggler.delayCall(onCast, DELAY_TIME)});
		}
		
		//释放
		private function onCast() : void
		{
			Log.Trace("onCast");
			_playCast.onPlay(onResultEffects);
			//_playCast.onPlay(function () : void {Starling.current.juggler.delayCall(onResultEffects, DELAY_TIME)});
		}
		
		//攻击造成的效果
		private function onResultEffects() : void
		{
			Log.Trace("onResultEffects");
			_playHitResult.onPlay(onNumbers);
			//_playHitResult.onPlay(function () : void {Starling.current.juggler.delayCall(onNumbers, DELAY_TIME)});
		}
		
		// 攻击结果数字
		private function onNumbers() : void
		{
			Log.Trace("onNumbers");
			_playNumbers.onPlay(onPlaySkillBuff);
			//_playNumbers.onPlay(function () : void {Starling.current.juggler.delayCall(onPlaySkillBuff, DELAY_TIME)});
		}
		
		// 状态
		private function onPlaySkillBuff() : void
		{
			Log.Trace("onPlaySkillBuff");
			//_callback();
			_playSkillBuff.onPlay(onComplete);
			//_playSkillBuff.onPlay(function () : void {Starling.current.juggler.delayCall(onComplete, DELAY_TIME)});
		}
		
		private function onComplete() : void
		{
			Log.Trace("onComplete");
			_callback();
		}

		
		/**
		 * 战斗特效配置数据 
		 * @param effectName
		 * @return 
		 * 
		 */		
		public function getFightEffectData(effectName:String) : FightEffectConfigData
		{
			var configData:FightEffectConfigData;
			
			for each(var item:FightEffectConfigData in _fightEffectDatas)
			{
				if (item.name == effectName)
				{
					configData = item;
					break;
				}
			}
			
			if (!configData) throw new Error("没找到战斗特效");
			
			return configData;
		}
		
		public function addAnimatable(object:IAnimatable) : void
		{
			if(fightType == V.FIGHT)
				_view.fight.juggle.add(object);
			else if(fightType == V.ENDLESS_FIGHT)
				_view.endless_fight.juggle.add(object);
			else if(fightType == V.PLAYER_KILLING_FIGHT)
				_view.player_killing_fight.juggle.add(object);
			else if(fightType == V.BOSS_FIGHT)
				_view.boss_fight.juggle.add(object);
		}
		
		public function removeAnimatable(object:IAnimatable) : void
		{
			if(fightType == V.FIGHT)
				_view.fight.juggle.remove(object);
			else if(fightType == V.ENDLESS_FIGHT)
				_view.endless_fight.juggle.remove(object);
			else if(fightType == V.PLAYER_KILLING_FIGHT)
				_view.player_killing_fight.juggle.remove(object);
			else if(fightType == V.BOSS_FIGHT)
				_view.boss_fight.juggle.remove(object);
		}
	}
}
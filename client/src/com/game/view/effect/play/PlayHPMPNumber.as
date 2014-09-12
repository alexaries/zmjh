package com.game.view.effect.play
{
	import com.engine.utils.Utilities;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.effect.FightEffectConfig;
	import com.game.view.fight.FightRoleComponent;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class PlayHPMPNumber extends BasePlay
	{
		private var _contain:Sprite;
		
		public function PlayHPMPNumber()
		{
			super();
		}
		
		private var _data:int;
		private var _type:String;
		private var _delayTime:Number;
		public function initNumber(target:Component, data:int, type:String, delayTime:Number) : void
		{
			_data = data;
			_type = type;
			_delayTime = delayTime;
			
			_contain = new Sprite();
			target.panel.addChild(_contain);
			_contain.x  = 27;
			_contain.y = 102;
			_contain.alpha = 1;
			
			createObj();
		}
		
		private function createObj() : void
		{			
			createSign();
			
			_value = Math.abs(_data);
			
			var arrs:Array = Utilities.seperate(_value);
			
			while (arrs.length > 0)
			{
				createNumber(arrs.shift());
			}
			
			onPlay();
		}
		
		private var _tween:Tween;
		private function onPlay() : void
		{
			_tween = new Tween(_contain, _delayTime);
			_tween.moveTo(_contain.x, 0);
			if (_type == FightEffectConfig.MP) _tween.delay = _delayTime / 3;
			_tween.onComplete = function () : void
			{
				var _tween_1:Tween = new Tween(_contain, _delayTime / 3, Transitions.EASE_IN_OUT);
				_tween_1.fadeTo(0);
				_tween_1.delay = _delayTime / 3 * 2;
				_tween_1.onComplete = onComplete;
				Starling.juggler.add(_tween_1);
			};
			Starling.juggler.add(_tween);
		}
		
		/**
		 * 播放完毕 
		 * 
		 */		
		private function onComplete() : void
		{
			if (_sign)
			{
				_sign.texture.dispose();
				_sign.dispose();
				_sign = null;
			}
			
			if (_contain)
			{
				if(_contain.parent != null) _contain.parent.removeChild(_contain);
				_contain.dispose();
				_contain = null;
			}
		}
		
		private var _sign:Image;
		private function createSign() : void
		{
			var texture:Texture;
			var name:String;
			switch (_type)
			{
				case FightEffectConfig.HP:
					name = (_data < 0 ? "DPHp" : "APHp");
					texture = _fightEffectView.titleTxAtlas2.getTexture(name);
					_sign = new Image(texture);
					break;
				case FightEffectConfig.MP:
					name = (_data < 0 ? "DPMp" : "APMp");
					texture = _fightEffectView.titleTxAtlas2.getTexture(name);
					_sign = new Image(texture);
					break;
				case FightEffectConfig.NEIGONG_HP:
					name = "DNHP";
					texture = _fightEffectView.titleTxAtlas2.getTexture(name);
					_sign = new Image(texture);
					break;
			}
			
			_contain.addChild(_sign);
		}
		
		private var _value:int;
		private function createNumber(remainder:int) : void
		{						
			var name:String;
			var texture:Texture;
			switch (_type)
			{
				case FightEffectConfig.HP:
					name = (_data < 0 ? "DHp" : "AHp");
					break;
				case FightEffectConfig.MP:
					name = (_data < 0 ? "DMp" : "AMp");
					break;
				case FightEffectConfig.NEIGONG_HP:
					name = "AMp";
					break;
			}
			name += "_" + (remainder + 1);
			texture = _fightEffectView.titleTxAtlas2.getTexture(name);
			var num:Image = new Image(texture);
			num.x = _contain.width;
			_contain.addChild(num);
		}
		
		private function getNumber() : int
		{
			var value:int = 0;
			
			
			return value;
		}
		
	}
}
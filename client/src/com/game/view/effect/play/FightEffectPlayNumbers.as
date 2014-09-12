package com.game.view.effect.play
{
	import com.engine.core.Log;
	import com.game.data.fight.structure.AttackRoundData;
	import com.game.data.fight.structure.DefendRoundData;
	import com.game.view.fight.FightResultComponent;
	import com.game.view.fight.FightRoleComponent;
	
	import starling.animation.Tween;

	public class FightEffectPlayNumbers extends BasePlay implements IPlay
	{
		public static const DELAY_TIME:Number = 0.5;
		
		public static const HP_AND_MP_DELAY_TIME:Number = 0.3;
		
		public var hpAndMpDelayTime:Number = 0.3;
		
		public function FightEffectPlayNumbers()
		{
			super();
		}
		
		private var _callback:Function;
		public function onPlay(callback:Function) : void
		{
			_callback = callback;
			
			_attackComplete = false;
			_defendComplete = false;

			onAttack();
		}
		
		protected function checkComplete() : void
		{
			if (_attackComplete && _defendComplete)
			{
				_callback();
			}
		}
		
		/**
		 * 攻击方 
		 * 
		 */
		private var _attackComplete:Boolean;
		private function onAttack() : void
		{
			var target:FightRoleComponent = _fightEffectView.attackTarget;
			var data:AttackRoundData = _fightEffectView.fightRound.attack;
			
			target.mpAndHpDelayTime = hpAndMpDelayTime;
			target.setHPAndMP(
				data,
				function () : void
				{
					_attackComplete = true;
					Log.Trace("onAttack Complete");
					// 攻击完 ——》被攻击方
					onDefend();
				}
			);
		}
		
		/**
		 * 被攻击方 
		 * 
		 */
		private var _defendComplete:Boolean;
		// 被攻击对象总数
		private var _curDefendNum:int;
		private function onDefend() : void
		{
			// 被攻击者（有可能没有如攻击者处于晕阙 睡眠）
			if (!_fightEffectView.fightRound.defend || _fightEffectView.fightRound.defend.length == 0)
			{
				_defendComplete = true;
				checkComplete();
				return;
			}
			
			_curDefendNum = _fightEffectView.fightRound.defend.length;
			Log.Trace("_curDefendNum:"+ _curDefendNum);
			
			var defendItem:FightRoleComponent;
			var defend:DefendRoundData;
			
			for (var i:int = 0; i < _fightEffectView.fightRound.defend.length; i++)
			{
				defendItem = _fightEffectView.defends[i];
				defendItem.mpAndHpDelayTime = hpAndMpDelayTime;
				defend = _fightEffectView.fightRound.defend[i];
				Log.Trace("defend " + i + " :" + defend.configRole.name);
				onDefendHPMP(defendItem, defend);
			}
		}
		
		private function checkDefendComplete() : void
		{
			_curDefendNum -= 1;
			
			Log.Trace("checkDefendComplete _curDefendNum:"+ _curDefendNum);
			// 特效全部播放完
			if (_curDefendNum == 0)
			{
				_defendComplete = true;
				checkComplete();
			}
		}
		
		private function onDefendHPMP(target:FightRoleComponent, data:DefendRoundData) : void
		{
			target.setHPAndMP(data, checkDefendComplete);
		}
	}
}
package com.game.view.fight
{
	import com.game.View;
	import com.game.template.V;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.text.TextField;

	public class FightEffect
	{
		private static var _tween:Tween;
		
		/**
		 * 受伤飘血 
		 * @param view
		 * @param tx
		 * @param startY
		 * @param callback
		 * 
		 */		
		public static function injuredNumEffect(view:View, tx:TextField, startY:int, callback:Function = null) : void
		{
			tx.alpha = 1;
			tx.y = startY;
			_tween = new Tween(tx, 0.5, Transitions.EASE_IN_OUT);
			_tween.moveTo(tx.x, 0);
			_tween.onComplete = function () : void
			{
				_tween = new Tween(tx, 0.1, Transitions.EASE_IN_OUT);
				_tween.fadeTo(0);
				_tween.delay = 0.2;
				_tween.onComplete = callback;
				view.fight.juggle.add(_tween);
			};
			
			view.fight.juggle.add(_tween);
		}
		
		// 攻击特效
		public static const DIS:int = 20;
		public static function attackEffect(view:View, target:Image, stand:String, callback:Function = null) : void
		{
			var dis:int;
			if (stand == V.ME) dis = DIS;
			else dis = -DIS;
			
			_tween = new Tween(target, 0.2, Transitions.EASE_IN_OUT);
			_tween.moveTo(target.x + dis, target.y);			
			_tween.onComplete = function () : void
			{
				_tween = new Tween(target, 0.2, Transitions.EASE_IN_OUT);
				_tween.moveTo(target.x - dis, target.y);
				_tween.onComplete = callback;
				view.fight.juggle.add(_tween);
			};
			view.fight.juggle.add(_tween);
		}
		
	}
}
package com.game.view.effect.play
{
	import com.game.View;
	import com.game.view.effect.FightEffectView;
	
	import starling.events.EventDispatcher;

	public class BasePlay extends EventDispatcher
	{
		protected var _fightEffectView:FightEffectView;
		
		protected var _view:View;
		
		public function BasePlay()
		{
			super();
			
			_view = View.instance;
			_fightEffectView = _view.fightEffect;
		}
	}
}
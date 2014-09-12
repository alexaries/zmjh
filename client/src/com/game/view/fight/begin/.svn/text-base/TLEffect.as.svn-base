package com.game.view.fight.begin
{
	import com.game.view.fight.begin.tl.*;

	public class TLEffect extends BaseBeginEffect
	{
		private var _tl:BaseTL;
		public function get tl() : BaseTL
		{
			return _tl;	
		}
		
		private var _tlType:String;
		public function get tlType() : String
		{
			return _tlType;
		}
		
		public function TLEffect()
		{
			super();
		}
		
		override protected function parseConfig() : void
		{
			super.parseConfig();
			
			_tlType = _config.type[0];
			
			switch (_tlType)
			{
				case "alpha":
					_tl = createTLAlpha();
					break;
				case "move":
					_tl = createTLMove();
					break;
			}
		}
		
		protected function createTLAlpha() : TL_ALPHA
		{
			var tl:TL_ALPHA = new TL_ALPHA();
			tl.parseConfig(_config);
			
			return tl;
		}
		
		protected function createTLMove() : TL_MOVE
		{
			var tl:TL_MOVE = new TL_MOVE();
			tl.parseConfig(_config);
			
			return tl;
		}
	}
}
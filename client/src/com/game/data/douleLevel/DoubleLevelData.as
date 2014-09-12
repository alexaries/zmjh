package com.game.data.douleLevel
{
	import com.game.data.Base;
	import com.game.data.player.structure.Player;

	public class DoubleLevelData extends Base
	{
		public function get player() : Player
		{
			return _data.player.player;
		}
		public function get doubleLevelInfo() : DoubleLevelInfo
		{
			return player.doubleLevelInfo;
		}
		
		public function DoubleLevelData()
		{
		}
		
		public function checkDoubleTime() : void
		{
			var bol:Boolean = _data.time.checkEveryDayPlay(doubleLevelInfo.time);
			
			if(bol)
				doubleLevelInfo.firstEnter();
		}
	}
}
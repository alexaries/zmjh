package com.game.data.worldBoss
{
	import com.game.data.Base;
	import com.game.data.player.structure.Player;
	
	public class WorldBossData extends Base
	{
		public function get player() : Player
		{
			return _data.player.player;
		}
		public function get worldBossInfo() : WorldBossInfo
		{
			return player.worldBossInfo;
		}
		
		public function WorldBossData()
		{
		}
		
		public function checkWorldBoss() : void
		{
			var bol:Boolean = _data.time.checkEveryDayPlay(worldBossInfo.time);
			
			if(bol)
				worldBossInfo.firstEnter();
		}
	}
}
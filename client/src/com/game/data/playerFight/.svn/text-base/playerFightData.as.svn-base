package com.game.data.playerFight
{
	import com.game.data.Base;
	import com.game.data.player.structure.Player;

	public class playerFightData extends Base
	{
		public function get player() : Player
		{
			return _data.player.player;
		}
		
		public function get playerFightInfo() : PlayerFightInfo
		{
			return player.playerFightInfo;
		}
		
		public function playerFightData()
		{
		}
		
		/**
		 * 检测
		 * 
		 */		
		public function checkData() : void
		{
			var bol:Boolean = _data.time.checkEveryDayPlay(playerFightInfo.rewardTime);
			
			if (bol)
			{
				playerFightInfo.firstEnter();
			}
		}
	}
}
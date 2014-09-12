package com.game.data.LevelSelect
{
	import com.game.data.Base;
	import com.game.data.player.structure.Player;

	public class AutoFightData extends Base
	{
		
		public function get player() : Player
		{
			return _data.player.player;
		}
		
		public function AutoFightData()
		{
		}
		
		public function checkData() : void
		{
			var bol:Boolean = _data.time.checkEveryDayPlay(player.autoFightInfo.time);
			
			// 隔天则初始化
			if (bol)
			{
				player.autoFightInfo.initInfo();
			}
		}
	}
}
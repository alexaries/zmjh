package com.game.data.daily
{
	import com.game.data.Base;
	import com.game.data.player.structure.Player;

	public class DailyThingData extends Base
	{
		public function get player() : Player
		{
			return _data.player.player;
		}
		
		public function DailyThingData()
		{
		}
		
		public function checkData() : void
		{
			var bol:Boolean = _data.time.checkEveryDayPlay(player.dailyThingInfo.time);
			
			// 隔天则初始化每日必做
			if (bol)
			{
				player.dailyThingInfo.initInfo();
			}
		}
	}
}
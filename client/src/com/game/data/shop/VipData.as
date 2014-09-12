package com.game.data.shop
{
	import com.game.data.Base;
	import com.game.data.player.structure.Player;

	public class VipData extends Base
	{
		public function get player() : Player
		{
			return _data.player.player;
		}
		public function VipData()
		{
		}
		
		public function checkData() : void
		{
			var bol:Boolean = _data.time.checkEveryDayPlay(player.vipInfo.time);
			
			// 隔天则初始化vip礼包领取
			if (bol)
			{
				player.vipInfo.initInfo();
			}
		}
	}
}
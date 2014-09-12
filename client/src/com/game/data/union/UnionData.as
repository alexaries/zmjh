package com.game.data.union
{
	import com.game.data.Base;
	import com.game.data.player.structure.Player;

	public class UnionData extends Base
	{
		public function get player() : Player
		{
			return _data.player.player;
		}
		
		public function UnionData()
		{
		}
		
		public function checkData() : void
		{
			var bol:Boolean = _data.time.checkEveryDayPlay(player.unionInfo.time);
			
			// 隔天则初始化每日任务模板数据
			if (bol)
			{
				player.unionInfo.initInfo();
			}
		}
	}
}
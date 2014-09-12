package com.game.data.online
{
	import com.game.data.Base;
	import com.game.data.player.structure.Player;
	import com.game.manager.DebugManager;
	import com.game.template.V;

	public class OnlineTimeData extends Base
	{
		public function get player() : Player
		{
			return _data.player.player;
		}
		
		public function get onlineTimeInfo() : OnlineTimeInfo
		{
			return player.onlineTimeInfo;
		}
		
		public function OnlineTimeData()
		{
			
		}
		
		public function checkOnlineTime() : void
		{
			var bol:Boolean = _data.time.checkEveryDayPlay(onlineTimeInfo.time);
			
			// 隔天则初始化每日任务模板数据
			if (bol)
			{
				initOnlineTime();
			}
		}
		
		private function initOnlineTime() : void
		{
			if (DebugManager.instance.gameMode == V.DEVELOP && _data.time.curTimeStr == null)
			{
				_data.time.curTimeStr = "2013-06-05 16:48:36";
			}
			onlineTimeInfo.time = _data.time.curTimeStr;
			onlineTimeInfo.nowRewardLevel = 0;
			onlineTimeInfo.reset();
		}
	}
}
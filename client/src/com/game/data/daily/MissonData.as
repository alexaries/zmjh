package com.game.data.daily
{
	import com.game.data.Base;
	import com.game.data.player.structure.HurtEnemyInfo;
	import com.game.data.player.structure.MissonInfo;
	import com.game.data.player.structure.Player;
	import com.game.manager.DebugManager;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;

	public class MissonData extends Base
	{
		public function get player() : Player
		{
			return _data.player.player;
		}
		
		public function get missonInfo() : MissonInfo
		{
			return player.missonInfo;
		}
		
		public function MissonData()
		{
			
		}
		
		/**
		 * 检测每日任务数据 
		 * 
		 */		
		public function checkData() : void
		{
			var bol:Boolean = _data.time.checkEveryDayPlay(missonInfo.lastTime);
			
			// 隔天则初始化每日任务模板数据
			if (bol)
			{
				initMissonInfo();
			}
			else
			{
				resetMissionInfo();
			}
		}
		
		/**
		 * 初始化模板数据 
		 * 
		 */		
		protected function initMissonInfo() : void
		{
			if (DebugManager.instance.gameMode == V.DEVELOP && _data.time.curTimeStr == null)
			{
				_data.time.curTimeStr = "2013-06-05 16:48:36";
			}
			missonInfo.lastTime = _data.time.curTimeStr;
			missonInfo.hurtEnemy = new Vector.<HurtEnemyInfo>();
			
			// task
			missonInfo.initTask();
		}
		
		private function resetMissionInfo() : void
		{
			missonInfo.resetMissionInfo();
		}
		
		/**
		 * 增加杀死怪物 
		 * @param id
		 * @param num
		 * 
		 */		
		public function countKillEnemy(id:int, num:int) : void
		{
			var index:int = searchKillEnemyIndex(id);
			
			// 没有该怪物记录
			if (index == -1)
			{
				var info:HurtEnemyInfo = new HurtEnemyInfo();
				info.id = id;
				info.num = num;
				missonInfo.hurtEnemy.push(info);
			}
			else
			{
				missonInfo.hurtEnemy[index].num += num;
			}
		}
		
		/**
		 * 获取所杀怪物的数量 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getKillEnemyNum(id:int) : int
		{
			var index:int = searchKillEnemyIndex(id);
			
			return index == -1 ? 0 : missonInfo.hurtEnemy[index].num;
		}
		
		protected function searchKillEnemyIndex(id:int) : int
		{
			var index:int = -1;
			var info:HurtEnemyInfo;
			for (var i:int = 0; i < missonInfo.hurtEnemy.length; i++)
			{
				info = missonInfo.hurtEnemy[i];
				if (info.id == id)
				{
					index = i;
					break;
				}
			}
			
			return index;
		}
	}
}
package com.game.data.save
{
	import com.engine.core.Log;
	import com.engine.net.GameRankListFor4399;
	import com.engine.net.RankEvent;
	import com.engine.net.RankEventType;
	import com.game.View;
	import com.game.data.Base;
	import com.game.template.InterfaceTypes;

	public class RankData extends Base
	{
		/**
		 * 真假小宝测试榜
		 */		
		private var _testWorldBossID:uint
		public function get testWorldBossID() : uint
		{
			if(_testWorldBossID == 0)
				_testWorldBossID = 589;
			return _testWorldBossID;
		}
		
		/**
		 * 真假小宝
		 */		
		private var _worldBossID:uint;
		public function get worldBossID() : uint
		{
			if(_worldBossID == 0)
				_worldBossID = 579;
			return _worldBossID;
		}
		
		/**
		 * 战力榜
		 */		
		private var _fightingID:uint;
		public function get fightingID() : uint
		{
			if(_fightingID == 0)
				_fightingID = 585;
			return _fightingID;
		}
		
		/**
		 * 竞技场
		 */		
		private var _playerFightID:uint;
		public function get playerFightID() : uint
		{
			if(_playerFightID == 0)
				_playerFightID = 592;
			return _playerFightID;
		}
		
		private var _userID:int;
		public function get userID() : int
		{
			return _userID;
		}
		
		public function set userID(value:int) : void
		{
			_userID = value;
		}
		private var _userName:String;
		public function get userName() : String
		{
			return _userName;
		}
		public function set userName(value:String) : void
		{
			_userName = value;
		}
		
		// 平台服务
		public function get serviceHold() : *
		{
			return GameRankListFor4399.instance.serviceHold;
		}
		
		private var _rank:GameRankListFor4399;
		public function get rank() : GameRankListFor4399
		{
			return _rank;
		}
		
		private var _callback:Function;
		public function set callback(value:Function) : void
		{
			_callback = value;
		}
		public function get callback() : Function
		{
			return _callback;
		}
		private var _submitCallback:Function;
		public function set submitCallback(value:Function) : void
		{
			_submitCallback = value;
		}
		public function get submitCallback() : Function 
		{
			return _submitCallback;
		}
		
		public function RankData()
		{
			_rank = GameRankListFor4399.instance;
			initEvent();
		}
		
		private function initEvent() : void
		{
			_rank.addEventListener(RankEventType.GET_USER_DATA, 	onRankEvent);
			_rank.addEventListener(RankEventType.GET_ONE_RANK_INFO, 	onRankEvent);
			_rank.addEventListener(RankEventType.GET_RANK_LIST_BY_OWN, 	 onRankEvent);
			_rank.addEventListener(RankEventType.GET_RANK_LISTS_DATA, 	onRankEvent);
			_rank.addEventListener(RankEventType.SUBMIT_SCORE_TO_RANK_LISTS, 	onRankEvent);
			_rank.addEventListener(RankEventType.RANK_LIST_ERROR, onRankError);
		}
		
		private function onRankError(e:RankEvent) : void
		{
			if(e.data.code == "10005")
			{
				View.instance.tip.interfaces(InterfaceTypes.Show,
					"当前浏览器存在两个账号，请重新登陆游戏！", null, null, false, false, false);
			}
			if(e.data.apiName == "5")
			{
				if(_callback != null) _callback(null, false);
			}
		}
		
		private function onRankEvent(e:RankEvent) : void
		{
			switch (e.type)
			{
				case RankEventType.GET_USER_DATA:
					if(_callback != null)
						_callback(e.data);
					break;
				case RankEventType.GET_ONE_RANK_INFO:
					if(_callback != null)
						_callback(e.data);
					break;
				case RankEventType.GET_RANK_LIST_BY_OWN:
					if(_callback != null)
						_callback(e.data);
					break;
				case RankEventType.GET_RANK_LISTS_DATA:
					if(_callback != null)
						_callback(e.data);
					break;
				case RankEventType.SUBMIT_SCORE_TO_RANK_LISTS:
					if(_submitCallback != null && (e.data as Array).length > 0)
					{
						//真假小宝
						if(uint((e.data as Array)[0].rId) == worldBossID)
							_submitCallback(e.data);
						//竞技场
						else if(uint((e.data as Array)[0].rId) == playerFightID)
						{
							if((e.data as Array)[0].code == "10000")
								_submitCallback();
							else
								_submitCallback(false);
						}
					}
					break;
			}
		}
		
		//根据用户名搜索其在某排行榜下的信息
		public function getOneRankInfo(arg1:uint, arg2:String):void
		{
			if(serviceHold)
			{
				serviceHold.getOneRankInfo(arg1, arg2);
			}
		}
		
		//根据自己的排名及范围取排行榜信息
		public function getRankListByOwn(arg1:uint, arg2:uint, arg3:uint):void
		{
			if(serviceHold)
			{
				serviceHold.getRankListByOwn(arg1, arg2, arg3);
			}
		}
		
		//根据一页显示多少条及取第几页数据来取排行榜信息
		public function getRankListsData(arg1:uint, arg2:uint, arg3:uint):void
		{
			if(serviceHold)
			{
				serviceHold.getRankListsData(arg1, arg2, arg3);
			}
		}
		
		//提交成绩到排行榜
		public function submitScoreToRankLists(arg1:uint, arg2:Array):void
		{
			if(serviceHold)
			{
				serviceHold.submitScoreToRankLists(arg1, arg2);
			}
		}
		
		//根据用户uid和存档索引获得数据
		public function getUserData(arg1:String, arg2:uint) : void
		{
			if(serviceHold)
			{
				serviceHold.getUserData(arg1, arg2);
			}
		}
	}
}
package com.game.data.daily
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.View;
	import com.game.data.Base;
	import com.game.data.db.protocal.Daily_attendance;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.SignInInfo;
	import com.game.template.V;

	public class DailyData extends Base
	{
		public function get player() : Player
		{
			return _data.player.player;
		}
		
		public function DailyData()
		{
		}
		
		/**
		 * 每日签到信息 
		 * @return 
		 * 
		 */		
		public function getSignInInfo() : SignInInfo
		{
			return player.signInInfo;
		}
		
		/**
		 *  
		 * @param rewardNum : 奖励的骰子
		 * @return 
		 * 
		 */		
		public function checkDiceReachUp(rewardNum:int) : Boolean
		{
			return (player.dice + rewardNum) > V.DICE_MAX_NUM;
		}
		
		/**
		 * 设置签到 
		 * @param signDay
		 * 
		 */		
		public function setSignInInfo(signDay:int, templateData:Daily_attendance) : void
		{
			player.signInInfo.lastDay = _data.time.curTimeStr;
			player.signInInfo.appendSignDays(_data.time.curTimeStr);
			player.signInInfo.duration = signDay;
			player.dailyThingInfo.setThingComplete(1);
			
			rewardDiceEveryDay(templateData);
			// 立即保存
			
			Log.Trace("每日签到保存");
			_data.control.save.onCommonSave(false, 1, false);
		}
		
		public function rewardDiceEveryDay(templateData:Daily_attendance) : void
		{
			// 每天色子 50
			player.dice += templateData.dice;
			
			var content:String = "恭喜你获得今日奖励 骰子X" + templateData.dice;
			View.instance.prompEffect.play(content);
		}
	}
}
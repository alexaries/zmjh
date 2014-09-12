package com.game.data.fight.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.View;

	public class SpecialEnemyData
	{
		private static var _anti:Antiwear;
		
		private static function get activityTime() : String
		{
			if(_anti == null) 
				_anti = new Antiwear(new binaryEncrypt());
			if(_anti["activityTime"] == null)
				_anti["activityTime"] = "2013-09-13 00:00:00";
			return _anti["activityTime"];
		}
		
		public function SpecialEnemyData()
		{
			
		}
		
		public static function checkMoonEnemy() : Boolean
		{
			var result:Boolean = false;
			var random:Number = Math.random();
			
			var maxRate:Number = 0.02;
			maxRate = Data.instance.player.player.multiRewardInfo.checkRPRoleRate(maxRate);
			maxRate = View.instance.double_level.checkDoubleRoleRate(maxRate);
			maxRate = Data.instance.player.player.vipInfo.checkRPUp(maxRate);
			
			if(random < maxRate && isInMoonActivity())
				result = true;
			
			if(View.instance.first_guide.isGuide == true || View.instance.get_role_guide.isGuide == true)
				result = false;
			
			return result;
		}
		
		/**
		 * 是否在活动日期之内
		 * @return 
		 * 
		 */		
		public static function isInMoonActivity() : Boolean
		{
			var result:Boolean = false;
			
			var intervalTime:int = Data.instance.time.disDayNum(activityTime, Data.instance.time.curTimeStr.split(" ")[0]);
			if(intervalTime >= 0 && intervalTime <= 17)
				result = true;
			
			return result;
		}
	}
}
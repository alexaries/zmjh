package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class SignInInfo
	{
		private var _anti:Antiwear;
		
		/**
		 * 签到持续时间 
		 * @return 
		 * 
		 */		
		public function get duration() : int
		{
			return _anti["duration"];
		}
		public function set duration(value:int) : void
		{
			_anti["duration"] = value;
		}
		
		/**
		 * 上一次领取每日奖励时间 
		 * @return 
		 * 
		 */		
		public function get lastDay() : String
		{
			return _anti['lastDay'];
		}
		public function set lastDay(value:String) : void
		{
			_anti['lastDay'] = value;
		}
		
		/**
		 * 签到记录 
		 * @return 
		 * 
		 */		
		public function get signDays() : String
		{
			return _anti['signDays'];
		}
		public function set signDays(value:String) : void
		{
			_anti['signDays'] = value;
		}
		
		public function SignInInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["duration"] = 0;
			_anti['lastDay'] = '';
			_anti['signDays'] = '';
		}
		
		/**
		 * 添加签到记录 
		 * 
		 */		
		public function appendSignDays(day:String) : void
		{
			signDays += "|" + day;
			
			var signArr:Array = [];
			signArr = signDays.split("|");
			
			while(signArr.length > 7)
			{
				signArr.shift();
			}
			signDays = signArr.join("|");
		}
		
		public function getSignInXML() : XML
		{
			var info:XML = <sign_in></sign_in>;
			
			info.appendChild(<duration>{duration}</duration>);
			info.appendChild(<lastDay>{lastDay}</lastDay>);
			info.appendChild(<signDays>{signDays}</signDays>);
			
			return info;
		}
	}
}
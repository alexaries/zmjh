package com.game.data.endless
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class EndlessInfo
	{
		private var _endlessDetail:Vector.<EndlessDetail>;
		public function get endlessDetail() :  Vector.<EndlessDetail>
		{
			return _endlessDetail;
		}
		
		private var _anti:Antiwear;
		
		public function get time() : String
		{
			return _anti["time"];
		}
		public function set time(value:String) : void
		{
			_anti["time"] = value;
		}
		
		/**
		 * 今天闯关的时间
		 * @return 
		 * 
		 */		
		public function get endlessTime() : int
		{
			return _anti["endlessTime"];
		}
		public function set endlessTime(value:int) : void
		{
			_anti["endlessTime"] = value;
		}
		
		/**
		 * 今天闯关关数
		 * @return 
		 * 
		 */		
		public function get endlessLevel() : int
		{
			return _anti["endlessLevel"];
		}
		public function set endlessLevel(value:int) : void
		{
			_anti["endlessLevel"] = value;
		}
		
		/**
		 * 曾经最大的闯关关数
		 * @return 
		 * 
		 */		
		public function get maxLevel() : int
		{
			return _anti["maxLevel"];
		}
		public function set maxLevel(value:int) : void
		{
			_anti["maxLevel"] = value;
		}
		
		/**
		 * 完成次数
		 * @return 
		 * 
		 */		
		public function get isComplete() : int
		{
			return _anti["isComplete"];
		}
		public function set isComplete(value:int) : void
		{
			_anti["isComplete"] = value;
		}
		
		public function EndlessInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["time"] = "";
			_anti["endlessTime"] = 0;
			_anti["endlessLevel"] = 0;
			_anti["maxLevel"] = 0;
			_anti["isComplete"] = 0;
		}
		
		public function init(data:XML) : void
		{
			time = data.time;
			endlessTime = data.endlessTime;
			endlessLevel = data.endlessLevel;
			maxLevel = data.maxLevel;
			isComplete = data.isComplete;
		}
		
		public function getXML() : XML
		{
			var info:XML = <endless></endless>;
			info.appendChild(<time>{time}</time>);
			info.appendChild(<endlessTime>{endlessTime}</endlessTime>);
			info.appendChild(<endlessLevel>{endlessLevel}</endlessLevel>);
			info.appendChild(<maxLevel>{maxLevel}</maxLevel>);
			info.appendChild(<isComplete>{isComplete}</isComplete>)
			
			return info;
		}
		
		public function checkMaxLevel(level:int) : void
		{
			if(level > maxLevel)
				maxLevel = level;
		}
	}
}
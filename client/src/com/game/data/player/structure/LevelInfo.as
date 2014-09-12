package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class LevelInfo
	{
		private var _anti:Antiwear;	
		
		/**
		 * 关卡名称 
		 */
		//public var name:String;
		public function get name() : String
		{
			return _anti["name"];
		}
		public function set name(value:String) : void
		{
			_anti["name"] = value;
		}
		
		/**
		 * 困难模式 
		 */		
		//public var difficulty:int;
		public function get difficulty() : int
		{
			return _anti["difficulty"];
		}
		public function set difficulty(value:int) : void
		{
			_anti["difficulty"] = value;
		}
		
		public function LevelInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["name"] = "";
			_anti["difficulty"] = 0;
		}
	}
}
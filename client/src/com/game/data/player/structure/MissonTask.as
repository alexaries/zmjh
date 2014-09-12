package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class MissonTask
	{
		private var _anti:Antiwear;
		
		/**
		 * 任务id 
		 * @return 
		 * 
		 */		
		public function get id() : int
		{
			return _anti["id"];
		}
		public function set id(value:int) : void
		{
			_anti["id"] = value;
		}
		
		/**
		 * 是否完成任务领取 
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
		
		/**
		 * 装备ID 
		 * @return 
		 * 
		 */		
		public function get equipmentID() : int
		{
			return _anti["equipmentID"];
		}
		public function set equipmentID(value:int) : void
		{
			_anti["equipmentID"] = value;
		}
		
		/**
		 * 道具ID 
		 * @return 
		 * 
		 */		
		public function get propID() : int
		{
			return _anti["propID"];
		}
		public function set propID(value:int) : void
		{
			_anti["propID"] = value;
		}
		
		public function MissonTask()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["id"] = 0;
			_anti["isComplete"] = -1;
			_anti["equipmentID"] = -1;
			_anti["propID"] = -1;
		}
	}
}
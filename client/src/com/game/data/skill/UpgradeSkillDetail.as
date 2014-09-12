package com.game.data.skill
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class UpgradeSkillDetail
	{
		private var _anti:Antiwear;
		
		public function get skillID() : int
		{
			return _anti["skillID"];
		}
		public function set skillID(value:int) : void
		{
			_anti["skillID"] = value;
		}
		
		public function get skillLevel() : int
		{
			return _anti["skillLevel"];
		}
		public function set skillLevel(value:int) : void
		{
			_anti["skillLevel"] = value;
		}
		
		
		public function UpgradeSkillDetail()
		{
			_anti = new Antiwear(new binaryEncrypt());
			_anti["skillID"] = 0;
			_anti["skillLevel"] = 0;
		}
	}
}
package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class GuideStructure
	{
		private var _anti:Antiwear;

		public function get levelName() : String
		{
			return _anti["levelName"];
		}
		public function set levelName(value:String) : void
		{
			_anti["levelName"] = value;
		}
		
		public function get type() : String
		{
			return _anti["type"];
		}
		public function set type(value:String) : void
		{
			_anti["type"] = value;
		}
		
		public function GuideStructure()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["id"] = 0;
			_anti["levelName"] = "";
			_anti["type"] = "";
			_anti["isComplete"] = 0;
		}
	}
}
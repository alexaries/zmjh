package com.game.data.save
{
	public class SubmitData extends Object
	{
		public var rId:int;
		
		public var score:int;
		
		public var extra:String;
		
		public function SubmitData(inputId:int, inputScore:int, inputExtra:String = "")
		{
			rId = inputId;
			score = inputScore;
			extra = inputExtra;
		}
	}
}
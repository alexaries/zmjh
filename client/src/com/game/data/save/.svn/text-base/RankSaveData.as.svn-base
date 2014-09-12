package com.game.data.save
{
	import com.game.Data;
	import com.game.data.Base;

	public class RankSaveData extends Base
	{
		public function RankSaveData()
		{
			
		}
		
		public static function RankSave(rankId:int, rankScore:int, rankExtra:String) : void
		{
			if(rankId == Data.instance.rank.worldBossID)
			{
				/*if(Data.instance.pay.userID == 465436479 || Data.instance.pay.userID == 115099833) 
				return;*/
			}
			
			var obj:SubmitData = new SubmitData(rankId, rankScore, rankExtra);
			var rankInfoAry:Array = new Array();
			rankInfoAry.push(obj);
			Data.instance.rank.submitScoreToRankLists(Data.instance.save.saveIndex, rankInfoAry);
		}
	}
}
package com.engine.net
{
	import com.game.Data;
	import com.game.View;
	
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	
	import unit4399.events.RankListEvent;
	
	public class GameRankListFor4399 extends EventDispatcher
	{
		
		public var serviceHold:*;
		public var isLocal:Boolean;
		
		private var _stage:Stage;
		public function get stage() : Stage
		{
			return _stage;
		}
		public function set stage(value:Stage) : void
		{
			_stage = value;
			
			serviceHold = Main.serviceHold;
			initEvent();
		}
		
		private static var _instance : GameRankListFor4399
		public static function get instance() : GameRankListFor4399
		{
			if (!_instance)
			{
				_instance = new GameRankListFor4399();
			}
			
			return _instance;
		}
		
		public function GameRankListFor4399()
		{
			if (_instance) throw new Error("该类只能为单例");
		}
		
		private function initEvent() : void
		{
			stage.addEventListener("rankListError",onRankListErrorHandler);
			stage.addEventListener("rankListSuccess",onRankListSuccessHandler);
		}
		
		private function onRankListErrorHandler(evt:*) : void
		{
			this.dispatchEvent(new RankEvent(RankEventType.RANK_LIST_ERROR, evt.data));
			var obj:Object = evt.data;
			var str:String  = "apiFlag:" + obj.apiName + "   errorCode:" + obj.code + "   message:" + obj.message + "\n";
			trace(str);
			//rttTxt.text += str; 
		}
		
		private function onRankListSuccessHandler(evt:*) : void
		{
			var obj:Object = evt.data;
			//rttTxt.text = rttTxt.text + "apiFlag:" + obj.apiName+ "\n";
			
			var data:* =  obj.data;
			
			switch(obj.apiName){
				case "1":
					//根据用户名搜索其在某排行榜下的信息
					this.dispatchEvent(new RankEvent(RankEventType.GET_ONE_RANK_INFO, data));
					break;
				case "2":
					//根据自己的排名及范围取排行榜信息
					this.dispatchEvent(new RankEvent(RankEventType.GET_RANK_LIST_BY_OWN, data));
					break;
				case "4":
					//根据一页显示多少条及取第几条数据来取排行榜信息
					decodeRankListInfo(data);
					this.dispatchEvent(new RankEvent(RankEventType.GET_RANK_LISTS_DATA, data));
					break;
				case "3":
					//批量提交成绩至对应的排行榜(numMax<=5,extra<=500B)
					decodeSumitScoreInfo(data);
					this.dispatchEvent(new RankEvent(RankEventType.SUBMIT_SCORE_TO_RANK_LISTS, data));
					break;
				case "5":
					//根据用户ID及存档索引获取存档数据
					decodeUserData(data);
					this.dispatchEvent(new RankEvent(RankEventType.GET_USER_DATA, data));
					break;
			}
		}
		
		private function decodeUserData(dataObj:Object) : void
		{
			if(dataObj == null)
			{
				trace("没有用户数据！");
				//rttTxt.text += "没有用户数据！\n";
				return;
			}
			var str:String = "存档索引：" + dataObj.index + "\n标题:" + dataObj.title+"\n数据：" + dataObj.data+"\n存档时间：" + dataObj.datetime + "\n";
			trace(str);
			//rttTxt.text += str;
		}
		
		private function decodeSumitScoreInfo(dataAry:Array) : void
		{
			if(dataAry == null || dataAry.length == 0)
			{
				//rttTxt.text += "没有数据,返回结果有问题！\n";
				trace("没有数据,返回结果有问题！");
				//View.instance.prompEffect.play("没有数据,返回结果有问题！");
				return;
			}
			
			for(var i:String in dataAry){
				var tmpObj:Object = dataAry[i];
				var str:String = "第" + (i + 1) + "条数据。排行榜ID：" + tmpObj.rId + "，信息码值：" + tmpObj.code + "\n";
				//tmpObj.code == "20005" 表示排行榜已被锁定
				if(tmpObj.code == "10000"){
					str += "当前排名:" + tmpObj.curRank + ",当前分数：" + tmpObj.curScore + ",上一局排名：" + tmpObj.lastRank + ",上一局分数：" + tmpObj.lastScore+"\n";
				}else{
					str += "该排行榜提交的分数出问题了。信息：" + tmpObj.message + "\n";
				}
				//View.instance.prompEffect.play(str);
				trace(str);	
				//rttTxt.text += str;
			}
		}
		
		private function decodeRankListInfo(dataAry:Array) : void
		{
			if(dataAry == null || dataAry.length == 0)
			{
				trace("没有数据！");
				//rttTxt.text += "没有数据！\n";
				return;
			}
			
			for(var i:String in dataAry)
			{
				var tmpObj:Object = dataAry[i];
				var str:String = "第" + (int(i) + 1) + "条数据。存档索引：" + tmpObj.index + ",用户id:" + tmpObj.uId + ",昵称：" + tmpObj.userName+",分数：" + tmpObj.score + ",排名：" + tmpObj.rank + ",来自：" + tmpObj.area + ",扩展信息：" + tmpObj.extra + "\n";
				trace(str);
				//rttTxt.text += str;
			}
		}
	}
}
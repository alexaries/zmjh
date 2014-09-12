package com.game.data.online
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.View;
	import com.game.data.db.protocal.Prop;
	import com.game.data.player.structure.Player;
	import com.game.manager.DebugManager;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	
	import flash.utils.getTimer;
	
	import starling.core.Starling;
	import starling.text.TextField;

	public class OnlineTimeInfo
	{
		public function get player() : Player
		{
			return Data.instance.player.player;
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
		
		public function get nowRewardLevel() : int
		{
			return _anti["nowRewardLevel"];
		}
		public function set nowRewardLevel(value:int) : void
		{
			_anti["nowRewardLevel"] = value;
		}
		
		private var _infoData:Vector.<Object>;
		public function get infoData() : Vector.<Object>
		{
			return _infoData;
		}
		private var _nowDate:Date;
		private var _useDate:Date;
		public function get useDate() : Date
		{
			return _useDate;
		}
		public function set useDate(value:Date) : void
		{
			_useDate = value;
		}
		private var _isComplete:Boolean;
		public function get isComplete() : Boolean
		{
			return _isComplete;
		}
		public function set isComplete(value:Boolean) : void
		{
			_isComplete = value;
		}
		
		private var _isOver:Boolean;
		public function get isOver() : Boolean
		{
			return _isOver;
		}
		public function OnlineTimeInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["time"] = "";
			_anti["nowRewardLevel"] = 0;
			_isComplete = false;
		}
		
		public function init(data:XML) : void
		{
			if (DebugManager.instance.gameMode == V.DEVELOP && Data.instance.time.curTimeStr == null)
			{
				Data.instance.time.curTimeStr = "2013-07-16 16:48:36";
			}
			// 上一次任务时间
			time = data.time;
			if(time == "")
				time = Data.instance.time.curTimeStr;
			nowRewardLevel = data.level;
			
			_nowDate = setDate(Data.instance.time.analysisTime(time));
			
			_infoData = new Vector.<Object>();
			_infoData = Data.instance.db.interfaces(InterfaceTypes.GET_ONLINE_BONUS_DATA);
			
			if(nowRewardLevel >= _infoData.length)
			{
				_isOver = true;
				_isComplete = false;
			}
			else
			{
				_isOver = false;
				var newDate:Date = Data.instance.time.returnTimeNow();
				if(((newDate.time - _nowDate.time) * .001 / 60) >= _infoData[nowRewardLevel].time)
				{
					_isComplete = true;
				}
				else
				{
					var count:Number = _infoData[nowRewardLevel].time * 60 * 1000 - (newDate.time - _nowDate.time);
					_useDate = new Date(_nowDate.fullYear, _nowDate.month, _nowDate.date, 0, 0, 0);
					_useDate.time += count;
					_isComplete = false;
				}
			}
		}
		
		public function reset() : void
		{
			_nowDate = setDate(Data.instance.time.analysisTime(time));
			_isComplete = true;
			_isOver = false;
		}
		
		public function getXML() : XML
		{
			var item:XML;
			var info:XML = <onlineTime></onlineTime>;
			info.appendChild(<time>{time}</time>);
			info.appendChild(<level>{nowRewardLevel}</level>);
			
			return info;
		}
		
		public function addNextReward() : void
		{
			_nowDate = Data.instance.time.returnTimeNow();
			addProps();
			nowRewardLevel++;
			_isComplete = false;
			if(nowRewardLevel >= _infoData.length)
			{
				_isOver = true;
			}
			else
			{
				_useDate = new Date(_nowDate.fullYear, _nowDate.month, _nowDate.date, int(_infoData[nowRewardLevel].time / 60), int(_infoData[nowRewardLevel].time % 60), 0);
				time = _nowDate.fullYear + "-" + addPre(_nowDate.month + 1) + "-" + addPre(_nowDate.date) + " " + _nowDate.hours + ":" + _nowDate.minutes + ":" + _nowDate.seconds;
			}
			
		}
		
		public function getDiceNum() : int
		{
			return int(_infoData[nowRewardLevel].dice);
		}
		
		private function addProps() : void
		{
			player.dice += int(_infoData[nowRewardLevel].dice);
			var str:String = "";
			if(_infoData[nowRewardLevel].prop_id != "0")
			{
				//道具ID
				var propIDList:Array = _infoData[nowRewardLevel].prop_id.split("|");
				//道具数量
				var propNumList:Array = _infoData[nowRewardLevel].number.split("|");
				for(var i:int = 0; i < propIDList.length; i++)
				{
					Data.instance.pack.addNoneProp(int(propIDList[i]), int(propNumList[i]));
					str += "，" +　(Data.instance.db.interfaces(InterfaceTypes.GET_PROP_BY_ID, propIDList[i]) as Prop).name + "X" + propNumList[i];
				}
			}
			
			if((nowRewardLevel + 1) >= _infoData.length)
			{
				str += "\n今日奖励已发放完毕，请明天继续领取";
			}
			else
			{
				str += "\n后续奖励更加丰富，尽请期待";
			}
			
			View.instance.tip.interfaces(InterfaceTypes.Show,
				"恭喜您获得骰子X" + int(_infoData[nowRewardLevel].dice) + " " + str,
				function () : void
				{
					Starling.juggler.delayCall(timeReset, .01);
				},
				null,
				false,
				true,
				false);
		}
		
		private function timeReset() : void
		{
			//超过12点重新开始计算在线时间
			if(_nowDate.date != Data.instance.time.serverDate.date)
			{
				_isComplete = false;
				_isOver = true;
				View.instance.tip.interfaces(InterfaceTypes.Show,
					"时间已过12点，请刷新页面重新开始计算在线时间！",
					function() : void
					{
						View.instance.toolbar.checkOnlineTime();
					},
					null,
					false,
					true,
					false);
				var newDate:Date = Data.instance.time.serverDate;
				time = newDate.fullYear + "-" + addPre(newDate.month + 1) + "-" + addPre(newDate.date) + " " + newDate.hours + ":" + newDate.minutes + ":" + newDate.seconds;
				
				Log.Trace("在线奖励保存");
				View.instance.controller.save.onCommonSave(false, 1, false);
			}
		}
		
		public function checkRewardState() : Boolean
		{
			var newDate:Date = Data.instance.time.returnTimeNow();
			if(((newDate.time - _nowDate.time) * .001 / 60) >= _infoData[nowRewardLevel].time)
			{
				_isComplete = true;
			}
			return _isComplete;
		}
		
		private function setDate(lastTime:Array) : Date
		{
			var startDate:Date = new Date(lastTime[0], (int(lastTime[1]) - 1), lastTime[2], lastTime[3], lastTime[4], lastTime[5]);
			return startDate;
		}
		
		private function addPre(count:Number) : String
		{
			var result:String = "";
			if(count < 10)
				result = "0" + count;
			else
				result = count.toString();
			
			return result
		}
	}
}
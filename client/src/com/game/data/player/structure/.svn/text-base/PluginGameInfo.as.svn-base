package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;

	public class PluginGameInfo
	{
		private var _anti:Antiwear;
		
		/**
		 * 酒时间 
		 * @return 
		 * 
		 */		
		public function get wine() : String
		{
			return _anti["wine"];
		}
		public function set wine(value:String) : void
		{
			_anti["wine"] = value;
		}
		
		/**
		 * 色时间 
		 * @return 
		 * 
		 */		
		public function get lechery() : String
		{
			return _anti["lechery"];
		}
		public function set lechery(value:String) : void
		{
			_anti["lechery"] = value;
		}
		
		/**
		 * 财时间 
		 * @return 
		 * 
		 */		
		public function get money() : String
		{
			return _anti["money"];
		}
		public function set money(value:String) : void
		{
			_anti["money"] = value;
		}
		
		/**
		 * 气时间 
		 * @return 
		 * 
		 */		
		public function get breath() : String
		{
			return _anti["breath"];
		}
		public function set breath(value:String) : void
		{
			_anti["breath"] = value;
		}
		
		public function get pluginTime() : Array
		{
			return _anti["pluginTime"];
		}
		public function set pluginTime(value:Array) : void
		{
			_anti["pluginTime"] = value;
		}
		
		public function PluginGameInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["wine"] = "";
			_anti["lechery"] = "";
			_anti["money"] = "";
			_anti["breath"] = "";
			_anti["pluginTime"] = [];
		}
		
		public function init(data:XML) : void
		{
			wine = data.wine;
			lechery = data.lechery;
			money = data.money;
			breath = data.breath;
			pluginTime = assignTime(data.time);
		}
		
		private function assignTime(str:String) : Array
		{
			var result:Array = str.split("|");
			if(result.length < 4)
				result = [0, 0, 0, 0];
			
			if(Data.instance.time.checkEveryDayPlay(wine))
				result[0] = 0;
			if(Data.instance.time.checkEveryDayPlay(lechery))
				result[1] = 0;
			if(Data.instance.time.checkEveryDayPlay(money))
				result[2] = 0;
			if(Data.instance.time.checkEveryDayPlay(breath))
				result[3] = 0;
			
			return result;
		}
		
		public function getXML() : XML
		{
			var info:XML = <plugin_game></plugin_game>;
			info.appendChild(<wine>{wine}</wine>);
			info.appendChild(<lechery>{lechery}</lechery>);
			info.appendChild(<money>{money}</money>);
			info.appendChild(<breath>{breath}</breath>);
			info.appendChild(<time>{getTime()}</time>);
			
			return info;
		}
		
		private function getTime() : String
		{
			var result:String = "";
			for(var i:int = 0; i < pluginTime.length; i++)
			{
				if(i != 0) result += "|";
				result += pluginTime[i];
			}
			return result;
		}
		
		public function setTime(count:int) : void
		{
			var list:Array = pluginTime;
			list[count]++;
			pluginTime = list;
			Data.instance.player.player.dailyThingInfo.checkPlugin();
		}
		
		public function checkVIP() : Boolean
		{
			var result:Boolean = false;
			var len:int = pluginTime.length;
			for(var i:int = 0; i < len; i++)
			{
				if(pluginTime[i] != 2)
				{
					result = true;
					break;
				}
			}
			return result;
		}
		
		/**
		 * 检测酒色财气是不是都至少完成一次
		 * @return 
		 * 
		 */		
		public function checkIsComplete() : Array
		{
			var countNum:int = 0;
			var result:Boolean = true;
			//主角等级大于等于5
			if(Data.instance.player.player.mainRoleModel.model.lv >= 5)
			{
				for each(var count:int in pluginTime)
				{
					if(count == 0)
						result = false;
					else
						countNum++;
				}
			}
			else
			{
				var len:int = pluginTime.length - 1;
				for(var i:int = 0; i < len; i++)
				{
					if(pluginTime[i] == 0)
						result = false;
					else
						countNum++;
				}
			}
			
			return [result, countNum];
		}
	}
}
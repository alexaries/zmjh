package com.game.data.midAutumn
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;

	public class MidAutumnInfo
	{
		private var _anti:Antiwear;
		
		public function get moonCakeUse() : int
		{
			return _anti["moonCakeUse"];
		}
		public function set moonCakeUse(value:int) : void
		{
			_anti["moonCakeUse"] = value;
			checkCount();
		}
		
		public function get alreadyGet() : Array
		{
			return _anti["alreadyGet"];
		}
		public function set alreadyGet(value:Array) : void
		{
			_anti["alreadyGet"] = value;
		}
		public function MidAutumnInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["moonCakeUse"] = 0;
			_anti["alreadyGet"] = [0, 0, 0, 0, 0, 0]
		}
		
		public function init(data:XML) : void
		{
			moonCakeUse = data.moonCakeUse;
			alreadyGet = (String(data.alreadyGet) == ""?[0, 0, 0, 0, 0, 0]:String(data.alreadyGet).split("|"));
		}
		
		public function getXML() : XML
		{
			var info:XML = <midAutumn></midAutumn>;
			info.appendChild(<moonCakeUse>{moonCakeUse}</moonCakeUse>);
			info.appendChild(<alreadyGet>{getAlreadyGet()}</alreadyGet>);
			
			return info;
		}
		
		private function getAlreadyGet() : String
		{
			var result:String = "";
			for each(var item:String in alreadyGet)
			{
				if(result != "") result += "|";
				result += item;
			}
			return result;
		}
		
		public function setAlready(id:int) : void
		{
			var list:Array = alreadyGet;
			list[id] = 1;
			alreadyGet = list;
		}
		
		private function checkCount() : void
		{
			/*if(moonCakeUse >= 0)
				Data.instance.player.player.roleTitleInfo.addNewTitle("花好月圆");*/
		}
	}
} 
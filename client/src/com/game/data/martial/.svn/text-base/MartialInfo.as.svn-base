package com.game.data.martial
{
	import com.game.Data;

	public class MartialInfo
	{
		private var _martialRoles:Vector.<MartialDetail>;
		public function get martialRoles() : Vector.<MartialDetail>
		{
			return  _martialRoles;
		}
		
		public function set martialRoles(value:Vector.<MartialDetail>) : void
		{
			_martialRoles = value;
		}

		public function MartialInfo()
		{
			_martialRoles = new Vector.<MartialDetail>();
		}
		
		public function init(data:XML) : void
		{
			var info:MartialDetail;
			for each(var item:XML in data.item)
			{
				info = new MartialDetail();
				info.name = item.@name;
				info.startTime = item.@startTime;
				info.duration = int(item.@duration);
				
				_martialRoles.push(info);
			}
		}
		
		public function getXML() : XML
		{
			var item:XML;
			var info:XML = <martial></martial>;
			
			for (var i:int = 0; i < _martialRoles.length; i++)
			{
				item = <item name={_martialRoles[i].name} startTime={_martialRoles[i].startTime} duration={_martialRoles[i].duration}/>
				info.appendChild(item);
			}
			
			return info;
		}
		
		/**
		 * 添加需要练功的角色
		 * @param name
		 * @param startTime
		 * @param duration
		 * 
		 */		
		public function addMartial(name:String, startTime:String, duration:int) : void
		{
			if(isInMartial(name)) return;
			
			var info:MartialDetail = new MartialDetail();
			
			info.name = name;
			info.startTime = startTime;
			info.duration = duration;
			
			_martialRoles.push(info);
		}
		
		/**
		 * 删除已经练功完成的角色
		 * @param name
		 * 
		 */		
		public function removeMartial(name:String) : void
		{
			for(var i:int = 0; i < _martialRoles.length; i++)
			{
				if(_martialRoles[i].name == name)
				{
					_martialRoles.splice(i, 1);
					break;
				}
			}
		}
		
		public function isInMartial(name:String) : Boolean
		{
			var result:Boolean = false;
			for(var i:int = 0; i < _martialRoles.length; i++)
			{
				if(_martialRoles[i].name == name)
				{
					result = true;
				}
			}
			return result;
		}
		
		public function getMartialRole(name:String) : MartialDetail
		{
			var result:MartialDetail;
			for(var i:int = 0; i < _martialRoles.length; i++)
			{
				if(_martialRoles[i].name == name)
				{
					result = _martialRoles[i];
				}
			}
			return result;
		}
		
		public function checkIsComplete() : Boolean
		{
			var result:Boolean = false;
			var nowDate:Date = Data.instance.time.returnTimeNow();
			var startDate:Date;
			for each(var item:MartialDetail in _martialRoles)
			{
				startDate = setDate(Data.instance.time.analysisTime(item.startTime));
				if((nowDate.time - startDate.time) > item.duration * 60 * 60 * 1000)
				{
					result = true;
					break;
				}
			}
			
			return result;
		}
		
		private function setDate(lastTime:Array) : Date
		{
			var startDate:Date = new Date(lastTime[0], int(lastTime[1] - 1), lastTime[2], lastTime[3], lastTime[4], lastTime[5]);
			return startDate;
		}
	}
}
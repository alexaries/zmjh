package com.game.data.Activity
{
	import com.game.Data;
	import com.game.data.Base;
	import com.game.data.db.protocal.Gift_package;
	import com.game.data.player.structure.Player;
	import com.game.template.InterfaceTypes;

	public class ActivityInfo extends Base
	{
		public function get player() : Player
		{
			return _data.player.player;
		}
		
		private var _activities:Vector.<ActivityDetail>;
		public function get activities() : Vector.<ActivityDetail>
		{
			return  _activities;
		}
		
		public function set activities(value:Vector.<ActivityDetail>) : void
		{
			_activities = value;
		}
		
		public function ActivityInfo()
		{
			_activities = new Vector.<ActivityDetail>();
		}
		
		public function init(data:XML) : void
		{
			var info:ActivityDetail;
			for each(var item:XML in data.item)
			{
				info = new ActivityDetail();
				info.id = int(item.@id);
				info.activityName = item.@activityName;
				info.alreadyGet = item.@alreadyGet;
				info.time = item.@time;
				
				activities.push(info);
			}
		}
		
		public function getXML() : XML
		{
			var item:XML;
			var info:XML = <activity></activity>;

			for (var i:int = 0; i < _activities.length; i++)
			{
				if(_activities[i].id == 0) continue;
				item = <item id={_activities[i].id} activityName={_activities[i].activityName} alreadyGet={_activities[i].alreadyGet} time={_activities[i].time}/>
				info.appendChild(item);
			}
			
			return info;
		}
		
		public function addActivity(id:int) : void
		{
			var info:ActivityDetail = new ActivityDetail();
			var gift:Gift_package = Data.instance.db.interfaces(InterfaceTypes.GET_GIFT_BY_ID, id) as Gift_package;
			
			info.id = gift.id;
			info.activityName = gift.name;
			info.alreadyGet = "1";
			info.time = Data.instance.time.returnTimeNowStr();
			
			_activities.push(info);
		}
		
		public function addFestivalActivity(id:int, code:String) : void
		{
			var info:ActivityDetail = new ActivityDetail();
			info.id = id;
			info.activityName = code;
			info.alreadyGet = "1";
			info.time = Data.instance.time.returnTimeNowStr();
			_activities.push(info);
		}
		
		public function checkNationalActivity(id:int) : Boolean
		{
			for each(var item:ActivityDetail in _activities)
			{
				if(item.id == id)
				{
					return true;
					break;
				}
			}
			return false;
		}
		
		public function checkAutumnActivity(code:String) : Boolean
		{
			for each(var item:ActivityDetail in _activities)
			{
				if(item.activityName == code)
				{
					return true;
					break;
				}
			}
			return false;
		}
		
		public function setActivity(id:int) : void
		{
			
			for (var i:int = 0; i < _activities.length; i++)
			{
				if(_activities[i].id == id)
				{
					_activities[i].time = Data.instance.time.returnTimeNowStr();
					break;
				}
			}
			if(i == _activities.length)
			{
				var info:ActivityDetail = new ActivityDetail();
				var gift:Gift_package = Data.instance.db.interfaces(InterfaceTypes.GET_GIFT_BY_ID, id) as Gift_package;
				
				info.id = gift.id;
				info.activityName = gift.name;
				info.alreadyGet = "1";
				info.time = Data.instance.time.returnTimeNowStr();
				
				_activities.push(info);
			}
		}
	}
}
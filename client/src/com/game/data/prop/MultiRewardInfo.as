package com.game.data.prop
{
	import com.game.View;
	import com.game.data.Base;
	import com.game.data.player.structure.Player;
	import com.game.template.InterfaceTypes;

	public class MultiRewardInfo extends Base
	{
		public static const LUCKYRATE:Number = .1;
		public static const LUCKYEQUIPRATE:Number = .05;
		public function get player() : Player
		{
			return _data.player.player;
		}
		
		private var _multiRewards:Vector.<MultiRewardData>;
		public function get multiRewards() : Vector.<MultiRewardData>
		{
			return _multiRewards;
		}
		
		public function set multiRewards(value:Vector.<MultiRewardData>) : void
		{
			_multiRewards = value;
		}
		
		private var _infoTip:Vector.<String>;
		
		public function MultiRewardInfo()
		{
			_multiRewards = new Vector.<MultiRewardData>();
			_infoTip = new Vector.<String>();
		}
		
		public function init(data:XML) : void
		{
			var info:MultiRewardData;
			for each(var item:XML in data.item)
			{
				info = new MultiRewardData();
				info.lastTime = int(item.@lastTime);
				info.multiTimes = int(item.@multiTimes);
				info.multiType = int(item.@multiType);
				
				_multiRewards.push(info);
			}
		}
		
		public function getXML() : XML
		{
			var item:XML;
			var info:XML = <multiReward></multiReward>;
			
			for (var i:int = 0; i < _multiRewards.length; i++)
			{
				item = <item lastTime={_multiRewards[i].lastTime} multiTimes={_multiRewards[i].multiTimes} multiType={_multiRewards[i].multiType}/>
				info.appendChild(item);
			}
			
			return info;
		}
		
		public function addMultiReward(lastTime:int, multiTimes:int, type:int) : Boolean
		{
			var result:Boolean = false;
			for(var i:int = 0; i < _multiRewards.length; i++)
			{
				if(_multiRewards[i].multiTimes == multiTimes && _multiRewards[i].multiType == type)
				{
					View.instance.tip.interfaces(InterfaceTypes.Show,
						"已使用过该道具~！",
						null,
						null,
						false,
						false,
						true);
					result = true;
					break;
				}
			}
			
			if(!result)
			{
				var info:MultiRewardData = new MultiRewardData();
				info.lastTime = lastTime;
				info.multiTimes = multiTimes;
				info.multiType = type;
				_multiRewards.push(info);
			}
			
			return result;
		}
		
		/**
		 * 返回加倍的数值
		 * @param count
		 * @param type	1-经验，2-战魂，3-金币，3-人品，RP卡
		 * @return 
		 * 
		 */		
		public function getResult(count:int, type:int) : int
		{
			var resultCount:int = 0;
			var baseCount:int = count;
			for(var i:int = _multiRewards.length - 1; i >= 0 ; i--)
			{
				if(_multiRewards[i].multiType == type)
				{
					_multiRewards[i].lastTime--;
					resultCount = baseCount * (_multiRewards[i].multiTimes - 1);
					if(_multiRewards[i].lastTime <= 0)
					{
						addTip(type, _multiRewards[i].multiTimes);
						var item:MultiRewardData = _multiRewards[i];
						_multiRewards.splice(i, 1);
						item = null;
					}
				}
			}
			return resultCount;
		}
		
		/**
		 * 删除道具
		 * @param type
		 * 
		 */		
		public function removeMultiReward(type:int) : void
		{
			for(var i:int = 0; i < _multiRewards.length; i++)
			{
				if(_multiRewards[i].multiType == type)
				{
					var item:MultiRewardData = _multiRewards[i];
					_multiRewards.splice(i, 1);
					item = null;
					break;
				}
			}
		}
		
		public function checkOver(type:int) : Boolean
		{
			var result:Boolean = false;
			for(var i:int = 0; i < _multiRewards.length; i++)
			{
				if(_multiRewards[i].multiType == type)
				{
					result = true;
					break;
				}
			}
			return result;
		}
		
		/**
		 * 检测是否使用RP卡，并且添加人物获得概率
		 * @param inputRate
		 * @return 
		 * 
		 */		
		public function checkRPRoleRate(inputRate:Number) : Number
		{
			var rate:Number = inputRate;
			
			if(rate != 0)
			{
				var luckyRate:Number = (checkOver(4)==true?MultiRewardInfo.LUCKYRATE:0);
				rate += luckyRate;
				if(rate > 1)
					rate = 1;
			}
			return rate;
		}
		
		/**
		 * 检测是否使用RP卡，并且添加装备道具获得概率
		 * @param inputRate
		 * @return 
		 * 
		 */		
		public function checkRPEquipRate(inputRate:Number) : Number
		{
			var rate:Number = inputRate;
			
			if(rate != 0)
			{
				var luckyRate:Number = (checkOver(4)==true?MultiRewardInfo.LUCKYEQUIPRATE:0);
				rate += luckyRate;
				if(rate > 1)
					rate = 1;
			}
			return rate;
		}
		
		public function returnLastTime(type:int) : int
		{
			var result:int = 0;
			for(var i:int = 0; i < _multiRewards.length; i++)
			{
				if(_multiRewards[i].multiType == type)
				{
					result = _multiRewards[i].lastTime;
					break;
				}
			}
			return result;
		}
		
		private function addTip(count:int, multi:int) : void
		{
			switch(count)
			{
				case 1:
					_infoTip.push(multi + "倍经验 ");
					break;
				case 2:
					_infoTip.push(multi + "倍战魂 ");
					break;
				case 3:
					_infoTip.push(multi + "倍金币 ");
					break;
				case 4:
					_infoTip.push("人品卡 ");
			}
		}
		
		/**
		 * 效果结束提示
		 * 
		 */		
		public function showTip() : void
		{
			if(_infoTip.length == 0) 
			{
				_infoTip = new Vector.<String>();
				return;
			}
			else
			{
				var str:String = "您的";
				for each(var item:String in _infoTip)
				{
					str += item;
				}
				str += "效果已经消失了哦！";
				View.instance.prompEffect.play(str);
				_infoTip = new Vector.<String>();
			}
		}
	}
}
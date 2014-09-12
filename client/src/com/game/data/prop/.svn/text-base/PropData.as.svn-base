package com.game.data.prop
{
	import com.game.View;
	import com.game.data.Base;
	import com.game.data.db.protocal.Prop;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.PropModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	
	import starling.core.Starling;

	public class PropData extends Base
	{
		public function get player() : Player
		{
			return _data.player.player;
		}
		private var _view:View;
		
		public function PropData()
		{
			_view = View.instance;
		}
		
		
		public function getInfo(prop_id:String, prop_num:String) : String
		{
			var info:String = "";
			var idList:Array = prop_id.split("|");
			var numList:Array = prop_num.split("|");
			for(var i:int = 0; i < idList.length; i++)
			{
				//骰子
				if(int(idList[i]) == 0)
				{
					if(int(numList[i]) != 0)
						info += "骰子x" + numList[i];
				}
				else
				{
					var props:Prop = _data.db.interfaces(InterfaceTypes.GET_PROP_BY_ID, int(idList[i]));
					if(info != "") info+="，";
					info += props.name + "x" + numList[i];
				}
			}
			return info;
		}
		
		private var _callback:Function;
		private var _propID:Array;
		private var _propNum:Array;
		/**
		 * 检测获得道具后是否超过道具上限值
		 * @return 
		 * 
		 */		
		public function checkData(prop_id:String, prop_num:String, callback:Function) : void
		{
			_callback = callback;
			_propID = prop_id.split("|");
			_propNum = prop_num.split("|");
			var tipInfo:String = "";
			var result:Boolean = true;
			for(var i:int = 0; i < _propID.length; i++)
			{
				//骰子
				if(_propID[i] == 0)
				{
					if(player.dice + int(_propNum[i]) > V.DICE_MAX_NUM && int(_propNum[i]) != 0)
					{
						tipInfo = addTipInfo(tipInfo, "骰子");
						result = false;
					}
				}
				else
				{
					_data.pack.addNoneProp(int(_propID[i]), 0);
					var props:PropModel = _data.pack.searchProp(int(_propID[i]));
					//碎片
					if(props.id >= 14 && props.id <= 20)
					{
						if(props.num + int(_propNum[i]) > V.PROP_SPECIAL_MAX_NUM)
						{
							tipInfo = addTipInfo(tipInfo, props.config.name);
							result = false;
						}
					}
						//其他道具
					else
					{
						if(props.num + int(_propNum[i]) > V.PROP_MAX_NUM)
						{
							tipInfo = addTipInfo(tipInfo, props.config.name);
							result = false;
						}
					}
				}
			}
			
			if(!result)
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					tipInfo + "数量达到最大值，建议消耗之后再领取！是否继续领取？",
					comfireFun, null, false);
			}
			else
				comfireFun();
		}
		
		private function comfireFun() : void
		{
			var info:String = "";
			for(var i:int = 0; i < _propID.length; i++)
			{
				if(int(_propID[i]) == 0 && int(_propNum[i]) != 0)
				{
					info += " 骰子X" + _propNum[i];
					player.dice += int(_propNum[i]);
				}
				else if(int(_propID[i] != 0))
				{
					_data.pack.addNoneProp(int(_propID[i]), int(_propNum[i]));
					info += " " + (_data.db.interfaces(InterfaceTypes.GET_PROP_BY_ID, _propID[i]) as Prop).name + "X" + _propNum[i];
				}
			}
			Starling.juggler.delayCall(_callback, .01, info);
		}
		
		private function addTipInfo(tipInfo:String, newInfo:String) : String
		{
			if(tipInfo == "")
			{
				tipInfo = newInfo;
			}
			else 
			{
				tipInfo += ("、" + newInfo);
			}
			return tipInfo;
		}
	}
}
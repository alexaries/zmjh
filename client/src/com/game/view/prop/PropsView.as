package com.game.view.prop
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.DataList;
	import com.game.data.db.protocal.Gift_package;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.PropModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	
	import flash.display.BitmapData;
	
	import starling.core.Starling;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class PropsView extends BaseView implements IView
	{
		private static const PROPCOUNT:int = 100;
		private static const DOUBLE:int = 2;
		private static const NORMAL:int = 1;
		private var _prop:PropModel;
		public function PropsView()
		{
			_moduleName = V.PROPS;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.GetTexture:
					return getTexture(args[0], "");
					break;
			}
		}
		
		
		private var _callback:Function;
		/**
		 * 使用道具
		 * @param props
		 * 
		 */		
		public function useProps(props:PropModel, callback:Function) : void
		{
			_prop = props;
			_callback = callback;
			switch(props.config.type)
			{
				//使用道具
				case 1:
					useProp(props);
					break;
				//道具不能使用
				default:
					unUse();
					break;
			}
		}
		
		/**
		 * 使用道具
		 * 
		 */		
		private function useProp(prop:PropModel) : void
		{
			if(prop.id <= 31 || prop.id == 40 || prop.id == 42 || prop.id == 50 || prop.id == 51 || prop.id == 52 || prop.id == 55)
			{
				if(checkStart(prop))
				{
					addGift();
				}
			}
			else if(prop.id == 32)
			{
				setWeather(prop.id);
			}
			else if(prop.id == 33)
			{
				setMultiReward(prop);
			}
			else if(prop.id == 39)
			{
				setLucky(prop);
			}
			else if(prop.id == 43)
			{
				wearFashion(prop);
			}
			else if(prop.id == 54)
			{
				composeTitle(prop);
			}
		}
		
		private function composeTitle(prop:PropModel) : void
		{
			if(player.pack.getPropNumById(54) >= DataList.list[400] && !player.roleTitleInfo.checkTitle(V.ROLE_NAME[1]))
			{
				Data.instance.pack.changePropNum(prop.id, -DataList.list[400]);
				_view.prompEffect.play("恭喜您获得“普天同庆”称号！");
				player.roleTitleInfo.addNewTitle(V.ROLE_NAME[1]);
				player.mainRoleModel.beginCount();
				_view.role.interfaces(InterfaceTypes.REFRESH);
				_view.controller.save.onCommonSave(false, 1, false);
			}
			else if(player.roleTitleInfo.checkTitle(V.ROLE_NAME[1]))
			{
				_view.prompEffect.play("已经获得过“普天同庆”称号！");
			}
			else if(player.pack.getPropNumById(54) < DataList.list[400])
			{
				_view.prompEffect.play("碎片不足，无法合成“普天同庆”称号！");
			}
		}
		
		private function wearFashion(prop:PropModel) : void
		{
			if(_view.map.isClose)
			{
				if(player.mainRoleModel.nowUseFashion == "")
				{
					player.multiRewardInfo.addMultiReward(PROPCOUNT, NORMAL, 5);
					player.roleFashionInfo.wearFashion(V.MAIN_ROLE_NAME, "NewDress");
					_view.prompEffect.play("使用鹿鼎小宝！");
				}
				else
				{
					player.multiRewardInfo.removeMultiReward(5);
					player.roleFashionInfo.unWearFashion(V.MAIN_ROLE_NAME, "NewDress");
					_view.prompEffect.play("使用虎小宝！");
				}
				player.mainRoleModel.beginCount();
				_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
				_view.role.interfaces(InterfaceTypes.REFRESH);
			}
			else
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"在关卡中无法更换时装！",
					null, null, false, true, false);
			}
		}
		
		private function setLucky(prop:PropModel) : void
		{
			var result:Boolean = false;
			result = player.multiRewardInfo.addMultiReward(PROPCOUNT, NORMAL, 4);
			if(!result)
			{
				_view.prompEffect.play("成功添加人品卡效果！");
				setNormal(prop);
			}
		}
		
		private function setMultiReward(prop:PropModel) : void
		{
			var result:Boolean = false;
			result = player.multiRewardInfo.addMultiReward(PROPCOUNT, DOUBLE, 1);
			if(!result)
			{
				_view.prompEffect.play("成功添加双倍经验效果！");
				setNormal(prop);
			}
		}
		
		private function setNormal(prop:PropModel) : void
		{
			Data.instance.pack.changePropNum(prop.id, -1);
			_view.role.interfaces(InterfaceTypes.REFRESH);
			_view.toolbar.interfaces(InterfaceTypes.CHECK_EXP);
		}
		
		private function setWeather(count:int) : void
		{
			if(_view.map.curLevel == "1_1" || _view.map.curLevel == "1_2" || _view.map.curLevel == "1_3")
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"该关卡中不能使用天气控制器！",
					null, null, false, false, true);
				return;
			}
			if(!_view.map.isClose)
			{
				_view.weather_select.interfaces();
			}
			else
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"请在关卡中使用该道具！",
					null, null, false, false, true);
			}
		}
		
		/**
		 * 添加奖励
		 * 
		 */		
		private function addGift() : void
		{
			//道具
			for(var i:int = 0; i < _propIDList.length; i++)
			{
				var props:PropModel = Data.instance.pack.searchProp(_propIDList[i]);
				if(props == null)
				{
					player.dice += int(_propNumList[i]);
				}
				else
				{
					Data.instance.pack.addNoneProp(props.id, int(_propNumList[i]));
				}
			}
			//装备
			for(var j:int = 0; j < _equipIDList.length; j++)
			{
				var equip:EquipModel = new EquipModel();
				equip.id = _equipIDList[j];
				Data.instance.pack.initEquipment(equip);
				Data.instance.pack.addEquipment(equip);
			}
			if(_nowGift.gold != 0)  player.money += _nowGift.gold;
			if(_nowGift.soul != 0)  player.fight_soul += _nowGift.soul;
			
			Data.instance.pack.changePropNum(_prop.config.id, -1);
			showSuccess();
			Log.Trace("获得奖励保存");
			_view.controller.save.onCommonSave(false, 1, false);
			if(_callback != null) _callback();
		}
		
		private var _nowGift:Gift_package;
		private var _propIDList:Array;
		private var _propNumList:Array;
		private var _equipIDList:Array;
		/**
		 * 判断礼包奖励获得后是否超过道具的上线
		 * 
		 */		
		private function checkStart(prop:PropModel) : Boolean
		{
			var info:String = "";
			var result:Boolean = true;
			analysisData(prop);
			var resultList:Array = checkData(_propIDList, _propNumList);
			result = resultList[0];
			info = resultList[1];
			if(!result) showInfo(info);
			return result;
		}
		
		/**
		 * 分析数据
		 * 
		 */		
		private function analysisData(prop:PropModel) : void
		{
			_propIDList = new Array();
			_propNumList = new Array();
			_equipIDList = new Array();
			
			_nowGift = (Data.instance.db.interfaces(InterfaceTypes.GET_GIFT_BY_ID, prop.id) as Gift_package);
			if(_nowGift.prop_id != "")
			{
				//道具ID
				_propIDList = _nowGift.prop_id.split("|");
				//道具数量
				_propNumList = _nowGift.prop_number.split("|");
			}
			
			if(_nowGift.equipment_id != "0")
			{
				//装备ID
				_equipIDList = _nowGift.equipment_id.split("|");
			}
		}
		
		/**
		 * 检测获得道具后是否超过道具上限值
		 * @return 
		 * 
		 */		
		public function checkData(propID:Array, propNum:Array) : Array
		{
			var tipInfo:String = "";
			var result:Boolean = true;
			for(var i:int = 0; i < propID.length; i++)
			{
				//骰子
				if(propID[i] == 0)
				{
					if(player.dice + int(propNum[i]) > V.DICE_MAX_NUM)
					{
						tipInfo = addTipInfo(tipInfo, "骰子");
						result = false;
					}
				}
				else
				{
					Data.instance.pack.addNoneProp(propID[i], 0);
					var props:PropModel = Data.instance.pack.searchProp(propID[i]);
					//碎片
					if(props.id >= 14 && props.id <= 20)
					{
						if(props.num + int(propNum[i]) > V.PROP_SPECIAL_MAX_NUM)
						{
							tipInfo = addTipInfo(tipInfo, props.config.name);
							result = false;
						}
					}
					//其他道具
					else
					{
						if(props.num + int(propNum[i]) > V.PROP_MAX_NUM)
						{
							tipInfo = addTipInfo(tipInfo, props.config.name);
							result = false;
						}
					}
				}
			}
			//trace(tipInfo);
			return [result, tipInfo];
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
		
		/**
		 * 道具超过上限值的信息显示
		 * 
		 */		
		private function showInfo(info:String) : void
		{
			_view.tip.interfaces(InterfaceTypes.Show,
				info + "数量达到最大值，建议消耗之后再打开！是否继续打开？",
				function () : void
				{
					Starling.juggler.delayCall(addGift, .01);
				},
				null, false);
		}
		
		private function showSuccess() : void
		{
			var str:String = _prop.config.message.split("：")[1];
			_view.tip.interfaces(InterfaceTypes.Show,
				"获得：" + str,
				null, null, false, true, false);
		}
		
		/**
		 * 无法在包裹里使用的道具——提示
		 * 
		 */		
		private function unUse() : void
		{
			_view.tip.interfaces(InterfaceTypes.Show,
				"该道具无法在包裹中使用！",
				null, null, false, true, false);
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			return _view.icon.interfaces(InterfaceTypes.GetTexture, name);
		}
	}
}
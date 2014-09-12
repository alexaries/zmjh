package com.game.view.midAutumn
{
	import com.game.Data;
	import com.game.View;
	import com.game.data.db.protocal.Festivals;
	import com.game.data.player.structure.RoleInfo;
	import com.game.template.InterfaceTypes;
	import com.game.view.effect.DeformTip;
	import com.game.view.equip.PropTip;
	import com.game.view.ui.UIConfig;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.GrayscaleFilter;

	public class MidAutumnItem extends DisplayObject
	{
		public function MidAutumnItem()
		{
			
		}
		
		private var _img:Image;
		public function get img() : Image
		{
			return _img;
		}
		private var _data:Festivals;
		private var _onlyShow:Boolean;
		private var _propTip:PropTip;
		private var _giftInfo:String;
		private var _deformTip:DeformTip;
		public function setData(img:Image, data:Festivals) : void
		{
			_img = img;
			_data = data;
			_img.useHandCursor = true;
			_img.addEventListener(TouchEvent.TOUCH, onGetProp);
			_onlyShow = false;
			
			_giftInfo = Data.instance.prop_data.getInfo(_data.prop_id, _data.prop_number);
			_giftInfo = getInfo(_giftInfo);
			_propTip = View.instance.ui.interfaces(UIConfig.PROP_TIP);
			_propTip.add({o:_img,m:{name:"", 
				message:"获得奖励：" + _giftInfo}}); 
			
			_deformTip = View.instance.ui.interfaces(UIConfig.DEFORM_TIP);
		}
		
		private function getInfo(info:String) : String
		{
			if(int(_data.gold) != 0)
			{
				if(info != "") info += "，";
				info += "金币x" + _data.gold;
			}
			if(int(_data.soul) != 0)
			{
				if(info != "") info += "，";
				info += "战魂x" + _data.soul;
			}
			if(_data.title != "0")
			{
				if(info != "") info += "，";
				info += "称号“" + _data.title + "”";
			}
			if(_data.characters != "0")
			{
				if(info != "") info += "，";
				info += "角色“" + _data.characters + "”";
			}
			return info;
		}
		
		public function setTouchable() : void
		{
			_onlyShow = false;
			_img.filter = null;
			_deformTip.addNewDeform(_img, "Gift_" + _data.id);
		}
		
		public function setUnTouchable() : void
		{
			_onlyShow = true;
			_img.filter = new GrayscaleFilter();
			_deformTip.removeDeform("Gift_" + _data.id);
		}
		
		private function onGetProp(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_img);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED && !_onlyShow)
			{
				Data.instance.prop_data.checkData(_data.prop_id, _data.prop_number, getReward);
			}
		}
		
		private function getReward(info:String) : void
		{
			if(int(_data.gold) != 0)
			{
				Data.instance.player.player.money += int(_data.gold);
			}
			if(int(_data.soul) != 0)
			{
				Data.instance.player.player.fight_soul += int(_data.soul);
			}
			if(_data.title != "0")
			{
				Data.instance.player.player.roleTitleInfo.addNewTitle(_data.title);
			}
			if(_data.characters != "0")
			{
				var roleInfo:RoleInfo = new RoleInfo();
				roleInfo.roleName = _data.characters;
				roleInfo.lv = 1;
				Data.instance.player.player.addRole(roleInfo);
				View.instance.toolbar.addRoleDeform();
			}
			View.instance.tip.interfaces(InterfaceTypes.Show,
				"恭喜你获得" + _giftInfo,
				null, null, false, true, false);
			
			Data.instance.player.player.midAutumnInfo.setAlready(_data.id - 1);
			View.instance.mid_autumn.interfaces(InterfaceTypes.REFRESH);
			View.instance.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
	}
}
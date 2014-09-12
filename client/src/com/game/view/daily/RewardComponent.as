package com.game.view.daily
{
	import com.game.Data;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.db.protocal.Mission;
	import com.game.data.db.protocal.Prop;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class RewardComponent extends Component
	{
		private static const DICE:Vector.<String> = Vector.<String>(["获得", "个骰子"]);
		private static const EQUIPMENT:Vector.<String> = Vector.<String>(["获得1件", "级", "装"]);
		private static const PROP:Vector.<String> = Vector.<String>(["获得", "个"]);
		private static const GOLD:Vector.<String> = Vector.<String>(["获得", "金币"]);
		private static const SOUL:Vector.<String> = Vector.<String>(["获得", "战魂"]);
		private static const INFO:Vector.<Vector.<String>> = Vector.<Vector.<String>>([DICE, EQUIPMENT, PROP, GOLD, SOUL]);
		public static const PROPINFO:Vector.<String> = Vector.<String>(["如意骰子", "满汉全席", "雪山人参"]);
		private static const OFFSETX:int = 9;
		private static const OFFSETY:int = 10;
		private var _rewardDetail:TextField;
		private var _rewardData:Object;
		public function get rewardData() : Object
		{
			return _rewardData;
		}
		public function set rewardData(value:Object) : void
		{
			_rewardData = value;
		}
		private var _image:Image;
		public function get rewardImage() : Image
		{
			return _image;
		}
		
		public function set rewardImage(value:Image) : void
		{
			_image = value;
		}
		
		public function RewardComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
		}
		
		private function getUI() : void
		{
			_rewardDetail = this.searchOf("RewardDetail");
			
			var texture:Texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "equip_1");
			_image = new Image(texture);
			
			this.panel.addChild(_image);
			_image.visible = false;
		}
		
		/**
		 * 显示奖励
		 * @param data
		 * @param equipmentID
		 * @param count
		 * 
		 */		
		public function showing(data:* = null, equipmentID:int = 0, count:int = 0) : void
		{
			if(data == null)
			{
				_rewardDetail.text = "";
				_image.visible = false;
				return;
			}
			
			_rewardData = data as Object;
			var _count:int = count;
			var _reward:Array = [_rewardData.dice, _rewardData.equipment, _rewardData.prop, _rewardData.gold, _rewardData.soul];
			var _lastReward:Array = [];
			
			for(var i:uint = 0; i < _reward.length; i++)
			{
				if(_reward[i] != 0)
				{
					_lastReward.push(i);
					_lastReward.push(_reward[i]);
				}
			}
			
			if(count == 4 && _lastReward.length != 8)
			{
				_rewardDetail.text = "";
				_image.visible = false;
				return;
			}
			_image.data = new Object();
			var textureInfo:String = "";
			var info:Vector.<String> = INFO[_lastReward[(_count - 1) * 2]];
			var reward:Array = _lastReward[(_count - 1) * 2 + 1].toString().split("|");
			var texture:Texture;
			
			var expData:Vector.<Object> = Data.instance.db.interfaces(InterfaceTypes.GET_LEVEL_UP_EXP);
			var mainRole:RoleModel = player.getRoleModel(V.MAIN_ROLE_NAME);
			var roleLv:int = mainRole.model.lv;
			
			switch(_lastReward[(_count - 1) * 2])
			{
				case 0:
					//骰子
					_rewardDetail.text = info[0] + reward[0].toString() + info[1];
					textureInfo = "DiceTwo_1";
					texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, textureInfo);
					_image.name = "dice";
					break;
				case 1:
					//装备
					_rewardDetail.text = info[0] + reward[0].toString() + info[1] + reward[1].toString() + info[2];
					textureInfo = "equip_" + equipmentID;
					texture = _view.icon.interfaces(InterfaceTypes.GetTexture, textureInfo);
					_image.name = "equip";
					Data.instance.db.interfaces(
						InterfaceTypes.GET_EQUIP_DATA_BY_ID,
						equipmentID,
						function (config:Equipment) : void
						{	
							_image.data[0] = config.name;
						});
					break;
				case 2:
					//道具
					_rewardDetail.text = info[0] + reward[1].toString() + info[1];
					textureInfo = "props_" + reward[0];
					texture = _view.icon.interfaces(InterfaceTypes.GetTexture, textureInfo);
					_image.name = "prop";
					Data.instance.db.interfaces(
						InterfaceTypes.GET_PROP_BASE_DATA, 
						reward[0], 
						function (prop:Prop) : void
						{
							_rewardDetail.text += prop.name;
							_image.data[0] = prop.name;
						});
					break;
				case 3:
					//金币
					_rewardDetail.text = info[0] + info[1];
					textureInfo = "Toolbar_Money";
					texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, textureInfo);
					_view.task.rewardMoney = reward[0] * expData[roleLv - 1].gold;
					_image.name = "money";
					break;
				case 4:	
					//战魂
					_rewardDetail.text = info[0] + info[1];
					textureInfo = "Toolbar_WarValue";
					texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, textureInfo);
					_view.task.rewardSoul = reward[0] * expData[roleLv - 1].gold;
					_image.name = "war";
					break;
			}
			
			//纹理
			_image.texture = texture;
			_image.visible = true;
			_image.x = OFFSETX;
			_image.y = OFFSETY;
			_image.readjustSize();
			resetImage(_image);
			if(textureInfo == "Toolbar_WarValue") 
			{
				_image.x = OFFSETX + 8;
				_image.y = OFFSETY - 3;
			}
			if(textureInfo == "Toolbar_Money")
			{
				_image.y = OFFSETY + 5;
			}
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new RewardComponent(_configXML, _titleTxAtlas);
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			super.destroy();
		}
	}
}
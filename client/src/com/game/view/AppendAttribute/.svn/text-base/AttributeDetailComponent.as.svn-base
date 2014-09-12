package com.game.view.AppendAttribute
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.data.db.protocal.Fight_soul;
	import com.game.data.player.structure.FightAttachInfo;
	import com.game.data.player.structure.Player;
	import com.game.template.InterfaceTypes;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	import com.game.view.ui.UIConfig;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class AttributeDetailComponent extends Component
	{
		private var _anti:Antiwear;
		private var _data:Object;
		private var _curType:String;
		private var _position:String;
		//private var _lv:int;
		private function set lv(value:uint) : void
		{
			_anti["lv"] = value;
		}
		private function get lv() : uint
		{
			return _anti["lv"];
		}
		
		// 战附配置数据
		private var _fightAttackInfo:Fight_soul;
		private var _curTypeFightAppend:int;
		
		//private var _needRoleLV:int;
		private function set needRoleLV(value:uint) : void
		{
			_anti["needRoleLV"] = value;
		}
		private function get needRoleLV() : uint
		{
			return _anti["needRoleLV"];
		}
		private function set needFightSoul(value:uint) : void
		{
			_anti["needFightSoul"] = value;
		}
		private function get needFightSoul() : uint
		{
			return _anti["needFightSoul"];
		}
		private var _curFight:FightAttachInfo;
		
		public function AttributeDetailComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			_anti = new Antiwear(new binaryEncrypt());
			_anti["needFightSoul"] = 0;
			_anti["needRoleLV"] = 0;
			_anti["lv"] = 0;
			
			super(item, titleTxAtlas);
			
			getUI();
			initEvent();
		}
		
		
		// 类型
		private var _attribute:TextField;
		// 等级
		private var _lvTF:TextField;
		// 图标
		private var _image:Image;
		// 升级
		private var _upgrade:Button;
		// 不能升级
		private var _unUp:Image;
		// tip
		private var _appAttributeTip:AppendAttributeTip;
		// 点击层
		private var _touchLayer:Image;
		private function getUI() : void
		{
			_attribute = this.searchOf("Tx_Attribute");
			_lvTF = this.searchOf("Tx_Level");
			_upgrade = this.searchOf("LevelUpBt");
			_unUp = this.searchOf("UnableUp");
			_appAttributeTip = _view.ui.interfaces(UIConfig.GET_APD_ATTRIBUTE_TIP);
			
			_image = this.searchOf("AttributeType");			
			
			_touchLayer = this.searchOf("TouchRect");
			_touchLayer.alpha = 0;
			_touchLayer.addEventListener(TouchEvent.TOUCH, onTouchEvent);
		}
		
		private function onTouchEvent(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_touchLayer);
			
			if (touch&&touch.phase == TouchPhase.HOVER) 
			{
				
				_appAttributeTip.x=touch.globalX+10;
				_appAttributeTip.y=touch.globalY+10;
				Starling.current.stage.addChild(_appAttributeTip);
				_appAttributeTip.setData(_data)
			}else
			{
				if (_appAttributeTip) _appAttributeTip.hide();
			}
		}
		
		/**
		 * 设置当前数值 
		 * @param data
		 * @param lv
		 * 
		 */		
		public function setData(type:String, lv:int, position:String, fightAttack:Fight_soul, curFight:FightAttachInfo) : void
		{
			_curType = type;
			_position = position;
			_fightAttackInfo = fightAttack;
			lv = lv;
			_curFight = curFight;
			
			// 需要角色等级
			needRoleLV = (lv + 1) * 2;
			// 需要将魂数量
			needFightSoul = _fightAttackInfo.basic_soul + _fightAttackInfo.soul_add * lv;
			
			var textureName:String;
			var value:int;
			switch (_curType)
			{
				case "hp":
					_attribute.text = "体力";
					textureName = "HP";
					value = _fightAttackInfo.hp;
					break;
				case "mp":
					_attribute.text = "元气";
					textureName = "MP";
					value = _fightAttackInfo.mp;
					break;
				case "atk":
					_attribute.text = "外功";
					textureName = "ATK";
					value = _fightAttackInfo.atk;
					break;
				case "def":
					_attribute.text = "根骨";
					textureName = "DEF";
					value = _fightAttackInfo.def;
					break;
				case "evasion":
					_attribute.text = "灵活";
					textureName = "Evasion";
					value = _fightAttackInfo.evasion;
					break;
				case "crit":
					_attribute.text = "暴击";
					textureName = "CRIT";
					value = _fightAttackInfo.crit;
					break;
			}
			
			var texture:Texture = this._titleTxAtlas.getTexture(textureName);
			_image.texture = texture;
			
			_lvTF.text = "等级  " + lv.toString();
			
			_data = {};
			var attributeName:String = _attribute.text;
			_data["name"] = attributeName + " (" + lv + "级)";
			_data["content"] = "每级增加" + attributeName + "值 " + value;
			_data["role"] = "韦小宝 " + needRoleLV + "级";
			_data["fightSoul"] = needFightSoul.toString();
			
			// 等级不足
			if (player.mainRoleModel.model.lv < needRoleLV)
			{
				_unUp.visible = true;
				_unUp.texture = this._titleTxAtlas.getTexture("LevelLack");
				_upgrade.visible = false;
			}
				// 将魂不足
			else if (player.fight_soul < needFightSoul)
			{
				_unUp.visible = true;
				_unUp.texture = this._titleTxAtlas.getTexture("FightSoulLack");
				_upgrade.visible = false;
			}
			else
			{
				_unUp.visible = false;
				_upgrade.visible = true;
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "LevelUpBt":
					onLVUp();
					break;
			}
		}
		
		/**
		 * 升级 
		 * 
		 */		
		private function onLVUp() : void
		{
			if (player.mainRoleModel.model.lv >= needRoleLV || player.fight_soul >= needFightSoul)
			{
				// 扣除战魂
				player.fight_soul -= needFightSoul;
				// 升级等级
				_curFight[_curType] += 1;
				
				// 重新计算当前位置上的角色
				if (_view.append_attribute.curRoleModel)
				{
					_view.append_attribute.curRoleModel.countFightAttack();
					if (_view.role.isShowed) _view.role.interfaces(InterfaceTypes.REFRESH);
				}
				
				_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
				_view.append_attribute.interfaces(InterfaceTypes.REFRESH);
				_view.prompEffect.play("升级成功!");
			}
			else
			{
				throw new Error("错误,等级不够或者没有足够的将魂");
			}
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new AttributeDetailComponent(_configXML, _titleTxAtlas);
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
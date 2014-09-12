package com.game.view.upgrade
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.data.db.protocal.Prop;
	import com.game.data.db.protocal.Skill;
	import com.game.data.db.protocal.Skill_up;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.Role.PropItemRender;
	import com.game.view.effect.TextColorEffect;
	import com.game.view.equip.PropTip;
	import com.game.view.skill.SkillTip;
	import com.game.view.ui.UIConfig;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class UpgradeSkillComponent extends Component
	{
		private var _anti:Antiwear;
		public function get usePropNum() : int
		{
			return _anti["usePropNum"];
		}
		public function set usePropNum(value:int) : void
		{
			_anti["usePropNum"] = value;
		}
		
		public function get useMoney() : int
		{
			return _anti["useMoney"];
		}
		public function set useMoney(value:int) : void
		{
			_anti["useMoney"] = value;
		}
		
		public function UpgradeSkillComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			_anti = new Antiwear(new binaryEncrypt());
			_anti["usePropNum"] = 0;
			_anti["useMoney"] = 0;
			
			super(item, titleTxAtlas);
			init();
		}
		
		override protected function init() : void
		{
			super.init();
			getUI();
			initEvent();
		}
		
		private var _skillTip:SkillTip;
		private var _skillNameTF:TextField;
		private var _upgradeLevelTF:TextField;
		private var _hurtTF:TextField;
		private var _moneyTF:TextField;
		private var _propTF_1:TextField;
		private var _propTF_2:TextField;
		private var _huo:TextField;
		private var _propBg:Image;
		private var _moneyEffect:TextColorEffect;
		private var _propEffect_1:TextColorEffect;
		private var _propEffect_2:TextColorEffect;
		private var _propTip:PropTip;
		private var _propNeedTF:TextField;
		private var _hurtTitleTF:TextField;
		private function getUI() : void
		{
			if (!_skillTip)
				_skillTip = _view.ui.interfaces(UIConfig.GET_SKILL_TIP);
			_skillNameTF = this.searchOf("SkillNameDetail");
			_upgradeLevelTF = this.searchOf("UpgradeLevelDetail");
			_hurtTF = this.searchOf("HurtDetail");
			_moneyTF = this.searchOf("MoneyDetail");
			_propTF_1 = this.searchOf("PropDetail_1");
			_propTF_2 = this.searchOf("PropDetail_2");
			_huo = this.searchOf("Huo");
			_propBg = this.searchOf("PropIcon_2");
			_propNeedTF = this.searchOf("NeedTitle");
			_propImage_1 = this.searchOf("PropImg_1");
			_propImage_2 = this.searchOf("PropImg_2");
			_hurtTitleTF = this.searchOf("HurtTitle");
			
			resetTF();
			
			_moneyEffect = new TextColorEffect(_moneyTF, 0xFFFF00, 0xFF0000, 0xFF0000, .6);
			_propEffect_1 = new TextColorEffect(_propTF_1, 0xFFFF00, 0xFF0000, 0xFF0000, .6);
			_propEffect_2 = new TextColorEffect(_propTF_2, 0xFFFF00, 0xFF0000, 0xFF0000, .6);
			
			_propTip = _view.ui.interfaces(UIConfig.PROP_TIP);
			
			_propTip_1 = new PropItemRender();
			panel.addChild(_propTip_1);
			_propTip_2 = new PropItemRender();
			panel.addChild(_propTip_2);
		}
		
		private function resetTF() : void
		{
			_skillNameTF.text = "";
			_upgradeLevelTF.text = "";
			_hurtTF.text = "";
			_moneyTF.text = "";
			_propTF_1.text = "";
			_propTF_2.text = "";
			_huo.visible = false;
			_propBg.visible = false;
			if(_skillImage != null &&_skillImage.parent) 	panel.removeChild(_skillImage);
			if(_propImage_1 != null &&_propImage_1.parent) 	panel.removeChild(_propImage_1);
			if(_propImage_2 != null &&_propImage_2.parent) 	panel.removeChild(_propImage_2);
		}
		
		private var _skillImage:Image;
		private var _skillData:Skill;
		private var _propImage_1:Image;
		private var _propImage_2:Image;
		private var _skillType:Vector.<int>;
		private var _skillConsume:Skill_up;
		public function setData(skill:Skill) : void
		{
			_skillData = skill;
			if(_skillData == null)
			{
				checkShow(_configXML.layer[0]);
				resetTF();
				return;
			}
			renderData();
			setSkillImage();
			setPropImage();
			renderSkillType();
			renderText();
			renderRequest();
		}
		
		private function renderData() : void
		{
			
			_nowLevel = player.upgradeSkill.returnSkillLevel(_skillData);
			_skillType = getSkillAttribute();
		}
		
		/**
		 * 判定是否回血技能
		 * 
		 */		
		private function renderSkillType():void
		{
			var targetXML:XML;
			if(_skillData.hp_up == 0 || _skillData == null)
			{
				if(_nowLevel < V.MAX_COMMON_SKILL_LEVEL)
					targetXML = _configXML.layer[0];
				else
					targetXML = _configXML.layer[2];
			}
			else
			{
				if(_nowLevel < V.MAX_CURE_SKILL_LEVEL)
					targetXML = _configXML.layer[0];
				else
					targetXML = _configXML.layer[2];
			}
			checkShow(targetXML);
		}
		
		/**
		 * 根据是否是回血技能显示界面
		 * @param name
		 * 
		 */		
		private function checkShow(targetXML:XML) : void
		{
			for each(var item:* in _uiLibrary)
			{
				if (item is DisplayObject) item.visible = false;
				if (item is Component) item["panel"].visible = false;
			}
			seStatusOfXML(targetXML, true);
		}
		
		/**
		 * 技能消耗是否达到要求
		 * 
		 */		
		private function renderRequest():void
		{
			//金币
			if(player.money < useMoney)
				_moneyEffect.play();
			else
				_moneyEffect.stop();
			
			//道具
			if(player.pack.getPropNumById(_skillType[0] + 43) < usePropNum)
				_propEffect_1.play();
			else
				_propEffect_1.stop();
			
			if(_skillType.length == 2)
			{
				if(player.pack.getPropNumById(_skillType[1] + 43) < usePropNum)
					_propEffect_2.play();
				else
					_propEffect_2.stop();
			}
		}		
		
		private var _propTip_1:PropItemRender;
		private var _propTip_2:PropItemRender;
		/**
		 * 技能消耗道具设置
		 * 
		 */		
		private function setPropImage():void
		{
			var texture:Texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "props_" + (_skillType[0] + 43));
			_propImage_1.texture = texture;
			_propImage_1.readjustSize();
			_propImage_1.width = 25;
			_propImage_1.height = 25;
			if(!_propImage_1.parent) 	panel.addChild(_propImage_1);
			_propTip_1.setData(int(_skillType[0] + 43), _propImage_1);
			
			if(_skillType.length == 2)
			{
				var textures:Texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "props_" + (_skillType[1] + 43));
				_propImage_2.texture = textures;
				_propImage_2.readjustSize();
				_propImage_2.width = 25;
				_propImage_2.height = 25;
				if(!_propImage_2.parent) 	panel.addChild(_propImage_2);
				_propTip_2.setData(int(_skillType[1] + 43), _propImage_2);
			}
			else
				if(_propImage_2 != null && _propImage_2.parent) panel.removeChild(_propImage_2);
		}
		
		private var _nowLevel:int;
		/**
		 * 文本框内容设置
		 * 
		 */		
		private function renderText() : void
		{
			//已经达到最大等级
			if(_skillData.hp_up == 0 && _nowLevel >= V.MAX_COMMON_SKILL_LEVEL)
			{
				_skillNameTF.text = _skillData.skill_name;
				_upgradeLevelTF.text = _nowLevel.toString();
				_hurtTF.text = (_skillData.damage_ratio * 100 + _nowLevel) + "%";
				_moneyTF.text = "";
				_propTF_1.text = "";
				_propTF_2.text = "";
			}
			else if(_skillData.hp_up != 0 && _nowLevel >= V.MAX_CURE_SKILL_LEVEL)
			{
				_skillNameTF.text = _skillData.skill_name;
				_upgradeLevelTF.text = _nowLevel.toString();
				_hurtTF.text = (_skillData.hp_up * 100 + _nowLevel) + "%";
				_moneyTF.text = "";
				_propTF_1.text = "";
				_propTF_2.text = "";
			}
			else
			{
				_skillConsume = _view.upgrade.skillUpData[_nowLevel] as Skill_up;
				useMoney = _skillConsume.gold;
				
				
				_skillNameTF.text = _skillData.skill_name;
				_upgradeLevelTF.text = _nowLevel + " ->" + (_nowLevel + 1);
				if(_skillData.hp_up == 0)
				{
					if(_skillType.length == 2)
						usePropNum = int(_skillConsume.number * .5);
					else
						usePropNum = _skillConsume.number;
					_hurtTF.text = int(_skillData.damage_ratio * 100 + _nowLevel) + "% -> " + int(_skillData.damage_ratio * 100 + _nowLevel + 1) + "%";
				}
				else
				{
					usePropNum = _skillConsume.number;
					_hurtTF.text = int(_skillData.hp_up * 100 + _nowLevel) + "% -> " + int(_skillData.hp_up * 100 + _nowLevel + 1) + "%";
				}
				_moneyTF.text = "X " + useMoney.toString();
				_propTF_1.text = "X " + usePropNum.toString();
				setPropType();
			}
			
			if(_skillData.hp_up == 0)
				_hurtTitleTF.text = "伤害：";
			else
				_hurtTitleTF.text = "治疗：";
		}
		
		/**
		 * 多属性技能
		 * 
		 */		
		private function setPropType() : void
		{
			if(_skillType.length < 2)
			{
				_propTF_2.visible = false;
				_huo.visible = false;
				_propBg.visible = false;
			}
			else
			{
				_propTF_2.visible = true;
				_propTF_2.text = "X " + usePropNum.toString();
				_huo.visible = true;
				_propBg.visible = true;
			}
		}
		
		/**
		 * 设置技能图片
		 * 
		 */		
		private function setSkillImage() : void
		{
			var texture:Texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "skill_" + _skillData.id);
			if(!_skillImage)
			{
				_skillImage = new Image(texture);
				_skillImage.x = 411;
				_skillImage.y = 141;
				_skillImage.addEventListener(TouchEvent.TOUCH, showInfo);
			}
			_skillImage.texture = texture;
			if(!_skillImage.parent) 	panel.addChild(_skillImage);
			_skillTip.setOtherData(_skillData);
		}
		
		/**
		 * 判断是否达到技能要求
		 * @return 
		 * 
		 */		
		public function checkConsume(callback:Function = null) : Boolean
		{
			var result:Boolean = true;
			var propUnEnough:Boolean = true;
			var info:String = "";
			if(player.money < useMoney)
			{
				info += "金币不足！";
				result = false;
			}
			
			var prop_1:Prop = (Data.instance.db.interfaces(InterfaceTypes.GET_PROP_BY_ID, _skillType[0] + 43) as Prop);
			if(player.pack.getPropNumById(_skillType[0] + 43) < usePropNum)
			{
				info += prop_1.name + "不足！";
				result = false;
				propUnEnough = false;
			}
			if(_skillType.length == 2)
			{
				var prop_2:Prop = (Data.instance.db.interfaces(InterfaceTypes.GET_PROP_BY_ID, _skillType[1] + 43) as Prop);
				if(player.pack.getPropNumById(_skillType[1] + 43) < usePropNum)
				{
					info += prop_2.name + "不足！";
					result = false;
					propUnEnough = false;
				}
			}
			
			if(info != "")
			{
				if(!propUnEnough)
					_view.buy.interfaces(InterfaceTypes.Show, info, null, function () : void{ _view.upgrade.hide(); _view.shop.interfaces();});
				else
					_view.tip.interfaces(InterfaceTypes.Show, info, null, null, false, true, false);
			}
			
			if(result)
			{
				var resultInfo:String = "是否消耗";
				resultInfo += usePropNum + "个" + prop_1.name;
				
				if(_skillType.length == 2)
					resultInfo += "和" + usePropNum + "个" + prop_2.name; 
				
				resultInfo += "升级技能？";
				
				_view.tip.interfaces(InterfaceTypes.Show, resultInfo, callback, null, false);
			}
			
			return result;
		}
		
		public function startUpgrade() : void
		{
			player.money -= useMoney;
			
			Data.instance.pack.changePropNum(_skillType[0] + 43, -usePropNum);
			if(_skillType.length == 2)
				Data.instance.pack.changePropNum(_skillType[1] + 43, -usePropNum);
		}
		
		private function showInfo(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_skillImage);
			var skillTouch:Touch = e.getTouch(_skillTip);
			if (!touch)
			{
				if (_skillTip && !skillTouch) _skillTip.hide();
				return;
			}
			switch (touch.phase)
			{
				case TouchPhase.ENDED:
					if(touch.tapCount == 2)
						onClick();
					if (_skillTip) _skillTip.hide();
					break;
				case TouchPhase.HOVER:
					
					if (!_skillTip.data || _skillTip.data.skill.id != _skillData.id) _skillTip.setOtherData(_skillData);
					this.panel.addChild(_skillTip);
					_skillTip.x = touch.globalX - 70;
					_skillTip.y = touch.globalY - 30;
					break;
			}
		}
		
		private function onClick() : void
		{
			resetTF();
			_view.upgrade.setUpgradeSkill();
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else
			{
				textures = _titleTxAtlas.getTextures(name);
			}
			return textures;
		}
		
		private function getSkillAttribute() : Vector.<int>
		{
			var result:Vector.<int> = new Vector.<int>();
			if (!_skillData.water && !_skillData.fire && !_skillData.chaos && !_skillData.poison)
				result.push(1);
			if(_skillData.fire == 1)
				result.push(2);
			if(_skillData.water == 1)
				result.push(3);
			if(_skillData.poison == 1)
				result.push(4);
			if(_skillData.chaos == 1)
				result.push(5);
			if(_skillData.hp_up != 0)
				result.push(10);
			
			return result;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			if (type == "public")
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			return texture;
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new UpgradeSkillComponent(_configXML, _titleTxAtlas);
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
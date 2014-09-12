package com.game.view.equip
{
	import com.engine.ui.controls.TipTextField;
	import com.engine.ui.core.BaseSprite;
	import com.engine.ui.core.Scale9Image;
	import com.engine.ui.core.Scale9Textures;
	import com.game.Data;
	import com.game.View;
	import com.game.data.db.protocal.Equipment_strengthen;
	import com.game.data.equip.EquipConfig;
	import com.game.data.player.structure.EquipModel;
	import com.game.manager.FontManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class EquipTip extends BaseSprite
	{
		private var _bg:Scale9Image;
		private var _line:Image;
		private var _money:Image;
		private static const LEFT_GAP:Number=11;
		private static const TEXT_VGAP:Number=-1;
		private static const CHANGE_VGAP:Number = -4;
		private static const INTERVAL:Number = 15;
		private var _view:View = View.instance;
		
		private var _data:EquipModel;
		public function get data() : EquipModel
		{
			return _data;
		}
		
		public function EquipTip()
		{
		}
		
		private var _bgTexture:Texture;
		private var _moneyTexture:Texture;
		private var _lineTexture:Texture;
		public function init(bgTexture:Texture, moneyTx:Texture, line:Texture) : void
		{
			_bgTexture = bgTexture;
			_moneyTexture = moneyTx;
			_lineTexture = line;
			
			initUi();
			initEvent();
		}
		
		
		
		private var _equipNameTF:TipTextField;
		private var _equipLV:TipTextField;
		private var _equipGrade:TipTextField;
		private var _equipType:TipTextField;
		
		private var _baseAttribute:TipTextField;
		private var _baseAttribute2:TipTextField;
		private var _strengthenAttribute:TipTextField
		private var _addAttributeTitle:TipTextField;
		private var _addAttribute:TipTextField;
		private var _belongAttribute:TipTextField;
		private var _valueMoney:TipTextField;
		private var _lineImag:Image;
		private var _composeAttribute:TipTextField;
		private var _baseComposeAttribute:TipTextField;
		
		private var _composeTotalTitle:TipTextField;
		private var _composeTotalValue:TipTextField;
		
		private var _hpTitle:TipTextField;
		private var _mpTitle:TipTextField;
		private var _atkTitle:TipTextField;
		private var _defTitle:TipTextField;
		private var _spdTitle:TipTextField;
		private var _critTitle:TipTextField;
		private var _evasionTitle:TipTextField;
		
		private var _hpAttribute:TipTextField;
		private var _mpAttribute:TipTextField;
		private var _atkAttribute:TipTextField;
		private var _defAttribute:TipTextField;
		private var _spdAttribute:TipTextField;
		private var _critAttribute:TipTextField;
		private var _evasionAttribute:TipTextField;
		/*private var _littleLineImag:Image;*/
		private function initUi() : void
		{
			// 底图
			var textures:Scale9Textures = new Scale9Textures(_bgTexture, new Rectangle(20, 20, 50, 50));
			_bg = new Scale9Image(textures);
			_bg.alpha = 1;
			_bg.width = 187;
			this.addChild(_bg);
			
			//装备名称
			_equipNameTF = createTextField();
			_equipNameTF.x = LEFT_GAP
			_equipNameTF.y = 10;
			_equipNameTF.color = 0x66CC33;
			this.addChild(_equipNameTF);
			
			// 强化
			_equipLV = createTextField(60);
			_equipLV.x = 109
			_equipLV.y = 10;
			_equipLV.color = 0x00FF00;
			this.addChild(_equipLV);
			
			//装备等级
			_equipGrade = createTextField();
			_equipGrade.x = LEFT_GAP;
			this.addChild(_equipGrade);
			
			// 种类
			_equipType = createTextField(60);
			_equipType.x = 109;
			_equipType.y = _equipGrade.y;
			this.addChild(_equipType);
			
			//基础属性
			_baseAttribute = createTextField(180, 35);
			_baseAttribute.x = LEFT_GAP
			this.addChild(_baseAttribute);
			_baseAttribute2 = createTextField(180, 35);
			_baseAttribute2.x = LEFT_GAP
			this.addChild(_baseAttribute2);
			//强化属性
			_strengthenAttribute = createTextField(180, 35);
			_strengthenAttribute.x = LEFT_GAP + 50;
			_strengthenAttribute.color = 0x00FF00;
			this.addChild(_strengthenAttribute);
			//附加属性标题
			_addAttributeTitle = createTextField(180, 35);
			_addAttributeTitle.x = LEFT_GAP;
			_addAttributeTitle.color = 0xFFFF00;
			this.addChild(_addAttributeTitle);
			//附加属性
			_addAttribute = createTextField(180, 35);
			_addAttribute.x = LEFT_GAP;
			_addAttribute.color = 0xFFFF00;
			this.addChild(_addAttribute);
			
			_hpAttribute = createTextField(180, 35);
			_hpAttribute.x = LEFT_GAP + 30;
			_hpAttribute.color = 0xFFFF00;
			this.addChild(_hpAttribute);
			
			_mpAttribute = createTextField(180, 35);
			_mpAttribute.x = LEFT_GAP + 30;
			_mpAttribute.color = 0xFFFF00;
			this.addChild(_mpAttribute);
			
			_atkAttribute = createTextField(180, 35);
			_atkAttribute.x = LEFT_GAP + 30;
			_atkAttribute.color = 0xFFFF00;
			this.addChild(_atkAttribute);
			
			_defAttribute = createTextField(180, 35);
			_defAttribute.x = LEFT_GAP + 30;
			_defAttribute.color = 0xFFFF00;
			this.addChild(_defAttribute);
			
			_spdAttribute = createTextField(180, 35);
			_spdAttribute.x = LEFT_GAP + 30;
			_spdAttribute.color = 0xFFFF00;
			this.addChild(_spdAttribute);
			
			_critAttribute = createTextField(180, 35);
			_critAttribute.x = LEFT_GAP + 30;
			_critAttribute.color = 0xFFFF00;
			this.addChild(_critAttribute);
			
			_evasionAttribute = createTextField(180, 35);
			_evasionAttribute.x = LEFT_GAP + 30;
			_evasionAttribute.color = 0xFFFF00;
			this.addChild(_evasionAttribute);
			
			
			_hpTitle = createTextField(180, 35);
			_hpTitle.x = LEFT_GAP;
			_hpTitle.color = 0xFFFF00;
			_hpTitle.text = "体力  ";
			this.addChild(_hpTitle);
			
			_mpTitle = createTextField(180, 35);
			_mpTitle.x = LEFT_GAP;
			_mpTitle.color = 0xFFFF00;
			_mpTitle.text = "元气  ";
			this.addChild(_mpTitle);
			
			_atkTitle = createTextField(180, 35);
			_atkTitle.x = LEFT_GAP;
			_atkTitle.color = 0xFFFF00;
			_atkTitle.text = "外功  ";
			this.addChild(_atkTitle);
			
			_defTitle = createTextField(180, 35);
			_defTitle.x = LEFT_GAP;
			_defTitle.color = 0xFFFF00;
			_defTitle.text = "根骨  ";
			this.addChild(_defTitle);
			
			_spdTitle = createTextField(180, 35);
			_spdTitle.x = LEFT_GAP;
			_spdTitle.color = 0xFFFF00;
			_spdTitle.text = "步法  ";
			this.addChild(_spdTitle);
			
			_critTitle = createTextField(180, 35);
			_critTitle.x = LEFT_GAP;
			_critTitle.color = 0xFFFF00;
			_critTitle.text = "暴击  ";
			this.addChild(_critTitle);
			
			_evasionTitle = createTextField(180, 35);
			_evasionTitle.x = LEFT_GAP;
			_evasionTitle.color = 0xFFFF00;
			_evasionTitle.text = "灵活  ";
			this.addChild(_evasionTitle);
			
			//主属性充灵
			_baseComposeAttribute = createTextField(90, 35);
			_baseComposeAttribute.x = LEFT_GAP + 50;
			_baseComposeAttribute.color = 0xFF9900;
			this.addChild(_baseComposeAttribute);
			//充灵属性
			_composeAttribute = createTextField(90, 35);
			_composeAttribute.x = LEFT_GAP + 50;
			_composeAttribute.color = 0xFF9900;
			this.addChild(_composeAttribute);
			
			_composeTotalTitle = createTextField(180, 35);
			_composeTotalTitle.x = LEFT_GAP;
			_composeTotalTitle.color = 0xFFFF00;
			this.addChild(_composeTotalTitle);
			
			_composeTotalValue = createTextField(90, 35);
			_composeTotalValue.x = LEFT_GAP + 50;
			_composeTotalValue.color = 0xFF00FF;
			this.addChild(_composeTotalValue);
			
			_lineImag=new Image(_lineTexture);
			addChild(_lineImag);
			_lineImag.x=_bg.width/2-_lineImag.width/2;
			
			//金币值
			_valueMoney=createTextField();
			_valueMoney.color = 0x66CC33;
			this.addChild(_valueMoney);
			
			// 金币
			_money = new Image(_moneyTexture);
			this.addChild(_money);
			_money.x=LEFT_GAP;
		}
		
		private function initEvent() : void
		{
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this);
			
			if (touch)
			{
				hide();
			}
		}
		
		public function setData(data:EquipModel) : void
		{
			_data = data;
			
			initRender();
		}
		
		private var _nowComposeData:Equipment_strengthen;
		private var _composeData:Object;
		private function initRender() : void
		{
			_nowComposeData = (Data.instance.db.interfaces(InterfaceTypes.GET_STRENGTHEN_DATA, _data.id) as Equipment_strengthen);
			_composeData = Data.instance.db.interfaces(InterfaceTypes.GET_FRAGMENT);
			
			var equipData:Vector.<String> = getAddAttributeStr();
			
			_equipNameTF.color = getEquipColorValue();
			_equipNameTF.text = _data.config.name;
			//强化
			if (_data.lv != 0) _equipLV.text = "+" + _data.lv;
			else _equipLV.text = "";
			
			_equipLV.x = _equipNameTF.textBounds.width + 20;
				
			_equipGrade.text = "等级 " + _data.config.grade_limit;
			_equipType.text = _data.config.type;
			_baseAttribute.text = "基础属性";
			_baseAttribute2.text = getBaseAttributeStr();
			_strengthenAttribute.x = _baseAttribute2.textBounds.width + 20;
			_strengthenAttribute.text = getStrengthAttributeStr();
			_baseComposeAttribute.x = _baseAttribute2.textBounds.width + _strengthenAttribute.textBounds.width + 30;
			_baseComposeAttribute.text = getBaseComposeStr();
			_addAttributeTitle.text = "附加属性";
			_addAttribute.text = equipData[0];
			_composeAttribute.x = _addAttribute.textBounds.width + 20;
			_composeAttribute.text = "";
			//_composeAttribute.text = equipData[1];
			_composeTotalTitle.text = "器灵值";
			_composeTotalValue.text = getTotalCompose().toString() + "/" + _nowComposeData.total_value.toString();
			_valueMoney.text = (_data.config.sale_money + _data.lv * _data.config.money_add).toString();
			
			setComposeColor();
			
			resetCompose();
			
			setAttributeColor();
		}
		
		private function setAttribute() : int
		{
			var lastCount:int = _addAttribute.y - INTERVAL + 1;
			
			if(_hpAttribute.text != "")	
			{
				_hpAttribute.y = _addAttribute.y + 1;
				lastCount = _hpTitle.y = _hpAttribute.y;
				_hpTitle.visible = true;
			}
			else 
			{
				_hpAttribute.y = _addAttribute.y - INTERVAL + 1;
				_hpTitle.visible = false
			}
			
			if(_mpAttribute.text != "")	
			{
				_mpAttribute.y = _hpAttribute.y + INTERVAL;
				lastCount = _mpTitle.y = _mpAttribute.y;
				_mpTitle.visible = true;
			}
			else
			{
				_mpAttribute.y = _hpAttribute.y;
				_mpTitle.visible = false;
			}
			
			if(_atkAttribute.text != "")
			{
				_atkAttribute.y = _mpAttribute.y + INTERVAL;
				lastCount = _atkTitle.y = _atkAttribute.y;
				_atkTitle.visible = true;
			}
			else 
			{
				_atkAttribute.y = _mpAttribute.y;
				_atkTitle.visible = false;
			}
			
			if(_defAttribute.text != "")
			{
				_defAttribute.y = _atkAttribute.y + INTERVAL;
				lastCount = _defTitle.y = _defAttribute.y;
				_defTitle.visible = true;
			}
			else
			{
				_defAttribute.y = _atkAttribute.y;
				_defTitle.visible = false;
			}
			
			if(_spdAttribute.text != "")
			{
				_spdAttribute.y = _defAttribute.y + INTERVAL;
				lastCount = _spdTitle.y = _spdAttribute.y;
				_spdTitle.visible = true;
			}
			else
			{
				_spdAttribute.y = _defAttribute.y;
				_spdTitle.visible = false;
			}
			
			if(_critAttribute.text != "")
			{
				_critAttribute.y = _spdAttribute.y + INTERVAL;
				lastCount = _critTitle.y = _critAttribute.y;
				_critTitle.visible = true;
			}
			else
			{
				_critAttribute.y = _spdAttribute.y;
				_critTitle.visible = false;
			}
			
			if(_evasionAttribute.text != "")
			{
				_evasionAttribute.y = _critAttribute.y + INTERVAL;
				lastCount = _evasionTitle.y = _evasionAttribute.y;
				_evasionTitle.visible = true;
			}
			else
			{
				_evasionAttribute.y = _critAttribute.y;
				_evasionTitle.visible = false;
			}
			
			return lastCount;
		}
		
		private function setAttributeColor() : void
		{
			if(_data.hp_compose == 0)  _hpAttribute.color = 0xFFFF00;
			else _hpAttribute.color = 0xFF9900;
			
			if(_data.mp_compose == 0)  _mpAttribute.color = 0xFFFF00;
			else _mpAttribute.color = 0xFF9900;
			
			if(_data.atk_compose == 0)  _atkAttribute.color = 0xFFFF00;
			else _atkAttribute.color = 0xFF9900;
			
			if(_data.def_compose == 0)  _defAttribute.color = 0xFFFF00;
			else _defAttribute.color = 0xFF9900;
			
			if(_data.spd_compose == 0)  _spdAttribute.color = 0xFFFF00;
			else _spdAttribute.color = 0xFF9900;
			
			if(_data.crit_compose == 0)  _critAttribute.color = 0xFFFF00;
			else _critAttribute.color = 0xFF9900;
			
			if(_data.evasion_compose == 0)  _evasionAttribute.color = 0xFFFF00;
			else _evasionAttribute.color = 0xFF9900;
		}
		
		private function setComposeColor() : void
		{
			if(getTotalCompose() >= _nowComposeData.total_value)	_composeTotalValue.color = 0xFF0000;
			else _composeTotalValue.color = 0xFF00FF;
		}
		
		private function getTotalCompose() : int
		{
			var resultCount:int = 0;
			var equipArr:Array = [_data.hp_compose, _data.mp_compose, _data.atk_compose, _data.def_compose, _data.evasion_compose, _data.crit_compose, _data.spd_compose];
			for(var i:int = 0; i < equipArr.length; i++)
			{
				resultCount += Math.floor(equipArr[i] /_composeData[i].add_value) * _composeData[i].use_value;
			}
			return resultCount;
		}
		
		/**
		 * 获取装备颜色 
		 * @return 
		 * 
		 */		
		private function getEquipColorValue() : int
		{
			var color:int;
			
			switch (_data.config.color)
			{
				case "白":
					color = V.WIHTE_COLOR;
					break;
				case "绿":
					color = V.GREEN_COLOR;
					break;
				case "蓝":
					color = V.BLUE_COLOR;
					break;
				case "夜":
					color = V.LITTLE_BLACK_COLOR;
					break;
				case "雨":
					color = V.LITTLE_BLUE_COLOR;
					break;
				case "雷":
					color = V.YELLOW_COLOR;
					break;
				case "风":
					color = V.WIND_COLOR;
					break;
			}
			
			return color;
		}
		
		private function resetCompose() : void
		{
			//装备名称
			_equipNameTF.y = 10;
			
			// 强化
			_equipLV.y = 10;
			
			//装备等级
			_equipGrade.y = _equipNameTF.y +_equipNameTF.height+TEXT_VGAP;
			
			// 种类
			_equipType.y = _equipGrade.y;
			
			//基础属性
			_baseAttribute.y = _equipGrade.y + _equipGrade.height+TEXT_VGAP;
			_baseAttribute2.y = _baseAttribute.y + _baseAttribute.height+TEXT_VGAP;
		
			//强化属性
			_strengthenAttribute.y = _baseAttribute.y + _baseAttribute.height+TEXT_VGAP;
			
			_baseComposeAttribute.y = _strengthenAttribute.y;
			_addAttributeTitle.y =_baseAttribute2.y + _baseAttribute2.height + TEXT_VGAP
			_addAttribute.y = _addAttributeTitle.y + _addAttributeTitle.height + TEXT_VGAP;
			
			_composeAttribute.y = _addAttributeTitle.y + _addAttributeTitle.height + TEXT_VGAP;
			
			var lastCount:int = setAttribute();
			
			if((_data.config.color == "白" || _data.config.color == "绿") && !checkCompose())	_composeTotalTitle.y=_baseAttribute2.y+_baseAttribute2.height+TEXT_VGAP;
			else 	_composeTotalTitle.y=lastCount + 20 + TEXT_VGAP;
			
			_composeTotalValue.y = _composeTotalTitle.y + 1;
			
			_lineImag.y = _composeTotalValue.y + _composeTotalValue.height + 4;
			
			// 金币
			_money.y = _lineImag.y +TEXT_VGAP+10;
			
			//金币值
			_valueMoney.x=_money.x+_money.width+10;
			_valueMoney.y=int( _money.y+_money.height/2-_valueMoney.height/2);
			
			
			_bg.height = _money.y + _money.height +10;
		}
		
		private function getBaseAttributeStr() : String
		{
			var str:String = "";
			
			if(_data.config.type == EquipConfig.WEAPON)
			{
				str = "" + "外功  " + _data.atk;
			}
			else if(_data.config.type == EquipConfig.CLOTHES)
			{
				str = "" + "根骨  " + _data.def;
			}
			else if(_data.config.type == EquipConfig.THING)
			{
				str = "" + "步法  " + _data.spd;
			}
			return str;
		}
		
		private function getStrengthAttributeStr() : String
		{
			var str:String = "";
			var lvData:Array = _view.controller.equip.getEquipmentLv(_data);
			if(_data.config.type == EquipConfig.WEAPON)
			{
				str = (lvData[0]!=0?("(+ " + lvData[0]) + ")":"");
			}
			else if(_data.config.type == EquipConfig.CLOTHES)
			{
				str = (lvData[1]!=0?("(+ " + lvData[1]) + ")":"");
			}
			else if(_data.config.type == EquipConfig.THING)
			{
				str = (lvData[2]!=0?("(+ " + lvData[2]) + ")":"");
			}
			return str;
		}
		
		private function getBaseComposeStr() : String
		{
			var str:String = "";
			if(_data.config.type == EquipConfig.WEAPON)
			{
				str = (data.atk_compose == 0?"":("(+ " + _data.atk_compose + ")"));
			}
			else if(_data.config.type == EquipConfig.CLOTHES)
			{
				str = (data.def_compose == 0?"":("(+ " + _data.def_compose + ")"));
			}
			else if(_data.config.type == EquipConfig.THING)
			{
				str = (data.spd_compose == 0?"":("(+ " + _data.spd_compose + ")"));
			}
			return str
		}
		
		private function getAddAttributeStr() : Vector.<String>
		{
			var resultStr:Vector.<String> = new Vector.<String>();
			var str:String = "";
			var composeStr:String = "";
			_hpAttribute.text = _mpAttribute.text = _defAttribute.text = _spdAttribute.text = _atkAttribute.text = _critAttribute.text = _evasionAttribute.text = "";
			//蓝装多属性显示
			if((_data.config.color == "白" || _data.config.color == "绿") && !checkCompose())
			{
				_addAttributeTitle.visible = false;
				//_littleLineImag.visible = false;
			}
			else
			{
				//_littleLineImag.visible = true;
				_addAttributeTitle.visible = true;
				if(_data.hp != 0 || _data.hp_compose != 0)
				{
					//str += "\n体力  "// +　(_data.hp + _data.hp_compose);
					//composeStr += "\n" + (_data.hp_compose == 0?"":("(+ " + _data.hp_compose + ")"));
					_hpAttribute.text = ((_data.hp + _data.hp_compose)==0?"":(_data.hp + _data.hp_compose).toString());
				}
				if(_data.mp != 0 || _data.mp_compose != 0)
				{
					//str += "\n元气  "// +　(_data.mp + _data.mp_compose);
					//composeStr += "\n" + (_data.mp_compose == 0?"":("(+ " + _data.mp_compose + ")"));
					_mpAttribute.text = ((_data.mp + _data.mp_compose)==0?"":(_data.mp + _data.mp_compose).toString());
				}
				//武器
				if(_data.config.type == EquipConfig.WEAPON)
				{
					
					if(_data.def != 0 || _data.def_compose != 0)
					{
						//str += "\n根骨  "//+ (_data.def + _data.def_compose);
						//composeStr += "\n" + (_data.def_compose == 0?"":("(+ " + _data.def_compose + ")"));
						_defAttribute.text = ((_data.def + _data.def_compose)==0?"":(_data.def + _data.def_compose).toString());
						
					}
					if(_data.spd != 0 || _data.spd_compose != 0)
					{
						//str += "\n步法  "// + (_data.spd + _data.spd_compose);
						//composeStr += "\n" + (_data.spd_compose == 0?"":("(+ " + _data.spd_compose + ")"));
						_spdAttribute.text = ((_data.spd + _data.spd_compose)==0?"":(_data.spd + _data.spd_compose).toString());
					}
					
				}
				//衣服
				else if(_data.config.type == EquipConfig.CLOTHES)
				{
					if(_data.atk != 0 || _data.atk_compose != 0)
					{
						//str += "\n外功  "//+ (_data.atk + _data.atk_compose);
						//composeStr += "\n" + (_data.atk_compose == 0?"":("(+ " + _data.atk_compose + ")"));
						_atkAttribute.text = ((_data.atk + _data.atk_compose)==0?"":(_data.atk + _data.atk_compose).toString());
					}
					if(_data.spd != 0 || _data.spd_compose != 0)
					{
						//str += "\n步法  "// + (_data.spd + _data.spd_compose);
						//composeStr += "\n" + (_data.spd_compose == 0?"":("(+ " + _data.spd_compose + ")"));
						_spdAttribute.text = ((_data.spd + _data.spd_compose)==0?"":(_data.spd + _data.spd_compose).toString());
					}
				}
				//饰品
				else if(_data.config.type == EquipConfig.THING)
				{
					if(_data.atk != 0 || _data.atk_compose != 0)
					{
						//str += "\n外功  "//+ (_data.atk + _data.atk_compose);
						//composeStr += "\n" + (_data.atk_compose == 0?"":("(+ " + _data.atk_compose + ")"));
						_atkAttribute.text = ((_data.atk + _data.atk_compose)==0?"":(_data.atk + _data.atk_compose).toString());
					}
					if(_data.def != 0 || _data.def_compose != 0)
					{
						//str += "\n根骨  "//+ (_data.def + _data.def_compose);
						//composeStr += "\n" + (_data.def_compose == 0?"":("(+ " + _data.def_compose + ")"));
						_defAttribute.text = ((_data.def + _data.def_compose)==0?"":(_data.def + _data.def_compose).toString());
					}
				}
				
				if(_data.crit != 0 || _data.crit_compose != 0)
				{
					//str += "\n暴击  " //+ (_data.crit + _data.crit_compose);
					//composeStr += "\n" + (_data.crit_compose == 0?"":("(+ " + _data.crit_compose + ")"));
					_critAttribute.text = ((_data.crit + _data.crit_compose)==0?"":(_data.crit + _data.crit_compose).toString());
				}
				
				if(_data.evasion != 0 || _data.evasion_compose != 0)
				{
					//str += "\n灵活  "//+ (_data.evasion + _data.evasion_compose);
					//composeStr += "\n" + (_data.evasion_compose == 0?"":("(+ " + _data.evasion_compose + ")"));
					_evasionAttribute.text = ((_data.evasion + _data.evasion_compose)==0?"":(_data.evasion + _data.evasion_compose).toString());
				}
				
				str = str.slice(1);
				composeStr = composeStr.slice(1);
			}
			resultStr.push(str);
			resultStr.push(composeStr);
			return resultStr;
		}
		
		protected function createTextField(W:int=90, H:int=19, Col:Number=0Xffffff, Str:String='', Size:uint=12, HAl:String=HAlign.LEFT, Auto:Boolean=true, Wor:Boolean=true) : TipTextField
		{
			var mytext:TipTextField=new TipTextField(W,H,Str);
			mytext.color=Col;
			mytext.fontSize=Size;
			mytext.hAlign=HAl;
			return mytext;
		}
		
		public function hide():void
		{
			if (this.parent) this.parent.removeChild(this);
		}
		
		/*override public function set x(value:Number):void
		{
			// TODO Auto Generated method stub
			if(value+this.width>Starling.current.stage.stageWidth)
			{
				value=Starling.current.stage.stageWidth-this.width-4;
			}
			super.x = value;
		}*/
		
		override public function set y(value:Number):void
		{
			if(value + this.height + this.parent.y>GameConfig.CAMERA_HEIGHT - 5)
			{
				value=GameConfig.CAMERA_HEIGHT - this.height - this.parent.y - 5;
			}
			super.y = value;
		}
		
		private function checkCompose() : Boolean
		{
			var isShow:Boolean = false;
			if(_data.hp_compose != 0) isShow = true;
			if(_data.mp_compose != 0) isShow = true;
			if(_data.evasion_compose != 0) isShow = true;
			if(_data.crit_compose != 0) isShow = true;
			if(_data.config.type == EquipConfig.WEAPON)
			{
				if(_data.def_compose != 0) isShow = true;
				if(_data.spd_compose != 0) isShow = true;
			}
			else if(_data.config.type == EquipConfig.CLOTHES)
			{
				if(_data.atk_compose != 0) isShow = true;
				if(_data.spd_compose != 0) isShow = true;
			}
			else if(_data.config.type == EquipConfig.THING)
			{
				if(_data.atk_compose != 0) isShow = true;
				if(_data.def_compose != 0) isShow = true;
			}
			return isShow;
		}
	}
}
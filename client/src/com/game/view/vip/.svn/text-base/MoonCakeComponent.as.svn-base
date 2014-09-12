package com.game.view.vip
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.engine.ui.controls.TipTextField;
	import com.game.Data;
	import com.game.View;
	import com.game.data.DataList;
	import com.game.data.db.protocal.Mall;
	import com.game.data.db.protocal.Prop;
	import com.game.data.db.protocal.Vip_mall;
	import com.game.data.player.structure.PropModel;
	import com.game.data.shop.ShopSubmitData;
	import com.game.manager.LayerManager;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.Role.PropItemRender;
	import com.game.view.equip.PropTip;
	import com.game.view.ui.UIConfig;
	
	import feathers.controls.TextInput;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.core.ITextEditor;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.HAlign;

	public class MoonCakeComponent extends Component
	{
		private var _anti:Antiwear;
		
		private var _allNum:int = 1;
		
		private function get buyNum() : int
		{
			return _anti["buyNum"];
		}
		
		private function set buyNum(value:int) : void
		{
			_anti["buyNum"] = value;
		}
		
		private function get rechargeCount() : int
		{
			return _anti["rechargeCount"];
		}
		
		private function set rechargeCount(value:int) : void
		{
			_anti["rechargeCount"] = value;
		}
		
		private function get totalMoney() : int
		{
			return _anti["totalMoney"];
		}
		
		private function set totalMoney(value:int) : void
		{
			_anti["totalMoney"] = value;
		}
		
		private var _propType:int;
		
		private var _input:TextInput;
		
		public function MoonCakeComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["buyNum"] = 0;
			_anti["rechargeCount"] = 0;
			_anti["totalMoney"] = 0;
			
			getUI();
		}
		private var propTitle:TextField;
		private var sellNum:TextField;
		private var upBtn:Button;
		private var downBtn:Button;
		private var buyBtn:Button;
		private var propTip:PropItemRender;
		private function getUI() : void
		{			
			propTitle = searchOf("PropTitle");
			sellNum = searchOf("SellNum");
			
			upBtn = searchOf("Up_Press");
			upBtn.addEventListener(TouchEvent.TOUCH, onAddNum);
			downBtn = searchOf("Down_Press");
			downBtn.addEventListener(TouchEvent.TOUCH, onReduceNum);
			
			buyBtn = searchOf("Buy");
			buyBtn.addEventListener(TouchEvent.TOUCH, onShowInfo);
			
			propTip = new PropItemRender();
			panel.addChild(propTip);
			
			_vipTip = new VipItemRender();
			panel.addChild(_vipTip);
		}
		
		private function onReduceNum(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(downBtn);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				if(buyNum > _allNum)	buyNum -= _allNum;
				_input.text = buyNum.toString();
			}
		}
		
		private function onAddNum(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(upBtn);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				if(buyNum < 99)	 
				{
					buyNum += _allNum;
					
					if(judgeRecharge()) buyNum -= _allNum;
				}
				
				_input.text = buyNum.toString();
			} 
		}
		
		/**
		 * 判断
		 * @return 
		 * 
		 */		
		private function judgeRecharge() : Boolean
		{
			var TOF:Boolean = false;
			if((buyNum * rechargeCount / _allNum) > _moonCakeNum)
			{
				View.instance.tip.interfaces(InterfaceTypes.Show, 
					_propName + "不足！",
					null,
					null,
					false,
					true,
					false);
				TOF = true;
			}
			
			return TOF;
		}
		
		private function onShowInfo(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(buyBtn);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{	
				var info:String = "";
				if(!judgeRecharge())
				{
					totalMoney = rechargeCount * buyNum / _allNum;
					
					if(_propType == 1)
					{
						info += "你兑换了" + buyNum * DataList.list[500] + "金钱，总共需要花费" + totalMoney + "个" + _propName + "\n\n";
						info += "（当前金钱" + player.money + "）";
					}
					else if(_propType == 2)
					{
						info += "你兑换了" + buyNum * DataList.list[500] + "战魂，总共需要花费" + totalMoney + "个" + _propName + "\n\n";
						info += "（当前战魂" + player.fight_soul + "）";
					}
					View.instance.tip.interfaces(InterfaceTypes.Show, 
						info,
						function () : void
						{
							Starling.juggler.delayCall(paySuccess, .1);
						},
						null,
						false);
				}
			}
		}
		
		/**
		 * 付款成功
		 * @param info
		 * 
		 */		
		private function paySuccess(info:String = "") : void
		{
			if(View.instance.shop.delayFun) return;
			
			var showInfo:String = "";
			View.instance.tip.interfaces(InterfaceTypes.Show, 
				"购买成功！",
				null,
				null,
				false,
				true,
				false);
			
			if(_propType == 1)
			{
				player.money += buyNum * DataList.list[500];
				showInfo = "恭喜你获得金钱" + buyNum * DataList.list[500];
			}
			else if(_propType == 2)
			{
				player.fight_soul += buyNum * DataList.list[500];
				showInfo = "恭喜你获得战魂" + buyNum * DataList.list[500];
			}
			
			Data.instance.pack.changePropNum(_propID, -buyNum);
			_moonCakeNum = Data.instance.player.player.pack.getPropNumById(_propID);
			
			_view.prompEffect.play(showInfo);
			
			_view.role.interfaces(InterfaceTypes.REFRESH);
			_view.vip_shop.interfaces(InterfaceTypes.REFRESH);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			reset();
		}
		
		private var _propImage:Image;
		private var _dayNum:Image;
		private var _propNum:int;
		private var _propID:int;
		private var _propModel:PropModel;
		private var _propName:String;
		private var _redLine:Image;
		private var _moonCakeNum:int;
		override public function setGridData(data:*) : void
		{
			_propModel = (data as Array)[1] as PropModel;
			_propID = _propModel.id;
			_moonCakeNum = Data.instance.player.player.pack.getPropNumById(_propID);
			_propType = (data as Array)[0];
			rechargeCount = 1;
			
			switch(_propID)
			{
				case 49:
					_propName = "月饼";
					break;
				case 54:
					_propName = "碎片";
					break;
			}
			sellNum.text = "1个" + _propName;
			
			_allNum = buyNum = 1;
			var num:int = 0;
			if(_propImage == null)
			{
				var textureInfo:String = "";
				var texture:Texture;
				switch(_propType)
				{
					case 1:
						textureInfo = "Toolbar_Money";
						texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, textureInfo);
						num = 500;
						propTitle.text = "金币";
						break;
					case 2:
						textureInfo = "Toolbar_WarValue";
						texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, textureInfo);
						num = 500;
						propTitle.text = "战魂";
						break;
				}
				_propImage = new Image(texture);
				_propImage.x = 19;
				_propImage.y = 42;
				if(textureInfo == "Toolbar_WarValue") 
				{
					_propImage.x = 24;
					_propImage.y = 38;
					_vipTip.setData(2, _propImage);
				}
				else if(textureInfo == "Toolbar_Money")
				{
					_propImage.x = 13;
					_propImage.y = 42;
					_vipTip.setData(1, _propImage);
				}
				_propImage.readjustSize();
				if(!_propImage.parent)	this.panel.addChild(_propImage);
			}
			if(_propBg == null)
			{
				var bgTexture:Texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "LittleBg");
				_propBg = new Image(bgTexture);
				_propBg.x = 43;
				_propBg.y = 70;
				panel.addChild(_propBg);
			}
			if(_tipInfo == null)
			{
				_tipInfo = createTipTextField(50, 20, 0xFFFFFF, num.toString());
				_tipInfo.hAlign = HAlign.CENTER;
				_tipInfo.x = 27;
				_tipInfo.y = 70;
				panel.addChild(_tipInfo);
			}
			
			if(!_input) _input = addText(135, 40, 30, 30, _allNum.toString());
		}
		
		private var _tipInfo:TipTextField;
		private var _propBg:Image;
		private var _vipTip:VipItemRender;
		private function renderOther():void
		{
			
		}
		
		protected function createTipTextField(W:int=180, H:int=20, Col:Number=0Xffffff, Str:String='', Size:uint=12, HAl:String=HAlign.LEFT, Auto:Boolean=true, Wor:Boolean=true) : TipTextField
		{
			var mytext:TipTextField = new TipTextField(W,H,Str);
			mytext.color=Col;
			mytext.fontSize=Size;
			mytext.hAlign=HAl;
			return mytext;
		}
		
		private function fashionUntouch() : void
		{
			_input.touchable = false;
			removeTouchable(upBtn);
			removeTouchable(downBtn);
		}
		
		public function setMask() : void
		{
			(this.searchOf("Prop_Bg") as Image).visible = false;
		}
		
		override public function inputChangeHandler( e:Event) : void
		{
			buyNum = int(_input.text);
			if(_input.text == "" || _input.text == "0")
			{
				buyNum = _allNum;
				_input.text = buyNum.toString();
			}
			else if(buyNum != _allNum && judgeRecharge())
			{
				buyNum = _moonCakeNum / rechargeCount;
				if(buyNum >= 99 || (buyNum + Data.instance.shop.getPropNum(_propID)) > 99)
				{
					if(_propID == 54)
						buyNum = 999 - Data.instance.shop.getPropNum(_propID);
					else 
						buyNum = 99 - Data.instance.shop.getPropNum(_propID);
				}
				else if(buyNum == 0)
				{
					buyNum = _allNum;
				}
				_input.text = buyNum.toString();
			}
		}
		
		public function reset() : void
		{
			buyNum = _allNum;
			if(_input != null)
				_input.text = buyNum.toString();
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			textures = _view.vip_shop.interfaces(InterfaceTypes.GetTextures, name);
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			texture = _view.vip_shop.interfaces(InterfaceTypes.GetTexture, name);
			return texture;
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new MoonCakeComponent(_configXML, _titleTxAtlas);
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			super.destroy();
		}
		
		override public function clear() : void
		{
			if(_input != null)
			{
				_input.removeEventListeners();
				_input.textEditorFactory = null;
				if(_input.parent) 	this.panel.removeChild(_input);
				_input = null;
			}
			
			if(_propImage != null)
			{
				_propImage.removeEventListeners();
				if(_propImage.parent)  this.panel.removeChild(_propImage);
				_propImage.dispose();
				_propImage = null;
			}
			
			if(_propBg != null)
			{
				_propBg.removeEventListeners();
				if(_propBg.parent)  this.panel.removeChild(_propBg);
				_propBg.dispose();
				_propBg = null;
			}
			
			if(_tipInfo != null)
			{
				_tipInfo = null;
			}
			/*_propTip.dispose();
			_propTip = null*/
		}
	}
}
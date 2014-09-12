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

	public class VipShopComponent extends Component
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
		
		private var _propType:Vip_mall;
		
		private var _input:TextInput;
		
		public function VipShopComponent(item:XML, titleTxAtlas:TextureAtlas)
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
		private var beforeNum:TextField;
		private function getUI() : void
		{			
			propTitle = searchOf("PropTitle");
			sellNum = searchOf("SellNum");
			beforeNum = searchOf("BeforeNum");
			
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
			if((buyNum * rechargeCount / _allNum) > _view.vip_shop.rechargeNum)
			{
				View.instance.tip.interfaces(InterfaceTypes.Show, 
					"余额不足！",
					null,
					null,
					false,
					true,
					false);
				TOF = true;
			}
			else if(Data.instance.shop.checkPropNum(_propID, buyNum))
			{
				var info:String = "";
				info = "购买会使数量超过上限值，无法执行！\n\n";
				if(_propID == 49)
					info += "(当前有" + _propType.name.split("（")[0] + Data.instance.shop.getPropNum(_propID).toString() + "个，上限为999个)";
				else
					info += "(当前有" + _propType.name.split("（")[0] + Data.instance.shop.getPropNum(_propID).toString() + "个，上限为99个)";
				View.instance.tip.interfaces(InterfaceTypes.Show, 
					info,
					null,
					null,
					false,
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
				//小宝时装
				if(_propID == 43)
				{
					if(player.roleFashionInfo.checkFashionExist(V.MAIN_ROLE_NAME, "NewDress"))
					{
						_view.tip.interfaces(InterfaceTypes.Show,
							"您已经购买了鹿鼎小宝时装",
							null, null, false, false, true);
						return;
					}
				}
				
				var info:String = "";
				if(!judgeRecharge())
				{
					totalMoney = rechargeCount * buyNum / _allNum;
					info += "你购买了" + buyNum + "个，总共需要花费" + totalMoney + "点券\n\n";
					if(_propType.name == "金钱")
					{
						info += "（当前金钱" + player.money + "）";
					}
					else if(_propType.name == "战魂")
					{
						info += "（当前战魂" + player.fight_soul + "）";
					}
					else if(_propType.name == "内功修为")
					{
						info += "（当前内功修为" + player.strength_exp + "）";
					}
					else
					{
						if(_propID == 43)
							info += "(当前有" + _propType.name.split("（")[0] + Data.instance.shop.getPropNum(_propID).toString() + "个，上限为1个)";
						else if(_propID == 49)
							info += "(当前有" + _propType.name.split("（")[0] + Data.instance.shop.getPropNum(_propID).toString() + "个，上限为999个)";
						else
							info += "(当前有" + _propType.name.split("（")[0] + Data.instance.shop.getPropNum(_propID).toString() + "个，上限为99个)";
					}
					View.instance.tip.interfaces(InterfaceTypes.Show, 
						info,
						function () : void
						{
							Starling.juggler.delayCall(delayFun, .1);
						},
						null,
						false);
				}
			}
		}
		
		public function delayFun() : void
		{
			if(View.instance.shop.delayFun) return;
			
			//Data.instance.server.getStoreState(function () : void {Data.instance.pay.reduceMoney(totalMoney, paySuccess, payFailure);});
			View.instance.controller.save.multipleState(multipleState);
			
			View.instance.tip.interfaces(InterfaceTypes.Show, 
				"系统正在处理当中，请稍等...",
				null,
				null,
				true);
		}
		
		/**
		 * 多开判断
		 * @param e
		 * 
		 */		
		private function multipleState(e:*) : void
		{
			if(e == "1")
			{
				if(Data.instance.pay.isLocal())
					Data.instance.pay.reduceMoney(totalMoney, paySuccess, payFailure);
				else
				{
					var shopObj:ShopSubmitData = new ShopSubmitData(_propType.propId, int(buyNum / _allNum), _propType.conpou);
					Data.instance.pay.buyPropNd(shopObj, paySuccess, payFailure);
				}
			}
			else View.instance.tip.interfaces(InterfaceTypes.Show, 
				"游戏多开了，无法保存游戏存档，请关闭该页面！", 
				null,
				null,
				true);
			Starling.juggler.delayCall(
				function () : void
				{
					LayerManager.instance.cpu_stage.frameRate = 0;
				},
				1);
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
			
			if(_propType.name == "金钱")
			{
				player.money += buyNum * DataList.list[500];
				showInfo = "恭喜你获得金钱" + buyNum * DataList.list[500];
				_view.vip_shop.resetGoldAndSoul();
			}
			else if(_propType.name == "战魂")
			{
				player.fight_soul += buyNum * DataList.list[500];
				showInfo = "恭喜你获得战魂" + buyNum * DataList.list[500];
				_view.vip_shop.resetGoldAndSoul();
			}
			else if(_propType.name == "内功修为")
			{
				player.strength_exp += buyNum * DataList.list[20];
				showInfo = "恭喜你获得内功修为" + buyNum * DataList.list[20];
			}
			else
			{
				//添加道具
				Data.instance.shop.addPropNum(_propID, buyNum);
				showInfo = "恭喜你获得" + _propType.name.split("（")[0] + " X " + buyNum;
			}
			
			_view.prompEffect.play(showInfo);
			
			if(_propID == 43)
			{
				player.roleFashionInfo.addFashionInfo(V.MAIN_ROLE_NAME, "NewDress");
				fashionUntouch();
			}		
			//刷新界面的点卷数
			if(info != "") _view.vip_shop.resetText(info);
			//保存数据
			Log.Trace("商城购买保存");
			_view.controller.save.onCommonSave(false, 1, false);
			_view.vip_shop.interfaces(InterfaceTypes.REFRESH);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
		
		/**
		 * 付款失败
		 * @param info
		 * 
		 */		
		private function payFailure(info:String = null) : void
		{
			if(View.instance.shop.delayFun) return;
			
			var message:String = info;
			View.instance.tip.interfaces(InterfaceTypes.Show, 
				message,
				null,
				null,
				false,
				true,
				false);
		}
		
		
		private var _propImage:Image;
		private var _dayNum:Image;
		private var _propNum:int;
		private var _propID:int;
		private var _redLine:Image;
		override public function setGridData(propType:*) : void
		{
			if(_redLine == null)
			{
				var lightBlack:Texture = Texture.fromColor(55, 2, 0xffFF0000);
				_redLine = new Image(lightBlack);
				_redLine.x = 68;
				_redLine.y = 64;
				this.panel.addChild(_redLine);
			}
			
			_propType = propType;
			_allNum = _propType.number;
			buyNum = _propType.number;
			rechargeCount = _propType.conpou;
			sellNum.text = rechargeCount + "点券";
			beforeNum.text = _propType.conpou_before + "点券";
			propTitle.text = _propType.name;
			
			if(_propType.name == "战魂" || _propType.name == "金钱" || _propType.name == "内功修为")
			{
				renderOther();
			}
			else
			{
				_propID = (Data.instance.db.interfaces(InterfaceTypes.GET_PROP_BY_NAME, _propType.name.split("（")[0]) as Prop).id;
				
				var textureInfo:String = "props_" + _propID;
				var texture:Texture = _view.icon.interfaces(InterfaceTypes.GetTexture, textureInfo);
				_propImage = new Image(texture);
				_propImage.x = 19;
				_propImage.y = 42;
				_propImage.width = 42;
				_propImage.height = 42;
				if(!_propImage.parent)	this.panel.addChild(_propImage);
				
				var information:Object = _view.vip_shop.propInformation();
				
				propTip.setData(_propID, _propImage);
			}
			
			if(!_input) _input = addText(135, 40, 30, 30, _allNum.toString());
			if(_allNum >= 50)
			{
				_input.touchable = false;
				removeTouchable(upBtn);
				removeTouchable(downBtn);
			}
			
			if(_propType.recommend == 1)
				(this.searchOf("Recommend") as Image).visible = true;
			else
				(this.searchOf("Recommend") as Image).visible = false;
			
			if(_propID == 43)
			{
				fashionUntouch();
				if(!_dayNum)
				{
					var dayTexture:Texture = getTexture("DayNum", "");
					_dayNum = new Image(dayTexture);
					_dayNum.x = 40;
					_dayNum.y = 25;
					_dayNum.touchable = false;
					panel.addChild(_dayNum);
				}
				panel.setChildIndex(_dayNum, panel.numChildren - 1);
			}
		}
		
		private var _tipInfo:TipTextField;
		private var _propBg:Image;
		private var _vipTip:VipItemRender;
		private function renderOther():void
		{
			_allNum = buyNum = 1;
			var num:int = 0;
			if(_propImage == null)
			{
				var textureInfo:String = "";
				var texture:Texture;
				switch(_propType.name)
				{
					case "金钱":
						textureInfo = "Toolbar_Money";
						texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, textureInfo);
						num = 500;
						break;
					case "战魂":
						textureInfo = "Toolbar_WarValue";
						texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, textureInfo);
						num = 500;
						break;
					case "内功修为":
						textureInfo = "neigong";
						texture = _view.icon.interfaces(InterfaceTypes.GetTexture, textureInfo);
						num = 20;
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
				else
				{
					_vipTip.setData(3, _propImage);
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
				buyNum = _view.vip_shop.rechargeNum / rechargeCount;
				if(buyNum >= 99 || (buyNum + Data.instance.shop.getPropNum(_propID)) > 99)
				{
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
			return new VipShopComponent(_configXML, _titleTxAtlas);
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
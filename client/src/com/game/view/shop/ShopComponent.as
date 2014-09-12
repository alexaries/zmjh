package com.game.view.shop
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.View;
	import com.game.data.DataList;
	import com.game.data.db.protocal.Mall;
	import com.game.data.db.protocal.Prop;
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

	public class ShopComponent extends Component
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
		
		private function get nationalDayTime() : String
		{
			return _anti["nationalDayTime"];
		}
		
		private var _propType:Mall;
		
		private var _input:TextInput;
				
		public function ShopComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["buyNum"] = 0;
			_anti["rechargeCount"] = 0;
			_anti["totalMoney"] = 0;
			_anti["nationalDayTime"] = "2013-10-01";
			
			getUI();
		}
		
		private var propTitle:TextField;
		private var sellNum:TextField;
		private var beforeNum:TextField;
		private var upBtn:Button;
		private var downBtn:Button;
		private var buyBtn:Button;
		private var propTip:PropItemRender;
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
			if((buyNum * rechargeCount / _allNum) > _view.shop.rechargeNum)
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
				if(_propID == 49 || _propID == 54)
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
					if(_propID == 43)
						info += "(当前有" + _propType.name.split("（")[0] + Data.instance.shop.getPropNum(_propID).toString() + "个，上限为1个)";
					else if(_propID == 49 || _propID == 54)
						info += "(当前有" + _propType.name.split("（")[0] + Data.instance.shop.getPropNum(_propID).toString() + "个，上限为999个)";
					else
						info += "(当前有" + _propType.name.split("（")[0] + Data.instance.shop.getPropNum(_propID).toString() + "个，上限为99个)";
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
				{
					Data.instance.pay.reduceMoney(totalMoney, paySuccess, payFailure);
					Log.Trace("V4版本发送信息到服务器...");
				}
				else
				{
					var shopObj:ShopSubmitData = new ShopSubmitData(_propType.propId, int(buyNum / _allNum), rechargeCount);
					Data.instance.pay.buyPropNd(shopObj, paySuccess, payFailure);
					Log.Trace("V5版本购买物品发送信息到服务器...");
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
			//添加道具
			Data.instance.shop.addPropNum(_propID, buyNum);
			
			if(_propID == 43)
			{
				player.roleFashionInfo.addFashionInfo(V.MAIN_ROLE_NAME, "NewDress");
				fashionUntouch();
			}		
			//刷新界面的点卷数
			if(info != "") View.instance.shop.resetText(info);
			//保存数据
			Log.Trace("商城购买保存");
			_view.controller.save.onCommonSave(false, 1, false);
			
			var info:String = "";
			View.instance.tip.interfaces(InterfaceTypes.Show, 
				"购买成功！",
				null,
				null,
				false,
				true,
				false);
			info = "恭喜你获得" + _propType.name.split("（")[0] + " X " + buyNum;
			_view.prompEffect.play(info);
			_view.shop.interfaces(InterfaceTypes.REFRESH);
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
		
		private function checkDate() : Boolean
		{
			var result:Boolean = false;
			var intervalTime:int = Data.instance.time.disDayNum(nationalDayTime, Data.instance.time.curTimeStr.split(" ")[0]);
			
			if(intervalTime >= 0 && intervalTime < 7)
				result = true;
			return result;
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
			
			if(_propType == null) return;
			_allNum = _propType.number;
			buyNum = _propType.number;
			
			if(checkDate())
			{
				beforeNum.text = _propType.conpou + "点券";
				beforeNum.visible = true;
				_redLine.visible = true;
				rechargeCount = Math.ceil(_propType.conpou * DataList.littleList[80]);
			}
			else
			{
				beforeNum.visible = false;
				_redLine.visible = false;
				rechargeCount = _propType.conpou;
			}
			
			sellNum.text = rechargeCount + "点券";
			propTitle.text = _propType.name;
			_propID = (Data.instance.db.interfaces(InterfaceTypes.GET_PROP_BY_NAME, _propType.name.split("（")[0]) as Prop).id;
			
			var textureInfo:String = "props_" + _propID;
			var texture:Texture = _view.icon.interfaces(InterfaceTypes.GetTexture, textureInfo);
			_propImage = new Image(texture);
			_propImage.x = 19;
			_propImage.y = 42;
			_propImage.width = 42;
			_propImage.height = 42;
			if(!_propImage.parent)	this.panel.addChild(_propImage);
			
			var information:Object = _view.shop.propInformation();
			
			propTip.setData(_propID, _propImage);
			
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
				buyNum = _view.shop.rechargeNum / rechargeCount;
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
			textures = _view.shop.interfaces(InterfaceTypes.GetTextures, name);
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			texture = _view.shop.interfaces(InterfaceTypes.GetTexture, name);
			return texture;
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new ShopComponent(_configXML, _titleTxAtlas);
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
			_input.removeEventListeners();
			_input.textEditorFactory = null;
			if(_input.parent) 	this.panel.removeChild(_input);
			_input = null;
			
			_propImage.removeEventListeners();
			if(_propImage.parent)  this.panel.removeChild(_propImage);
			_propImage.dispose();
			_propImage = null;
			
			/*_propTip.dispose();
			_propTip = null*/
		}
	}
}
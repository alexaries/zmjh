package com.game.view.vip
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.View;
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

	public class VipGoldShopComponent extends Component
	{
		private var _anti:Antiwear;
		
		private function get allNum() : int
		{
			return _anti["allNum"];
		}
		
		private function set allNum(value:int) : void
		{
			_anti["allNum"] = value;
		}
		
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
		
		public function VipGoldShopComponent(item:XML, titleTxAtlas:TextureAtlas)
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
		}
		
		private function onReduceNum(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(downBtn);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				if(buyNum > allNum)	buyNum -= allNum;
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
					buyNum += allNum;
					
					if(judgeRecharge()) buyNum -= allNum;
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
			if((buyNum * rechargeCount / allNum) > player.money)
			{
				View.instance.tip.interfaces(InterfaceTypes.Show, 
					"金钱不足！",
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
				var info:String = "";
				if(!judgeRecharge())
				{
					totalMoney = rechargeCount * buyNum / allNum;
					info += "你购买了" + buyNum + "个，总共需要花费" + totalMoney + "金钱\n\n";
					if(_propID == 43)
						info += "(当前有" + _propType.name.split("（")[0] + Data.instance.shop.getPropNum(_propID).toString() + "个，上限为1个)";
					else if(_propID == 49)
						info += "(当前有" + _propType.name.split("（")[0] + Data.instance.shop.getPropNum(_propID).toString() + "个，上限为999个)";
					else
						info += "(当前有" + _propType.name.split("（")[0] + Data.instance.shop.getPropNum(_propID).toString() + "个，上限为99个)";
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
			player.money -= totalMoney;
			//添加道具
			Data.instance.shop.addPropNum(_propID, buyNum);
			
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
			_view.vip_shop.resetGoldAndSoul();
			_view.vip_shop.interfaces(InterfaceTypes.REFRESH);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
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
			allNum = _propType.number;
			buyNum = _propType.number;
			rechargeCount = _propType.gold;
			sellNum.text = rechargeCount + "金钱";
			beforeNum.text = _propType.gold_before + "金钱";
			
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
			
			if(!_input) _input = addText(135, 40, 30, 30, allNum.toString());
			if(allNum >= 50)
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
				buyNum = allNum;
				_input.text = buyNum.toString();
			}
			else if(buyNum != allNum && judgeRecharge())
			{
				buyNum = player.money / rechargeCount;
				if(buyNum >= 99 || (buyNum + Data.instance.shop.getPropNum(_propID)) > 99)
				{
					buyNum = 99 - Data.instance.shop.getPropNum(_propID);
				}
				else if(buyNum == 0)
				{
					buyNum = allNum;
				}
				_input.text = buyNum.toString();
			}
		}
		
		public function reset() : void
		{
			buyNum = allNum;
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
			return new VipGoldShopComponent(_configXML, _titleTxAtlas);
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
			/*_propTip.dispose();
			_propTip = null*/
		}
	}
}
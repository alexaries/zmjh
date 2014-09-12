package com.game.view.vip
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.DataList;
	import com.game.manager.DebugManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.effect.TweenEffect;
	import com.game.view.equip.PropTip;
	import com.game.view.ui.UIConfig;
	
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class VIPView extends BaseView implements IView
	{
		private var _anti:Antiwear;
		private function get preRecharged() : int
		{
			return _anti["preRecharged"];
		}
		private function set preRecharged(value:int) : void
		{
			_anti["preRecharged"] = value;
		}
		private function get preLevel() : int
		{
			return _anti["preLevel"];
		}
		private function set preLevel(value:int) : void
		{
			_anti["preLevel"] = value;
		}
		public function VIPView()
		{
			_moduleName = V.VIP;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.VIP;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["preRecharged"] = 0;
			
			super();
		}
		
		public function interfaces(type:String="", ...args):*
		{
			if (type == "") type = InterfaceTypes.Show;
			Log.Trace("VipView" + type + "-----" + args);
			
			switch (type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
			}
		}
		
		override protected function init() : void
		{
			if(!isInit)
			{
				super.init();
				
				initXML();
				initTexture();
				initComponent();
				initUI();
				getUI();
				initEvent();
				isInit = true;
			}
			
			getRecharged();
			
			_view.layer.setCenter(panel);
		}
		
		private function preRender():void
		{
			preRecharged = player.vipInfo.nowRecharged;
			preLevel = player.vipInfo.nowVIPLevel;
			_vipLevel.text = "VIP" + player.vipInfo.nowVIPLevel.toString();
			
			//达到VIP5级
			if(preLevel == 5)
			{
				_expBar.width = 346;
				_needRecharged.text = "";
			}
			else
			{
				_expBar.width = preRecharged / (player.vipInfo.levelList[preLevel] * DataList.list[1000]) * 346;
				_needRecharged.text = "再充值" + (player.vipInfo.levelList[preLevel] * DataList.list[1000] - preRecharged) + "点券您将成为VIP" + (preLevel + 1);
			}
			_barPoint.x = _expBar.x + _expBar.width - _barPoint.width * .5;
		}
		
		private function render():void
		{
			_view.addToFrameProcessList("setPosition", setPosition);
			renderButton();
			renderTF();
			renderEffect();
		}
		
		private function renderEffect() : void
		{
			renderImage();
			this.panel.touchable = false;
			_vipLevel.text = "VIP" + preLevel;
			if(preLevel < player.vipInfo.nowVIPLevel)
			{
				_tweenEffect.setStart(_expBar, "width", 346, (346 - _expBar.width) / 346 * 2,
					function() : void{
						_view.prompEffect.play("恭喜您升到VIP" + preLevel);
						if(preLevel != 5)
						{
							_expBar.width = 0;
							renderEffect();
						}
						else
							endLevel();
					});
				preLevel++;
			}
			else if(preLevel == player.vipInfo.nowVIPLevel)
			{
				if(preLevel == 5)
					endLevel();
				else
				{
					if(preRecharged == player.vipInfo.nowRecharged)
						endLevel();
					else
						_tweenEffect.setStart(_expBar, "width", player.vipInfo.nowRecharged / (player.vipInfo.levelList[player.vipInfo.nowVIPLevel] * DataList.list[1000]) * 346, 1, endLevel);
				}
			}
		}
		
		private function endLevel() : void
		{
			renderImage();
			this.panel.touchable = true;
			_view.removeFromFrameProcessList("setPosition");
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.checkVip();
			if(player.vipInfo.nowVIPLevel == 5)
			{
				_vipLevel.text = "VIP" + player.vipInfo.nowVIPLevel.toString();
				_expBar.width = 346;
				_barPoint.x = _expBar.x + 346 - _barPoint.width * .5;
			}
		}
		
		private function setPosition() : void
		{
			_barPoint.x = _expBar.x + _expBar.width - _barPoint.width * .5;
		}
		
		private function renderTF() : void
		{
			//_vipLevel.text = "VIP" + player.vipInfo.nowVIPLevel.toString();
			if(player.vipInfo.nowVIPLevel == 5)
				_needRecharged.text = "";
			else
				_needRecharged.text = "再充值" + (player.vipInfo.levelList[player.vipInfo.nowVIPLevel] * DataList.list[1000] - player.vipInfo.nowRecharged) + "点券您将成为VIP" + (player.vipInfo.nowVIPLevel + 1);
		}
		
		private function renderImage():void
		{
			for(var i:int = 1; i <= 14; i++)
			{
				removeTouchable(this.searchOf("VipImage_" + i) as Image);
				if(int((i + 2) / 3) <= preLevel)
					addTouchable(this.searchOf("VipImage_" + i) as Image);
			}
			for(var j:int = 1; j <=5; j++)
			{
				removeTouchable(this.searchOf("VipLevel_" + j) as Image);
				if(j <= preLevel)
					addTouchable(this.searchOf("VipLevel_" + j) as Image);
			}
			
			if(player.vipInfo.checkLevelTwo())
				addTouchable(_vipShowBtn);
			else
				removeTouchable(_vipShowBtn);
		}
		
		private function renderButton():void
		{
			
		}
		
		private var _positionXML:XML;
		private var _infoData:Vector.<Object>;
		private function initXML():void
		{
			_positionXML = getXMLData(_moduleName, GameConfig.VIP_RES, "VipPosition");
			if(_infoData == null)
			{
				_infoData = new Vector.<Object>();
				_infoData = Data.instance.db.interfaces(InterfaceTypes.GET_VIP_INFO_DATA);
			}
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture():void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(_moduleName, GameConfig.VIP_RES, "Vip");			
				obj = getAssetsObject(_moduleName, GameConfig.VIP_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
			}
		}
		
		private function initComponent():void
		{
			var name:String;
			var cp:Component;
			var layerName:String;
			for each(var items:XML in _positionXML.component.Items)
			{
				name = items.@name;
				if (!this.checkInComponent(name))
				{
					switch (name)
					{
						
					}
				}
			}
		}
		
		private function initUI():void
		{
			var name:String;
			var obj:*;
			var layerName:String;
			for each(var items:XML in _positionXML.layer)
			{
				layerName = items.@layerName;
				for each(var element:XML in items.item)
				{
					name = element.@name;
					
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						obj["layerName"] = layerName;
						_uiLibrary.push(obj);
					}
				}
			}
		}
		
		private var _getLogin:Image;
		private var _vipBtn_1:Image;
		private var _vipBtn_2:Image;
		private var _vipBtn_3:Image;
		private var _expBar:Image;
		private var _barPoint:Image;
		private var _vipLevel:TextField;
		private var _needRecharged:TextField;
		private var _tweenEffect:TweenEffect;
		private var _pointEffect:TweenEffect;
		private var _propTip:PropTip;
		private var _nowPer:TextField;
		private var _vipShowBtn:Image;
		private function getUI():void
		{
			_getLogin = this.searchOf("VipImage_1") as Image;
			_vipBtn_1 = this.searchOf("VipImage_5") as Image;
			_vipBtn_2 = this.searchOf("VipImage_9") as Image;
			_vipBtn_3 = this.searchOf("VipImage_10") as Image;
			_vipShowBtn = this.searchOf("VipImage_15") as Image;
			
			_getLogin.addEventListener(TouchEvent.TOUCH, onGetLogin);
			_vipBtn_1.addEventListener(TouchEvent.TOUCH, onGotoVip_1);
			_vipBtn_2.addEventListener(TouchEvent.TOUCH, onGotoVip_2);
			_vipBtn_3.addEventListener(TouchEvent.TOUCH, onGotoVip_3);
			_vipShowBtn.addEventListener(TouchEvent.TOUCH, onGotoVip_4);
			
			_expBar = this.searchOf("ExpBar") as Image;
			_barPoint = this.searchOf("ExpPoint") as Image;
			_vipLevel = this.searchOf("NowVipLevel") as TextField;
			_needRecharged = this.searchOf("NeedRecharged") as TextField;
			_tweenEffect = new TweenEffect();
			_pointEffect = new TweenEffect();
			_nowPer = this.searchOf("NowPer");
			
			initRender();
		}
		
		private function initRender():void
		{
			_propTip = _view.ui.interfaces(UIConfig.PROP_TIP);
			for(var i:int = 1; i < 15; i++)
			{
				var count:int = (i - 1) % 3 + 1;
				_propTip.add({o:searchOf("VipImage_" + i), m:{name:"", message:_infoData[int((i - 1) / 3)]["info_" + count]}}); 
			}
		}
		
		private function onGetLogin(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_getLogin);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				if(player.vipInfo.checkAlreadyGet())
				{
					Data.instance.prop_data.checkData("0|1|2|3", "80|4|4|4", getReward);
				}
				else
				{
					_view.tip.interfaces(InterfaceTypes.Show, 
						"今日已领取过登录礼包！",
						null, null, false, true, false);
				}
			}
		}
		
		private function getReward(info:String) : void
		{
			Data.instance.player.player.money += DataList.list[4] * DataList.list[1000];
			Data.instance.player.player.fight_soul += DataList.list[4] * DataList.list[1000];
			
			_view.tip.interfaces(InterfaceTypes.Show,
				"恭喜你获得骰子×80、如意骰子×4、满汉全席×4、雪山人参×4、金钱×4000、战魂×4000。",
				null, null, false, true, false);
			player.vipInfo.alreadyGet = 1;
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
		
		private function onGotoVip_1(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_vipBtn_1);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				this.hide();
				_view.vip_shop.interfaces(InterfaceTypes.Show, 0);
			}
		}
		
		private function onGotoVip_4(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_vipShowBtn);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				this.hide();
				_view.vip_shop.interfaces(InterfaceTypes.Show, 0);
			}
		}
		
		private function onGotoVip_2(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_vipBtn_2);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				this.hide();
				_view.vip_shop.interfaces(InterfaceTypes.Show, 1);
			}
		}
		
		private function onGotoVip_3(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_vipBtn_3);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				this.hide();
				_view.vip_shop.interfaces(InterfaceTypes.Show, 2);
			}
		}
		
		private function getRecharged() : void
		{
			preRender();
			if(DebugManager.instance.gameMode == V.DEVELOP)
			{
				getSuccess("50000");
				return;
			}
			
			if(player.vipInfo.nowVIPLevel < 5)
			{
				_view.loadData.loadDataPlay();
				Data.instance.pay.getTotalRecharged(getSuccess, getRecharged);
			}
			else
				getSuccess("50000");
		}
		
		private function getSuccess(info:String) : void
		{
			_view.loadData.hide();
			player.vipInfo.nowRecharged = int(info);
			if(player.vipInfo.nowVIPLevel == 5)
			{
				if(!player.roleTitleInfo.checkTitle(V.ROLE_NAME[4]))
				{
					player.roleTitleInfo.addNewTitle(V.ROLE_NAME[4]);
					player.mainRoleModel.beginCount();
				}
				_nowPer.text = "50000/50000";
			}
			else
				_nowPer.text = info + "/" + player.vipInfo.levelList[player.vipInfo.nowVIPLevel] * DataList.list[1000];
			if(preLevel != 5)
				render();
			else
				renderImage();
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "Close":
					this.hide();
					break;
				case "Recharge":
					Data.instance.pay.payMoney(300, null);
					break;
			}
		}
		
		override public function hide() : void
		{
			super.hide();
			_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
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
	}
}
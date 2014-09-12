package com.game.view.vip
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.ui.controls.ComponentGrid;
	import com.engine.ui.controls.TabBar;
	import com.game.Data;
	import com.game.data.player.structure.PropModel;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.Role.ChangePageComponent;
	import com.game.view.ViewEventBind;
	import com.game.view.shop.ShopComponent;
	
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class VipShopView extends BaseView implements IView
	{
		private var _anti:Antiwear;
		public function get rechargeNum() : int
		{
			return _anti["_rechargeNum"];
		}
		
		public function set rechargeNum(value:int) : void
		{
			_anti["_rechargeNum"] = value;
		}
		
		private var _nowTab:int;
		
		private var _curPosition:int;
		private var _propID:int;
		private var _propModel:*;
		
		public function VipShopView()
		{
			_moduleName = V.VIP_SHOP;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.SHOP;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["rechargeNum"] = 0;
			
			super();
		}
		
		public function interfaces(type:String="", ...args):*
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_curPosition = 0;
					_loadBaseName = V.SHOP;
					_nowTab = (args.length == 1?args[0]:0);
					this.show();
					break;
				case InterfaceTypes.GetTexture:
					return getTexture(args[0], "");
					break;
				case InterfaceTypes.GetTextures:
					return getTextures(args[0], "");
					break;
				case InterfaceTypes.REFRESH:
					onRefresh();
					break;
				case InterfaceTypes.GET_MALL:
					_curPosition = 1;
					_loadBaseName = V.SHOP;
					_propID = args[0];
					_propModel = args[1];
					this.show();
					break;
			}
		}
		
		private function onRefresh() : void
		{
			var len:int = _componentList.length;
			for(var i:int = 0; i < len; i++)
			{
				if(_componentList[i] is VipShopComponent)
					(_componentList[i] as VipShopComponent).reset();
				else if(_componentList[i] is VipGoldShopComponent)
					(_componentList[i] as VipGoldShopComponent).reset();
			}
		}
		
		override protected function init() : void
		{
			if(!this.isInit)
			{
				super.init();
				this.isInit = true;
				initXML();
				initTextures();
				initComponent();
				initUI();
				getUI();
				initEvent();
			}
			_view.loadData.loadDataPlay();
			render();
			renderData();
			renderBar();
			onRefresh();
			resetGoldAndSoul()
			_view.layer.setCenter(panel);
			_view.layer.addTipChildAt(panel, "");
			
			checkStatus();
		}
		
		/**
		 * 商城大界面和小界面的切换
		 * 
		 */		
		private function checkStatus() : void
		{
			var targetXML:XML = new XML();
			targetXML = _positionXML.layer[_curPosition];
			
			resetPosition(targetXML);
			
			for each(var item:* in _uiLibrary)
			{
				if (item is starling.display.DisplayObject) item.visible = false;
				else if (item is Component) (item as Component).panel.visible = false;
			}
			
			seStatusOfXML(targetXML, true);
			
			if(_curPosition == 0)
			{
				_shopGird_1.visible = true;
				_shopGird_2.visible = true;
				_shopGird_3.visible = true;
				_shopGird_4.visible = true;
				_shopTipMask.visible = false;
				checkProp(_nowTab);
			}
			else
			{
				_singleShop.setGridData([_propID, _propModel]);
				_singleShop.setMask();
				_shopTipMask.visible = true;
			}
			
		}
		
		private function renderBar():void
		{
			_tabBar.selectIndex = TABS.indexOf(TABS[_nowTab]);
		}
		
		private function render() : void
		{
			renderButton();
		}
		
		private function renderButton() : void
		{
			for(var i:int = 1; i <= 4; i++)
			{
				removeTouchable(this["_vipSelect_" + i]);
			}
			if(player.vipInfo.checkLevelTwo())
				addTouchable(_vipSelect_1);
			if(player.vipInfo.checkLevelThree())
				addTouchable(_vipSelect_2);
			if(player.vipInfo.checkLevelFour())
				addTouchable(_vipSelect_3);
			if(player.vipInfo.checkLevelFive())
				addTouchable(_vipSelect_4);
		}
		
		private var _positionXML:XML;
		private var _propData:Vector.<Object>;
		private var _propInformation:Object;
		private function initXML():void
		{
			if(!_positionXML) _positionXML = getXMLData(V.SHOP, GameConfig.SHOP_RES, "VipShopPosition");
			if(!_propData) _propData = Data.instance.db.interfaces(InterfaceTypes.GET_VIP_MALL_DATA);
			if(!_propInformation) _propInformation = Data.instance.db.interfaces(InterfaceTypes.GET_PROP_DATA);
		}
		
		public function propInformation() : Object
		{
			return _propInformation;
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTextures():void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				
				var textureXML:XML = getXMLData(V.SHOP, GameConfig.SHOP_RES, "Shop");
				obj = getAssetsObject(V.SHOP, GameConfig.SHOP_RES, "Textures");
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
						case "BuyComponent":
							cp = new VipShopComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "GoldBuyComponent":
							cp = new VipGoldShopComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "MoonCakeComponent":
							cp = new MoonCakeComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "ChangePage":
							cp = new ChangePageComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
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
		
		private var _vipSelect_1:MovieClip;
		private var _vipSelect_2:MovieClip;
		private var _vipSelect_3:MovieClip;
		private var _vipSelect_4:MovieClip;
		private var _changePage_1:ChangePageComponent;
		private var _changePage_2:ChangePageComponent;
		private var _changePage_3:ChangePageComponent;
		private var _changePage_4:ChangePageComponent;
		private var _shopGird_1:ComponentGrid;
		private var _shopGird_2:ComponentGrid;
		private var _shopGird_3:ComponentGrid;
		private var _shopGird_4:ComponentGrid;
		private var _tabBar:TabBar;
		private var _curTab:String;
		public static const TABS:Array = ["vip1", "vip2", "vip3", "vip4"];
		private var _rechargeNumText:TextField;
		private var _singleShop:MoonCakeComponent;
		private var _shopTipMask:Image;
		private var _goldTF:TextField;
		private var _soulTF:TextField;
		private function getUI():void
		{
			for(var i:int = 1; i <= 4; i++)
			{
				this["_vipSelect_" + i] = this.searchOf("Vip_Select_" + i) as MovieClip;
				this["_changePage_" + i] = this.searchOf("VipChangePageList_" + i) as ChangePageComponent;
			}
			
			setPropData();
			
			var arr:Array = [_vipSelect_1, _vipSelect_2, _vipSelect_3, _vipSelect_4];
			_tabBar = new TabBar(arr);
			_tabBar.addEventListener(TabBar.TYPE_SELECT_CHANGE, onTabChange);
			_tabBar.selectIndex = TABS.indexOf(TABS[0]);
			
			_rechargeNumText = this.searchOf("RechargeNum");
			_singleShop = this.searchOf("SingleShop") as MoonCakeComponent;
			
			_goldTF = this.searchOf("GoldDetail");
			_soulTF = this.searchOf("SoulDetail");
			
			createSingleMask();
		}
		
		private function createSingleMask() : void
		{
			var maskTexture:Texture = Texture.fromColor(GameConfig.CAMERA_WIDTH + 10, GameConfig.CAMERA_HEIGHT + 10, 0xff000000);
			_shopTipMask = new Image(maskTexture);
			_shopTipMask.alpha = 0.4;
			this.panel.addChildAt(_shopTipMask, (panel.getChildIndex(_singleShop.panel) - 2));
			_shopTipMask.visible = false;
		}
		
		private var _componentList:Vector.<Component>;
		private function setPropData() : void
		{
			_componentList = new Vector.<Component>();
			var componentData:Vector.<Object> = new Vector.<Object>();
			var componentList:Vector.<Component> = new Vector.<Component>();
			var component:Component;
			for(var i:int = 1; i <= 4; i++)
			{
				componentData = new Vector.<Object>();
				componentList = new Vector.<Component>();
				for(var j:int = 0; j < _propData.length; j++)
				{
					if(_propData[j].vip_type == (i + 1))
					{
						componentData.push(_propData[j]);
						
						if(_propData[j].gold == 0)
							component = createComponentItem("BuyComponent", ("BuyItem" + j).toString());
						else
							component = createComponentItem("GoldBuyComponent", ("BuyItem" + j).toString());
						componentList.push(component);
						_componentList.push(component);
					}
				}
				
				//componentData.reverse();
				
				if(!this["_shopGird_" + i])
				{
					this["_shopGird_" + i] = new ComponentGrid(componentList, 3, 3, 150, 65, 100, 40);
					this["_shopGird_" + i]["layerName"] = "ShopBar";
					this["_shopGird_" + i].x = 120;
					this["_shopGird_" + i].y = 190;
					panel.addChild(this["_shopGird_" + i]);
					_uiLibrary.push(this["_shopGird_" + i]);
				}
				this["_shopGird_" + i].setData(componentData, this["_changePage_" + i]);
			}
		}
		
		private function onTabChange(e:Event) : void
		{
			_curTab = TABS[e.data as int];
			checkProp(e.data as int);
			renderButton();
		}
		
		private function checkProp(count:int) : void
		{
			for(var i:int = 1; i <= 4; i++)
			{
				(this["_changePage_" + i] as ChangePageComponent).panel.visible = false;
				(this["_shopGird_" + i] as ComponentGrid).visible = false;
			}
			(this["_changePage_" + (count + 1)] as ChangePageComponent).panel.visible = true;
			(this["_shopGird_" + (count + 1)] as ComponentGrid).visible = true;
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					break;
				case "Recharge":
					Data.instance.pay.payMoney(300, renderData);
					//Data.instance.pay.addMoney(1000);
					break;
				case "CloseSingle":
					this.hide();
					_singleShop.clear();
					_view.layer.setTipMaskShow();
					_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
					break;
			}
		}
		
		public function renderData() : void
		{
			Data.instance.pay.getBalance(renderText, renderData);
		}
		
		private function renderText(str:String) : void
		{
			rechargeNum = int(str);
			_rechargeNumText.text = "点券：" + rechargeNum.toString();
			_view.loadData.hide();
		}
		
		public function resetText(str:String) : void
		{
			rechargeNum = int(str);
			_rechargeNumText.text = "点券：" + rechargeNum.toString();
		}
		
		public function resetGoldAndSoul() : void
		{
			_goldTF.text = player.money.toString();
			_soulTF.text = player.fight_soul.toString();
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
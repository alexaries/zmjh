package com.game.view.shop
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.ui.controls.ComponentGrid;
	import com.engine.ui.controls.Grid;
	import com.engine.ui.controls.TabBar;
	import com.game.Data;
	import com.game.data.db.protocal.Mall;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.Role.ChangePageComponent;
	import com.game.view.ViewEventBind;
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class ShopView extends BaseView implements IView
	{
		public static const TABS:Array = ["allProp", "newProp"];
		public static const ALLPROP:String = "allProp";
		public static const NEWPROP:String = "newProp";
		private var _curTab:String;
		private var _anti:Antiwear;
		
		private var _positionXML:XML;
		private var _curPosition:int;
		/**
		 * 纹理 
		 */		
		private var _titleTxAtlas:TextureAtlas;
		
		public var delayFun:Boolean = false;
		
		public function get rechargeNum() : int
		{
			return _anti["_rechargeNum"];
		}
		
		public function set rechargeNum(value:int) : void
		{
			_anti["_rechargeNum"] = value;
		}
		
		private function get nationalDayTime() : String
		{
			return _anti["nationalDayTime"];
		}
		
		private var refresh:Boolean = false;
		
		private var _propName:String;
		
		private var _callback:Function;
		
		public function ShopView()
		{
			_moduleName = V.SHOP;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.SHOP;
			
			_anti = new Antiwear(new binaryEncrypt());
			rechargeNum = 0;
			_anti["nationalDayTime"] = "2013-09-29";
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_curPosition = 0;
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
					_propName = args[0];
					_callback = args[1];
					this.show();
					break;
			}
		}
		
		public function getTitleTxAtlas() : TextureAtlas
		{
			return this._titleTxAtlas;
		}
		
		override protected function init() : void
		{
			_view.loadData.loadDataPlay();
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
			renderData();
			onRefresh();
			_view.layer.setCenter(panel);
			_view.layer.addTipChildAt(panel, "");
			
			checkStatus();
		}
		
		private function onRefresh() : void
		{
			for(var i:int; i < _componentData.length; i++)
			{
				(_componentList[i] as ShopComponent).reset();
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
					break;
				case "CloseSingle":
					this.hide();
					_singleShop.reset();
					_view.layer.setTipMaskShow();
					_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
					if(_callback != null) _callback();
					break;
			}
		}
		
		private var _propData:Object;
		private var _propInformation:Object;
		private var _infomationXML:XML;
		private function initXML() : void
		{
			if(!_positionXML) _positionXML = getXMLData(V.SHOP, GameConfig.SHOP_RES, "ShopPosition");
			
			if(!_propData) _propData = Data.instance.db.interfaces(InterfaceTypes.GET_MALL);
			
			if(!_propInformation) _propInformation = Data.instance.db.interfaces(InterfaceTypes.GET_PROP_DATA);
		}
		
		public function propInformation() : Object
		{
			return _propInformation;
		}
		
		private function initTextures() : void
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
		
		private function initComponent() : void
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
							cp = new ShopComponent(items, _titleTxAtlas);
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
		
		private function initUI() : void
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
		
		private var _tabBar:TabBar;
		private var _rechargeNumText:TextField;
		private var _rechargeBtn:Button;
		
		private var _componentList:Vector.<Component>;
		private var _componentData:Vector.<Object>;
		private var _shopPageComponent:ChangePageComponent;
		private var _shopGrid:ComponentGrid;
		
		private var _newComponentList:Vector.<Component>;
		private var _newComponentData:Vector.<Object>;
		private var _newPageComponent:ChangePageComponent;
		private var _newGrid:ComponentGrid;
		
		private var _singleShop:ShopComponent;
		private var _shopTipMask:Image;
		private var _nationalTitle:Image;
		private function getUI() : void
		{
			//(searchOf("Prop_Select") as MovieClip).visible = false
			
			_rechargeNumText = searchOf("RechargeNum");
			
			_rechargeBtn = searchOf("Recharge");
			_rechargeBtn.addEventListener(TouchEvent.TOUCH, onChargeLink);
			
			_shopPageComponent = this.searchOf("ShopChangePageList");
			_newPageComponent = this.searchOf("NewChangePageList");
			_fashionPageComponent = this.searchOf("FashionChangePageList");
			
			setPropData();
			
			var arr:Array = [searchOf("All_Select"), searchOf("Prop_Select"), searchOf("Fashion_Select")];
			_tabBar = new TabBar(arr);
			_tabBar.addEventListener(TabBar.TYPE_SELECT_CHANGE, onTabChange);
			_curTab = ALLPROP;
			_tabBar.selectIndex = TABS.indexOf(_curTab);
			
			_singleShop = this.searchOf("SingleShop");
			
			_nationalTitle = this.searchOf("NationalTitle");
			
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
		
		
		private function setPropData() : void
		{
			setAllProp();
			setNewProp();
			setFashionProp();
		}
		
		private function setAllProp() : void
		{
			_componentData = new Vector.<Object>();
			_componentList = new Vector.<Component>();
			
			for(var i:int = 0; i < _propData.length; i++)
			{
				_componentData.push(_propData[i]);
				_componentList.push(createComponentItem("BuyComponent", ("BuyItem" + i).toString()));
			}
			
			_componentData.reverse();
			
			if(!_shopGrid)
			{
				_shopGrid = new ComponentGrid(_componentList, 3, 3, 150, 65, 100, 40);
				_shopGrid["layerName"] = "ShopBar";
				_shopGrid.x = 120;
				_shopGrid.y = 190;
				panel.addChild(_shopGrid);
				_uiLibrary.push(_shopGrid);
			}
			_shopGrid.setData(_componentData, _shopPageComponent);
		}
		
		private function setNewProp() : void
		{
			_newComponentData = new Vector.<Object>();
			_newComponentList = new Vector.<Component>();
			
			for(var i:int = 0; i < _propData.length; i++)
			{
				if(_propData[i].recommend == 1)
				{
					_newComponentData.push(_propData[i]);
					_newComponentList.push(createComponentItem("BuyComponent", ("BuyItem" + i).toString()));
				}
			}
			
			_newComponentData.reverse();
			
			if(!_newGrid)
			{
				_newGrid = new ComponentGrid(_newComponentList, 3, 3, 150, 65, 100, 40);
				_newGrid["layerName"] = "ShopBar";
				_newGrid.x = 120;
				_newGrid.y = 190;
				panel.addChild(_newGrid);
				_uiLibrary.push(_newGrid);
			}
			_newGrid.setData(_newComponentData, _newPageComponent);
		}
		
		private var _fashionComponentList:Vector.<Component>;
		private var _fashionComponentData:Vector.<Object>;
		private var _fashionPageComponent:ChangePageComponent;
		private var _fashionGrid:ComponentGrid;
		private function setFashionProp() : void
		{
			_fashionComponentData = new Vector.<Object>();
			_fashionComponentList = new Vector.<Component>();
			
			for(var i:int = 0; i < _propData.length; i++)
			{
				if(_propData[i].type == 2)
				{
					_fashionComponentData.push(_propData[i]);
					_fashionComponentList.push(createComponentItem("BuyComponent", ("BuyItem" + i).toString()));
				}
			}
			
			_fashionComponentData.reverse();
			
			if(!_fashionGrid)
			{
				_fashionGrid = new ComponentGrid(_fashionComponentList, 3, 3, 150, 65, 100, 40);
				_fashionGrid["layerName"] = "ShopBar";
				_fashionGrid.x = 120;
				_fashionGrid.y = 190;
				panel.addChild(_fashionGrid);
				_uiLibrary.push(_fashionGrid);
			}
			_fashionGrid.setData(_fashionComponentData, _fashionPageComponent);
		}
		
		/**
		 * 充值功能
		 * @param e
		 * 
		 */		
		private function onChargeLink(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_rechargeBtn);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				Data.instance.pay.payMoney(300, renderData);
				//Data.instance.pay.addMoney(0);
			}
		}
		
		private function onTabChange(e:Event) : void
		{
			_curTab = TABS[e.data as int];
			checkProp();
		}
		
		private function checkProp() : void
		{
			if(_curTab == ALLPROP)
			{
				_shopPageComponent.panel.visible = true;
				_shopGrid.visible = true;
				_newPageComponent.panel.visible = false;
				_newGrid.visible = false;
				_fashionPageComponent.panel.visible = false;
				_fashionGrid.visible = false;
			}
			else if(_curTab == NEWPROP)
			{
				_shopPageComponent.panel.visible = false;
				_shopGrid.visible = false;
				_newPageComponent.panel.visible = true;
				_newGrid.visible = true;
				_fashionPageComponent.panel.visible = false;
				_fashionGrid.visible = false;
			}
			else
			{
				_shopPageComponent.panel.visible = false;
				_shopGrid.visible = false;
				_newPageComponent.panel.visible = false;
				_newGrid.visible = false;
				_fashionPageComponent.panel.visible = true;
				_fashionGrid.visible = true;
			}
		}
		
		/**
		 * 获得当前剩余游戏币
		 * 
		 */		
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
				_shopGrid.visible = true;
				_newGrid.visible = true;
				_shopTipMask.visible = false;
				checkProp();
				checkShowImage();
			}
			else
			{
				_singleShop.setGridData(getPropByName(_propName));
				_singleShop.setMask();
				_shopTipMask.visible = true;
			}
			
		}
		
		private function checkShowImage():void
		{
			var intervalTime:int = Data.instance.time.disDayNum(nationalDayTime, Data.instance.time.curTimeStr.split(" ")[0]);
			
			if(intervalTime > 8)
			{
				_nationalTitle.visible = false;
			}
			else
				_nationalTitle.visible = true;
		}
		
		private function getPropByName(str:String) : Mall
		{
			var mall:Mall;
			for each(var item:Mall in _propData)
			{
				if(item.name == str)
				{
					mall = item;
					break;
				}
			}
			return mall;
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
		
		override public function resetView() : void
		{
			_callback = null;
			_shopGrid = null;
			_newGrid = null;
		}
	}
}
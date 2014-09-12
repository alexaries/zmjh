package com.game.view.LevelEvent
{
	import com.game.Data;
	import com.game.data.db.protocal.Item_disposition;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.PropModel;
	import com.game.manager.LayerManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.ui.Keyboard;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.MovieClip;
	import starling.events.KeyboardEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class OpenItemBoxView extends BaseView implements IView
	{
		// 当前关卡
		private var _curLevel:String;
		public function get curLevel() : String
		{
			return _curLevel;
		}
		
		// 当前关卡难易度
		private var _curDifficult:int;
		public function get curDifficult() : int
		{
			return _curDifficult;
		}
		
		// 当前宝箱类型
		private var _curType:String;
		public function get curType() : String
		{
			return _curType;
		}
		
		// 当前关卡掉落概率
		private var _itemDispose:Item_disposition;
		public function get itemDispose() : Item_disposition
		{
			return _itemDispose;
		}
		
		private var _data:Data = Data.instance;
		
		public function OpenItemBoxView()
		{
			_moduleName = V.OPEN_ITEM_BOX;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			_view.icon.interfaces();
			
			if (type == "") type = InterfaceTypes.Show;
			switch (type)
			{
				case InterfaceTypes.Show:
					_curLevel = args[0];
					_curType = args[1];
					_curDifficult = args[2];
					this.show();
					LayerManager.instance.gpu_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
					break;
				case InterfaceTypes.ITEM_SELECTED:
					onItemSelected(args[0], args[1], args[2]);
					break;
				case InterfaceTypes.LOCK:
					this.panel.touchable=false;
					break;
			}
		}
		
		/**
		 * 已选择卡牌 
		 * @param selectedName
		 * 
		 */
		private var _info:String;
		protected function onItemSelected(selectedName:String, data:*, type:String) : void
		{
			var targetButton:ItemComponent = this.searchOf(selectedName);
			_getItemBtn.x = targetButton.panel.x - 18;
			_getItemBtn.visible = true;
				
			
			switch (type)
			{
				// 金钱
				case V.MONEY_ITEMBOX:
					var money:int = data;
					player.money += money;
					_info = "获得" + money + "金币";
					break;
				// 装备
				case V.EQUIP_ITEMBOX:
					var equipModel:EquipModel = data as EquipModel;
					_view.controller.pack.addEquipment(equipModel);
					_info = "获得装备" + equipModel.config.name;
					break;
				// 道具
				case V.PROP_ITEMBOX:
					var propModel:PropModel = data as PropModel;
					_view.controller.pack.addProp(propModel);
					_info = "获得道具" + propModel.config.name;
					break;
			}
			
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			initRender("FrontSence");
			
			_view.weather.setSun();
			
			/*if(_view.map.autoLevel) 
			{
				//_view.prompEffect.play(_info);
				_view.map.fightCount++;
				_view.auto_fight.addContent("第" + _view.map.fightCount + "波\n");
				_view.auto_fight.addContent(_info + "\n\n");
				this.hide();
				_view.map.skipLevel();
			}*/
			
			if(_view.first_guide.isGuide)
			{
				_view.first_guide.setFunc();
			}
			this.panel.touchable=true;
		}
		
		override protected function init() : void
		{
			getData();
			
			if (!isInit)
			{
				isInit = true;
				super.init();

				initXML();
				initTexture();
				initComponent();
				initUI();
				initEvent();
				initBeginEvent();
				
			}
			
			getUI();
			getRandomData();
			initRender("BackSence");
			selectItem();
			
			if(_view.first_guide.isGuide)
				_view.first_guide.setFunc();
		}
		
		
		
		private function onKeyDowns(e:KeyboardEvent) : void
		{
			if(!_getItemBtn.visible && this.panel.touchable){
				switch(e.keyCode)  
				{
					case Keyboard.NUMBER_1:
						onItemSelected("Card1",_items[0], _curType)
						break;
					case Keyboard.NUMBER_2:
						onItemSelected("Card2",_items[1], _curType)
						break;
					case Keyboard.NUMBER_3:
						onItemSelected("Card3",_items[2], _curType)
						break;
					case Keyboard.NUMBER_4:
						onItemSelected("Card4",_items[3], _curType)
						break;
					case Keyboard.NUMBER_5:
						onItemSelected("Card5",_items[4], _curType)
						break;
				}
			}else if(e.keyCode==Keyboard.SPACE && this.panel.touchable){
				getItem();
			}
	

		}
		
		// 获取当前关卡数据
		private function getData() : void
		{
			if (!_curLevel) throw new Error("错误的关卡 打开宝箱");
			
			_view.controller.db.getItemDisposition(
				_curLevel,
				_curDifficult,
				function (data:Item_disposition) : void
				{
					_itemDispose = data;
				});
		}
		
		private var _items:*;
		private function getRandomData() : void
		{
			switch (_curType)
			{
				case V.MONEY_ITEMBOX:
					_boxType.currentFrame = _world.currentFrame = 0;
					_items = ItemBoxUititlies.getGoldItems(_itemDispose);
					break;
				case V.EQUIP_ITEMBOX:
					_boxType.currentFrame = _world.currentFrame = 1;
					_items = ItemBoxUititlies.getEquipItems(_itemDispose);
					break;
				case V.PROP_ITEMBOX:
					_boxType.currentFrame = _world.currentFrame = 2;
					_items = ItemBoxUititlies.getPropItems(_itemDispose);
					break;
			}
			
			if (!_items) throw new Error("错误 打开宝箱");
		}
		
		private var itemList:Vector.<ItemComponent>;
		// 开始选择
		protected function initRender(layer:String) : void
		{
			itemList = new Vector.<ItemComponent>();
			for(var i:int = 0; i <　_uiLibrary.length; i++)
			{
				if (_uiLibrary[i] is ItemComponent)
				{
					var name:String = (_uiLibrary[i] as ItemComponent).name;
					var index:int = ItemBoxUititlies.getBoxIndex(name);
					(_uiLibrary[i] as ItemComponent).setReward(_items[index], _curType);
					(_uiLibrary[i] as ItemComponent).setStatus(layer);
					itemList.push(_uiLibrary[i]);
				}
			}
			
			this.display();
			
		}
		
		/**
		 * 选择翻牌
		 * 
		 */		
		private function selectItem() : void
		{
			/*if(_view.map.autoLevel)
			{
				var count:int = Math.floor(Math.random() * itemList.length);
				var index:int = ItemBoxUititlies.getBoxIndex(itemList[count].name);
				_view.openItemBox.interfaces(InterfaceTypes.ITEM_SELECTED, itemList[count].name, _items[index], _curType);
			}*/
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.LEVEL_EVENT, GameConfig.LE_RES, "OpenItemBoxPosition");
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.LEVEL_EVENT, GameConfig.LE_RES, "LevelEvent");			
				obj = getAssetsObject(V.LEVEL_EVENT, GameConfig.LE_RES, "Textures");
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
						case "Card":
							cp = new ItemComponent(items, _titleTxAtlas);
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
			
			_view.layer.setCenter(panel);
		}
		
		private var _getItemBtn:Button;
		private var _world:MovieClip;
		private var _boxType:MovieClip;
		private function getUI() : void
		{
			if (!_getItemBtn) _getItemBtn = this.searchOf("GetItemButton");
			_getItemBtn.visible = false;
			
			if (!_world) _world = this.searchOf("WordType");
			if (!_boxType) _boxType = this.searchOf("ImageType");
		}	
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "GetItemButton":
					getItem();
					break;
			}
		}
		
		override protected function onClickBeginHandle(e:ViewEventBind) : void
		{
			this.panel.touchable = false;
		}
		
		private function getItem():void{
			_view.prompEffect.play(_info);
			_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
			LayerManager.instance.gpu_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
			this.panel.touchable=true;
			this.hide();
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			textures = _titleTxAtlas.getTextures(name);
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			
			texture = _titleTxAtlas.getTexture(name);
			
			return texture;
		}
		
		override public function update() : void
		{
			super.update();
		}
		
		override public function close() : void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			if(_view.first_guide.isGuide)
			{
				Starling.juggler.delayCall(function () : void{_view.first_guide.setFunc(true);}, .01);
			}
			super.hide();
		}
	}
}
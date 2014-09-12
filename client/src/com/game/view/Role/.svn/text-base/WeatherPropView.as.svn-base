package com.game.view.Role
{
	import com.game.Data;
	import com.game.data.db.protocal.Item_disposition;
	import com.game.data.player.structure.Player;
	import com.game.data.prop.MultiRewardInfo;
	import com.game.manager.LayerManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import flash.ui.Keyboard;
	
	import starling.display.Image;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class WeatherPropView extends BaseView implements IView
	{
		public function WeatherPropView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.WEATHEAR_PROP;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
			}
		}
		
		override protected function init() : void
		{
			if (!this.isInit)
			{
				super.init();
				isInit = true;
				
				this.hide();
				getData();
				initXML();
				initTexture();
				initUI();
				getUI();
				initEvent();
				initBeginEvent();
				initPlayer();
			}
		}
		
		private function initPlayer() : void
		{
			
		}
		
		private var _lvInfoData:Vector.<Object>;
		private function getData() : void
		{
			//_lvInfoData = Data.instance.db.interfaces(InterfaceTypes.GET_PROP_BASE_DATA);
		}
		
		/**
		 * 通过关卡 
		 * @param equipModel
		 * 
		 */
		private var _curLV:String;
		private var _callback:Function;
		private var _difficult:int;
		private var _type:String
		public function pass(type:String, callback:Function) : void
		{
			_type = type;
			_callback = callback;
			
			var random:Number = Math.random();
			
			var rate:Number = 0.01;
			
			rate = player.multiRewardInfo.checkRPEquipRate(rate);
			rate = _view.double_level.checkDoublePropRate(rate);
			rate = player.vipInfo.checkRPUp(rate);
			
			if(random > rate || type == "")
			{
				if(_callback != null) _callback();
				return;
			}
			
			render();
			this.display();
			LayerManager.instance.addKeyDowns(this.panel, comfireFun);
		}
		
		private function render() : void
		{
			var texture:Texture;
			switch(_type)
			{
				case "夜":
					texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "props_35");
					Data.instance.pack.addNoneProp(35, 1);
					_itemNameTF.text = "夜神令牌";
					break;
				case "雨":
					texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "props_36");
					Data.instance.pack.addNoneProp(36, 1);
					_itemNameTF.text = "雨神令牌";
					break;
				case "风":
					texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "props_37");
					Data.instance.pack.addNoneProp(37, 1);
					_itemNameTF.text = "风神令牌";
					break;
				case "雷":
					texture = _view.icon.interfaces(InterfaceTypes.GetTexture, "props_38");
					Data.instance.pack.addNoneProp(38, 1);
					_itemNameTF.text = "雷神令牌";
					break;
			}
			_itemImage.texture = texture;
		}
		
		override protected function onClickBeginHandle(e:ViewEventBind) : void
		{
			this.panel.touchable = false;
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "OkBt":
					comfireFun();
					break;
			}
		}
		
		private function comfireFun() : void
		{
			LayerManager.instance.removeKeyDowns();
			this.hide();
			if (_callback != null) _callback();
			this.panel.touchable = true;
		}
		

		
		private var _itemImage:Image;
		private var _itemNameTF:TextField;
		private var _itemTitle:TextField;
		private function getUI() : void
		{
			_itemTitle = this.searchOf("Tx_Tip");
			_itemTitle.text = "恭喜您获得道具";
			_itemImage = this.searchOf("Item");
			_itemNameTF = this.searchOf("Tx_ItemTip");
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
			
			_view.layer.setCenter(this.panel);
		}
		
		// xml
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "GainEquipPosition");
		}
		
		// 初始化纹理
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				_titleTxAtlas = _view.roleRes.titleTxAtlas;
			}
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
		
		override public function display():void
		{
			super.display();
			var type:String = "add" + _layer + "Child";
			_view.layer[type](panel, sign);
		}
		
		override public function close():void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
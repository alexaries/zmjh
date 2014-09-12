package com.game.view.map
{
	import com.game.Data;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.db.protocal.Message_disposition;
	import com.game.data.equip.EquipUtilies;
	import com.game.data.player.structure.EquipModel;
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

	public class PassLVView extends BaseView implements IView
	{
		public function PassLVView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.PASS_LV;
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
			}
		}
		
		private var _lvInfoData:Vector.<Object>;
		private function getData() : void
		{
			_lvInfoData = Data.instance.db.interfaces(InterfaceTypes.GET_MESSAGE_DISPOSITION);
		}
		
		private var _curLVInfo:Message_disposition;
		private var _curEquipModel:EquipModel;
		private function searchLVInfo() : void
		{
			_curLVInfo = null;
			_curEquipModel = null;
			
			for each(var item:Message_disposition in _lvInfoData)
			{
				if (item.level_name == _curLV && item.difficulty == _difficult)
				{
					_curLVInfo = item;
					break;
				}
			}
			
			if (!_curLVInfo) throw new Error("error");
			
			_curEquipModel = createEquipModel();
			_view.controller.pack.addEquipment(_curEquipModel);
		}
		
		private function createEquipModel() : EquipModel
		{
			var model:EquipModel = new EquipModel();
			Data.instance.db.interfaces(
				InterfaceTypes.GET_EQUIP_BASE_DATA,
				_curLVInfo.level_equipment,
				function (data:Equipment) : void
				{
					model.config = data;
				});
			model.id = model.config.id;
			Data.instance.pack.initEquipment(model);
			
			return model;
		}
		
		/**
		 * 通过关卡 
		 * @param equipModel
		 * 
		 */
		private var _curLV:String;
		private var _callback:Function;
		private var _difficult:int;
		public function pass(lv:String, difficult:int, callback:Function) : void
		{
			_curLV = lv;
			_difficult = difficult;
			_callback = callback;
			
			searchLVInfo();
			render();
			this.display();
			LayerManager.instance.addKeyDowns(this.panel, comfireFun);
			
			//扫荡模式
			/*if(_view.map.autoLevel) 
			{
				this.hide();
				if (_callback != null) _callback();
			}*/
		}
		
		override protected function onClickBeginHandle(e:ViewEventBind) : void
		{
			this.panel.touchable=false;
		}
		
		private function render() : void
		{
			_itemNameTF.text = _curEquipModel.config.name;
			
			var equipFileName:String = "equip_" + _curEquipModel.config.id;
			var texture:Texture = _view.equip.interfaces(InterfaceTypes.GetTexture, equipFileName);
			_itemImage.texture = texture;
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
			this.panel.touchable=true;
		}
		
		
		private var _itemImage:Image;
		private var _itemNameTF:TextField;
		private function getUI() : void
		{
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
			_positionXML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "PassLevelPosition");
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
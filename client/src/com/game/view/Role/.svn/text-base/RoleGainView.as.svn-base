package com.game.view.Role
{
	import com.game.Data;
	import com.game.data.player.structure.RoleModel;
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

	public class RoleGainView extends BaseView implements IView
	{
		public function RoleGainView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.ROLE_GAIN;
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
				initXML();
				initTexture();
				initUI();
				getUI();
				initEvent();
				initBeginEvent();
			}
		}
		
		// 获取角色
		private var _callback:Function;
		private var _curRoleModel:RoleModel;
		public function gain(data:RoleModel, callback:Function) : void
		{
			_callback = callback;
			_curRoleModel = data;
			
			render();
			LayerManager.instance.addKeyDowns(this.panel, comfireFun);
			//自动战斗
			/*if(_view.map.autoLevel)
			{
				_view.auto_fight.addContent("获得角色" + _curRoleModel.configData.name + "\n\n");
				this.hide();					
				if (_callback != null) _callback();
			}*/
		}
		
		private function render() : void
		{
			this.display();
			
			_roleNameTF.text = _curRoleModel.configData.name;
			
			
			_roleGrade.visible = true;
			_roleImage.visible = true;
			_roleType.visible = true;
			
			checkGrade(_curRoleModel.configData.name, _roleGrade);
			checkType(_curRoleModel.configData.name, _roleType);
			checkImage(_curRoleModel.configData.name, _roleImage);
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
			this.panel.touchable=true;
		}
		
		private var _roleImage:Image;
		private var _roleNameTF:TextField;
		private var _roleType:Image;
		private var _roleGrade:Image;
		private function getUI() : void
		{
			_roleImage = this.searchOf("Role");
			_roleNameTF = this.searchOf("Tx_Name");
			_roleType = this.searchOf("RoleType");
			_roleGrade = this.searchOf("RoleGrade");
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
			_positionXML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "GainRolePositon");
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
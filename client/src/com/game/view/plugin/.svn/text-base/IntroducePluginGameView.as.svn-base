package com.game.view.plugin
{
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;

	public class IntroducePluginGameView extends BaseView implements IView
	{
		/**
		 * UI位置文件 
		 */		
		private var _positionXML:XML;
		
		public function IntroducePluginGameView()
		{
			_moduleName = V.INTRODUCE_PLUGIN_GAME;
			_layer = LayerTypes.TOP;
			_loaderModuleName = V.PLUGIN_GAME;
			
			super();
		}
		
		private var _type:String;
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch (type)
			{
				case InterfaceTypes.Show:
					_type = args[0];
					_view.instruction.interfaces(InterfaceTypes.Show, show);
					break;
			}
		}
		
		override protected function init():void
		{
			if (!isInit)
			{
				super.init();
				isInit = true;
				
				initData();
				initUI();
				getUI();
				initEvent();
			}
			checkStatus(_type);
		}
		
		private function checkStatus(select:String) : void
		{
			var targetXML:XML;
			switch(select)
			{
				case "wine":
					targetXML = _positionXML.layer[0];
					break;
				case "lechery":
					targetXML = _positionXML.layer[1];
					break;
				case "money":
					targetXML = _positionXML.layer[2];
					break;
				case "breath":
					targetXML = _positionXML.layer[3];
					break;
			}
			
			resetPosition(targetXML);
			
			for each(var item:* in _uiLibrary)
			{
				if (item is DisplayObject) item.visible = false;
				else if (item is Component) (item as Component).panel.visible = false;
			}
			
			seStatusOfXML(targetXML, true);
			
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					break;
			}
		}
		
		protected function initData() : void
		{
			if (!_positionXML)
			{
				_positionXML = getXMLData(_loaderModuleName, GameConfig.PLUGIN_GAME_RES, "IntroducePosition");
			}
		}
		
		protected function initUI() : void
		{
			initLayout();
			
			display();
			_view.layer.setCenter(panel);
		}
		
		private function initLayout() : void
		{
			var name:String;
			var obj:*;			
			for each(var items:XML in _positionXML.layer)
			{
				for each(var element:XML in items.item)
				{
					name = element.@name;
					
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						_uiLibrary.push(obj);
					}
				}
			}
		}
		
		private var _closeButton:Button;
		private function getUI() : void
		{
			_closeButton = (this.searchOf("Close") as Button);
			panel.setChildIndex(_closeButton, panel.numChildren - 1);
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
				textures = _view.pluginGame.titleTxAtlas.getTextures(name);
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
			else if(type == "instruction")
			{
				texture = _view.instruction.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _view.pluginGame.titleTxAtlas.getTexture(name);
			}
			
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
			super.hide();
		}
	}
}
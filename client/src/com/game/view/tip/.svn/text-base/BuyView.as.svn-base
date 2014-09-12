package com.game.view.tip
{
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import starling.display.DisplayObject;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class BuyView extends BaseView implements IView
	{
		public function BuyView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.BUY;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		private var _info:String;
		private var _okCallback:Function;
		private var _buyCallback:Function;
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_info = args[0];
					_okCallback = args[1];
					_buyCallback = args[2];
					this.show();
					break;
				case InterfaceTypes.HIDE:
					this.hide();
					break;
			}
		}
		
		override protected function init() : void
		{
			if (!isInit)
			{
				super.init();
				isInit = true;
				
				initXML();
				initComponent();
				initUI();
				getUI();
				initEvent();
			}
			
			render();
			
			_view.layer.setCenter(panel);
		}
		
		private function render():void
		{
			_wordTF.text = _info;
		}
		
		private var _wordTF:TextField
		private function getUI():void
		{
			_wordTF = this.searchOf("TipWord");
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.LOAD, GameConfig.LOAD_RES, "BuyPosition", V.LOAD);
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
						/*case "GameTip":
							cp = new GameTipComponent(items, _view.load.titleTxAtlas);
							_components.push(cp);
							break;*/
					}
				}
			}
		}
		
		private function initUI() : void
		{
			var name:String;
			var obj:DisplayObject;
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
						uiLibrary.push(obj);
					}
				}
			}
			
			display();
			_view.layer.setCenter(panel);
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				// 确认
				case "OkBt":
					if(_okCallback != null) _okCallback();
					hide();
					break;
				// 取消
				case "BuyBt":
					if(_buyCallback != null) _buyCallback();
					hide();
					break;
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture> = _view.load.titleTxAtlas.getTextures(name);		
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture = _view.load.titleTxAtlas.getTexture(name);		
			return texture;
		}
		
		/**
		 * 每帧调用 
		 * 
		 */
		override public function update():void
		{
			super.update();
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
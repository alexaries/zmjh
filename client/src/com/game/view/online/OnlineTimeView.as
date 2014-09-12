package com.game.view.online
{
	import com.game.Data;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	
	import flash.display.Bitmap;
	import flash.utils.getTimer;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class OnlineTimeView extends BaseView implements IView
	{
		private var _countTime:int;
		public function get countTime() : int
		{
			return _countTime;
		}
		private var _startTime:int;
		private var _endTime:int;
		
		public function OnlineTimeView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.ONLINE_TIME;
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
				case InterfaceTypes.INIT:
					initTime();
					break;
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
			
			renderTimeState();
			_view.layer.setCenter(panel);
		}
		
		private function renderTimeState() : void
		{
			
		}
		
		private function initTime() : void
		{
			_startTime = getTimer();
			_countTime = 0;
			_view.addToFrameProcessList("onlineTime", countOnlineTime);
		}
		
		private function countOnlineTime() : void
		{
			_endTime = getTimer();
			_countTime += _endTime - _startTime;
			_startTime = getTimer();
		}
		
		private function returnNowTime() : Date
		{
			var nowDate:Date = Data.instance.time.returnTimeNow();
			return nowDate;
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.ONLINE_TIME, GameConfig.ONLINE_TIME_RES, "OnlineTimePosition");
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTextures() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				
				var textureXML:XML = getXMLData(V.ONLINE_TIME, GameConfig.ONLINE_TIME_RES, "OnlineTime");			
				obj = getAssetsObject(V.ONLINE_TIME, GameConfig.ONLINE_TIME_RES, "Textures");
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
						/*case "ChangePage":
							cp = new ChangePageComponent(items, _view.daily.titleTxAtlas);
							_components.push(cp);
							break;*/
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
		
		private function getUI() : void
		{
			
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
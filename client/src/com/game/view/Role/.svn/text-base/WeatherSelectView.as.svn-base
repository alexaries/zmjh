package com.game.view.Role
{
	import com.engine.core.Log;
	import com.engine.ui.controls.TabBar;
	import com.game.Data;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import flash.display.Bitmap;
	
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class WeatherSelectView extends BaseView implements IView
	{
		public function WeatherSelectView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.WEATHER_SELECT;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		private var _count:int;
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
			if(!this.isInit)
			{
				super.init();
				this.isInit = true;
				initXML();
				initTextures();
				initUI();
				getUI();
				initEvent();
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					break;
				case "TipOk":
					this.startChangeWeather();
					break;
				case "TipCancel":
					this.hide();
					break;
			}
		}
		
		private function startChangeWeather() : void
		{
			this.hide();
			_view.role.interfaces(InterfaceTypes.HIDE);
			_view.weather.setWeather(_count + 1);
			Data.instance.pack.changePropNum(32, -1);
			Log.Trace("天气控制器使用保存");
			_view.controller.save.onCommonSave(false, 1, false);
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
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "WeatherSelectPosition");
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTextures() : void
		{
			if (!_titleTxAtlas)
			{
				_titleTxAtlas = _view.roleRes.titleTxAtlas;
			}
		}
		
		private var _tabBar:TabBar;
		private function getUI() : void
		{
			var arr:Array = [searchOf("RoleNightSelect"), searchOf("RoleRainSelect"), searchOf("RoleThunderSelect"), searchOf("RoleWindSelect")];
			_tabBar = new TabBar(arr);
			_tabBar.addEventListener(TabBar.TYPE_SELECT_CHANGE, onTabChange);
			_tabBar.selectIndex = 0;
		}
		
		private function onTabChange(e:Event) : void
		{
			_count = (e.data as int);
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else if(type == "load")
			{
				textures = _view.load.interfaces(InterfaceTypes.GetTextures, name);
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
			else if(type == "load")
			{
				texture = _view.load.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			
			return texture;
		}
	}
}
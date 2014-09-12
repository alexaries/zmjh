package com.game.view.weather
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.manager.DebugManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.effect.EffectShow;
	
	import flash.display.Bitmap;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class WeatherView extends BaseView implements IView
	{
		private var weatherType:Array = ["wea_inside_rate", "wea_night_rate", "wea_rain_rate", "wea_rain_rate", "wea_night_rate"];
			
		private var _anti:Antiwear;
		
		private var _positionXML:XML;
		
		private var _titleTxAtlas:TextureAtlas;
		
		public function WeatherView()
		{
			_moduleName = V.WEATHER;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.PUBLIC;
			
			_anti = new Antiwear(new binaryEncrypt());
			
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
				case InterfaceTypes.GetTexture:
					return getTexture(args[0], "");
					break;
				case InterfaceTypes.GetTextures:
					return getTextures(args[0], "");
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
			this.hide();
			_view.layer.setCenter(panel);
		}
		
		private var _usePropCallback:Function;
		/**
		 * 选择天气
		 * @param selectCount
		 * 
		 */		
		public function setWeather(selectCount:int, callback:Function = null) : void
		{
			_usePropCallback = callback;
			for(var j:int = 0; j < _view.map.weatherList.length; j++)
			{
				_view.map.weatherList[j] = false;
			}
			_view.map.weatherTime = _weatherData[selectCount].wea_time;
			_view.map.weatherList[selectCount] = true;
			_view.map.initWeather();
			addWeatherCartoon();
		}
		
		private function noWeather() : void
		{
			_view.map.weatherTime = 0;
			_view.map.weatherList[0] = true;
			_view.map.interfaces(InterfaceTypes.SET_EFFECT);
			_view.map.initWeather();
		}
		
		
		/**
		 * 进入关卡触发天气的概率
		 * 
		 */		
		public function initWeather(curLevel:String) : void
		{
			Log.Trace("进入关卡触发天气");
			if(curLevel == "1_1" || curLevel == "1_2" || curLevel == "1_3")
			{
				noWeather();
				return;
			}
			var lastCount:int = 0;
			var rateCount:Number = 0;
			var random:Number = Math.random();
			for(var i:int = 0; i < _weatherData.length; i++)
			{
				rateCount += _weatherData[i].wea_start_rate;
				if(random <= rateCount)
				{
					lastCount = i;
					break;
				}
			}
			for(var j:int = 0; j < _view.map.weatherList.length; j++)
			{
				_view.map.weatherList[j] = false;
			}
			_view.map.weatherTime = _weatherData[lastCount].wea_time;
			_view.map.weatherList[lastCount] = true;
			_view.map.initWeather();
			_view.map.interfaces(InterfaceTypes.SET_EFFECT);
			if(lastCount == 0)	_view.prompEffect.play("阳光明媚！！！");
			else if(lastCount == 1)		_view.prompEffect.play("黑夜降临！！！");
			else if(lastCount == 2)		_view.prompEffect.play("大雨倾盆！！！");
		}
		
		/**
		 * 根据概率重新设置天气情况
		 * 
		 */		
		public function resetWeather() : void
		{
			Log.Trace("重新设置天气");
			_view.map.weatherTime = 0;
			var lastCount:int = 0;
			var rateCount:Number = 0;
			var random:Number = Math.random();
			for(var i:int = 0; i < _weatherData.length; i++)
			{
				rateCount += _weatherData[i][weatherType[_view.map.getWeatherStatus()]];
				if(random <= rateCount)
				{
					lastCount = i;
					break;
				}
			}
			for(var j:int = 0; j < _view.map.weatherList.length; j++)
			{
				_view.map.weatherList[j] = false;
			}
			_view.map.weatherTime = _weatherData[lastCount].wea_time;
			_view.map.weatherList[lastCount] = true;
			_view.map.initWeather();
			addWeatherCartoon();
		}
		
		/**
		 * 设置阳光明媚
		 * 
		 */		
		public function setSun() : void
		{
			if(_view.map.weatherTime <= 0) 
			{
				if(_view.map.allowSun) return;
				
				for(var i:int = 0; i < _view.map.weatherList.length; i++)
				{
					_view.map.weatherList[i] = false;
				}
				_view.map.initWeather();
				_view.map.weatherTime = 0;
				_view.map.weatherList[0] = true;
				_view.map.allowSun = true;
				
				_view.toolbar.interfaces(InterfaceTypes.SET_EFFECT);
				_view.map.interfaces(InterfaceTypes.SET_EFFECT);
				if(_view.map.weatherTime == 0)
					_view.prompEffect.play("阳光明媚！！！");
				Log.Trace("回到晴天");
			}
		}
		
		private var _weatherData:Object;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.WEATHER, GameConfig.WEATHER_RES, "WeatherPosition");
			_weatherData = Data.instance.db.interfaces(InterfaceTypes.GET_WEATHER_DATA);
		}
		
		public function get weatherData() : Object
		{
			return _weatherData;
		}
		
		private function initTextures() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				
				var textureXML:XML = getXMLData(V.WEATHER, GameConfig.WEATHER_RES, "Weather");			
				obj = getAssetsObject(V.WEATHER, GameConfig.WEATHER_RES, "Textures");
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
		
		//抽签动画
		private var _weatherCartoon:MovieClip;
		//翻牌动画
		private var _weatherShowCard:MovieClip;
		private function getUI() : void
		{
			var frames:Vector.<Texture> = this.getTextures("DrawLabel_", "");
			_weatherCartoon = new MovieClip(frames, 8);
			_weatherCartoon.addFrame(frames[3]);
			_weatherCartoon.addFrame(frames[2]);
			_weatherCartoon.addFrame(frames[1]);
			_weatherCartoon.addFrame(frames[0]);
			_weatherCartoon.touchable = false;
			_weatherCartoon.currentFrame = 0;
			_weatherCartoon.stop();
			_weatherCartoon.x = -_weatherCartoon.width * .5;
			_weatherCartoon.y = -_weatherCartoon.height * .5;
			
			
			var cardFrames:Vector.<Texture> = this.getTextures("Weather_", "");
			_weatherShowCard = new MovieClip(cardFrames);
			_weatherShowCard.touchable = false;
			_weatherShowCard.currentFrame = 0;
			_weatherShowCard.stop();
			_weatherShowCard.pivotX = 0.5 * _weatherShowCard.width;
			_weatherShowCard.pivotY = 0.5 * _weatherShowCard.height;
			_weatherShowCard.x = - 4;
			_weatherShowCard.y = - 33;
		}
		
		
		/**
		 * 添加抽签动画
		 * 
		 */		
		private function addWeatherCartoon() : void
		{
			this.display();
			_view.toolbar.interfaces(InterfaceTypes.LOCK);
			var  effectShow:EffectShow = new EffectShow(panel);
			effectShow.addShowObj(_weatherCartoon);
			effectShow.addShowObj(_weatherShowCard, .3, flipComplete, flipCard);
			effectShow.start();
		}
		
		private var tw:Tween;
		private var tw_1:Tween;
		/**
		 * 开始翻牌
		 * 
		 */	
		private function flipCard(obj:*) : void
		{
			obj.stop();
			tw = new Tween(obj, .3);
			tw.animate("scaleX", 0);
			Starling.juggler.add(tw);
		}
		
		/**
		 * 显示结果
		 * 
		 */		
		private function flipComplete() : void
		{
			addMovieClip(panel, _weatherShowCard);
			_weatherShowCard.stop();
			if(_view.map.allowBlack) 
			{
				_view.prompEffect.play("黑夜降临！！！");
				_weatherShowCard.currentFrame = 2;
			}
			else if(_view.map.allowRain)
			{
				_view.prompEffect.play("大雨倾盆！！！");
				_weatherShowCard.currentFrame = 3;
			}
			else if(_view.map.allowThunder)
			{
				_view.prompEffect.play("雷雨交加！！！");
				_weatherShowCard.currentFrame = 4;
			}
			else if(_view.map.allowWind)
			{
				_view.prompEffect.play("狂风大作！！！");
				_weatherShowCard.currentFrame = 5;
			}
			else
			{
				_view.prompEffect.play("阳光明媚！！！");
				_weatherShowCard.currentFrame = 1;
			}
			
			Starling.juggler.remove(tw);
			
			tw_1 = new Tween(_weatherShowCard, .3);
			tw_1.animate("scaleX", 1);
			tw_1.onComplete = flipOver;
			Starling.juggler.add(tw_1);
			
		}
		
		/**
		 * 翻牌结束
		 * 
		 */		
		private function flipOver() : void
		{
			_view.toolbar.interfaces(InterfaceTypes.SET_EFFECT);
			_view.map.interfaces(InterfaceTypes.SET_EFFECT);
			Starling.juggler.delayCall(
				function() : void
				{
					removeMovieClip(_weatherShowCard);
					Starling.juggler.remove(tw_1);
					_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
					hide();
					if(_usePropCallback != null)
					{
						_usePropCallback();
						_usePropCallback = null;
					}
				},
				1.5);
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
			
		override public function display() : void
		{
			panel.visible = true;
			panel.alpha = 1;
			
			// add
			var type:String = "add" + _layer + "Child";
			if (!panel.parent) _view.layer[type](panel, sign);
		}
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
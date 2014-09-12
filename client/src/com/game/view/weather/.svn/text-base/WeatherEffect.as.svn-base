package com.game.view.weather
{
	import com.engine.core.Log;
	import com.game.View;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.map.player.PlayerEntity;
	import com.game.view.map.player.PlayerStatus;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Sine;
	
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.utils.Timer;
	
	import starling.animation.DelayedCall;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class WeatherEffect extends Sprite
	{
		private static const RAIN_DENSITY:int = 80;
		private static const THUNDER_RAIN_DENSITY:int = 320;
		private static const THUNDER_DENSITY:int = 2;
		private static const WIND_DENSITY:int = 2;
		private var _rain_density:int;
		private var _blackSp:Sprite;
		private var _blackCircle:Image;
		private var _leftImg:Image;
		private var _rightImg:Image;
		private var _topImg:Image;
		private var _downImg:Image;
		private var _view:View;
		public function WeatherEffect()
		{
			_view = View.instance;
		}
		
		/**
		 * 黑夜模式判断
		 * 
		 */
		public function initWeatherBlack() : void
		{
			
			if(_view.map.allowBlack) 
				Starling.juggler.delayCall(addBlackMode, 1, _view.map.playerRole);
			else
				leaveBlackMode();
		}
		
		/**
		 * 下雨模式判断
		 * 
		 */		
		public function initWeatherRain() : void
		{
			if(_view.map.allowRain)
				Starling.juggler.delayCall(addRainEffect, 1, _view.map.panel);
			else
				leaveRainEffect();
		}
		
		/**
		 * 雷雨模式判断
		 * 
		 */		
		public function initWeatherThunder() : void
		{
			if(_view.map.allowThunder) 
				Starling.juggler.delayCall(addThunderEffect, 1, _view.map.panel);
			else
				removeThunderEffect();
		}
		
		
		/**
		 * 大风模式判断
		 * 
		 */		
		public function initWeatherWind() : void
		{
			if(_view.map.allowWind)
				Starling.juggler.delayCall(addWindEffect, 1, _view.map.panel, _view.map.playerRole);
			else
				leaveWindEffect();
		}
		
		/**
		 * 添加黑夜模式
		 * @param player
		 * 
		 */		
		public function addBlackMode(player:PlayerEntity) : void
		{
			Log.Trace("黑夜模式");
			if(!_blackSp)
			{
				_blackSp = new Sprite();
				createCircleImage();
				
				var texture:Texture = Texture.fromColor(300, 300, 0xFF000000);
				_leftImg = createRectImage(-200 - GameConfig.CAMERA_WIDTH + 1, -200, GameConfig.CAMERA_WIDTH, 400, texture, _leftImg);
				_rightImg = createRectImage(200 - 1, -200, GameConfig.CAMERA_WIDTH, 400, texture, _rightImg);
				_topImg = createRectImage(-GameConfig.CAMERA_WIDTH, -200 - GameConfig.CAMERA_HEIGHT + 1, GameConfig.CAMERA_WIDTH * 2, GameConfig.CAMERA_HEIGHT, texture, _topImg);
				_downImg = createRectImage(-GameConfig.CAMERA_WIDTH, 200 - 1, GameConfig.CAMERA_WIDTH * 2, GameConfig.CAMERA_HEIGHT, texture, _downImg);
				_blackSp.addChild(_leftImg);
				_blackSp.addChild(_rightImg);
				_blackSp.addChild(_topImg);
				_blackSp.addChild(_downImg);
			}
			
			var curState:String = _view.map.playerRole.State;
			_view.map.playerRole.State = PlayerStatus.ZMHP;
			
			_blackSp.alpha = 0;
			_blackSp.touchable = false;
			var tween:Tween = new Tween(_blackSp, .5);
			tween.animate("alpha", 1);
			tween.onComplete = function () : void
			{
				if(_view.map.playerRole != null)
					_view.map.playerRole.State = curState;
			}
			Starling.juggler.add(tween);
			
			if(_blackSp.parent == null) player.addChild(_blackSp);
			Log.Trace("黑夜模式加载成功");
		}
		
		/**
		 * 创建中空圆圈
		 * 
		 */		
		private function createCircleImage() : void
		{
			var _circle:Shape = new Shape;
			_circle.graphics.clear();
			_circle.graphics.lineStyle(0); 
			_circle.graphics.beginFill(0x000000, 1);
			_circle.graphics.drawRect(-10, -10, 420, 420);  
			_circle.graphics.lineStyle(3, 0xFFFFFF, 0); 
			_circle.graphics.drawCircle(200, 200, 150);
			_circle.graphics.endFill(); 
			_circle.filters = [new BlurFilter(15, 15, BitmapFilterQuality.LOW)];
			_circle.cacheAsBitmap = true;
			
			var _bmpData:BitmapData = new BitmapData(400, 400, true, 0);
			_bmpData.draw(_circle);
			
			var texture:Texture = Texture.fromBitmapData(_bmpData);
			_bmpData.dispose();
			_blackCircle = new Image(texture);
			_blackCircle.x = -200;
			_blackCircle.y = -200;
			_blackSp.addChild(_blackCircle);
		}
		
		/**
		 * 创建黑色矩形
		 * 
		 */		
		private function createRectImage(xPos:int, yPos:int, wid:int, hei:int, texture:Texture, img:Image, alp:Number = 1) : Image
		{
			img = new Image(texture);
			img.width = wid;
			img.height = hei;
			img.x = xPos;
			img.y = yPos;
			img.alpha = alp;
			img.readjustSize();
			
			return img;
		}
		
		/**
		 * 去除黑夜模式
		 * 
		 */		
		public function leaveBlackMode() : void
		{
			if(_blackSp && _blackSp.parent)
			{
				var tween:Tween = new Tween(_blackSp, .5);
				tween.animate("alpha", 0);
				tween.onComplete = function () : void
				{
					if(_blackSp != null && _blackSp.parent != null) _blackSp.parent.removeChild(_blackSp);
				}
				Starling.juggler.add(tween);
				Log.Trace("黑夜模式结束");
			}
		}
		
		/**
		 * 删除黑夜模式素材
		 * 
		 */		
		public function removeBlackEffect() : void
		{
			if (_blackCircle != null)
			{
				if(_blackCircle.parent) _blackCircle.parent.removeChild(_blackCircle);
				_blackCircle.texture.dispose();
				_blackCircle.dispose();
				_blackCircle = null;
			}
			if(_leftImg != null)
			{
				if(_leftImg.parent) _leftImg.parent.removeChild(_leftImg);
				_leftImg.dispose();
				_leftImg = null;
			}
			if(_rightImg != null)
			{
				if(_rightImg.parent) _rightImg.parent.removeChild(_rightImg);
				_rightImg.dispose();
				_rightImg = null;
			}
			if(_topImg != null)
			{
				if(_topImg.parent) _topImg.parent.removeChild(_topImg);
				_topImg.dispose();
				_topImg = null;
			}
			if(_downImg != null)
			{
				if(_downImg.parent) _downImg.parent.removeChild(_downImg);
				_downImg.texture.dispose();
				_downImg.dispose();
				_downImg = null;
			}
			if(_blackSp != null)
			{
				if(_blackSp.parent) _blackSp.parent.removeChild(_blackSp);
				_blackSp.dispose();
				_blackSp = null;
				Log.Trace("黑夜模式删除素材");
			}
		}
		
		private var _rainTexture:Texture;
		private var _rainLayer:Sprite;
		private var _rainImageList:Vector.<Image>;
		private var _rainEffectList:Vector.<MovieClip>;
		/**
		 * 添加下雨特效
		 * 
		 */		
		public function addRainEffect(panel:Sprite) : void
		{
			Log.Trace("下雨模式");
			_rain_density = RAIN_DENSITY;
			onlyAddRain(panel);
		}
		
		private function onlyAddRain(panel:Sprite) : void
		{
			if(_rainTexture == null)
			{
				var shape:Shape = new Shape();
				var colors:Array = [0xFFFFFF, 0xFFFFFF];
				var alphas:Array = [0.7,0.1];//可以设置渐变两边的alpha值,1<alpha>0
				var ratios:Array = [0x00, 0xFF];
				var matr:Matrix = new Matrix();
				matr.createGradientBox(20, 20, 0, 0, 0);
				var spreadMethod:String = SpreadMethod.PAD;
				shape.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matr, spreadMethod);  
				shape.graphics.drawRoundRect(0,0,70,10, 2, 2);
				
				var _bmpData:BitmapData = new BitmapData(70, 10, true, 0);
				_bmpData.draw(shape);
				
				_rainTexture = Texture.fromBitmapData(_bmpData);
				_bmpData.dispose();
			}
			if(!_rainLayer)		_rainLayer = new Sprite();
			if(!_rainLayer.parent)		panel.addChild(_rainLayer);
			if(!_rainLayer.hasEventListener(Event.ENTER_FRAME))		_rainLayer.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			
			createRain();
		}
		
		/**
		 * 删除下雨特效
		 * 
		 */		
		public function leaveRainEffect() : void
		{
			removeRainEffect();
		}
		
		/**
		 * 雨丝移动循环函数
		 * @param e
		 * 
		 */		
		private function onEnterFrameHandler(e:Event) : void
		{
			for each(var rainImage:Image in _rainImageList)
			{
				rainImage.y += 15;
				rainImage.x += 2.5;
				//重新设置移动到界面外的雨丝
				if(rainImage.y > GameConfig.CAMERA_HEIGHT + 80)
				{
					rainImage.x = Math.random() * (GameConfig.CAMERA_WIDTH + 50) - 50;
					rainImage.y = 0;
				}
			}
			for each(var rainEffect:MovieClip in _rainEffectList)
			{
				if(rainEffect.isComplete) 
				{
					if(rainEffect.parent) rainEffect.parent.removeChild(rainEffect);
					rainEffect.currentFrame = 0;
					Starling.juggler.remove(rainEffect);
				}
			}
			
			for(var j:uint = 0; j < _rain_density / RAIN_DENSITY * 2; j++)
			{
				var random:int = int(Math.random() * _rain_density);
				_rainEffectList[random].x = _rainImageList[random].x - 20;
				_rainEffectList[random].y = _rainImageList[random].y - 5;
				
				_rainEffectList[random].currentFrame = 0;
				_rainEffectList[random].play();
				Starling.juggler.add(_rainEffectList[random]);
				_rainLayer.addChild(_rainEffectList[random]);
				
				_rainImageList[random].x = Math.random() * (GameConfig.CAMERA_WIDTH + 50) - 50;
				_rainImageList[random].y = 0;
			}
		}
		
		/**
		 * 创建雨丝效果
		 * 
		 */		
		private function createRain() : void
		{
			_rainImageList = new Vector.<Image>();
			var rain:Image;
			//密度
			for(var i:uint = 0 ; i < _rain_density; i++)
			{
				rain = new Image(_rainTexture);
				rain.x = Math.random() * (GameConfig.CAMERA_WIDTH + 50) - 50;
				rain.y = -Math.random() * GameConfig.CAMERA_HEIGHT;
				rain.data = [rain.x, rain.y];
				rain.height = 2;
				rain.rotation = -100 / 180 * Math.PI;
				rain.touchable = false;
				_rainLayer.addChild(rain);
				_rainImageList.push(rain);
			}
			
			_rainEffectList = new Vector.<MovieClip>();
			var textures:Vector.<Texture> = _view.other_effect.interfaces(InterfaceTypes.GetTextures, "Rain_00");
			var rainEffect:MovieClip;
			for(var j:uint = 0; j < _rain_density; j++)
			{
				rainEffect = new MovieClip(textures);
				rainEffect.touchable = false;
				rainEffect.loop = false;
				_rainEffectList.push(rainEffect);
			}
		}
		
		/**
		 * 删除雨丝素材
		 * 
		 */		
		public function removeRainEffect() : void
		{
			if(_rainImageList != null)
			{
				for(var i:int = _rainImageList.length - 1; i >= 0; i--)
				{
					if(_rainImageList[i].parent) _rainImageList[i].parent.removeChild(_rainImageList[i]);
					_rainImageList[i].dispose();
					_rainImageList[i] = null;
				}
				_rainImageList.length = 0;
				_rainImageList = null;
			}
			if(_rainEffectList != null)
			{
				for(var j:int = _rainEffectList.length - 1; j >= 0; j--)
				{
					if(_rainEffectList[j].parent) _rainEffectList[j].parent.removeChild(_rainEffectList[j]);
					_rainEffectList[j].currentFrame = 0;
					_rainEffectList[j].stop();
					Starling.juggler.remove(_rainEffectList[j]);
					if(j == 0) _rainEffectList[j].texture.dispose();
					_rainEffectList[j].dispose();
					_rainEffectList[j] = null;
				}
				_rainEffectList.length = 0;
				_rainEffectList = null
			}
			if(_rainLayer && _rainLayer.hasEventListener(Event.ENTER_FRAME)) _rainLayer.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			if(_rainLayer && _rainLayer.parent) _rainLayer.parent.removeChild(_rainLayer);
			
			if(_rainTexture != null)
			{
				_rainTexture.dispose();
				_rainTexture = null;
				
				Log.Trace("雨天模式结束");
			}
		}
		
		/**
		 * 添加雷雨特效
		 * @param panel
		 * 
		 */		
		public function addThunderEffect(panel:Sprite) : void
		{
			Log.Trace("雷雨模式");
			_rain_density = THUNDER_RAIN_DENSITY;
			onlyAddRain(panel);
			addLightEffect(panel);
		}
		
		private var _lightWhite:Image;
		private var _commonLight:Image;
		private var _thunderPanel:Sprite;
		private var _blackPanel:Image;
		public var _thunderList:Vector.<MovieClip>;
		private function addLightEffect(panel:Sprite) : void
		{
			_thunderPanel = panel;
			
			if(!_lightWhite && !_commonLight)
			{
				var lightWhite:Texture = Texture.fromColor(100, 100, 0xffffffff);
				_lightWhite = createRectImage(0, 0, GameConfig.CAMERA_WIDTH, GameConfig.CAMERA_HEIGHT, lightWhite, _lightWhite, .9);
				_commonLight = createRectImage(0, 0, GameConfig.CAMERA_WIDTH, GameConfig.CAMERA_HEIGHT, lightWhite, _commonLight, .9);
			}
			if(!_blackPanel)
			{
				var lightBlack:Texture = Texture.fromColor(100, 100, 0xff000000);
				_blackPanel = createRectImage(0, 0, GameConfig.CAMERA_WIDTH, GameConfig.CAMERA_HEIGHT, lightBlack, _blackPanel, .6);
				_blackPanel.touchable = false;
			}
			if(_blackPanel.parent == null) _thunderPanel.addChild(_blackPanel);
			
			if(_thunderList == null)
			{
				_thunderList = new Vector.<MovieClip>();
				var atlas:TextureAtlas = _view.other_effect.titleTxAtlas;
				var textures:Vector.<Texture> = atlas.getTextures("Thunder_00");
				for(var i:int = 0; i < THUNDER_DENSITY; i++)
				{
					var thunderMC:MovieClip = new MovieClip(textures);
					thunderMC.pivotX = thunderMC.width / 2;
					thunderMC.pivotY = thunderMC.height - 60;
					thunderMC.stop();
					thunderMC.loop = false;
					_thunderList.push(thunderMC);
				}
			}
			
			startCommonLight();
		}
		
		private var commonTimer:Timer;
		private var commonDelay:DelayedCall;
		private var _continueDelay:Boolean;
		private function startCommonLight() : void
		{
			_continueDelay = true;
			commonTimer = new Timer(70, 6);
			if(!commonTimer.hasEventListener(TimerEvent.TIMER)) commonTimer.addEventListener(TimerEvent.TIMER, onCommonTimerHandler);
			commonTimer.start();
		}
		
		private function onCommonTimerHandler(e:TimerEvent) : void
		{
			if(e.target.currentCount % 2 == 1)
			{
				_thunderPanel.addChild(_commonLight);
			}
			else 
			{
				if(_commonLight.parent) _commonLight.parent.removeChild(_commonLight);
			}
			if(e.target.currentCount == e.target.repeatCount)
			{
				if(_commonLight.parent) _commonLight.parent.removeChild(_commonLight);
				e.target.removeEventListener(TimerEvent.TIMER, onTimerHandler);
				if(_continueDelay) commonDelay = Starling.juggler.delayCall(startCommonLight, (Math.random() * 5 + 5));
			}
		}
		
		public function renderLight() : void
		{
			var thunderTimer:Timer = new Timer(100, 6);
			thunderTimer.addEventListener(TimerEvent.TIMER, onTimerHandler);
			thunderTimer.start();
		}
		
		private function onTimerHandler(e:TimerEvent) : void
		{
			if(e.target.currentCount % 2 == 1)
			{
				_thunderPanel.addChild(_lightWhite);
			}
			else 
			{
				if(_lightWhite.parent) _lightWhite.parent.removeChild(_lightWhite);
			}
			if(e.target.currentCount == e.target.repeatCount)
			{
				if(_lightWhite.parent) _lightWhite.parent.removeChild(_lightWhite);
				e.target.removeEventListener(TimerEvent.TIMER, onTimerHandler);
			}
		}
		
		/**
		 * 删除雷雨特效
		 * 
		 */		
		public function removeThunderEffect() : void
		{
			removeRainEffect();
			if(_lightWhite && _lightWhite.parent) _lightWhite.parent.removeChild(_lightWhite);
			if(_commonLight && _commonLight.parent) _commonLight.parent.removeChild(_commonLight);
			if(_blackPanel && _blackPanel.parent) _blackPanel.parent.removeChild(_blackPanel);
			if(_thunderList != null)
			{
				for(var i:int = _thunderList.length - 1; i >= 0; i--)
				{
					if(_thunderList[i].parent) _thunderList[i].parent.removeChild(_thunderList[i]);
					_thunderList[i].currentFrame = 0;
					_thunderList[i].stop();
					Starling.juggler.remove(_thunderList[i]);
					if(i == 0) _thunderList[i].texture.dispose();
					_thunderList[i].dispose();
					_thunderList[i] = null;
				}
				_thunderList.length = 0;
				_thunderList = null;
				Log.Trace("雷雨天气结束");
			}
			if(commonTimer)		commonTimer.reset();
			
			_continueDelay = false;
			
			if(commonDelay) 
			{
				Starling.juggler.remove(commonDelay);
			}
		
			//Starling.juggler.purge();
		}
		
		
		private var _windTexture_1:Texture;
		private var _windTexture_2:Texture;
		private var _windTexture_3:Texture;
		private var _windImageList:Vector.<Image>;
		private var _windTextureList:Vector.<Texture>;
		private var _windTimer:Timer;
		private var _littleWindTimer:Timer;
		private var _windPanel:Sprite;
		private var _windForward:Boolean;
		public var _windBackEffect:Vector.<MovieClip>;
		public var _windFrontEffect:Vector.<MovieClip>;
		public var _windBackFashionEffect:Vector.<MovieClip>;
		public var _windFrontFashionEffect:Vector.<MovieClip>;
		/**
		 * 添加大风特效 
		 * @param panel
		 * 
		 */		
		public function addWindEffect(panel:Sprite, player:PlayerEntity) : void
		{
			Log.Trace("大风模式");
			_windForward = false;
			_windPanel = panel;
			
			_windPanel.addEventListener(Event.ENTER_FRAME, onWindFrameHandler);
			if(!_windTexture_1)
				_windTexture_1 = _view.other_effect.interfaces(InterfaceTypes.GetTexture, "Leaf_1");
			if(!_windTexture_2)
				_windTexture_2 = _view.other_effect.interfaces(InterfaceTypes.GetTexture, "Leaf_2");
			if(!_windTexture_3)
				_windTexture_3 = _view.other_effect.interfaces(InterfaceTypes.GetTexture, "Leaf_3");
			
			_windTextureList = new Vector.<Texture>();
			_windTextureList.push(_windTexture_1, _windTexture_2, _windTexture_3);
			
			_windImageList = new Vector.<Image>();
			
			addBlackMode(player);
			
			_windTimer = new Timer(5000);
			_windTimer.addEventListener(TimerEvent.TIMER, onAddLeaf);
			//_windTimer.start();
			
			_littleWindTimer = new Timer(500);
			_littleWindTimer.addEventListener(TimerEvent.TIMER, onAddLittleLeaf);
			_littleWindTimer.start();
			
			var atlas:TextureAtlas = _view.other_effect.titleTxAtlas;
			if(!_windFrontEffect && !_windBackEffect && !_windFrontFashionEffect && !_windBackFashionEffect)
			{
				_windFrontEffect = new Vector.<MovieClip>();
				_windBackEffect = new Vector.<MovieClip>();
				_windFrontFashionEffect = new Vector.<MovieClip>();
				_windBackFashionEffect = new Vector.<MovieClip>();
				var backTextures:Vector.<Texture> = atlas.getTextures("WindBack");
				var frontTextures:Vector.<Texture> = atlas.getTextures("WindFront");
				var backFashionTextures:Vector.<Texture> = atlas.getTextures("FashionWindBack");
				var frontFashionTextures:Vector.<Texture> = atlas.getTextures("FashionWindFront");
				for(var i:uint = 0; i < WIND_DENSITY; i++)
				{
					_windFrontEffect.push(createMC(frontTextures));
					_windBackEffect.push(createMC(backTextures));
					_windFrontFashionEffect.push(createMC(frontFashionTextures));
					_windBackFashionEffect.push(createMC(backFashionTextures));
				}
			}
		}
		
		private function createMC(texture:Vector.<Texture>) : MovieClip
		{
			var mc:MovieClip = new MovieClip(texture);
			mc.pivotX = mc.width / 2 + 8;
			mc.pivotY = mc.height / 2 + 30;
			return mc;
		}
		
		public function removeWindFly() : void
		{
			for each(var windBack:MovieClip in _windBackEffect)
			{
				if(windBack.parent) windBack.parent.removeChild(windBack);
				windBack.stop()
				windBack.currentFrame = 0;
				Starling.juggler.remove(windBack);
			}
			for each(var windFront:MovieClip in _windFrontEffect)
			{
				if(windFront.parent) windFront.parent.removeChild(windFront);
				windFront.stop()
				windFront.currentFrame = 0;
				Starling.juggler.remove(windFront);
			}
			for each(var windFrontFashion:MovieClip in _windFrontFashionEffect)
			{
				if(windFrontFashion.parent) windFrontFashion.parent.removeChild(windFrontFashion);
				windFrontFashion.stop()
				windFrontFashion.currentFrame = 0;
				Starling.juggler.remove(windFrontFashion);
			}
			for each(var windBackFashion:MovieClip in _windBackFashionEffect)
			{
				if(windBackFashion.parent) windBackFashion.parent.removeChild(windBackFashion);
				windBackFashion.stop()
				windBackFashion.currentFrame = 0;
				Starling.juggler.remove(windBackFashion);
			}
		}
		
		private function onWindFrameHandler() : void
		{
			for(var i:uint = 0; i < _windImageList.length; i++)
			{
				_windImageList[i].y += _windImageList[i].data[1];
				if(_windForward)
				{
					_windImageList[i].x += _windImageList[i].data[0];
				}
				else
				{
					_windImageList[i].x -= _windImageList[i].data[0];
				}
				if(_windImageList[i].y > GameConfig.CAMERA_HEIGHT + 40)
				{
					_windImageList[i].data[2] = true;
				}
			}
			
			for(var j:int = _windImageList.length - 1; j >= 0; j--)
			{
				if(_windImageList[j].data[2] == true)
				{
					if(_windImageList[j].parent) _windImageList[j].parent.removeChild(_windImageList[j]);
					_windImageList[j].dispose();
					_windImageList[j] = null;
					_windImageList.splice(j, 1);
				}
			}
		}
		
		private function onAddLittleLeaf(e:TimerEvent) : void
		{
			if(e.target.currentCount % 60 == 0) _windForward = !_windForward;
			
			if(_windForward) addLeft();
			else addLeft(V.WEATHER_RIGHT);
			
			if(e.target.currentCount %30 == 0 || e.target.currentCount %31 == 0 || e.target.currentCount %32 == 0)
				setAllLeaf();
		}
		
		private function addLeft(forward:String = V.WEATHER_LEFT, count:int = 0) : void
		{
			for(var i:uint = 0; i < 5; i++)
			{
				var img:Image = new Image(_windTextureList[Math.floor(Math.random() * _windTextureList.length)]);
				img.touchable = false;
				img.scaleY = -1;
				if(forward == V.WEATHER_LEFT)
				{
					img.x = -GameConfig.CAMERA_WIDTH * Math.random() + GameConfig.CAMERA_WIDTH * .3;
					img.y = -GameConfig.CAMERA_HEIGHT * Math.random();
				}
				else if(forward == V.WEATHER_RIGHT)
				{
					img.scaleX = -1;
					img.x = GameConfig.CAMERA_WIDTH * .7 + GameConfig.CAMERA_WIDTH * .8 * Math.random();
					img.y = -GameConfig.CAMERA_HEIGHT * .8 * Math.random();
				}
				img.data = new Object();
				img.data[0] = (count == 0?Math.random() * 20 + 10:count);
				img.data[1] = (count == 0?Math.random() * 20 + 10:count);
				img.data[2] = false;
				_windPanel.addChild(img);
				_windImageList.push(img);
			}
		}
		
		private function setAllLeaf() : void
		{
			for(var i:uint = 0; i < _windImageList.length; i++)
			{
				_windImageList[i].data[0] = 40;
				_windImageList[i].data[1] = 40;
			}
		}
		
		private function onAddLeaf(e:TimerEvent) : void
		{
			addThreeWind(_windPanel);
		}
		
		private function addThreeWind(panel:Sprite) : void
		{
			for(var i:uint = 0; i < 5; i++)
			{
				var img:Image = new Image(_windTextureList[Math.floor(Math.random() * _windTextureList.length)]);
				img.touchable = false;
				panel.addChild(img);
				_windImageList.push(img);
				var xPos:int = img.x = -GameConfig.CAMERA_WIDTH * .5 * Math.random();
				var yPos:int = img.y = -GameConfig.CAMERA_HEIGHT * .5 * Math.random();
				TweenMax.to(img, 2, {bezier:[
					{x:xPos + 470, y:yPos + 320},
					{x:xPos + 500, y:yPos + 260},
					{x:xPos + 440, y:yPos + 290},
					{x:xPos + GameConfig.CAMERA_WIDTH * 1.5, y:yPos + GameConfig.CAMERA_HEIGHT * 1.5}], 
					ease:Linear.easeNone, onComplete:removeThis, onCompleteParams:[img]});
			}
		}
		
		private function removeThis(img:Image) : void
		{
			if(img.parent) img.parent.removeChild(img);
		}

		
		/**
		 * 删除大风特效
		 * 
		 */		
		public function leaveWindEffect() : void
		{
			if(_windImageList == null) return ;
			for(var i:int = _windImageList.length - 1; i >= 0; i--)
			{
				if(_windImageList[i].parent) _windImageList[i].parent.removeChild(_windImageList[i]);
				_windImageList[i].dispose();
				_windImageList[i] = null;
			}
			_windImageList.length = 0;
			_windImageList = null;
			_littleWindTimer.reset();
			_windTimer.reset();
			_windPanel.removeEventListener(Event.ENTER_FRAME, onWindFrameHandler);
			Log.Trace("大风天气结束");
		}
		
		/**
		 * 删除大风素材
		 * 
		 */		
		public function removeWindEffect() : void
		{
			removeBlackEffect();
			if(!_windImageList) return ;
			leaveWindEffect();
			_windTexture_1.dispose();
			_windTexture_1 = null;
			_windTexture_2.dispose();
			_windTexture_2 = null;
			_windTexture_3.dispose();
			_windTexture_3 = null;
			
			removeWindMC(_windBackEffect);
			removeWindMC(_windFrontEffect);
			removeWindMC(_windFrontFashionEffect);
			removeWindMC(_windBackFashionEffect);
		}
		
		private function removeWindMC(mcList:Vector.<MovieClip>) : void
		{
			for(var i:int = mcList.length - 1; i >= 0; i--)
			{
				if(mcList[i].parent) mcList[i].parent.removeChild(mcList[i]);
				mcList[i].stop()
				mcList[i].currentFrame = 0;
				Starling.juggler.remove(mcList[i]);
				if(i == 0) mcList[i].texture.dispose();
				mcList[i].dispose();
				mcList[i] = null;
			}
			mcList.length = 0;
			mcList = null;
		}
		
		public function removeAll() : void
		{
			removeBlackEffect();
			removeRainEffect();
			removeThunderEffect();
			removeWindEffect();
		}
	}
}
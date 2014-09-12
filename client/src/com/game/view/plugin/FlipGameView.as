package com.game.view.plugin
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	
	import flash.display.Bitmap;
	import flash.utils.getTimer;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class FlipGameView extends BaseView implements IView
	{
		private static const CARD_COUNT:int = 18;
		private static const INTERVALX:int = 115;
		private static const INTERVALY:int = 150;
		private static const OFFSETX:int = 185;
		private static const OFFSETY:int = 190;
		private static const LASTTIME:int = 40;
		private static const LIGHT:String = "light_00";
		private static const DIGIT:String = "go_00";
		private var _anti:Antiwear;
		/**
		 * 列数
		 */		
		private var _widthCount:int = 6;
		/**
		 * 行数
		 */		
		private var _heightCount:int = 3;
		private var _positionXML:XML;
		private var _titleTxAtlas:TextureAtlas;
		/**
		 * 未配对的牌数组
		 */		
		private var _cardLibrary:Vector.<CardEntity>;
		/**
		 * 已配对的牌数组
		 */		
		private var _cardRemoveLibrary:Vector.<CardEntity>;
		/**
		 * 牌所代表的人物
		 */		
		private var _cardData:Array;
		/**
		 * 翻转过来的第一张牌
		 */		
		private var _firstCard:CardEntity;
		/**
		 * 翻转过来的第二张牌
		 */		
		private var _secondCard:CardEntity;
		
		private var _experience:TextField;
		private var _flipCount:TextField;
		/**
		 * 游戏时间倒计时文本框
		 */		
		private var _coldTime:TextField;
		private var _progressBar:Image;
		private var _progressBg:Image;
		private var _countDownCount:int;
		/**
		 * 游戏结束信息框
		 */		
		private var _flipGameOverComponent:FlipGameOverComponent;
		private var _flipStartTime:int;
		private var _curCardIndex:int;
		
		private var _mainRole:RoleModel;
		
		/**
		 * 
		 */		
		private var _lightEffect:MovieClip;
		
		private var _lightLibrary:Vector.<MovieClip>;
		
		private var _coldDownDigit:MovieClip;
		
		private function set experienceNum(value:int) :void
		{
			_anti["experienceNum"] = value;
		}
		
		private function get experienceNum() : int
		{
			return _anti["experienceNum"];
		}
		
		private function set flipNum(value:int) : void
		{
			_anti["flipNum"] = value;
		}
		
		private function get flipNum() : int
		{
			return _anti["flipNum"];
		}
		
		private function set lastFlipCount(value:int) : void
		{
			_anti["lastFlipCount"] = value;
		}
		
		private function get lastFlipCount() : int
		{
			return _anti["lastFlipCount"];
		}
		
		private function set flipIntervalTime(value:Number) : void
		{
			_anti["flipIntervalTime"] = value;
		}
		
		private function get flipIntervalTime() : Number
		{
			return _anti["flipIntervalTime"];
		}
		
		private function set roleLv(value:int) :void
		{
			_anti["roleLv"] = value;
		}
		
		private function get roleLv() : int
		{
			return _anti["roleLv"];
		}
		
		private var ratioData:Object;
		
		public function FlipGameView()
		{
			_moduleName = V.FLIP_GAME;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.FLIP_GAME;
			
			_cardLibrary = new Vector.<CardEntity>();
			_cardRemoveLibrary = new Vector.<CardEntity>;
			_lightLibrary = new Vector.<MovieClip>;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["experienceNum"] = 0;
			_anti["flipNum"] = 0;
			_anti["lastFlipCount"] = 0;
			_anti["flipIntervalTime"] = LASTTIME + 1;
			_anti["roleLv"] = 0;
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch(type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
				case InterfaceTypes.GetTextures:
					return getTextures(args[0], "")
					break;
			}
		}
		
		override protected function init() : void
		{
			if(!this.isInit)
			{
				super.init();
				isInit = true;
				initXML();
				initTexture();
				initComponent();
				initUI();
				getUI();
				initLight();
				initCard();
				initEvent();
				initData();
			}
			
			initRender();
			_view.layer.setCenter(panel);
		}
		
		private function initXML() : void
		{
			_positionXML = getXMLData(V.FLIP_GAME, GameConfig.FLIP_GAME_RES, "FlipGamePosition");
		}
		
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.FLIP_GAME, GameConfig.FLIP_GAME_RES, "FlipGame");
				obj = getAssetsObject(V.FLIP_GAME, GameConfig.FLIP_GAME_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
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
					if(name == "PassGame")
					{
						cp = new FlipGameOverComponent(items, _titleTxAtlas);
						_components.push(cp);
					}
				}
			}
		}
		
		private function getUI() : void
		{
			_experience = this.searchOf("experience");
			_flipCount = this.searchOf("count");
			_progressBar = this.searchOf("ProgressBar");
			_progressBg = this.searchOf("BarBg");
			_coldTime = this.searchOf("coldTime");
			
			_flipGameOverComponent = this.searchOf("passGame") as FlipGameOverComponent;
			_flipGameOverComponent.hide();
		}
		
		/**
		 * 初始化过关特效
		 * 
		 */		
		private function initLight() : void
		{
			var frames:Vector.<Texture> = this.getTextures(LIGHT, "effect")
			for(var i:int = 0; i < 4; i ++)
			{
				var _light:MovieClip = new MovieClip(frames);
				_light.touchable = false;
				_light.stop();
				_lightLibrary.push(_light);
				Starling.juggler.add(_light);
			}
			
			var digitFrames:Vector.<Texture> = this.getTextures(DIGIT, V.PUBLIC);
			_coldDownDigit = new MovieClip(digitFrames);
			_coldDownDigit.touchable = false;
			_coldDownDigit.stop();
		}
		
		private function initCard() : void
		{
			_cardData = [];
			for(var i:uint = 1; i< CARD_COUNT * .5 + 1; i++)
			{
				_cardData.push(i);
				_cardData.push(i);
			}
			
			for(var j:uint = 0; j<_heightCount; j++)
			{
				for(var k:uint = 0; k<_widthCount; k++)
				{
					var card:CardEntity = new CardEntity();
					card.x = k * INTERVALX + OFFSETX;
					card.y = j * INTERVALY + OFFSETY;
					var r:int = Math.floor(Math.random() * _cardData.length);
					card.cardFace = _cardData[r];
					_cardData.splice(r, 1);
					panel.addChild(card);
					_cardLibrary.push(card);
				}
			}
		}
		
		/**
		 * 初始化经验数据和人物等级
		 * 
		 */		
		private function initData() : void
		{
			ratioData = Data.instance.db.interfaces(InterfaceTypes.GET_SMALLGAME_CARD);
			_mainRole = player.getRoleModel(V.MAIN_ROLE_NAME);
			roleLv = _mainRole.model.lv;
		}
		
		/**
		 * 点击事件
		 * @param e
		 * 
		 */		
		private function onTouchHandler(e:TouchEvent) : void
		{
			if(_firstCard != null && _secondCard != null) return;
			var touch:Touch = e.getTouch(panel);
			var curCard:CardEntity  = e.currentTarget as CardEntity;
			if(touch.phase == TouchPhase.ENDED && !curCard.alreadyFlip)
			{
				//第一张牌
				if(_firstCard == null)
				{
					_firstCard = curCard;
					curCard.startFlip(curCard.cardFace);
					curCard.addFilter();
					_firstCard.removeEventListener(TouchEvent.TOUCH, onTouchHandler);
				}
				//两次点击一张牌，回到背面
				/*else if(_firstCard == curCard)
				{
					curCard.removeFilter();
					curCard.startFlip(0);
					_firstCard = null;
				}*/
				//第二张牌
				else if(_secondCard == null)
				{
					curCard.addFilter();
					_secondCard = curCard;
					curCard.startFlip(curCard.cardFace);
					//两张牌一样
					if(_firstCard.cardFace == _secondCard.cardFace)
					{
						experienceNum += 1 * roleLv * ratioData[_firstCard.cardFace - 1].exp;
						flipNum ++;
						lastFlipCount = ((lastFlipCount < flipNum)?flipNum:lastFlipCount); 
						_firstCard.removeEventListener(TouchEvent.TOUCH, onTouchHandler);
						_secondCard.removeEventListener(TouchEvent.TOUCH, onTouchHandler);
						_cardLibrary.splice(_cardLibrary.indexOf(_firstCard), 1);
						_cardLibrary.splice(_cardLibrary.indexOf(_secondCard), 1);
						_cardRemoveLibrary.push(_firstCard);
						_cardRemoveLibrary.push(_secondCard);
						_firstCard.removeFilter();
						_secondCard.removeFilter();
						Starling.juggler.delayCall(delayEffect, .5, _firstCard, _secondCard);
						_firstCard = null;
						_secondCard = null;
						renderData();
					}
					//两张牌不一样
					else 
					{
						flipNum = 0;
						Starling.juggler.delayCall(returnCard, .5);
					}
				}
			}
		}
		
		private function delayEffect(card_1:CardEntity, card_2:CardEntity) : void
		{
			card_1.addEffect();
			card_2.addEffect();
		}
		
		/**
		 * 牌返回背面
		 * 
		 */		
		private function returnCard() : void
		{
			_firstCard.addEventListener(TouchEvent.TOUCH, onTouchHandler);
			_firstCard.startFlip(0);
			_secondCard.startFlip(0);
			_firstCard.removeFilter();
			_secondCard.removeFilter();
			_firstCard = null;
			_secondCard = null;		
		}
		
		private function initRender() : void
		{
			renderStart();
			renderData();
		}
		
		/**
		 * 延迟4秒开始——3，2，1，go！
		 * 
		 */		
		private function renderStart() : void
		{
			_countDownCount = 3;
			panel.addChildAt(_coldDownDigit, panel.numChildren - 1);
			_coldDownDigit.x = panel.width * .5 - _coldDownDigit.width * .5;
			_coldDownDigit.y = panel.height * .5 - _coldDownDigit.height * .5;
			_coldDownDigit.currentFrame = _countDownCount;
			juggle.delayCall(delayedStart, 1);
			juggle.delayCall(changeText, 1.5);
		}
		
		/**
		 * 改变游戏开始倒计时显示
		 * 
		 */		
		private function changeText() : void
		{
			_countDownCount--;
			if(_countDownCount < 0)
			{
				_coldDownDigit.parent.removeChild(_coldDownDigit);
				return;
			}
			_coldDownDigit.currentFrame = _countDownCount;
			juggle.delayCall(changeText, 1);
		}
		
		/**
		 * 开始翻转牌让玩家观看
		 * 
		 */		
		private function delayedStart() : void
		{
			_curCardIndex = 0;
			renderCard();
		}
		
		/**
		 * 按顺序翻转牌
		 * 
		 */		
		private function renderCard() : void
		{
			_cardLibrary[_curCardIndex].startFlip(_cardLibrary[_curCardIndex].cardFace);
			_cardLibrary[_curCardIndex + _widthCount].startFlip(_cardLibrary[_curCardIndex + _widthCount].cardFace);
			_cardLibrary[_curCardIndex + _widthCount * 2].startFlip(_cardLibrary[_curCardIndex + _widthCount * 2].cardFace);
			Starling.juggler.delayCall(returnCardBack, 1, _curCardIndex);
			_curCardIndex++;
			if(_curCardIndex == _widthCount)
			{
				Starling.juggler.delayCall(addEvent, 1.5);
				return;
			}
			Starling.juggler.delayCall(renderCard, .5);
		}
		
		/**
		 * 返回背面
		 * @param curIndex
		 * 
		 */		
		private function returnCardBack(curIndex:int) : void
		{
			_cardLibrary[curIndex].startFlip(0);
			_cardLibrary[curIndex + _widthCount].startFlip(0);
			_cardLibrary[curIndex + _widthCount * 2].startFlip(0);
		}
		
		/**
		 * 牌添加点击时间和添加时间事件
		 * 
		 */		
		private function addEvent() : void
		{
			//为所有牌添加点击事件
			for(var i:uint = 0; i < _cardLibrary.length; i++)
			{
				_cardLibrary[i].addEventListener(TouchEvent.TOUCH, onTouchHandler);
			}
			
			_flipStartTime = getTimer();
			panel.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		/**
		 * 主循环函数，时间设置
		 * @param e
		 * 
		 */		
		private function onEnterFrameHandler(e:Event) : void
		{
			var intervalTime:int = getTimer() - _flipStartTime;
			flipIntervalTime -= intervalTime * .001;
			_flipStartTime = getTimer();
			
			renderText();
			judgeGameOver();
		}
		
		/**
		 * 游戏倒计时显示
		 * 
		 */		
		private function renderText() : void
		{
			_coldTime.text = int(flipIntervalTime).toString();
			_progressBar.width = ((flipIntervalTime - 1)<0?0:(flipIntervalTime - 1)) / LASTTIME * _progressBg.width;
		}
		
		/**
		 * 判断游戏是否结束
		 * 
		 */		
		private function judgeGameOver() : void
		{
			//时间结束或者所有牌都翻转正确
			if(flipIntervalTime <= 0 || _cardLibrary.length == 0)
			{
				for(var i:uint = 0; i < _cardLibrary.length; i++)
				{
					_cardLibrary[i].removeEventListener(TouchEvent.TOUCH, onTouchHandler);
				}
				panel.removeEventListeners();
				setGameOverInfo();
			}
		}
		
		/**
		 * 设置游戏结束信息框
		 * 
		 */		
		private function setGameOverInfo() : void
		{
			_flipGameOverComponent.showing(experienceNum, lastFlipCount);
			setLightPosition();
		}
		
		/**
		 * 设置过关特效
		 * 
		 */		
		private function setLightPosition() : void
		{
			var position:Array = [[60,-20], [360, -20], [60, 200], [360, 200]];
			for(var i:int = 0; i < _lightLibrary.length; i++)
			{
				_lightLibrary[i].x = position[i][0];
				_lightLibrary[i].y = position[i][1];
				_lightLibrary[i].currentFrame = Math.floor(Math.random() * _lightLibrary.length);
				_lightLibrary[i].play();
				panel.addChild(_lightLibrary[i]);
			}
		}
		
		/**
		 * 经验值和连翻数显示
		 * 
		 */		
		private function renderData() : void
		{
			_experience.text = experienceNum.toString();
			_flipCount.text = lastFlipCount.toString();
			//连翻数放大效果
			if(flipNum != 0 && flipNum == lastFlipCount)
			{
				var tween:Tween = new Tween(_flipCount, .3);
				tween.animate("scaleX", 1.5);
				tween.animate("scaleY", 1.5);
				tween.onComplete = tweenComplete;
				Starling.juggler.add(tween);
			}
		}
		
		/**
		 * 连翻数缩小
		 * 
		 */
		private function tweenComplete() : void
		{
			var tween:Tween = new Tween(_flipCount, .3);
			tween.animate("scaleX", 1);
			tween.animate("scaleY", 1);
			Starling.juggler.add(tween);
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.pluginGame.interfaces(InterfaceTypes.GetTextures, name);
			}
			else if(type == "effect")
			{
				textures = _view.other_effect.interfaces(InterfaceTypes.GetTextures, name);
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
				texture = _view.pluginGame.interfaces(InterfaceTypes.GetTexture, name);
			}
			else if(type == "effect")
			{
				texture = _view.other_effect.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			return texture;
		}
		
		/**
		 * 重写close函数
		 * 
		 */		
		override public function close() : void
		{
			clearLibrary();
			clearResource();
			super.close();
		}
		
		/**
		 * 清除牌数组
		 * 
		 */		
		private function clearLibrary() : void
		{
			while(_cardLibrary.length != 0)
			{
				var obj_1:CardEntity = _cardLibrary.shift();
				_cardLibrary.splice(0, 1);
				obj_1.clear();
			}
			while(_cardRemoveLibrary.length != 0)
			{
				var obj_2:CardEntity = _cardRemoveLibrary.shift();
				_cardRemoveLibrary.splice(0, 1);
				obj_2.clear();
			}
		}
		
		/**
		 * 清除纹理
		 * 
		 */		
		private function clearResource() : void
		{
			_titleTxAtlas.dispose();
			_titleTxAtlas = null;
			
			while(_lightLibrary.length != 0)
			{
				var light:MovieClip = _lightLibrary.shift();
				_lightLibrary.splice(0, 1);
				light.removeEventListeners();
				light.texture.dispose();
				light.dispose();
				light = null;
			}
			
			_coldDownDigit.texture.dispose();
			_coldDownDigit.dispose();
			_coldDownDigit = null;
		}
	}
}
package com.game.view.plugin
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.View;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Entity;
	
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class CardEntity extends Sprite
	{
		private static const CARD_STATE:String = "Card000";
		private static const CARD_EFFECT:String = "success_00";
		private static const CARD_CLICK:String = "click_00";
		private var _anti:Antiwear;
		private var _view:View;
		private var _curCard:MovieClip;
		private var _effectMC:MovieClip;
		private var _clickMC:MovieClip;
		private var _flipStep:int;
		private var _curFrame:int;
		
		public function set alreadyFlip(value:Boolean) :void
		{
			_anti["alreadyFlip"] = value;
		}
		
		public function get alreadyFlip() : Boolean
		{
			return _anti["alreadyFlip"];
		}
		
		public function set cardFace(value:int) : void
		{
			_anti["cardFace"] = value;
		}
		
		public function get cardFace() : int
		{
			return _anti["cardFace"];
		}
		
		public function CardEntity()
		{
			_view = View.instance;
			
			_anti = new Antiwear(new binaryEncrypt());
			cardFace = 0;
			alreadyFlip = false;
			
			init();
		}
		
		/**
		 * 初始化纹理
		 * 
		 */		
		private function init() : void
		{
			_curCard = getMovieClip();
			_curCard.stop();
			addChild(_curCard);
			Starling.juggler.add(_curCard);
			
			_effectMC = initEffect();
			_effectMC.stop();
			_effectMC.loop = false;
			_effectMC.touchable =false;
			Starling.juggler.add(_effectMC);
			
			_clickMC = initClick();
			_clickMC.stop();
			_clickMC.touchable = false;
			Starling.juggler.add(_clickMC);
		}
		
		/**
		 * 获得牌的元件
		 * @return 
		 * 
		 */		
		private function getMovieClip() : MovieClip
		{
			var mp:MovieClip;
			var frames:Vector.<Texture> = _view.flip_Game.interfaces(InterfaceTypes.GetTextures, CARD_STATE);
			mp = new MovieClip(frames);
			
			mp.pivotX = mp.width/2;
			mp.pivotY = mp.height/2;
			
			return mp;
		}
		
		/**
		 * 初始化配对成功的特效
		 * @return 
		 * 
		 */		
		private function initEffect() : MovieClip
		{
			
			var frames:Vector.<Texture> = _view.flip_Game.interfaces(InterfaceTypes.GetTextures, CARD_EFFECT);
			var effectMC:MovieClip = new MovieClip(frames);
			
			effectMC.pivotX = effectMC.width/2;
			effectMC.pivotY = effectMC.height/2;
			
			return effectMC;
		}
		
		/**
		 * 初始化点击牌的特效
		 * @return 
		 * 
		 */		
		private function initClick() : MovieClip
		{
			var frames:Vector.<Texture> = _view.flip_Game.interfaces(InterfaceTypes.GetTextures, CARD_CLICK);
			var mc:MovieClip = new MovieClip(frames);
			
			mc.width = mc.width * 1.05;
			mc.height = mc.height * 1.05;
			
			mc.pivotX = mc.width/2;
			mc.pivotY = mc.height/2;
			
			mc.x = 3;
			mc.y = 3;
			
			return mc;
		}
		
		/**
		 * 开始翻转
		 * @param curFrame
		 * 
		 */		
		public function startFlip(curFrame:int) : void
		{
			_curFrame = curFrame;
			_flipStep = 10;
			alreadyFlip = true;
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		/**
		 * 翻转循环函数
		 * @param e
		 * 
		 */		
		private function onEnterFrameHandler(e:Event) : void
		{
			_flipStep--;
			if(_flipStep > 5)
			{
				this.scaleX = .2 * (_flipStep - 6);
			}
			else 
			{
				this.scaleX = .2 * (5 - _flipStep);
			}
			if(_flipStep == 5) _curCard.currentFrame = _curFrame;
			if(_flipStep == 0)
			{
				this.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
				alreadyFlip = false;
			}
		}
		
		
		/**
		 * 添加配对成功的特效
		 * 
		 */		
		public function addEffect() : void
		{
			addChild(_effectMC);
			_effectMC.play();
		}
		
		/**
		 * 添加点击发光的特效
		 * 
		 */		
		public function addFilter() : void
		{
			addChild(_clickMC);
			_clickMC.play();
		}
		
		/**
		 * 去除点击发光的特效
		 * 
		 */		
		public function removeFilter() : void
		{
			removeChild(_clickMC);
			_clickMC.stop();
		}
		
		/**
		 * 清除
		 * 
		 */		
		public function clear() : void
		{
			_curCard.removeEventListeners();
			_curCard.texture.dispose();
			_curCard.dispose();
			_curCard = null;
			
			_effectMC.removeEventListeners();
			_effectMC.texture.dispose();
			_effectMC.dispose();
			_effectMC = null;
			
			_clickMC.removeEventListeners();
			_clickMC.texture.dispose();
			_clickMC.dispose();
			_clickMC = null;
			
			this.dispose();
		}
	}
}
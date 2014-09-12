package com.game.view.cartoon
{
	import com.engine.core.Log;
	import com.game.View;
	import com.game.template.GameConfig;
	import com.game.view.effect.FloatEffect;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class CartoonPlay extends Sprite
	{
		public static const COMPLETE:String = "complete";
		
		private var _textures:Vector.<Texture>;
		private var _total:int;
		private var _curPage:int;
		private var _curImage:Image;
		private var _nextImage:Image;
		
		private var _hand:Image;
		private var _handFloatEffect:FloatEffect;
		public function CartoonPlay(textures:Vector.<Texture>)
		{
			Log.Trace("CartoonPlay init!");
			super();
			
			_textures = textures;
			_total = _textures.length;
			_curPage = 1;

			initEvent();
			setEventDisable(false);
			_hand = new Image(View.instance.publicRes.titleTxAtlas.getTexture("hand"));
			_hand.visible = false;
			_hand.x = 800;
			_hand.y = 500;
			addChild(_hand);
			_handFloatEffect = new FloatEffect(_hand, 5);
			_handFloatEffect.play();
		}
		
		private function initEvent() : void
		{
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this);
			
			if (touch && touch.phase == TouchPhase.ENDED)
			{
				onMove();
			}
		}
		
		private function onMove() : void
		{
			Log.Trace("CartoonPlay Move!");
			if(_curImage == null)
			{
				Log.Trace("动画不存在！");
				this.dispatchEventWith(CartoonPlay.COMPLETE);
				return;
			}
			
			if (_curPage >= _total)
			{
				this.dispatchEventWith(CartoonPlay.COMPLETE);
				return;
			}
			
			setEventDisable(false);
			
			var curTween:Tween = new Tween(_curImage, 1);
			curTween.moveTo(-GameConfig.CAMERA_WIDTH, 0);
			curTween.onComplete = onMoveComplete;
			Starling.juggler.add(curTween);
			
			var nextTween:Tween = new Tween(_nextImage, 1);
			nextTween.moveTo(0, 0);
			Starling.juggler.add(nextTween);
		}
		
		private function onMoveComplete() : void
		{
			_curPage++;
			
			if (_curPage < _total)
			{
				onPlay();
			}
			else
			{
				setEventDisable(true);
			}
		}
		
		public function start() : void
		{
			Log.Trace("Cartoon Play!");
			
			_curPage = 1;
			
			_hand.visible = true;
			show();
			onPlay();
		}
		
		private function onPlay() : void
		{
			if(_curImage)
			{
				_curImage.dispose();
				if (_curImage.parent) _curImage.parent.removeChild(_curImage);
				_curImage = null;
			}
			
			if(_nextImage)
			{
				_nextImage.dispose();
				if (_nextImage.parent) _nextImage.parent.removeChild(_nextImage);
				_nextImage = null;
			}
			
			var curTexture:Texture = _textures[_curPage - 1];
			_curImage = new Image(curTexture);
			addChild(_curImage);
			_curImage.x = 0;
			
			if (_curPage < _total)
			{
				var nextTexture:Texture = _textures[_curPage];
				_nextImage = new Image(nextTexture);
				addChild(_nextImage);
				_nextImage.x = GameConfig.CAMERA_WIDTH;
			}
			
			setEventDisable(true);
			this.setChildIndex(_hand, this.numChildren - 1);
		}
		
		protected function setEventDisable(disable:Boolean) : void
		{
			this.touchable = disable;
		}
		
		public function show() : void
		{
			this.visible = true;
		}
		
		public function clear() : void
		{
			
			_hand.dispose();
			_hand = null;
			_handFloatEffect.destroy();
			
			this.removeEventListeners();
			this.dispose();

			_curImage.dispose();
			_curImage = null;
			
			if (_nextImage)
			{
				_nextImage.dispose();
				_nextImage = null;
			}
		}
	}
}
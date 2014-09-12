package com.game.view.dice
{
	import com.engine.event.EventTypes;
	import com.game.View;
	import com.game.view.Entity;
	
	import starling.animation.IAnimatable;
	import starling.animation.Tween;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.Texture;

	public class DiceEntity extends Entity
	{
		private var _runTextures:Vector.<Texture>;
		private var _standTextures:Vector.<Texture>;
		private var _curRandomPoint:uint;
		public function set curRandomPoint(value:uint) : void
		{
			_curRandomPoint = value;
		}
		
		public const FPS:uint = 15;
		
		protected const PLAY_TIME:uint = 80;
		
		private var _isPlay:Boolean;
		public function get isPlay() : Boolean
		{
			return _isPlay;
		}
		public function set isPlay(value:Boolean) : void
		{
			_isPlay = value;
			_playCount = FPS;
			
			checkStatus();
		}
		
		public function DiceEntity(runTextures:Vector.<Texture>, standTextures:Vector.<Texture>, x:Number = 0, y:Number = 0, type:String = 'dice')
		{
			_runTextures = runTextures;
			_standTextures = standTextures;
			
			_isPlay = false;
			super(x, y, type);
		}
		
		override public function added() : void
		{
			super.added();
			
			init();
		}
		
		private var _runDice:MovieClip;
		private var _standDice:Image;
		private function init() : void
		{
			_runDice = new MovieClip(_runTextures, FPS);
			_runDice.pivotX = _runDice.width/2;
			_runDice.pivotY = _runDice.height/2;
			addToStage(_runDice);
			
			_standDice = new Image(_standTextures[0]);
			_standDice.pivotX = _standDice.width/2;
			_standDice.pivotY = _standDice.height * 0.6;
			addToStage(_standDice);
			
			checkStatus(false);
		}
		
		private function stop(isDispatch:Boolean = true) : void
		{
			_runDice.stop();
			_runDice.visible = false;
			_standDice.visible = true;
			
			if (isDispatch)
			{
				var tween:Tween = new Tween(_standDice, 1);
				tween.onComplete = onDelayComplete;
				view.juggle.add(tween);
			}
			else
			{
				_standDice.visible = false;
			}
		}
		
		private function onDelayComplete() : void
		{
			_standDice.visible = false;
			this.dispatchEventWith(EventTypes.DICE_STOP, true, _curRandomPoint + 1);
		}
		
		private var _playCount:uint = 0;
		private function start(isDispatch:Boolean = true) : void
		{
			_standDice.visible = false;
			
			_runDice.visible = true;
			_runDice.currentFrame = 1;
			_runDice.play();
			
			//_curRandomPoint = getRandomPoint();
			_standDice.texture = _standTextures[_curRandomPoint];
		}
		
		private function checkStatus(isDispatch:Boolean = true) : void
		{
			if (_isPlay) start();
			else stop(isDispatch);
		}
		
		private function comfireDice() : void
		{
			//_curRandomPoint = getRandomPoint();
			onDelayComplete();
		}
		
		/**
		 * 自动获得骰子点数
		 * 
		 */		
		public function checkAuto() : void
		{
			//_curRandomPoint = getRandomPoint();
			onDelayComplete();
		}
		
		override public function update():void
		{
			super.update();
			
			if (_playCount != 0)
			{
				_playCount--;
			}
			else if (_isPlay)
			{
				_isPlay = false;
				stop();
			}
		}
		
		override public function removed():void
		{
			view.juggle.remove(_runDice);
		}
		
		private function addToStage(obj:DisplayObject) : void
		{
			if (!obj) return;
			
			if (!obj.parent) addChild(obj);
			
			if (obj is IAnimatable) view.juggle.add(obj as IAnimatable);
		}
		
		private function removeFromStage(obj:DisplayObject) : void
		{
			if (!obj) return;
			
			if (obj.parent) obj.parent.removeChild(obj);
			
			if (obj is IAnimatable) view.juggle.remove(obj as IAnimatable);
		}
		
		private function getRandomPoint() : uint
		{
			return Math.random() * 6;
		}
	}
}
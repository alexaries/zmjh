package com.game.view.effect
{
	import starling.animation.DelayedCall;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	
	public class OriginalShakeEffect
	{
		private static const INTERVAL_TIME:Number = .02;
		private static const ROTATION:Number = .16;
		private var _thisObj_1:DisplayObject;
		private var _tween_1:Tween;
		private var _startY_1:int;
		private var _startX_1:int;
		private var _startPivotX:int;
		private var _startPivotY:int;
		private var _changePivotX_1:int;
		private var _changePivotY_1:int;
		private var _isPlay:Boolean;
		private var _count:int;
		private var _commonDelay:DelayedCall;
		public function get isPlay() : Boolean
		{
			return _isPlay;
		}
		
		public function OriginalShakeEffect(obj_1:DisplayObject)
		{
			_isPlay = false;
			
			_thisObj_1 = obj_1;
			_startX_1 = _thisObj_1.x;
			_startY_1 = _thisObj_1.y;
			_startPivotX = _thisObj_1.pivotX;
			_startPivotY = _thisObj_1.pivotY;
			_changePivotX_1 = _thisObj_1.pivotX * ROTATION;
			_changePivotY_1 = _thisObj_1.pivotY * ROTATION;
			
			_count = 0;
		}
		
		public function play() : void
		{
			if(!_isPlay)
			{
				_isPlay = true;
				_thisObj_1.pivotY = _startPivotY + _changePivotX_1;
				_thisObj_1.y = _startY_1 + _changePivotX_1;
				
				onStartFun();
			}
		}
		
		private function onStartFun() : void
		{
			_thisObj_1.pivotX = _startPivotX - _changePivotX_1;
			_thisObj_1.x = _startX_1 - _changePivotX_1;
			
			Starling.juggler.remove(_tween_1);
			_tween_1 = new Tween(_thisObj_1, INTERVAL_TIME);
			_tween_1.reverse = true;
			_tween_1.repeatCount = 2;
			_tween_1.animate("rotation", -15 * Math.PI / 180);
			_tween_1.onComplete = onContinueFun;
			
			if(_count < 2)
				_tween_1.animate("y", (_thisObj_1.y - 5));
			else 
				_tween_1.animate("y", (_thisObj_1.y + 5));
			
			if(_count < 4)
				Starling.juggler.add(_tween_1);
			else
			{
				_count = 0;
				_commonDelay = Starling.juggler.delayCall(function () : void{Starling.juggler.add(_tween_1);}, 1.5);
			}
			
		}
		
		private function onContinueFun() : void
		{
			_thisObj_1.pivotX = _startPivotX + _changePivotX_1;
			_thisObj_1.x = _startX_1 + _changePivotX_1;
			
			Starling.juggler.remove(_tween_1);
			_tween_1 = new Tween(_thisObj_1, INTERVAL_TIME);
			_tween_1.reverse = true;
			_tween_1.repeatCount = 2;
			_tween_1.animate("rotation", 15 * Math.PI / 180);
			_tween_1.onComplete = onStartFun;
			Starling.juggler.add(_tween_1);
			
			if(_count < 2)
				_tween_1.animate("y", (_thisObj_1.y - 5));
			else 
				_tween_1.animate("y", (_thisObj_1.y + 5));
			
			_count++;
		}
		
		public function stop() : void
		{
			if(_isPlay)
			{
				_isPlay = false;
				_thisObj_1.rotation = 0;
				_thisObj_1.y = _startY_1;
				_thisObj_1.pivotY = _startPivotY;
				_thisObj_1.x = _startX_1;
				_thisObj_1.pivotX = _startPivotX;
				Starling.juggler.remove(_tween_1);
				_count = 0;
				if(_commonDelay != null) Starling.juggler.remove(_commonDelay);
			}
		}
	}
}
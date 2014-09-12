package com.game.view.effect
{
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;

	public class EffectShow
	{
		private var _objList:Vector.<DisplayObject>;
		private var _delayTimeList:Vector.<Number>;
		private var _callbackFunList:Vector.<Function>;
		private var _showFunList:Vector.<Function>;
		private var _panel:Sprite;
		private var _count:int;
		
		public function EffectShow(panel:Sprite)
		{
			_panel = panel;
			reset();
		}
		
		/**
		 * 添加动画特效
		 * @param obj			动画元件
		 * @param delayTime		动画持续时间
		 * @param delayFun		动画播放结束后的回调函数
		 * @param showFun		动画播放过程中的执行函数
		 * 
		 */		
		public function addShowObj(obj:DisplayObject, delayTime:Number = 0, callback:Function = null, showFun:Function = null) : void
		{
			_objList.push(obj);
			_delayTimeList.push(delayTime);
			_callbackFunList.push(callback);
			_showFunList.push(showFun);
		}
		
		/**
		 * 开始播放动画
		 * 
		 */		
		public function start() : void
		{
			if(_count >= _objList.length)
			{
				reset();
				return;
			}
			continueShowObj(_objList[_count], _delayTimeList[_count], _callbackFunList[_count], _showFunList[_count]);
		}
		
		/**
		 * 还原
		 * 
		 */		
		private function reset() : void
		{
			_count = 0;
			_objList = new Vector.<DisplayObject>();
			_delayTimeList = new Vector.<Number>();
			_callbackFunList = new Vector.<Function>();
			_showFunList = new Vector.<Function>();
		}
		
		/**
		 * 逐步添加动画特效
		 * @param obj
		 * @param delayTime
		 * @param callback
		 * @param showFun
		 * 
		 */		
		private function continueShowObj(obj:DisplayObject, delayTime:Number, callback:Function = null, showFun:Function = null) : void
		{
			if(obj == null || _panel == null) return;
			
			addObj(_panel, obj);
			if(showFun != null) showFun(obj);
			if(obj is MovieClip && delayTime == 0)
				(obj as MovieClip).addEventListener(Event.COMPLETE, onPlayComplete);
			else
				Starling.juggler.delayCall(onPlayComplete, delayTime);
			
			function onPlayComplete(e:Event = null) : void
			{
				if(e != null)
					(obj as MovieClip).removeEventListener(Event.COMPLETE, onPlayComplete);
				
				_count++;
				removeObj(obj);
				if(callback != null) callback();
				start();
			}
		}
		
		/**
		 * 删除
		 * @param mc
		 * 
		 */	
		private function removeObj(obj:DisplayObject) : void
		{
			if(obj.parent) obj.parent.removeChild(obj);
			if(obj is MovieClip)
			{
				var item:MovieClip = obj as MovieClip;
				item.stop();
				Starling.juggler.remove(item);
			}
			obj.visible = false;
		}
		
		/**
		 * 添加
		 * @param thisPanel
		 * @param mc
		 * 
		 */		
		private function addObj(thisPanel:Sprite, obj:DisplayObject) : void
		{
			thisPanel.addChild(obj);
			if(obj is MovieClip)
			{
				var item:MovieClip = obj as MovieClip;
				item.currentFrame = 0;
				item.play();
				Starling.juggler.add(item);
			}
			obj.visible = true;
		}
	}
}
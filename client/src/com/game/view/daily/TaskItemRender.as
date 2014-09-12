package com.game.view.daily
{
	import com.engine.ui.controls.IGrid;
	import com.game.View;
	import com.game.template.InterfaceTypes;
	import com.game.view.effect.GlowAnimationEffect;
	import com.game.view.effect.TextColorEffect;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class TaskItemRender extends Sprite implements IGrid
	{
		private var _view:View = View.instance;
		private var _image:Image;
		private var _taskDetail:*;
		private var _taskBar:TaskBarComponent;
		private var _taskComfire:Boolean;
		
		public function TaskItemRender()
		{
			_taskComfire = false;
		}
		
		private var _tween_1:Tween;
		private var _barEffect:GlowAnimationEffect;
		private var _textEffect:TextColorEffect;
		public function setData(taskDetail:*) : void
		{
			_taskDetail = taskDetail;
			if(!_taskDetail) return;
			
			_taskBar = _view.task.interfaces(InterfaceTypes.GET_TASKBAR_COMPONENT);
			_taskBar.taskName.text = _taskDetail.mission_name.toString();
			
			this.useHandCursor = true;
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(_taskBar.panel);
			
			_textEffect = new TextColorEffect(_taskBar.taskName, 0xFF0000, 0xFFFF00, 0x000000, .6);
			_barEffect = new GlowAnimationEffect(this, 0xFFFF00);
		}
		
		public function play() : void
		{
			_barEffect.play();
			_textEffect.play();
		}
		
		public function stop() : void
		{
			_barEffect.stop();
			_textEffect.stop();
		}
		
		public function addAlready() : void
		{
			_taskBar.alreadyGet.visible = true;
		}
		
		public function removeAlready() : void
		{
			_taskBar.alreadyGet.visible = false;
		}
		
		private function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this);
			if(touch)
			{
				if(touch.phase == TouchPhase.ENDED)
				{
					_view.task.interfaces(InterfaceTypes.GET_TASKDETAIL, _taskDetail);
					_taskBar.taskBar.currentFrame = 1;
					_taskComfire = true;
				}
				else if (touch.phase == TouchPhase.HOVER)
				{
					_taskBar.taskBar.currentFrame = 1;
				}
			}
			else if(!touch && !_taskComfire)
			{
				_taskBar.taskBar.currentFrame = 0;
			}
		}
		
		public function setState() : void
		{
			_taskBar.taskBar.currentFrame = 1;
			_taskComfire = true;
		}
		
		public function resetTouch() : void
		{
			_taskBar.taskBar.currentFrame = 0;
			_taskComfire = false;
		}
		
		public function clear() : void
		{			
			this.removeEventListeners();
			this.dispose();
		}
	}
}
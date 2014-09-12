package com.game.view.dailyWork
{
	import com.engine.ui.controls.IGrid;
	import com.game.View;
	import com.game.template.InterfaceTypes;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class DailyWorkItemRender extends Sprite implements IGrid
	{
		public function DailyWorkItemRender()
		{
			_dailyWorkComfire = false;
		}
		
		public function setData(data:*):void
		{
		}
		
		private var _view:View = View.instance;
		private var _image:Image;
		private var _dailyWorkDetail:*;
		private var _dailyWorkComponent:DailyWorkComponent;
		private var _dailyWorkComfire:Boolean;


		public function setData(dailyWorkDetail:*) : void
		{
			_dailyWorkDetail = dailyWorkDetail;
			if(!_dailyWorkDetail) return;
			
			_dailyWorkComponent = _view.daily_work.interfaces(InterfaceTypes.GET_DAILY_WORK_COMPONENT);
			_dailyWorkComponent.dailyWorkName.text = _dailyWorkDetail.mission_name.toString();
			
			this.useHandCursor = true;
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(_dailyWorkComponent.panel);
		}
		
		
		public function addAlready() : void
		{
			_dailyWorkComponent.dailyWorkComplete.visible = true;
		}
		
		public function removeAlready() : void
		{
			_dailyWorkComponent.dailyWorkCompleteImage.visible = false;
		}
		
		private function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this);
			if(touch)
			{
				if(touch.phase == TouchPhase.ENDED)
				{
					_view.task.interfaces(InterfaceTypes.GET_TASKDETAIL, _dailyWorkDetail);
					_dailyWorkComfire = true;
				}
				else if (touch.phase == TouchPhase.HOVER)
				{
				}
			}
			else if(!touch && !_dailyWorkComfire)
			{
			}
		}
		
		public function setState() : void
		{
			_dailyWorkComfire = true;
		}
		
		public function resetTouch() : void
		{
			_dailyWorkComfire = false;
		}
		
		public function clear() : void
		{			
			this.removeEventListeners();
			this.dispose();
	}
}
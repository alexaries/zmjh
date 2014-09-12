package com.engine.ui.controls
{
	import com.engine.ui.core.BaseSprite;
	import com.game.view.Component;
	import com.game.view.Role.ChangePageComponent;
	import com.game.view.worldBoss.RankAreaComponent;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class ComponentGrid extends BaseSprite
	{
		private var _CS:Vector.<Component>;
		
		/**
		 * 行 
		 */		
		private var _col:int;
		/**
		 * 列 
		 */		
		private var _row:int;
		
		private var _W:int;
		
		private var _H:int;
		
		private var _offsetX:int; 
		
		private var _offsetY:int;
		
		private var _data:*;
		
		private var _uiPool:Object; 
		
		private var _curPage:uint;
		
		private var _pageNum:uint;
		
		public function ComponentGrid(CS:Vector.<Component>, col:uint, row:uint, W:int, H:int, offsetX:int, offsetY:int)
		{
			_CS = CS;
			_col = col;
			_row = row;
			_W = W;
			_H = H;
			_offsetX = offsetX;
			_offsetY = offsetY;
			
			_curPage = 1;
			_pageNum = col*row;
			_uiPool = {};
		}
		
		private var _navi:ChangePageComponent;
		public function setData(data:*, pageNavi:ChangePageComponent = null, CS:Vector.<Component> = null) : void
		{
			_data = data;
			_navi = pageNavi;
			if(CS != null) _CS = CS;
			
			if(_navi){
				var dataLen:uint = _data["length"];
				_navi.setData(dataLen,this._pageNum);
				if(!_navi.hasEventListener(ChangePageComponent.PAGE_CHANGE_EVENT)){
					_navi.addEventListener(ChangePageComponent.PAGE_CHANGE_EVENT,naviPageChanged);
				}
			}
			
			resetData();
			initRender();
			checkPage();
		}
		
		private function naviPageChanged(evt:Event):void{
			this._curPage = uint(evt.data);
			
			resetData();
			initRender();
			checkPage();
		}
		
		public function clearOwn() : void
		{
			var item:Component;
			var items:Array;
			for (var key:String in _uiPool)
			{
				items = _uiPool[key];
				
				while (items.length > 0)
				{
					item = items.pop();
					if (item.panel.parent) item.panel.parent.removeChild(item.panel);
					item["clear"]();
					item = null;
				}
			}
		}
		
		private function resetData() : void
		{
			var item:Component;
			var items:Array;
			for (var key:String in _uiPool)
			{
				items = _uiPool[key];
				
				while (items.length > 0)
				{
					item = items.pop();
					if (item.panel.parent) item.panel.parent.removeChild(item.panel);
					item["clear"]();
					item = null;
				}
			}
		}
		
		private function initRender() : void
		{
			var item:Component;
			
			var index:int;
			for (var i:int = 0, len:int = _data["length"]; i < len; i++)
			{
				index = i /this._pageNum;
				if (! _uiPool[index]) _uiPool[index] = [];
				item = _CS[i];
				item.setGridData(_data[i]);
				item.panel.x = Math.floor(i % _row) * (_W + _offsetX);
				
				var j:int = Math.floor(i / _row);
				j = j % _col;
				item.panel.y = j * (_H + _offsetY);
				this.addChild(item.panel as DisplayObject);
				_uiPool[index].push(item);
			}
		}
		
		private function checkPage() : void
		{
			var item:Component;
			for (var key:String in _uiPool)
			{
				if (key == (_curPage-1).toString())
				{
					for each(item in _uiPool[key]) item.panel.visible = true;
				}
				else
				{
					for each(item in _uiPool[key]) item.panel.visible = false
				}
			}
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			if(this._data){
				_data = null;
			}
			if(this._navi){
				_navi = null;
			}
			super.destroy();
		}
	}
}
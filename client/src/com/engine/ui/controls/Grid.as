package com.engine.ui.controls
{
	import com.engine.ui.core.BaseSprite;
	import com.game.view.Role.ChangePageComponent;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class Grid extends BaseSprite
	{
		private var _CS:Class;
		
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
		
		public function Grid(CS:Class, col:uint, row:uint, W:int, H:int, offsetX:int, offsetY:int)
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
		public function setData(data:*, pageNavi:ChangePageComponent = null) : void
		{
			_data = data;
			_navi = pageNavi;
			
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
		
		private function resetData() : void
		{
			var item:DisplayObject;
			var items:Array;
			for (var key:String in _uiPool)
			{
				items = _uiPool[key];
				
				while (items.length > 0)
				{
					item = items.pop();
					if (item.parent) item.parent.removeChild(item);
					item["clear"]();
					item = null;
				}
			}
		}
		
		private function initRender() : void
		{
			var item:IGrid;
			
			var index:int;
			for (var i:int = 0, len:int = _data["length"]; i < len; i++)
			{
				index = i /this._pageNum;
				if (! _uiPool[index]) _uiPool[index] = [];
				item = new _CS();
				item.setData(_data[i]);
				item.x = Math.floor(i % _row) * (_W + _offsetX);
				
				var j:int = Math.floor(i / _row);
				j = j % _col;
				item.y = j * (_H + _offsetY);
				this.addChild(item as DisplayObject);
				_uiPool[index].push(item);
			}
		}
		
		private function checkPage() : void
		{
			var item:DisplayObject;
			for (var key:String in _uiPool)
			{
				if (key == (_curPage-1).toString())
				{
					for each(item in _uiPool[key]) item.visible = true;
				}
				else
				{
					for each(item in _uiPool[key]) item.visible = false;
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
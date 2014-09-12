package com.game.view
{
	import com.engine.core.Log;
	import com.engine.net.LoadResponder;
	import com.game.SuperBase;
	import com.game.SuperSubBase;
	import com.game.View;
	import com.game.data.player.structure.Player;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	
	import flash.net.LocalConnection;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;

	public class Base extends SuperSubBase
	{
		private var mLastFrameTimestamp:Number;
		private var _listeners:Vector.<ViewEventBind>;
		
		protected var _loaderModuleName:String;
		protected var hideBar:Function;
		protected var loadBar:Function;
		protected var _loadBaseName:String = '';
		protected var _loadResources:Array = [];
		protected var _instanceName:String;
		protected var _view:View;
		protected var _layer:String;
		protected var _moduleName:String;		
		public var panel:Sprite;
		public var juggle:Juggler;
		public var isJuggler:Boolean;
		private var _player:Player;
		protected function get player() : Player
		{
			return _view.controller.player.getPlayerData();
			
		}
		protected function set player(value:Player) : void
		{
			_player = value;
		}
		
		/**
		 * 该面板是否处于激活状态 
		 */		
		private var _active:Boolean;
		public function get active() : Boolean
		{
			return _active;
		}
		public function set active(value:Boolean) : void
		{
			_active = value;
			checkActive();
		}
		
		/**
		 * 是否初始化 
		 */		
		private var _isInit:Boolean;
		public function get isInit() : Boolean
		{
			return _isInit;
		}
		public function set isInit(value:Boolean) : void
		{
			_isInit = value;
		}
		
		/**
		 * 所有UI 
		 */		
		protected var _uiLibrary:Array;
		public function get uiLibrary() : Array
		{
			return _uiLibrary;
		}
		
		/**
		 * 组件 
		 */		
		protected var _components:Vector.<Component>;
		public function get components() : Vector.<Component>
		{
			return _components;
		}
		/*
		private var _guideCallback:Function;
		public function set guideCallback(value:Function) : void
		{
			_guideCallback = value;
		}
		
		private var _guideParam:int;
		public function set guideParam(value:int) : void
		{
			_guideParam = value;
		}
		
		private var _clickFun:Function
		public function set clickFun(value:Function) : void
		{
			_clickFun = value;
		}
		public function get clickFun() : Function
		{
			return _clickFun
		}
		
		private var _clickParam:Object
		public function set clickParam(value:Object) : void
		{
			_clickParam = value;
		}
		public function get clickParam() : Object
		{
			return _clickParam
		}
*/
		public function Base()
		{
			panel = new Sprite();
			juggle = new Juggler();
			_listeners = new Vector.<ViewEventBind>();
			_components = new Vector.<Component>();
			_uiLibrary = [];
			isJuggler = true;
			mLastFrameTimestamp = getTimer() / 1000.0;
		}

		protected function show() : void
		{
			Log.Trace(_moduleName);
			
			display();
			initLoad();
		}
		
		/**
		 * 加载资源 
		 * 
		 */		
		protected function initLoad() : void
		{
			var lr : LoadResponder = new LoadResponder(
				init,			
				loadProgress
			);
			
			if (_loadBaseName == '') _loadBaseName = _moduleName;			
			_loadResources.push(_loadBaseName);
			
			_view.res.loadResource(_loaderModuleName, lr, _loadResources);
		}
		
		protected function loadProgress(name:String, percent:Number, loadedSize:int, totalSize:int) : void
		{
			if (loadBar is Function)
			{
				try
				{
					loadBar(name, percent, loadedSize, totalSize);
				}catch (e:*) {loadBar()}
			}
			else
			{
				if (_view.load.isInit) 
				{
					_view.load.smallLoadProgressBar(name, percent, loadedSize, totalSize);
				}
			}
		}
		
		override public function settle(instanceName:String, s:SuperBase):void
		{
			if (null == _view)
			{
				_instanceName = instanceName;
				_view = s as View;
			}
			
			checkActive();
		}
		
		private function checkActive() : void
		{
			if (active)
			{
				_view.addToFrameProcessList(_instanceName, update);
			}
			else
			{
				_view.removeFromFrameProcessList(_instanceName);
			}
		}
		
		// 初始化
		protected function init() : void
		{
			if (_view.load.isInit) _view.load.hide();
			_view.loadData.hide();
			_view.preload.hide();
			
			active = true;
			
			if(!_allEntities) _allEntities = new Dictionary();
			if(!_addList) _addList = new Vector.<Entity>();
			if(!_removeList) _removeList = new Vector.<Entity>();
			
			
			/*
			if(_guideCallback != null)
			{
				_guideCallback(_guideParam);
				_guideCallback = null;
				_view.guide.clickContinue = _clickFun;
				_view.guide.clickContinueParam = _clickParam;
			}*/
		}
		
		// 监听事件
		protected function initEvent() : void
		{
			// event
			if (!panel.hasEventListener(TouchEvent.TOUCH)) 
			{
				panel.addEventListener(TouchEvent.TOUCH, onTouch);
			}
			
			panel.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event) : void
		{
			
		}
		
		/**
		 *  触摸（鼠标）
		 * @param e
		 * 
		 */
		protected function onTouch(e:TouchEvent) : void
		{
			var touch:Touch;
			for each(var eb:ViewEventBind in _listeners)
			{
				touch = e.getTouch(eb.target, eb.phase);
				
				if (!touch) continue;
				// 回调
				if (eb.isReturnParam) eb.callback(eb);
				else eb.callback();				
			}
		}
		
		public function addListener(item:ViewEventBind) : void
		{
			if (!(item && item.target && item.phase != '' && item.callback != null)) throw new Error("错误的事件添加");
			
			if (checkListener(item)) return;
			
			_listeners.push(item);
		}
		
		protected function checkListener(bind:ViewEventBind) : Boolean
		{
			var bol:Boolean = false;
			for each(var item:ViewEventBind in _listeners)
			{
				if (item.target.name == bind.target.name && item.phase == bind.phase)
				{
					bol = true;
					break;
				}
			}
			
			return bol;
		}
		
		protected function removeListener(target:DisplayObject, phase:String) : void
		{
			var eb:ViewEventBind;
			for (var i:int = 0; i < _listeners.length; i++)
			{
				eb = _listeners[i];
				
				if (eb.target == target && eb.phase == phase)
				{
					_listeners.splice(i, 1);
					i--;
				}
			}
		}
		
		protected function removeListeners(target:DisplayObject) : void
		{
			var eb:ViewEventBind;
			for (var i:int = 0; i < _listeners.length; i++)
			{
				eb = _listeners[i];
				
				if (eb.target == target)
				{
					_listeners.splice(i, 1);
					i--;
				}
			}
		}
		
		protected function removeAllListeners() : void
		{
			var eb:ViewEventBind;
			while(_listeners.length > 0)
			{
				eb = _listeners.pop();
				eb = null;
			}
		}
		
		/**
		 * 每帧调用 
		 * 
		 */		
		public function update() : void
		{
			updateLists();
			updateEntities();

			var now:Number = getTimer() / 1000.0;
			var passedTime:Number = now - mLastFrameTimestamp;
			mLastFrameTimestamp = now;
			if(isJuggler)
				juggle.advanceTime(passedTime);
		}
		
		private function updateLists() : void
		{
			processAddList();
			processRemoveList();
		}
		
		private function processAddList() : void
		{
			var entity:Entity;
			while (this._addList.length) 
			{
				entity = _addList[0];
				addEntityToLookUp(entity);
				entity.added();
				_addList.splice(0, 1);
			}
		}
		
		private function addEntityToLookUp(entity:Entity):void
		{
			var entityTypeArray:Vector.<Entity> = getType(entity.type);
			if (entityTypeArray == null || entityTypeArray.length == 0) 
			{
				entityTypeArray = new Vector.<Entity>();
			}
			entityTypeArray.push(entity);
			_allEntities[entity.type] = entityTypeArray;
		}
		
		private function processRemoveList() : void
		{
			var entity:Entity;
			while (this._removeList.length) 
			{
				entity = _removeList[0];
				entity.removed();
				panel.removeChild(entity);
				entity.view = null;
				removeFromObjectLookup(entity);
				_removeList.splice(0, 1);
			}
		}
		
		private function removeFromObjectLookup(entity:Entity):void
		{
			var entityTypeArray:Vector.<Entity> = this.getType(entity.type);
			var index:int = entityTypeArray.indexOf(entity);
			entityTypeArray.splice(index, 1);
			
			if (entityTypeArray.length == 0) 
			{
				entityTypeArray = null;
			}
		}
		
		/**
		 * 对象收集 
		 */		
		protected var _allEntities:Dictionary;
		protected var _addList:Vector.<Entity>;
		protected var _removeList:Vector.<Entity>;
		
		public function getType(type:String):Vector.<Entity>
		{
			return _allEntities[type];
		}
		
		public function add(entity:Entity) : void
		{
			entity.view = this;
			_addList.push(entity);
		}
		
		public function remove(entity:Entity) : void
		{
			if (!entity.view) 
			{
				trace("entity view 不能删除");
				return;
			}
			_removeList.push(entity);
		}
		
		public function removeAll() : void
		{
			var entity:Entity;
			var i:int = 0;
			for each (var entities:Vector.<Entity> in _allEntities) 
			{
				var numEntities:int = entities.length;
				for (i; i < numEntities; i++) 
				{
					entity = entities[i];
					remove(entity);
				}
			}
			
			updateLists();
		}
		
		private function updateEntities() : void
		{
			var entity:Entity;
			for each (var entities:Vector.<Entity> in _allEntities) 
			{				
				var numEntities:int = entities.length;
				for (var i:int = 0; i < numEntities; i++) 
				{
					entity = entities[i];
					entity.update();
				}
			}
		}
		
		public function destroy() : void
		{
			this._view.destroyObject(this._instanceName);
		}
		
		public function close() : void
		{
			isInit = false;
			active = false;
			
			removeAllListeners();
			removeAll();
			
			panel.removeChildren();
			panel.dispose();
			
			switch (_layer)
			{
				case LayerTypes.TIP:
					_view.layer.setTipMaskHide();
					break;
				case LayerTypes.TOP:
					_view.layer.setTopMaskHide();
					break;
			}
		}
		
		/**
		 * 显示 
		 * 
		 */		
		public function display() : void
		{
			panel.visible = true;
			panel.alpha = 1;
			
			// add
			var type:String = "add" + _layer + "Child";
			if (!panel.parent) _view.layer[type](panel, sign);
			
			switch (_layer)
			{
				case LayerTypes.TIP:
					_view.layer.setTipMaskShow();
					break;
				case LayerTypes.TOP:
					_view.layer.setTopMaskShow();
					break;
			}
		}
		
		/**
		 * 隐藏 
		 * 
		 */		
		public function hide() : void
		{
			panel.visible = false;
			
			switch (_layer)
			{
				case LayerTypes.TIP:
					_view.layer.setTipMaskHide();
					break;
				case LayerTypes.TOP:
					_view.layer.setTopMaskHide();
					break;
			}
		}
		
		// GC
		protected function gc() : void
		{
			try {
				new LocalConnection().connect('foo');
				new LocalConnection().connect('foo');
			}
			catch (e : *) {}
		}
		
		/**
		 * 当前界面是否打开着 
		 * @return 
		 * 
		 */		
		public function get isShowed() : Boolean
		{
			return panel && panel.visible && panel.parent;
		}
		
		public function resetView() : void
		{
			isInit = false;
		}
	}
}
package com.game.manager
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	import com.engine.core.Log;
	import com.engine.net.*;
	import com.engine.net.File;
	import com.engine.utils.Utilities;
	import com.game.ClassProxy;
	import com.game.template.*;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.Responder;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	
	public class ResCacheManager extends ClassProxy
	{
		/**
		 *  设定加载失败时的重试次数
		 */		
		public static const MAXTRIES:int = 6;
		
		private var _loaders:Object;
		private var _RAssets:Object;
		private var _isInit:Boolean = false;
		
		private var _pools:Object;
		private var _loadQeue:Vector.<CurLoad>;
		
		public function ResCacheManager(s:Singleton)
		{
			if (_instance)
			{
				throw new Error("ResCacheManager 是单例！");
			}
			
			_loaders = {};			 
			_RAssets = {};
			_pools = {};
			_loadQeue = new Vector.<CurLoad>();
		}
		
		protected function getLoaders(LoaderModule:String) : BulkLoader
		{
			if (!_loaders[LoaderModule])
			{
				_loaders[LoaderModule] = createLoader(LoaderModule);
			}
			
			return _loaders[LoaderModule];
		}
		
		protected function createLoader(LoaderModule:String) : BulkLoader
		{
			var loader:BulkLoader;
			loader = new BulkLoader();
			loader.logLevel = BulkLoader.LOG_INFO;
			if (DebugManager.instance.gameMode == V.DEVELOP)
			{
				loader._logFunction = trace;
			}
			else
			{
				loader._logFunction = DebugManager.instance.debugOutput;
			}
			
			return loader;
		}
		
		public function init(data:Object) : void
		{
			if (_isInit)
			{
				throw new Error("stage == null");
			}
			else
			{
				_isInit = true;
				if (data) write(data);
				registerAssets();
			}
		}
		
		/**
		 * 版本号 
		 * @return 
		 * 
		 */
		private var _version:String;
		public function set version(value:String) : void
		{
			_version = value;
		}
		
		public function onVersion() : String
		{
			if (!_version || _version == "") throw new Error("错误的版本号");
			
			return _version;
		}
		
		/**
		 * 注册元件库 
		 * 
		 */
		private function registerAssets() : void
		{
			for (var key:String in GameConfig.instance.ASSETS)
			{
				if (hasAssets(key))
				{
					throw new Error("元件 " + key + " 多次注册");
				}
				else
				{
					_RAssets[key] = GameConfig.instance.ASSETS[key];
				}
			}
		}
		
		/**
		 * 是否已经注册 
		 * @param key
		 * @return 
		 * 
		 */		
		public function hasAssets(key:String) : Boolean
		{
			return this._RAssets[key];
		}
		
		/**
		 * 放进队列
		 * @param lr
		 * @param resources
		 * 
		 */		
		private function pushLoad(module:String, lr:LoadResponder, resources:Array) : void
		{
			this._loadQeue.push(new CurLoad(module, lr, resources));
		}
		
		/**
		 * 加载资源 
		 * @param lr
		 * @param loadName
		 * 
		 */
		public function loadResource(module:String, lr:LoadResponder, resources:Array) : void
		{
			pushLoad(module, lr, resources);
			
			if (!_curLoadRes) checkLoadQeue();
		}
		
		private var _curLoadRes:CurLoad;
		private var _curLoader:BulkLoader;
		private function checkLoadQeue() : void
		{
			if (_loadQeue.length == 0) 
			{
				_curLoadRes = null;
				return;
			}
			
			_curLoadRes = _loadQeue.shift();
			_curLoader = getLoaders(_curLoadRes.module);
			
			var haveLoadItem:Boolean = false;
			for each(var loadName:String in _curLoadRes.resources)
			{
				// 加载的素材数
				var list:Array = getLoadList(loadName);
				var vers:Array = getVerList(loadName);
				var sizes:Array = getSizeList(loadName);
				
				if (!list || list.length == 0) continue;
				
				// 素材地址头
				var prependURLs:String = getPrependURLs(loadName);
				
				var url:String;
				var id:String;
				var item:String;
				var ver:String;
				var size:int;
				for (var i:int = 0; i < list.length; i++)
				{
					item = list[i];
					ver = vers[i];
					size = parseInt(sizes[i]);
					
					if (DebugManager.instance.gameMode == V.DEVELOP) ver = Math.random().toString();
					
					url = prependURLs + item + "?rnd=" + ver;
					id = loadName + '_' + item;
					
					if (_curLoader.get(id)) continue;
					
					haveLoadItem = true;
					_curLoader.add(url, {id:id, weight:size, maxTries:MAXTRIES});
				}
			}
			
			if (haveLoadItem)
			{
				_curLoader.addEventListener(BulkLoader.COMPLETE, completeHandler);
				_curLoader.addEventListener(BulkLoader.PROGRESS, onProgress);
				_curLoader.start();
			}
			else
			{
				completeHandler(null);
			}
		}
		
		private function onProgress(e:BulkProgressEvent) : void
		{
			//trace(e._percentLoaded, e._ratioLoaded, e._weightPercent, e.bytesLoaded, e.bytesTotal, e.bytesTotalCurrent, e.itemsLoaded, e.itemsTotal);
			
			_curLoadRes.lr.progress("", e._weightPercent, e.bytesLoaded, e.bytesTotalCurrent);
		}
		
		/**
		 * 全部加载完毕 
		 * @param e
		 * 
		 */		
		private function completeHandler(e:Event) : void
		{
			_curLoader.removeEventListener(BulkLoader.COMPLETE, completeHandler);
			_curLoadRes.lr.callback();
			_curLoadRes = null;
			
			checkLoadQeue(); 
		}
		
		public function getURL(modelName:String, fileName:String) : String
		{
			return getPrependURLs(modelName) + fileName;
		}
		
		/**
		 * 获取加载前缀地址 
		 * @param modelName
		 * @return 
		 * 
		 */		
		public function getPrependURLs (modelName:String) : String
		{
			return URIManager.assetsUrl;// + _RAssets[modelName]['path'] + "/";
		}	
		
		/**
		 * 获取资源列表 
		 * @param moduleName
		 * @return 
		 * 
		 */		
		private function getLoadList (moduleName:String) : Array
		{
			var loadItems:Array = _RAssets[moduleName] ? _RAssets[moduleName]['res'] : [];
			return loadItems;
		}	
		
		/**
		 * 素材大小 
		 * @param moduleName
		 * @return 
		 * 
		 */		
		private function getSizeList(moduleName:String) : Array
		{
			var sizes:Array = _RAssets[moduleName] ? _RAssets[moduleName]['size'] : [];
			return sizes;
		}
		
		/**
		 * 版本号 
		 * @param moduleName
		 * @return 
		 * 
		 */		
		private function getVerList(moduleName:String) : Array
		{
			var vers:Array = _RAssets[moduleName] ? _RAssets[moduleName]['ver'] : [];
			return vers;
		}
		
		/**
		 * 获取类 
		 * @param ModelName
		 * @param name
		 * @param className
		 * @return 
		 * 
		 */		
		public function getAssetsClass (LoaderModule:String, ModelName:String, swfName:String, className:String) : Class
		{
			var loader:BulkLoader = _loaders[LoaderModule];
			if (!loader) throw new Error("没有该模块的加载器");
			
			var CS:Class = _pools[ModelName + "_" + className];

			if (!CS)
			{
				var item:ImageItem = loader.get(ModelName + "_" +swfName) as ImageItem;
				CS = item.getDefinitionByName(className) as Class;
				_pools[ModelName + "_" + className] = CS;
			}
			
			if (!CS) throw new Error("没有找到CS类");
			
			return CS;
		}
		
		/**
		 * 获取类对象 
		 * @param ModelName
		 * @param name
		 * @param className
		 * @return 
		 * 
		 */		
		public function getAssetsObject(LoaderModule:String, ModelName:String, SWFName:String, className:String) : Object
		{	
			var obj:Object =  new (getAssetsClass(LoaderModule, ModelName, SWFName, className))
			if (!obj) throw new Error("Object NULL");
			
			return obj;
		}
		
		/**
		 * 获取数据（非swf） 
		 * @param ModelName
		 * @param name
		 * @return 
		 * 
		 */		
		public function getAssetsData(LoaderModule:String, ModelName:String, name:String) : Object
		{
			var loader:BulkLoader = _loaders[LoaderModule];
			if (!loader) throw new Error("没有该模块的加载器");
			
			var obj:Object = _pools[ModelName + "_" + name];			
			if (!obj)
			{
				var item:LoadingItem = loader.get(ModelName + "_" +name) as LoadingItem;
				obj = item.content;
				
				_pools[ModelName + "_" + name] = obj;
			}
			
			if (!obj) throw new Error("Object NULL");
			
			return obj;
		}
		
		private static var _instance : ResCacheManager;
		public static function get instance () : ResCacheManager
		{
			if (null == _instance)
			{
				_instance = new ResCacheManager(new Singleton());
			}
			
			return _instance;
		}
	}
}

import com.engine.net.LoadResponder;

class CurLoad
{
	/**
	 * 回调对象 
	 */	
	public var lr:LoadResponder;
	
	/**
	 * 加载资源 
	 */	
	public var resources:Array;
	
	/**
	 * loader加载模块 
	 */	
	public var module:String;
	
	public function CurLoad(LoadModule:String, ilr:LoadResponder, iresources:Array)
	{
		module = LoadModule;
		lr = ilr;
		resources = iresources;
	}
}

class Singleton {}
package com.game.data.db.templateData
{
	import com.engine.core.Log;
	import com.game.manager.ResCacheManager;
	import com.game.template.GameConfig;
	import com.game.template.V;
	
	import flash.utils.ByteArray;

	public class TDBase
	{
		/**
		 * 资源管理器 
		 */		
		protected var _res:ResCacheManager;
		/**
		 * 主模块 
		 */		
		protected var _moduleName:String;
		/**
		 * 配置文件名 
		 */		
		protected var _XMLFileName:String;
		/**
		 * 配置文件数据(xml) 
		 */		
		protected var _dataFile:XML;
		/**
		 * 数据 
		 */		
		protected var _data:Vector.<Object>;
		public function get data() : Vector.<Object>
		{
			return _data;
		}
		
		protected var CS:Class;
		
		public function TDBase()
		{
			_res = ResCacheManager.instance;
			_moduleName = V.DB;
		}
		
		protected function assign() : void
		{
			_data = new Vector.<Object>();
			var xmlData:ByteArray = _res.getAssetsObject(V.PUBLIC, this._moduleName, GameConfig.DB_RES, _XMLFileName.replace(".xml", "")) as ByteArray;
			 _dataFile = XML(xmlData.toString());
			 
			var protocol:*;
			for each(var item:XML in _dataFile.RECORD)
			{
				protocol = new CS();
				protocol.assign(item);
				_data.push(protocol);
			}
		}
		
		/**
		 * 取值 
		 * @param key
		 * @param value
		 * @return 
		 * 
		 */		
		protected function searchForKey(key:String, value:*) : Object
		{
			var obj:Object;
			for each(var item:Object in _data)
			{
				if (item[key] == value)
				{
					obj = item;
					break;
				}
			}
			
			return obj;
		}
		
		/**
		 * 获取数据 
		 * @param args
		 * 
		 */		
		protected function getData(args:Array) : void
		{
			var name:String = args[0];
			var callback:Function = args[1];
			
			var data:Object = this.searchForKey("name", name);
			
			if (!data) Log.Error("没有找到相关的基础信息:" + _moduleName + "---" + name);
			
			callback(data);
		}
	}
}
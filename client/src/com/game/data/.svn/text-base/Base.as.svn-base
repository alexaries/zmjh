package com.game.data
{
	import com.game.Data;
	import com.game.SuperBase;
	import com.game.SuperSubBase;
	
	import flash.utils.ByteArray;

	public class Base extends SuperSubBase
	{
		protected var _instanceName:String;
		protected var _data:Data;
		
		public function Base()
		{
		}
		
		override public function settle(instanceName:String, s:SuperBase):void
		{
			if (null == _data)
			{
				_instanceName = instanceName;
				_data = s as Data;
			}
		}
		
		public function destroy() : void
		{
			_data.destroyObject(_instanceName);
		}
		
		/**
		 * 请求数据调用 
		 * 
		 */		
		protected function call() : void
		{
			
		}
		
		/**
		 * 获取xml文件 
		 * @param ModelName ： 模块名
		 * @param SWFName ： swf
		 * @param fileName ： 目标文件
		 * @return 
		 * 
		 */		
		protected function getXMLData(ModelName:String, SWFName:String, fileName:String) : XML
		{
			var xmlData:XML;
			var bytes:ByteArray = _data.res.getAssetsObject(ModelName, ModelName, SWFName, fileName) as ByteArray;
			xmlData = XML(bytes.toString());
			
			return xmlData;
		}
	}
}
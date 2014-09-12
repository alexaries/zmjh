package com.game.data.guide
{
	public class GuideFuncData
	{
		private var _func:String;
		public function get func() : String
		{
			return _func;
		}
		private var _clickFunc:String;
		public function get clickFunc() : String
		{
			return _clickFunc;
		}
		private var _param:String;
		public function get param() : String
		{
			return _param;
		}
		private var _id:int;
		public function get id() : int
		{
			return _id;
		}
		private var _xPos:Number;
		public function get xPos() : Number
		{
			return _xPos;
		}
		private var _yPos:Number;
		public function get yPos() : Number
		{
			return _yPos;
		}
		private var _pointForward:String;
		public function get pointForward() : String
		{
			return _pointForward;
		}
		private var _words:String;
		public function get words() : String
		{
			return _words;
		}
		private var _touchName:String;
		public function get touchName() : String
		{
			return _touchName;
		}
		private var _touchable:Boolean;
		public function get touchable() : Boolean
		{
			return _touchable;
		}
		
		public function GuideFuncData()
		{
			
		}
		
		public function initData(config:XML) : void
		{
			_func = config.@func;
			_clickFunc = config.@clickFunc;
			_param = config.@param;
			_id = config.@id;
			_xPos = config.@x;
			_yPos = config.@y;
			_pointForward = config.@position;
			_touchName = config.@touchName;
			_touchable = (config.@touchable=="true"?true:false);
			_words = config;
		}
	}
}
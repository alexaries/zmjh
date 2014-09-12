package com.game.data.guide
{
	public class GuideWordData
	{
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
		private var _shape:String;
		public function get shape() : String
		{
			return _shape;
		}
		private var _wid:int;
		public function get wid() : int
		{
			return _wid;
		}
		private var _hei:int;
		public function get hei() : int
		{
			return _hei;
		}
		private var _type:String;
		public function get type() : String
		{
			return _type;
		}
		public function GuideWordData()
		{
			
		}
		
		public function initData(config:XML) : void
		{
			_id = config.@id;
			_xPos = config.@x;
			_yPos = config.@y;
			_pointForward = config.@position;
			_touchName = config.@touchName;
			_touchable = (config.@touchable=="true"?true:false);
			_shape = config.@shape;
			_wid = config.@width;
			_hei = config.@height;
			_type = config.@type;
			_words = config;
		}
	}
}
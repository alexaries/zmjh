package com.game.view.effect.protocol
{
	public class FightEffectConfigData
	{
		private var _id:int;
		public function get id() : int
		{
			return _id;
		}
		
		private var _name:String;
		public function get name() : String
		{
			return _name;
		}
		
		private var _texture_name:String;
		public function get texture_name() : String
		{
			return _texture_name;
		}
		
		private var _X:int;
		public function get X() : int
		{
			return _X;
		}
		
		private var _Y:int;
		public function get Y() : int
		{
			return _Y;
		}
		
		private var _texture_index:int;
		public function get texture_index() : int
		{
			return _texture_index;
		}
		
		private var _frames:Vector.<FightEffectFrameData>;
		public function get frames() : Vector.<FightEffectFrameData>
		{
			return _frames;
		}
		
		public function FightEffectConfigData()
		{
		}
		
		private var _configXML:XML;
		public function init(configXML:XML) : void
		{
			_configXML = configXML;
			
			_id = _configXML.@id;
			_name = _configXML.@name;
			_texture_name = _configXML.@texture_name;
			_X = _configXML.@x;
			_Y = _configXML.@y;
			_texture_index = _configXML.@texture_index;
			
			_frames = FightEffectUtils.parseFrameXML(configXML);
		}
	}
}
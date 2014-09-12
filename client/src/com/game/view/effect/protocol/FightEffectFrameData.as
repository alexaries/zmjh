package com.game.view.effect.protocol
{
	public class FightEffectFrameData
	{
		private var _id:int;
		public function get id() : int
		{
			return _id;
		}
		
		private var _frame_index:int;
		public function get frame_index() : int
		{
			return _frame_index;
		}
		
		private var _time:int;
		public function get time() : int
		{
			return _time;
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
		
		private var _W:int;
		public function get W() : int
		{
			return _W;
		}
		
		private var _H:int;
		public function get H() : int
		{
			return _H;
		}
		
		public function FightEffectFrameData()
		{
		}
		
		private var _frameXML:XML;
		public function init(frameXML:XML) : void
		{
			_frameXML = frameXML;
			
			_id = _frameXML.@id;
			_frame_index = _frameXML.@frame_index;
			_time = _frameXML.@time;
			_X = _frameXML.@x;
			_Y = _frameXML.@y;
			
			_W = _frameXML.@W;
			_H = _frameXML.@H;
		}
	}
}
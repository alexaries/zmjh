package com.game.view.map
{
	import starling.display.Sprite;

	public class MapLayer
	{
		private var _panel:Sprite;
		
		/**
		 * 顶层 
		 */		
		private var _topLayer:Sprite;
		public function get topLayer() : Sprite
		{
			return _topLayer;
		}
		
		/**
		 * 道具层 
		 */		
		private var _propLayer:Sprite;
		public function get propLayer() : Sprite
		{
			return _propLayer;
		}
		
		/**
		 * 塔层 
		 */		
		private var _bulletLayer:Sprite;
		public function get bulletLayer() : Sprite
		{
			return _bulletLayer;
		}
		
		/**
		 * 玩家 
		 */		
		private var _playerLayer:Sprite;
		public function get playerLayer() : Sprite
		{
			return _playerLayer;
		}
		
		/**
		 * 地图层 
		 */		
		private var _mapLayer:Sprite;
		public function get mapLayer() : Sprite
		{
			return _mapLayer;
		}
		
		public function MapLayer(panel:Sprite)
		{
			_panel = panel;
			
			_topLayer = new Sprite();
			_bulletLayer = new Sprite();
			_propLayer = new Sprite();
			
			_playerLayer = new Sprite();
			_mapLayer = new Sprite();
		}
		
		public function initLayer() : void
		{
			_panel.addChild(_mapLayer);
			_mapLayer.x = _mapLayer.y = 0;
			
			_mapLayer.addChild(_propLayer);
			_propLayer.x = _propLayer.y = 0;
			_propLayer.flatten();
			
			
			_mapLayer.addChild(_playerLayer);
			_playerLayer.x = _playerLayer.y = 0;
			
			_mapLayer.addChild(_bulletLayer);
			_bulletLayer.x = _bulletLayer.y = 0;
			
			_panel.addChild(_topLayer);
			_topLayer.x = _topLayer.y = 0;
			_topLayer.flatten();
		}
		
		/**
		 * 清除地图层 
		 * 
		 */		
		public function clear() : void
		{
			_mapLayer.removeEventListeners();
			_playerLayer.removeChildren();
			_mapLayer.dispose();
			
			_propLayer.removeEventListeners();
			_propLayer.removeChildren();
			_propLayer.dispose();
			
			_bulletLayer.removeEventListeners();
			_bulletLayer.removeChildren();
			_bulletLayer.dispose();
			
			_playerLayer.removeEventListeners();
			_playerLayer.removeChildren();
			_playerLayer.dispose();
			
			_topLayer.removeEventListeners();
			_topLayer.removeChildren();
			_topLayer.dispose();
		}
	}
}
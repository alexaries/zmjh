package com.game.view.map
{
	import com.game.template.GameConfig;
	import com.game.view.map.player.PlayerEntity;
	import com.game.view.map.player.TDPlayerEntity;
	
	import starling.events.EventDispatcher;
	
	public class TDMapCamera extends EventDispatcher
	{
		private var _mapWidth:int;
		
		private var _mapHeight:int;
		
		private var _player:TDPlayerEntity;
		
		private var _view:TowerDefenceView;
		
		public function TDMapCamera()
		{
		}
		
		public function initCamera(view:TowerDefenceView, player:TDPlayerEntity, mapWidth:int, mapHeight:int) : void
		{
			_view = view;
			_player = player;
			_mapWidth = mapWidth;
			_mapHeight = mapHeight;
		}
		
		/**
		 * 每帧调用 
		 * 
		 */		
		public function update() : void
		{
			if (!_player) return;
			
			autoResizeX();
			autoResizeY();
		}
		
		protected function autoResizeX() : void
		{
			// 角色居中
			if (_player.x > GameConfig.CAMERA_WIDTH/2 && _player.x < (_mapWidth - GameConfig.CAMERA_WIDTH/2))
			{
				_view.mapLayers.mapLayer.x = -(_player.x - GameConfig.CAMERA_WIDTH/2);
			}
			else if (_player.x > GameConfig.CAMERA_WIDTH/2 && _player.x > (_mapWidth - GameConfig.CAMERA_WIDTH/2))
			{
				_view.mapLayers.mapLayer.x = -(_mapWidth - GameConfig.CAMERA_WIDTH);
			}
			else if (_player.x <= GameConfig.CAMERA_WIDTH/2)
			{
				_view.mapLayers.mapLayer.x = 0;
			}
		}
		
		protected function autoResizeY() : void
		{
			if (_player.y > GameConfig.CAMERA_HEIGHT/2 && _player.y < (_mapHeight - GameConfig.CAMERA_HEIGHT/2))
			{
				_view.mapLayers.mapLayer.y = -(_player.y - GameConfig.CAMERA_HEIGHT/2);
			}
			else if (_player.y > GameConfig.CAMERA_HEIGHT/2 && _player.y > (_mapHeight - GameConfig.CAMERA_HEIGHT/2))
			{
				_view.mapLayers.mapLayer.y = -(_mapHeight - GameConfig.CAMERA_HEIGHT);
			}
			else if (_mapHeight - GameConfig.CAMERA_HEIGHT/2)
			{
				_view.mapLayers.mapLayer.y = 0;
			}
		}
		
		/**
		 * 清除 
		 * 
		 */		
		public function clear() : void
		{
			_player = null;
		}
	}
}
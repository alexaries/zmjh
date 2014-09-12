package com.game.controller.LevelSelect
{
	import com.game.controller.Base;
	import com.game.data.player.structure.LevelInfo;

	public class LVSelectController extends Base
	{
		public function LVSelectController()
		{
		}
		
		public function getLVInfos(curSceneId:int) : Vector.<LevelInfo>
		{
			return _controller.data.lvSelect.getLVInfos(curSceneId);
		}
		
		public function getHighLV() : int
		{
			return _controller.data.lvSelect.getHighLV();
		}
		
		public function passLevel(sceneId:int, lv:int, hard:int) : void
		{
			_controller.data.lvSelect.passLevel(sceneId, lv, hard);
		}
	}
}
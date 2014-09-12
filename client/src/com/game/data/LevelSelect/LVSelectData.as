package com.game.data.LevelSelect
{
	import com.engine.core.Log;
	import com.game.View;
	import com.game.data.Base;
	import com.game.data.player.structure.LevelInfo;
	import com.game.data.player.structure.Player;

	public class LVSelectData extends Base
	{
		private var _player:Player;
		
		public function LVSelectData()
		{
		}
		
		public function initEquip() : void
		{
			_player = _data.player.player;
		}
			
		public function getLVInfo(sceneId:int, lv:int) : LevelInfo
		{
			var info:LevelInfo;
			var lvName:String = sceneId + "_" + lv;
			
			for each(var item:LevelInfo in _player.pass_level)
			{
				if (item.name == lvName)
				{
					info = item;
					break;
				}
			}
						
			return info;
		}
		
		/**
		 * 检测是否通过特定困难度的关卡 
		 * @param sceneId
		 * @param lv
		 * @param difficult
		 * @return 
		 * 
		 */		
		public function checkLvPass(sceneId:int, lv:int, difficult:int = 2) : Boolean
		{
			var info:LevelInfo;
			var lvName:String = sceneId + "_" + lv;
			
			for each(var item:LevelInfo in _player.pass_level)
			{
				if (item.name == lvName)
				{
					info = item;
					break;
				}
			}
			
			return info && (info.difficulty >= difficult);
		}
		
		public function getLVInfos(curSceneId:int) : Vector.<LevelInfo>
		{
			initEquip();
			
			var data:Vector.<LevelInfo> = new Vector.<LevelInfo>();
			
			var info:LevelInfo;
			for(var i:int = 0; i < _player.pass_level.length; i++)
			{
				info = _player.pass_level[i];
				
				if (info.name == curSceneId + "_1" || info.name == curSceneId + "_2" || info.name == curSceneId + "_3")
				{
					data.push(info);
				}
			}
			
			return data;
		}
		
		public function getHighLV() : int
		{
			initEquip();
			
			var allRequest:int = 0;
			
			var lv:int = -1;
			
			var info:LevelInfo;
			for(var i:int = 0; i < _player.pass_level.length; i++)
			{
				info = _player.pass_level[i];
				
				if(info.name == "1_1")
				{
					if (lv < 1) lv = 1;
				}
				
				if(info.name == "2_1")
				{
					if (lv < 2) lv = 2;
				}
				
				if(info.name == "3_1")
				{
					if (lv < 3) lv = 3;
				}
				
				if(info.name == "4_1")
				{
					if (lv < 4) lv = 4;
				}
				
				if(info.name == "4_4")
				{
					if(lv < 5) lv = 5;
				}
				
				if(info.name == "5_4")
				{
					if(lv < 6) lv = 6;
				}
			}
			
			if (lv == -1) throw new Error("Error");
			
			return lv;
		}
		
		public function passLevel(sceneId:int, lv:int, hard:int) : void
		{
			// 隐藏地图无需升级处理
			var info:LevelInfo = getLVInfo(sceneId, lv);
			
			switch (lv)
			{
				// 隐藏地图
				case 4:
					if (!info) addNewLevel(sceneId, lv, hard);
					break;
				// 每个大关最后一个关卡
				case 3:
					var nextSceneId:int = sceneId + 1;
					var infos:Vector.<LevelInfo> = getLVInfos(nextSceneId);
					if (infos.length == 0) addNewLevel(nextSceneId, 1);
					break;
				default:
					var nextLv:int = lv + 1;
					var nextInfo:LevelInfo = getLVInfo(sceneId, nextLv);
					if (!nextInfo) addNewLevel(sceneId, nextLv);
			}
			
			// 开启下一困难模式
			if (lv != 4 && hard != 3 && info.difficulty != 3)
			{
				var nextHard:int = hard + 1;
				info.difficulty = nextHard;
				View.instance.double_level.checkKindStatus();
			}
		}
		
		/**
		 * 新关卡 
		 * @param sceneId
		 * @param lv
		 * 
		 */		
		private function addNewLevel(sceneId:int, lv:int, difficulty:int = 1) : void
		{
			var info:LevelInfo = new LevelInfo();
			info.name = sceneId + "_" + lv;
			info.difficulty = difficulty;
			_player.pass_level.push(info);
			
			//增加5-1、6-1和隐藏关卡后不添加抖动效果
			if((sceneId == 5 && lv == 1) || (sceneId == 6 && lv == 1) || lv == 4){}
			else
				View.instance.world.addIconDeform(sceneId);
			
			//4-4隐藏过后添加关卡5的抖动效果
			if(sceneId == 4 && lv == 4)
				View.instance.world.addIconDeform(5);
			//5-4隐藏过后添加关卡6的抖动效果
			if(sceneId == 5 && lv == 4)
				View.instance.world.addIconDeform(6);
			
			//可以打1-3后添加双倍副本
			if(info.name == "1_3" && info.difficulty == 1)
			{
				_player.doubleLevelInfo.level = "1_3";
				View.instance.double_level.addTimeCalculate();
			}
		}
	}
}
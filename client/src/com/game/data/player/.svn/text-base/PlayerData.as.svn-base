package com.game.data.player
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.data.Base;
	import com.game.data.fight.structure.Battle_WeModel;
	import com.game.data.player.structure.EquipInfo;
	import com.game.data.player.structure.FightAttach;
	import com.game.data.player.structure.FightAttachInfo;
	import com.game.data.player.structure.FormationInfo;
	import com.game.data.player.structure.LevelInfo;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.RoleInfo;
	import com.game.data.player.structure.SkillInfo;
	import com.game.manager.DebugManager;
	import com.game.template.V;

	public class PlayerData extends Base
	{
		private var _anti:Antiwear;	
		
		private var _player:Player;
		public function get player() : Player
		{
			return _player;
		}
		public function setPlayerNull() : void
		{
			_player = null;
		}
		
		public function PlayerData()
		{
			_anti = new Antiwear(new binaryEncrypt());
		}
		
		public function getPlayerDataForFight() : Object
		{
			if (!_player || !_player.isInit) throw new Error("玩家数据还没获取");
			
			var obj:Object = PlayerFightDataUtitlies.convertPlayerToBattleData(_player);
			return obj;
		}
		
		public function reqPlayerData(callback:Function) : void
		{
			if (!_player || !_player.isInit)
			{
				_player = new Player();
				
				// 假如处于开发模式则加载本地的PlayerData.xml
				if (DebugManager.instance.gameMode == V.DEVELOP)
				{
					onLocalData(callback);
				}
				else
				{
					onNetData(callback);
				}
			}
			else
			{
				callback();
			}
		}
		
		/**
		 * 从平台数据获取 
		 * 
		 */		
		private function onNetData(callback:Function) : void
		{
			_playerDataConfig = _data.save.saveData;
			
			parseData(_playerDataConfig);
			callback();
		}
		
		/**
		 * 本地加载配置文件初始化玩家数据 
		 * 
		 */
		private var _playerDataConfig:XML;
		private function onLocalData(callback:Function) : void
		{
			_playerDataConfig = _data.res.getAssetsData(V.LOAD, V.LOAD, "PlayerData.xml") as XML;
			
			parseData(_playerDataConfig);
			
			callback();
		}
		
		/**
		 * 解析玩家数据XML 
		 * @param configXML
		 * 
		 */		
		private function parseData(configXML:XML) : void
		{
			_player.init(configXML);
		}	
	}
}
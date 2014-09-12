package com.game.data.playerKilling
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.View;
	import com.game.data.Base;
	import com.game.data.player.PlayerFightDataUtitlies;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;

	public class PlayerKillingPlayerData extends Base
	{
		private var _anti:Antiwear;	
		
		private var _player:PlayerKillingPlayer;
		public function get player() : PlayerKillingPlayer
		{
			return _player;
		}
		
		public function PlayerKillingPlayerData()
		{
			_anti = new Antiwear(new binaryEncrypt());
		}
		
		public function getEnemyDataForFight() : Object
		{
			var obj:Object = PlayerKillingFightDataUtitlies.convertPlayerToBattleData(_player);
			return obj;
		}
		
		/**
		 * 解析玩家数据XML 
		 * @param configXML
		 * 
		 */		
		public function parseData(configXML:XML, playerName:String, playerRank:int, playerUID:String) : void
		{
			//var xml:XML = Data.instance.res.getAssetsData(V.LOAD, V.LOAD, "PlayerData.xml") as XML;
			if(configXML == null) 
			{
				throw new Error("没有玩家数据！");
				return;
			}
			else
			{
				_player = new PlayerKillingPlayer();
				
				_player.init(configXML);
				
				View.instance.player_killing_fight.interfaces(InterfaceTypes.Show, playerName, playerRank, playerUID);
			}
		}	
	}
}
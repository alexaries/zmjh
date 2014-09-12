package com.game.data.pack
{
	import com.game.data.Base;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.PackInfo;
	import com.game.data.playerKilling.PlayerKillingPlayer;

	public class PlayerKillingPackData extends Base
	{
		private var _player:PlayerKillingPlayer;
		
		private var _pack:PackInfo;
		
		public function PlayerKillingPackData()
		{
		}
		
		/**
		 * 初始化背包 
		 * 
		 */		
		public function initPack() : void
		{
			_player = _data.playerKillingPlayer.player;
			_pack = _player.pack;
			
		}
		
		/**
		 * 获取装备数据 
		 * @param equipMID
		 * @return 
		 * 
		 */		
		public function getEquipModelByMID(equipMID:int) : EquipModel
		{
			var model:EquipModel;
			
			for each(var item:EquipModel in _pack.equips)
			{
				if (item.mid == equipMID)
				{
					model = item;
					break;
				}
			}
			
			return model;
		}
	}
}
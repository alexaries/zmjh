package com.game.data.plugin
{
	import com.game.Data;
	import com.game.data.Base;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.PluginGameInfo;
	import com.game.data.player.structure.PropModel;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.V;

	public class PluginGameData extends Base
	{
		public function get player() : Player
		{
			return _data.player.player;
		}
		
		public function PluginGameData()
		{
		}
		
		/**
		 * 游戏插件数据 
		 * @return 
		 * 
		 */		
		public function getPluginInfo() : PluginGameInfo
		{
			return player.pluginGameInfo;
		}
		
		/**
		 * 酒插件游戏获得物品 
		 * @param legs 满汉全席
		 * @param ginseng 人参
		 * @param freedomDice 如意色子
		 * @param randomDice 随机色子
		 * 
		 */		
		public function getThingInWine(legs:int, ginseng:int, freedomDice:int, randomDice:int) : void
		{
			var id:int = -1;
			var num:int = 0;
			
			// 满汉全席
			id = 2;
			num = player.pack.getPropNumById(id);
			num += legs;
			player.pack.setPropNum(num,id);
			
			// 人参
			id = 3;
			num = player.pack.getPropNumById(id);
			num += ginseng;
			player.pack.setPropNum(num,id);
			
			// 如意色子
			id = 1;
			num = player.pack.getPropNumById(id);
			num += freedomDice;
			player.pack.setPropNum(num,id);
			
			// 随机色子
			player.dice += randomDice;
			
			// 设置进入每日副本时间
			player.pluginGameInfo.wine = _data.time.curTimeStr;
			player.pluginGameInfo.setTime(0);
			
		}
		
		/**
		 * 色插件获得经验
		 * @param exp 经验值
		 * 
		 */		
		public function getlechery(exp:int, flip:int) : void
		{
			//小宝经验
			var _mainRole:RoleModel = player.getRoleModel(V.MAIN_ROLE_NAME);
			_mainRole.addExp(exp);
			_mainRole.checkGrade(null);
			
			var front:String = player.formation.front;
			var middle:String = player.formation.middle;
			var back:String = player.formation.back;
			//先锋经验
			if(front && front != "" && front != V.MAIN_ROLE_NAME)
			{
				_mainRole = player.getRoleModel(front);
				_mainRole.addExp(exp);
			}
			//中坚经验
			if(middle && middle != "" && middle != V.MAIN_ROLE_NAME)
			{
				_mainRole = player.getRoleModel(middle);
				_mainRole.addExp(exp);
			}
			//大将经验
			if(back && back != "" && back != V.MAIN_ROLE_NAME)
			{
				_mainRole = player.getRoleModel(back);
				_mainRole.addExp(exp);
			}
			
			// 设置进入每日副本时间
			player.pluginGameInfo.lechery = _data.time.curTimeStr;
			player.pluginGameInfo.setTime(1);
		}
		
		
		/**
		 * 财插件获得经验
		 * @param money 金钱
		 * 
		 */	
		public function getMoney(money:int) : void
		{
			player.money += money;
			player.pluginGameInfo.money = _data.time.curTimeStr;
			player.pluginGameInfo.setTime(2);
		}
		
		/**
		 * 气插件获得经验
		 * @param soulExp 战魂
		 * 
		 */	
		public function getBreath(soulExp:int, destroy:int) : void
		{
			player.fight_soul += soulExp;
			player.pluginGameInfo.breath = _data.time.curTimeStr;
			player.pluginGameInfo.setTime(3);
		}
		
		public function getStrengthen(signNum:int) : void
		{
			var prop:PropModel = new PropModel();
			prop.id = signNum;
			prop.num = 1;
			Data.instance.pack.addProp(prop);
		}
		
	}
}
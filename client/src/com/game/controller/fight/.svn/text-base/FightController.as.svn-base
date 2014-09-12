package com.game.controller.fight
{
	import com.game.controller.Base;
	import com.game.data.fight.FightModelStructure;
	import com.game.data.fight.structure.FightConfigStructure;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;

	public class FightController extends Base
	{
		public function FightController()
		{
		}
		
		public function reqFightData(level:String, difficult:int, monster:String) : void
		{
			_controller.data.fight.reqFightData(level, difficult, monster);
		}
		
		public function getInitFight(callback:Function) : void
		{
			_controller.data.fight.getInitFight(callback);
		}
		
		public function beginRunFight(data:Object) : void
		{
			//_controller.view.fight.interfaces(InterfaceTypes.BEGIN_RUN, data);
			_controller.view.fightBegin.interfaces(InterfaceTypes.Show, data);
		}
		
		public function endlessFightData(level:int, monsterType:int) : void
		{
			_controller.data.fight.reqEndlessFightData(level, monsterType);
		}
		
		public function getEndlessInitFight(callback:Function) : void
		{
			_controller.data.fight.getEndlessInitFight(callback);
		}
		
		public function beginEndlessRunFight(data:Object) : void
		{
			_controller.view.fightBegin.interfaces(InterfaceTypes.Show, data, V.ENDLESS_FIGHT);
		}
		
		public function countEndlessTime(level:int, timeCount:int) : Boolean
		{
			return _controller.data.fight.countEndlessTime(level, timeCount);
		}
		
		public function playerKillingFightData() : void
		{
			_controller.data.playerKillingFight.reqFightData();
		}
		
		public function getPlayerKillingInitFight(callback:Function) : void
		{
			_controller.data.playerKillingFight.getInitFight(callback);
		}
		
		public function beginPlayerKillingRunFight(data:Object) : void
		{
			_controller.view.fightBegin.interfaces(InterfaceTypes.Show, data, V.PLAYER_KILLING_FIGHT);
		}
		
		public function reqBossFightData() : void
		{
			_controller.data.fight.reqBossFightData();
		}
		
		public function getBossInitFight(callback:Function) : void
		{
			_controller.data.fight.getBossInitFight(callback);
		}
		
		public function beginBossRunFight(data:Object) : void
		{
			_controller.view.fightBegin.interfaces(InterfaceTypes.Show, data, V.BOSS_FIGHT);
		}
	}
}
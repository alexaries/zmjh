package com.game.data.playerKilling
{
	public class PlayerKillingConfigStructure
	{
		// 我方
		public var Me:Object;
		// 敌方
		public var Enemy:Object;
		
		public function PlayerKillingConfigStructure()
		{
			Me = {"1":{}, "2":{}, "3":{}};
			Enemy = {"1":{}, "2":{}, "3":{}};
		}
		
		/**********************我方************************/
		public function initMe(data:Object) : void
		{
			parse(data);	
		}
		
		public function parse(value:Object) : void
		{			
			for (var i:int = 1; i <= 3; i++)
			{
				Me[i] = value[i];
			}
		}
		
		/**********************我方************************/
		public function initEnemy(data:Object) : void
		{
			parseEnemy(data);	
		}
		
		public function parseEnemy(value:Object) : void
		{			
			for (var i:int = 1; i <= 3; i++)
			{
				Enemy[i] = value[i];
			}
		}
	}
}
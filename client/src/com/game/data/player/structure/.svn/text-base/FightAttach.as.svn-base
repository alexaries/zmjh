package com.game.data.player.structure
{
	public class FightAttach
	{
		/**
		 * 先锋 
		 */		
		public var front:FightAttachInfo;
		/**
		 * 中坚 
		 */		
		public var middle:FightAttachInfo;
		/**
		 * 大将 
		 */		
		public var back:FightAttachInfo;
		
		public function FightAttach()
		{
		}
		
		public function getFightAttach() : XML
		{
			var xml:XML = <fightAttach></fightAttach>;
			
			var fontXML:XML = <front  hp={front.hp} mp={front.mp} atk={front.atk} def={front.def} spd={front.spd} 
									  evasion={front.evasion} crit={front.crit} hit={front.hit} toughness={front.toughness} 
									  ats={front.ats} adf={front.adf} exp={front.exp}/>;
			var middleXML:XML = <middle  hp={middle.hp} mp={middle.mp} atk={middle.atk} def={middle.def} spd={middle.spd} 
									  evasion={middle.evasion} crit={middle.crit} hit={middle.hit} toughness={middle.toughness} 
									  ats={middle.ats} adf={middle.adf} exp={middle.exp}/>;
			var backXML:XML = <back  hp={back.hp} mp={back.mp} atk={back.atk} def={back.def} spd={back.spd} 
									  evasion={back.evasion} crit={back.crit} hit={back.hit} toughness={back.toughness} 
									  ats={back.ats} adf={back.adf} exp={back.exp}/>;
			
			xml.appendChild(fontXML);
			xml.appendChild(middleXML);
			xml.appendChild(backXML);
			
			return xml;
		}
	}
}
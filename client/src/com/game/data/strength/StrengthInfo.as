package com.game.data.strength
{
	import com.game.Data;
	import com.game.data.player.structure.FormationInfo;
	import com.game.template.InterfaceTypes;

	public class StrengthInfo
	{
		/**
		 * 先锋 
		 */		
		public var front:StrengthDetail;
		/**
		 * 中坚 
		 */		
		public var middle:StrengthDetail;
		/**
		 * 大将 
		 */		
		public var back:StrengthDetail;
		
		public function StrengthInfo()
		{
			
		}
		
		public function init(data:XML) : void
		{
			front = assignStrength(data.front[0]);
			middle = assignStrength(data.middle[0]);
			back = assignStrength(data.back[0]);
		}
		
		public static function assignStrength(item:XML) : StrengthDetail
		{
			var info:StrengthDetail = new StrengthDetail();
			
			info.ats = (item == null?0:item.@ats);
			info.adf = (item == null?0:item.@adf);
			info.ats_exp = (item == null?0:item.@ats_exp);
			info.adf_exp = (item == null?0:item.@adf_exp);
			
			return info;
		}
		
		public function getXML() : XML
		{
			var xml:XML = <strength></strength>;
			
			var fontXML:XML = <front ats={front.ats} adf={front.adf} ats_exp={front.ats_exp} adf_exp={front.adf_exp}/>;
			var middleXML:XML = <middle ats={middle.ats} adf={middle.adf} ats_exp={middle.ats_exp} adf_exp={middle.adf_exp}/>;
			var backXML:XML = <back ats={back.ats} adf={back.adf} ats_exp={back.ats_exp} adf_exp={back.adf_exp}/>;
			
			xml.appendChild(fontXML);
			xml.appendChild(middleXML);
			xml.appendChild(backXML);
			
			return xml;
		}
		
		private var _strengthData:Vector.<Object>; 
		public function getStrengthLevel(formation:FormationInfo) : Array
		{
			var result:int = 0;
			var allResult:int = 0;
			if(_strengthData == null)
			{
				_strengthData = new Vector.<Object>();
				_strengthData = Data.instance.db.interfaces(InterfaceTypes.GET_STRENGTH_DATA);
			}
			
			if(formation.front != "")
			{
				if(front.ats > 0)
					result += _strengthData[front.ats - 1].ads;
				if(front.adf > 0)
					result += _strengthData[front.adf - 1].adf;
				allResult += 3249 * 2;
			}
			if(formation.middle != "")
			{
				if(middle.ats > 0)
					result += _strengthData[middle.ats - 1].ads;
				if(middle.adf > 0)
					result += _strengthData[middle.adf - 1].adf;
				allResult += 3249 * 2;
			}
			if(formation.back != "")
			{
				if(back.ats > 0)
					result += _strengthData[back.ats - 1].ads;
				if(back.adf > 0)
					result += _strengthData[back.adf - 1].adf;
				allResult += 3249 * 2;
			}
			
			return [result, allResult];
		}
	}
}
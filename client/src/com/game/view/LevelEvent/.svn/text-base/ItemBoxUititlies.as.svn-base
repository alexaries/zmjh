package com.game.view.LevelEvent
{
	import com.engine.utils.Utilities;
	import com.game.Data;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.db.protocal.Item_disposition;
	import com.game.data.db.protocal.Prop;
	import com.game.data.db.protocal.Special_boss;
	import com.game.data.equip.EquipUtilies;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.PropModel;
	import com.game.template.InterfaceTypes;

	public class ItemBoxUititlies
	{
		public static var _data:Data = Data.instance;
		
		// 次数
		public static const TIME:uint = 6;
		
		public static function getPropItems(data:Item_disposition) : Vector.<PropModel>
		{
			var items:Vector.<PropModel> = new Vector.<PropModel>();
			var propsDB:* = _data.db.interfaces(InterfaceTypes.GET_PROP_DATA);
			
			var i:int = 0;
			var propModel:PropModel;
			while (i <　TIME)
			{
				propModel = getRandomProp();
				items.push(propModel);
				
				i++;
			}
			
			return items;
			
			function getRandomProp() : PropModel
			{
				var prop:Prop;
				var random:Number = Math.random();
				var curRate:Number = 0;
				for (var i:int = 0; i < propsDB.length; i++)
				{
					curRate += propsDB[i].rate;
					if (random <= curRate)
					{
						prop = propsDB[i];
						break;
					}
				}
				
				var model:PropModel = new PropModel();
				model.id = prop.id;
				model.num = 1;
				model.config = prop;
				return model;
			}
		}
		
		public static function getEndlessPropItems(data:Object) : Vector.<PropModel>
		{
			var curData:Special_boss = data as Special_boss;
			var items:Vector.<PropModel> = new Vector.<PropModel>();
			var propsDB:* = _data.db.interfaces(InterfaceTypes.GET_PROP_DATA);
			
			var propTypeList:Array = curData.reward.split("|");
			var propNumList:Array = curData.reward_number.split("|");
			var propRateList:Array = curData.reward_rate.split("|");
			
			var i:int = 0;
			var propModel:PropModel;
			
			while (i <　TIME)
			{
				propModel = getRandomProp();
				items.push(propModel);
				
				i++;
			}
			
			function getRandomProp() : PropModel
			{
				var prop:Prop;
				var random:Number = Math.random();
				var curRate:Number = 0;
				
				for (var i:int = 0; i < propRateList.length; i++)
				{
					curRate += Number(propRateList[i]);
					if (random <= curRate)
					{
						prop = _data.db.interfaces(InterfaceTypes.GET_PROP_BY_ID, propTypeList[i]);
						break;
					}
				}
				
				
				var model:PropModel = new PropModel();
				model.id = prop.id;
				model.num = propNumList[i];
				model.config = prop;
				return model;
			}
			
			return items;
		}

		/**
		 * 装备 
		 * @param data
		 * @return 
		 * 
		 */		
		public static function getEquipItems(data:Item_disposition) : Vector.<EquipModel>
		{
			var items:Vector.<EquipModel> = new Vector.<EquipModel>();
			
			var equipment_grade:Array = data.equiment_grade.split("|");
			var equ_gra_rate:Array = data.equ_gra_rate.split("|");
			var equipment_quality:Array = data.equiment_quality.split("|");
			var equ_qua_rate:Array = data.equ_qua_rate.split("|");
			
			var i:int = 0;
			var equipModel:EquipModel;
			while (i < TIME)
			{
				equipModel = getRandomEquip();
				items.push(equipModel);
				
				i++;
			}
			
			return items;
			
			function getRandomEquip() : EquipModel
			{
				var gradeIndex:int = getRandomTargetIndex(equ_gra_rate);
				var targetGrade:int = equipment_grade[gradeIndex];
				
				var qualityIndex:int = getRandomTargetIndex(equ_qua_rate);
				var targetQuality:String = equipment_quality[qualityIndex];
				
				var equips:Vector.<Equipment> = _data.db.interfaces(InterfaceTypes.GET_EQUIP_DATA_BY_GRADE, targetGrade, targetQuality);
				var equipsIndex:int = Utilities.GetRandomIntegerInRange(0, equips.length - 1);
				
				var model:EquipModel = new EquipModel();
				model.config = equips[equipsIndex];
				model.id = model.config.id;
				Data.instance.pack.initEquipment(model);
				
				return model;
			}
		}
		
		
	
		protected static function getRandomTargetIndex(source:Array) : int
		{
			var index:int = -1;
			
			var rand:Number = Math.random();
			var curRate:Number = 0;
			for (var i:int = 0; i < source.length; i++)
			{
				curRate += Number(source[i]);
				if (rand <= curRate)
				{
					index = i;
					break;
				}
			}
			
			if (index == -1) throw new Error("错误");
			
			return index;
		}
		
		
		/**
		 * 金币 
		 * @param data
		 * @return 
		 * 
		 */		
		public static function getGoldItems(data:Item_disposition) : Vector.<int>
		{
			var items:Vector.<int> = new Vector.<int>();
			
			var random:Number;
			var i:int = 0;
			while (i < TIME)
			{
				random = Math.random();
				
				if (random <= data.gold_rate1)
				{
					items.push(1);
				}
				else if (random <= (data.gold_rate1 + data.gold_rate10))
				{
					items.push(10);
				}
				else if (random <= (data.gold_rate1 + data.gold_rate10 + data.gold_rate100))
				{
					items.push(100);
				}
				else if (random <= (data.gold_rate1 + data.gold_rate10 + data.gold_rate100 + data.gold_rate1000))
				{
					items.push(1000);
				}
				else if(random <= (data.gold_rate1 + data.gold_rate10 + data.gold_rate100 + data.gold_rate1000 + data.gold_rate2000))
				{
					items.push(2000);
				}
				
				i++;
			}
			
			return items;
		}
		
		public static function getBoxIndex(name:String) : int
		{
			name = name.replace("Card", "");
			return parseInt(name) - 1;
		}
	}
}
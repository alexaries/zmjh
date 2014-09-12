package com.game.data.role
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.data.DataList;
	import com.game.data.db.protocal.Characters;
	import com.game.data.db.protocal.Title;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;

	public class RoleTitleInfo
	{
		private var _anti:Antiwear;
		public function get nowTitle() : String
		{
			return _anti["nowTitle"];
		}
		public function set nowTitle(value:String) : void
		{
			_anti["nowTitle"] = value;
		}
		
		private function get allTitle() : Array
		{
			return _anti["allTitle"];
		}
		private function set allTitle(value:Array) : void
		{
			_anti["allTitle"] = value;
		}
		
		private function get titleData() : Vector.<Object>
		{
			return _anti["titleData"];
		}
		private function set titleData(value:Vector.<Object>) : void
		{
			_anti["titleData"] = value;
		}
		
		public function RoleTitleInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["nowTitle"] = "";
			_anti["allTitle"] = new Array();
			_anti["titleData"] = new Vector.<Object>();
		}
		
		public function init(data:XML) : void
		{
			nowTitle = data.nowTitle;
			allTitle = String(data.allTitle).split("|");
			
			initData();
		}
		
		private function initData():void
		{
			titleData = Data.instance.db.interfaces(InterfaceTypes.GET_TITLE_ADD_DATA);
		}
		
		public function getXML() : XML
		{
			var item:XML;
			var info:XML = <roleTitle></roleTitle>;
			
			item = <nowTitle>{nowTitle}</nowTitle>;
			info.appendChild(item);
			
			item = <allTitle>{getAllTitle()}</allTitle>;
			info.appendChild(item);
			
			return info;
		}
		
		/**
		 * 附加称号属性
		 * @param lvData
		 * @param baseData
		 * @return 
		 * 
		 */		
		public function additionProperty(player:*, lvData:Characters, baseData:Characters) : Characters
		{
			var resultData:Characters = new Characters();
			var titleObj:Object;
			
			if(player.vipInfo.checkLevelFive())
				titleObj = getAllTitlePro();
			else
				titleObj = getTitle();
			
			if(titleObj != null)
			{
				resultData.hp = lvData.hp * titleObj.hp + baseData.hp * titleObj.hp;
				resultData.mp = lvData.mp * titleObj.mp + baseData.mp * titleObj.mp;
				resultData.atk = lvData.atk * titleObj.atk + baseData.atk * titleObj.atk;
				resultData.def = lvData.def * titleObj.def + baseData.def * titleObj.def;
				resultData.spd = (baseData.spd * titleObj.spd < 1?1:baseData.spd * titleObj.spd);
			}
			
			return resultData;
		}
		
		/**
		 * 获得所有已有称号的属性
		 * @return 
		 * 
		 */		
		private function getAllTitlePro() : Object
		{
			var title:Title = new Title();
			var titleList:Vector.<Object> = new Vector.<Object>();
			for each(var item:Object in titleData)
			{
				for each(var str:String in allTitle)
				{
					if(item.name == str)
						titleList.push(item);
				}
			}
			
			for each(var items:Object in titleList)
			{
				title.hp += items.hp;
				title.mp += items.mp;
				title.atk += items.atk;
				title.def += items.def;
				title.spd += items.spd;
			}
			return title;
		}
		
		/**
		 * 获得当前称号的属性
		 * @return 
		 * 
		 */		
		private function getTitle() : Object
		{
			var result:Object;
			for each(var item:Object in titleData)
			{
				if(item.name == nowTitle)
				{
					result = item;
					break;
				}
			}
			
			return result;
		}
		
		/**
		 * 获得玩家当前的所有称号
		 * @return 
		 * 
		 */		
		private function getAllTitle() : String
		{
			var result:String = "";
			for each(var item:String in allTitle)
			{
				if(result != "") result += "|";
				result += item;
			}
			return result;
		}
		
		/**
		 * 添加新的称号
		 * @param title
		 * 
		 */		
		public function addNewTitle(title:String) : void
		{
			var titleList:Array = allTitle;
			if(!checkTitle(title))
			{
				titleList.push(title);
			}
			
			allTitle = titleList;
		}
		
		
		/**
		 * 删除指定的称号
		 * @param title
		 * 
		 */		
		public function removeTitle(title:String) : void
		{
			var list:Array = allTitle;
			for each(var item:String in list)
			{
				if(item == title)
				{
					list.splice(list.indexOf(item), 1);
					break;
				}
			}
			
			allTitle = list;
		}
		
		/**
		 * 检测该称号是否存在
		 * @param title
		 * @return 
		 * 
		 */		
		public function checkTitle(title:String) : Boolean
		{
			var result:Boolean = false;
			for each(var item:String in allTitle)
			{
				if(item == title)
				{
					result = true;
					break;
				}
			}
			
			return result;
		}
		
		/**
		 * 初出江湖称号提升10%经验
		 * @param exp
		 * @return 
		 * 
		 */		
		public function checkExpTitle(exp:int) : int
		{
			var result:int = 0;
			if(Data.instance.player.player.vipInfo.checkLevelFive() || nowTitle == V.ROLE_NAME[2])
				result = exp * DataList.littleList[10];
			return result;
		}
		
		/**
		 * 富甲天下称号提升20%金钱
		 * @param money
		 * @return 
		 * 
		 */		
		public function checkMoneyTitle(money:int) : int
		{
			var result:int = 0;
			if(Data.instance.player.player.vipInfo.checkLevelFive() || nowTitle == V.ROLE_NAME[4])
				result = money * DataList.littleList[20];
			return result;
		}
	}
}
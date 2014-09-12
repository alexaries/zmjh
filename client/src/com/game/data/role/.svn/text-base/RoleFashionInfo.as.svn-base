package com.game.data.role
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.data.db.protocal.Characters;
	import com.game.data.player.structure.Player;
	import com.game.template.V;

	public class RoleFashionInfo
	{
		private function get fashionAdditionProperty() : Array
		{
			if(_anti["fashionAdditionProperty"].length == 0)
				_anti["fashionAdditionProperty"] = [.1];
			return _anti["fashionAdditionProperty"];
		}
		private function get fashionName() : Array
		{
			if(_anti["fashionName"].length == 0)
				_anti["fashionName"] = ["NewDress"];
			return _anti["fashionName"];
		}
		
		private var _anti:Antiwear;
		
		public function get player() : Player
		{
			return Data.instance.player.player;
		}
		
		private var _allType:Vector.<RoleFashionDetail>
		public function get allType() : Vector.<RoleFashionDetail>
		{
			return _allType;
		}
		public function set allType(value:Vector.<RoleFashionDetail>) : void
		{
			_allType = value;
		}
		
		public function RoleFashionInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_allType = new Vector.<RoleFashionDetail>();
			_anti["fashionName"] = new Array();
			_anti["fashionAdditionProperty"] = new Array();
		}
		
		public function init(data:XML) : void
		{
			var info:RoleFashionDetail;
			for each(var item:XML in data.item)
			{
				info = new RoleFashionDetail();
				info.owner = item.@owner;
				info.type = item.@type;
				info.getTime = item.@getTime;
				info.isUse = int(item.@isUse);
				
				_allType.push(info);
			}
		}
		
		public function getXML() : XML
		{
			var item:XML;
			var info:XML = <fashion></fashion>;
			
			for (var i:int = 0; i < _allType.length; i++)
			{
				item = <item owner={_allType[i].owner} getTime={_allType[i].getTime} type={_allType[i].type} isUse={_allType[i].isUse}/>
				info.appendChild(item);
			}

			return info;
		}
		
		
		/**
		 * 返回该角色正在使用的时装类型
		 * @param name
		 * @return 
		 * 
		 */		
		public function checkFashionUse(name:String) : String
		{
			var result:String = "";
			for each(var item:RoleFashionDetail in _allType)
			{
				if(item.owner == name.split("（")[0] && item.isUse == 1)
				{
					result = item.type;
					break;
				}
			}
			
			return result;
		}
		
		public function additionProperty(lvData:Characters, baseData:Characters) : Characters
		{
			var fashionIndex:int = fashionName.indexOf(checkFashionUse(V.MAIN_ROLE_NAME));
			var resultData:Characters = new Characters();
			if(fashionIndex != -1)
			{
				var nowProperty:Number = fashionAdditionProperty[fashionIndex];
				resultData.hp = lvData.hp * nowProperty + baseData.hp * nowProperty;
				resultData.mp = lvData.mp * nowProperty + baseData.mp * nowProperty;
				resultData.atk = lvData.atk * nowProperty + baseData.atk * nowProperty;
				resultData.def = lvData.def * nowProperty + baseData.def * nowProperty;
				resultData.spd = baseData.spd * nowProperty;
				resultData.evasion = baseData.evasion * nowProperty;
				resultData.crit = baseData.crit * nowProperty;
				/*resultData.ats = _characterConfig.ats * nowProperty;
				resultData.adf = _characterConfig.adf * nowProperty;*/
			}
			
			return resultData;
		}
		
		/**
		 * 检测是否已存在该时装
		 * @param type	时装类型
		 * @return 		是否存在
		 * 
		 */		
		public function checkFashionExist(name:String, type:String) : Boolean
		{
			var result:Boolean = false;
			for each(var item:RoleFashionDetail in _allType)
			{
				if(item.owner == name.split("（")[0] && item.type == type)
				{
					result = true;
					break;
				}
			}
			return result;
		}
		
		/**
		 * 添加type类型的时装，返回是否添加成功
		 * @param name	角色名字
		 * @param type	时装类型
		 * @return 
		 * 
		 */			
		public function addFashionInfo(name:String, type:String) : Boolean
		{
			var result:Boolean = false;
			if(!checkFashionExist(name, type))
			{
				result = true;
				var newFashion:RoleFashionDetail = new RoleFashionDetail();
				newFashion.owner = name.split("（")[0];
				newFashion.type = type;
				newFashion.getTime = Data.instance.time.curTimeStr;
				newFashion.isUse = 0;
				_allType.push(newFashion);
			}
			return result;
		}
		
		/**
		 * 删除type类型的时装
		 * @param type	时装类型
		 * @return 		是否删除成功
		 * 
		 */			
		public function removeFashionInfo(name:String, type:String) : Boolean
		{
			var result:Boolean = false;
			for each(var item:RoleFashionDetail in _allType)
			{
				if(item.owner == name.split("（")[0] && item.type == type)
				{
					result = true;
					_allType.splice(_allType.indexOf(item), 1);
					break;
				}
			}
			
			return result;
		}
		
		public function returnLastTime(name:String, type:String) : int
		{
			var result:int = 0;
			for each(var item:RoleFashionDetail in _allType)
			{
				if(item.owner == name.split("（")[0] && item.type == type)
				{
					result = Data.instance.time.disDayNum(item.getTime.split(" ")[0], Data.instance.time.returnTimeNowStr().split(" ")[0]);
					break;
				}
			}
			//result = (30 - result < 0?0:30 - result);
			result = 30 - result;
			return result;
		}
		
		
		public function wearFashion(name:String, type:String) : void
		{
			for each(var item:RoleFashionDetail in _allType)
			{
				if(item.owner == name.split("（")[0] && item.type == type)
				{
					item.isUse = 1;
					break;
				}
			}
		}
		
		public function unWearFashion(name:String, type:String) : void
		{
			for each(var item:RoleFashionDetail in _allType)
			{
				if(item.owner == name.split("（")[0] && item.type == type)
				{
					item.isUse = 0;
					break;
				}
			}
		}
	}
}
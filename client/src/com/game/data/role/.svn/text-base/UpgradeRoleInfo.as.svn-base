package com.game.data.role
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.data.db.protocal.Characters;
	import com.game.template.InterfaceTypes;

	public class UpgradeRoleInfo
	{
		private var _anti:Antiwear;
		//private var roleList:Array;
		private function get roleList() : Array
		{
			return _anti["roleList"];
		}
		private function set roleList(value:Array) : void
		{
			_anti["roleList"] = value;
		}
		public function get getRoleList() : Array
		{
			return roleList;
		}
		
		public function UpgradeRoleInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["roleList"] = new Array();
		}
		
		public function init(data:XML) : void
		{
			roleList = String(data.roles).split("|");
		}
		
		public function getXML() : XML
		{
			var info:XML = <upgradeRole></upgradeRole>;
			
			var roleInfo:String = getAllRoles();
			info.appendChild(<roles>{roleInfo}</roles>);
			
			return info;
		}
		
		private function getAllRoles() : String
		{
			var info:String = "";
			
			for (var i:int = 0; i < roleList.length; i++)
			{
				if (i != 0) info += "|";
				info += roleList[i];
			}
			
			return info;
		}
		
		public function resetRole() : void
		{
			var resultArr:Array = roleList;
			for(var i:int = resultArr.length - 1; i >= 0; i--)
			{
				if(resultArr[i].split("（")[0] == "韦小宝")
					resultArr.splice(i, 1);
			}
			roleList = resultArr;
		}
		
		public function addRole(roleName:String) : void
		{
			if(!checkRole(roleName))
			{
				var obj:Characters = Data.instance.db.interfaces(InterfaceTypes.GET_ROLE_DATA_BY_NAME, roleName);
				//合成该角色需要的消耗的角色
				if(obj.synthetic != "无")
				{
					var allRole:Array = obj.synthetic.split("|");
					for each(var name:String in allRole)
					{
						addRole(name);
					}
				}
				if(obj.quality == 2 || obj.quality == 3)
				{
					addRole(roleName.split("（")[0]);
				}
				if(obj.quality == 4)
				{
					var arr:Array = obj.name.split("（")
					if(arr.length == 2)
					{
						if(arr[1] == "雷）")
							addRole(arr[0] + "（雨）");
						else if(arr[1] == "风）")
							addRole(arr[0] + "（夜）");
					}
				}
				
				var resultArr:Array = roleList;
				resultArr.push(roleName);
				roleList = resultArr;
			}
		}
		
		
		public function checkRole(roleName:String) : Boolean
		{
			var result:Boolean = false;
			for each(var name:String in roleList)
			{
				if(name == roleName)
				{
					result = true;
					break;
				}
			}
			
			return result;
		}
		
	}
}
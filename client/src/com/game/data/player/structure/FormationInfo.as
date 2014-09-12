package com.game.data.player.structure
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.template.V;

	public class FormationInfo
	{
		public function get player() : Player
		{
			return Data.instance.player.player;
		}
		
		private var _anti:Antiwear;
		
		/**
		 * 先锋 
		 */		
		public function get front() : String
		{
			return _anti["front"];
		}
		public function set front(value:String) : void
		{
			_anti["front"] = value;
		}
		/**
		 * 中坚 
		 */		
		public function get middle() : String
		{
			return _anti["middle"];
		}
		public function set middle(value:String) : void
		{
			_anti["middle"] = value;
		}
		/**
		 * 大将 
		 */		
		public function get back() : String
		{
			return _anti["back"];
		}
		public function set back(value:String) : void
		{
			_anti["back"] = value;
		}
		
		public function FormationInfo()
		{
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["front"] = "";
			_anti["middle"] = "";
			_anti["back"] = "";
		}
		
		public function getXML() : XML
		{
			return <formation front={front} middle={middle} back={back} />;
		}
		
		public function jugleInFormation(roleName:String) : Boolean
		{
			var bol:Boolean = false;
			
			if (roleName == front) bol = true;
			if (roleName == middle) bol = true;
			if (roleName == back) bol = true;
			
			return bol;
		}
		
		public function getOtherRoleName() : Vector.<String>
		{
			var other:Vector.<String> = new Vector.<String>();
			
			if (front && front != "" && front != V.MAIN_ROLE_NAME)
			{
				other.push(front);
			}
			
			if (middle && middle != "" && middle != V.MAIN_ROLE_NAME)
			{
				other.push(middle);
			}
			
			if (back && back != "" && back != V.MAIN_ROLE_NAME)
			{
				other.push(back);
			}
			
			return other;
		}
		
		public function getAllRoleName() : Array
		{
			var all:Array = [];
			
			if (front && front != "")
			{
				all.push(front);
			}
			
			if (middle && middle != "")
			{
				all.push(middle);
			}
			
			if (back && back != "")
			{
				all.push(back);
			}
			
			return all;
		}
		
		public function glowingChange(startName:String, endName:String) : void
		{
			if(front == startName)
				front = endName;
			if(middle == startName)
				middle = endName;
			if(back == startName)
				back = endName;
		}
		
		public function assignExp(autoExp:int) : void
		{
			var singleExp:int = autoExp / (getAllRoleName() as Array).length;
			var nowRole:RoleModel;
			if(front && front != "")
			{
				nowRole = player.getRoleModel(front);
				nowRole.addExp(singleExp);
			}
			if(middle && middle != "")
			{
				nowRole = player.getRoleModel(middle);
				nowRole.addExp(singleExp);
			}
			if(back && back != "")
			{
				nowRole = player.getRoleModel(back);
				nowRole.addExp(singleExp);
			}
		}
	}
}
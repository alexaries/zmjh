package com.game.data.db.protocal
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;

	public class Vip_info
	{
		private var _anti:Antiwear;
		
		public var id:int;
		public var info_1:String;
		public var info_2:String;
		public var info_3:String;
		
		public function Vip_info()
		{
			_anti = new Antiwear(new binaryEncrypt());
		}
		
		public function assign(data:XML) : void
		{
			
			id = data.@id
			
			
			info_1 = data.@info_1
			
			
			info_2 = data.@info_2
			
			
			info_3 = data.@info_3
			
		}
		
		public function copy() : Vip_info
		{
			var target:Vip_info = new Vip_info();
			
			
			target.id = this.id;
			
			
			target.info_1 = this.info_1;
			
			
			target.info_2 = this.info_2;
			
			
			target.info_3 = this.info_3;
			
			
			return target;
		}
	}
}
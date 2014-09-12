package com.game.data.shop
{
	import com.game.Data;

	public class ShopSubmitData extends Object
	{
		public var propId:String;
		public var count:int;
		public var price:int;
		public var idx:int;
		public var tag:String;
		
		public function ShopSubmitData(id:String, num:int, money:int, str:String = "")
		{
			propId = id;
			count = num;
			price = money;
			idx = Data.instance.save.saveIndex;
			tag = str;
		}
	}
}
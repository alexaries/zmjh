package com.game.data.shop
{
	import com.game.Data;
	import com.game.data.Base;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.PropModel;
	import com.game.data.prop.PropUtilies;
	import com.game.template.V;

	public class ShopData extends Base
	{
		public function get player() : Player
		{
			return _data.player.player;
		}
		
		public function ShopData()
		{
		}
		
		public function getPropNum(id:int) : int
		{
			var	num:int = player.pack.getPropNumById(id);
			return num;
		}
		
		public function checkPropNum(id:int, addNum:int) : Boolean
		{
			var tooMuch:Boolean = false
			var	num:int = player.pack.getPropNumById(id);
			if(id == 49 || id == 54)
			{
				if((num + addNum) > V.PROP_SPECIAL_MAX_NUM)
				{
					tooMuch = true;
				}
			}
			else
			{
				if((num + addNum) > V.PROP_MAX_NUM)
				{
					tooMuch = true;
				}
			}
			return tooMuch;
		}
		
		
		public function addPropNum(id:int, addNum:int) : void
		{
			var prop:PropModel = new PropModel();
			prop.id = id;
			prop.num = addNum;
			prop.config = PropUtilies.getPropById(prop.id);
			Data.instance.pack.addProp(prop);
		}
	}
}
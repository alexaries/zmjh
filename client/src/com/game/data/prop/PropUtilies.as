package com.game.data.prop
{
	import com.game.Data;
	import com.game.data.db.protocal.Prop;
	import com.game.template.InterfaceTypes;

	public class PropUtilies
	{
		private static var _data:Data = Data.instance;
		
		public static function getPropById(id:int) : Prop
		{
			var prop:Prop;
			
			_data.db.interfaces(
				InterfaceTypes.GET_PROP_BASE_DATA,
				id,
				function (data:Prop) : void
				{
					prop = data;
				});
			
			return prop;
		}
	}
}
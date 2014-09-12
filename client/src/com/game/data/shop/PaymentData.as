package com.game.data.shop
{
	import com.game.Data;
	import com.game.View;
	import com.game.manager.LayerManager;
	import com.game.template.InterfaceTypes;
	
	import starling.core.Starling;

	public class PaymentData
	{
		private static var _useMoney:int;
		private static var _obj:ShopSubmitData;
		private static var _callback:Function;
		
		public function PaymentData()
		{
			
		}
		
		public static function startPay(useMoney:int, obj:ShopSubmitData, callback:Function, info:String = "") : void
		{
			_useMoney = useMoney;
			_obj = obj;
			_callback = callback;
			View.instance.tip.interfaces(InterfaceTypes.Show,
				info,
				function () : void
				{
					Starling.juggler.delayCall(callServer, .1);
				}, 
				null,
				false);
		}
		
		private static function callServer() : void
		{
			View.instance.controller.save.multipleState(multipleState);
			View.instance.tip.interfaces(InterfaceTypes.Show,
				"系统正在处理当中，请稍等...",
				null,
				null,
				true);
		}
		
		/**
		 * 多开判断
		 * @param e
		 * 
		 */		
		private static function multipleState(e:*) : void
		{
			if(e == "1")
			{
				if(Data.instance.pay.isLocal())
					Data.instance.pay.reduceMoney(_useMoney, paySuccess, payFailure);
				else
					Data.instance.pay.buyPropNd(_obj, paySuccess, payFailure);
			}
			else if(e == "0")
			{
				View.instance.tip.interfaces(InterfaceTypes.Show, 
					"游戏多开了，无法保存游戏存档，请关闭该页面！", 
					null,
					null,
					true);
				Starling.juggler.delayCall(
					function () : void 
					{
						LayerManager.instance.cpu_stage.frameRate = 0;
					},
					1);
			}
			else
			{
				View.instance.tip.interfaces(InterfaceTypes.Show, 
					"网络异常，请检测网络连接是否正常。如一直无法操作请刷新网页。", 
					null,
					null,
					false,
					true,
					false);
			}
		}
		
		public static function paySuccess(info:String = "") : void
		{
			View.instance.prompEffect.play("购买成功！");
			View.instance.tip.hide();
			_callback();
		}
		
		public static function payFailure(info:String = "") : void
		{
			if(View.instance.shop.delayFun) return;
			
			var list:Array = info.split("|");
			var message:String = (list.length > 1?list[1]:list[0]);
			View.instance.tip.interfaces(InterfaceTypes.Show, message, null, null, false, true, false);
		}
	}
}
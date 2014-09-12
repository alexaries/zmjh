package com.engine.net
{
	import com.engine.core.Log;
	import com.game.Data;
	
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	
	import unit4399.events.PayEvent;
	import unit4399.events.ShopEvent;
	
	public class GamePayFor4399 extends EventDispatcher
	{
		public var serviceHold:*;
		public var isLocal:Boolean;
		
		private var _stage:Stage;
		public function get stage() : Stage
		{
			return _stage;
		}
		public function set stage(value:Stage) : void
		{
			_stage = value;
			
			serviceHold = Main.serviceHold;
			initEvent();
		}
		
		private static var _instance : GamePayFor4399
		public static function get instance() : GamePayFor4399
		{
			if (!_instance)
			{
				_instance = new GamePayFor4399();
			}
			
			return _instance;
		}
		
		public function GamePayFor4399()
		{
			if (_instance) throw new Error("该类只能为单例");
		}
		
		private function initEvent() : void
		{
			stage.addEventListener("logsuccess",onPayEventHandler,false,0,true);
			stage.addEventListener("usePayApi",onPayEventHandler,false,0,true);
			stage.addEventListener("incMoney",onPayEventHandler,false,0,true);
			stage.addEventListener("decMoney",onPayEventHandler,false,0,true);
			stage.addEventListener("getMoney",onPayEventHandler,false,0,true);
			stage.addEventListener("payMoney",onPayEventHandler,false,0,true);
			stage.addEventListener("paiedMoney",onPayEventHandler,false,0,true);
			stage.addEventListener("rechargedMoney",onPayEventHandler,false,0,true);
			stage.addEventListener("payError",onPayEventHandler,false,0,true);
			
			stage.addEventListener(ShopEvent.SHOP_ERROR_ND,onShopEventHandler);
			stage.addEventListener(ShopEvent.SHOP_BUY_ND,onShopEventHandler);
			stage.addEventListener(ShopEvent.SHOP_GET_LIST,onShopEventHandler);
		}
		
		private function onPayEventHandler(e:*):void{
			Log.Trace("支付事件类型--------->"+e.type +"  e.data is Boolean------>"+(e.data is Boolean));
			switch(e.type){
				case "logsuccess":
					//登录成功：｛uid:”用户ID”,name:”用户昵称”｝
					//登录失败不会触发
					Data.instance.pay.userID = int(e.data.uid);
					Data.instance.pay.userName = e.data.name;
					Data.instance.rank.userID = int(e.data.uid);
					Data.instance.rank.userName = e.data.name;
					Log.Trace("登录成功------>uid:"+e.data.uid+"  name:"+e.data.name);
					
					//serviceHold.getUserData("115099833",0);
					//serviceHold.getOneRankInfo(1, e.data.name);
					
					break;
				case "usePayApi":
					//收到该事件，表明支付接口可以正常使用了
					Log.Trace("可以正常使用支付API");
					break;
				case "incMoney":
					if(e.data!==null&&!(e.data is Boolean)){
						Log.Trace("增加游戏币后的余额为："+e.data.balance);
						Data.instance.pay.payFun(true);
						break;
					}
					Log.Trace("增加游戏币错误！");
					Data.instance.pay.payFun(false);
					break;
				case "decMoney":
					if(e.data!==null&&!(e.data is Boolean)){
						Log.Trace("减少游戏币后的余额为："+e.data.balance);
						Data.instance.pay.payFun(true, e.data.balance.toString());
						break;
					}
					Log.Trace("减少游戏币错误！");
					Data.instance.pay.payFun(false);
					break;
				case "getMoney":
					if(e.data!==null&&!(e.data is Boolean)){
						Log.Trace("获取游戏币余额为："+e.data.balance);
						Data.instance.pay.payFun(true, e.data.balance.toString());
						break;
					}
					Log.Trace("获取游戏币余额错误！");
					Data.instance.pay.payFun(false);
					break;
				case "payMoney":
					Log.Trace("充值游戏币失败");
					Data.instance.pay.payFun(false);
					break;
				case "paiedMoney":
					if(e.data!==null&&!(e.data is Boolean)){
						Log.Trace("获取累积消费的游戏币为："+e.data.balance);
						break;
					}
					Log.Trace("获取累积消费的游戏币错误！");
					break;
				case "rechargedMoney":
					if(e.data!==null&&!(e.data is Boolean)){
						Log.Trace("获取累积充值的游戏币为："+e.data.balance);
						Data.instance.pay.payFun(true, e.data.balance.toString());
						break;
					}
					Log.Trace("获取累积充值的游戏币错误！");
					Data.instance.pay.payFun(false);
					break;
				case "payError":
					/*
					0|请重试!若还不行,请重新登录!!
					1|程序有问题，请联系技术人员100584399!!
					2|请检查,目前传进来的值等于0!!
					3|游戏不存在或者没有支付接口!!
					4|余额不足!!
					5|出错了,请重新登录!
					6|日期或者时间的格式出错了!!'
					*/
					if(e.data==null) break;
					Log.Trace("使用支付接口其他错误----->" + e.data.info);
					Data.instance.pay.payFun(false, e.data.info)
					break;
			}
		}
		
		private function onShopEventHandler(evt:*):void{
			switch(evt.type){
				case ShopEvent.SHOP_ERROR_ND:
					errorFun(evt.data);
					break;
				case ShopEvent.SHOP_BUY_ND:
					buySuccFun(evt.data);
					break;
				case ShopEvent.SHOP_GET_LIST:
					getSuccFun(evt.data as Array);
					break;
			}
		}
		
		private function errorFun(error:Object):void{
			Log.Trace("eId:" + error.eId + "  message:" + error.msg + "\n");
			
			Data.instance.pay.payFun(false, errorMessage(error.eId));
		}
		
		private function errorMessage(id:int) : String
		{
			Log.Trace("商城购买失败！");
			var result:String = "";
			switch(id)
			{
				case 10005:
					result = "当前游戏帐号不是最新的游戏帐号，请重新登录";
					break;
				case 20000:
					result = "该物品不存在";
					break;
				case 20001:
					result = "前后端价格不一致";
					break;
				case 20002:
					result = "该用户没有余额";
					break;
				case 20003:
					result = "用户余额不足";
					break;
				case 20004:
					result = "扣款出错";
					break;
				case 20010:
					result = "限量/限时/限量限时活动已结束";
					break;
				case 20011:
					result = "销售物品数量不足";
					break;
				case 20012:
					result = "活动未开始";
					break;
				case 20013:
					result = "限量折扣/限时折扣/限量限时折扣活动已结束";
					break;
				case 30000:
					result = "系统级出错";
					break;
				case 80001:
					result = "取物品列表出错了！";
					break;
				case 90001:
					result = "传的索引值有问题！";
					break;
				case 90003:
					result = "购买的物品数据不完善！";
					break;
				case 90004:
					result = "购买的物品数量须至少1个！";
					break;
				case 90005:
					result = "购买的物品数据类型有误！";
					break;
				default:
					result = "购买异常";
					break;
			}
			return result;
		}
		　　
		private function getSuccFun(data:Array):void{
			if(data == null){
				Log.Trace("获取物品列表时，返回空值了\n");
				return;
			}
			　　  
			if(data.length == 0){
				Log.Trace("无商品列表\n");
				return;
			}
			　　  
			for(var i:Object in data){
				var propData:Object = data[i];
				Log.Trace("propNum:" + i + "  propId:" + propData.propId + "  price:" + propData.price + "   propType:" + propData.propType + "\n");
			}
		}
		　　
		private function buySuccFun(data:Object):void{
			Log.Trace("商城购买成功！");
			Log.Trace("propId:" + data.propId + "  count:" + data.count + "   balance:" + data.balance + "   tag:" + data.tag + "\n");
			Data.instance.pay.payFun(true, data.balance);
		}
	}
}
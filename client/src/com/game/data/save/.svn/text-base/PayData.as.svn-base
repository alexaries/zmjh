package com.game.data.save
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.engine.net.GamePayFor4399;
	import com.game.View;
	import com.game.data.Base;
	import com.game.template.InterfaceTypes;
	
	import starling.core.Starling;

	public class PayData extends Base
	{
		// 回调方法
		private var _callbackSuccess:Function;
		private var _callbackFailure:Function;
		
		private var payMoneyVar:PayMoneyVar = PayMoneyVar.getInstance();
		
		private var _userID:int;
		public function get userID() : int
		{
			return _userID;
		}
		
		public function set userID(value:int) : void
		{
			_userID = value;
		}
		private var _userName:String;
		public function get userName() : String
		{
			return _userName;
		}
		public function set userName(value:String) : void
		{
			_userName = value;
		}
		
		//游戏在积分论坛的ID
		private var _gameID:int;
		public function get gameID() : int
		{
			if(_gameID != 50) _gameID = 50;
			return _gameID;
		}
		
		// 平台服务
		public function get serviceHold() : *
		{
			return GamePayFor4399.instance.serviceHold;
		}
		
		public function PayData()
		{
			
		}
		
		public function isLocal() : Boolean
		{
			return GamePayFor4399.instance.isLocal;
		}
		
		/**
		 * 设置回调方法
		 * @param successFun
		 * @param failureFun
		 * 
		 */		
		private function setFun(successFun:Function = null, failureFun:Function = null) : void
		{
			_callbackSuccess = successFun;
			_callbackFailure = failureFun;
		}
		
		/**
		 * 购买商品
		 * @param dataObj
		 * @param successFun
		 * @param failureFun
		 * 
		 */		
		public function buyPropNd(dataObj:Object, successFun:Function = null, failureFun:Function = null) : void
		{
			Log.Trace("V5Buy");
			setFun(successFun, failureFun);
			if(serviceHold)
			{
				serviceHold.buyPropNd(dataObj);
			}
		}
		
		/**
		 * 减少游戏币
		 * @param num
		 * @param successFun
		 * @param failureFun
		 * 
		 */		
		public function reduceMoney(num:int, successFun:Function = null, failureFun:Function = null) : void
		{
			Log.Trace("V4Buy");
			setFun(successFun, failureFun);
			if(serviceHold)
			{
				serviceHold.decMoney(num);
			}
		}
		
		/**
		 * 增加游戏币
		 * @param num
		 * @param successFun
		 * @param failureFun
		 * 
		 */		
		public function addMoney(num:int, successFun:Function = null, failureFun:Function = null) : void
		{
			setFun(successFun, failureFun);
			if(serviceHold)
			{
				serviceHold.incMoney(num);
			}
		}
		
		/**
		 * 打开充值链接
		 * @param num
		 * @param successFun
		 * @param failureFun
		 * 
		 */		
		public function payMoney(num:int, successFun:Function = null, failureFun:Function = null) : void
		{
			var payMoneyVar:PayMoneyVar = PayMoneyVar.getInstance();
			payMoneyVar.money = 10; 
			setFun(successFun, failureFun);
			if(serviceHold)
			{
				if(isLocal())
					serviceHold.payMoney(num);
				else
					serviceHold.payMoney_As3(payMoneyVar);
			}
		}
		
		/**
		 * 获得游戏币的值
		 * @return 
		 * 
		 */		
		public function getBalance(successFun:Function = null, failureFun:Function = null) : void
		{
			setFun(successFun, failureFun);
			if(serviceHold)
			{
				serviceHold.getBalance();
			}
		}
		
		/**
		 * 获取累积充值的游戏币
		 * @param successFun
		 * @param failureFun
		 * 
		 */
		public function getTotalRecharged(successFun:Function = null, failureFun:Function = null) : void
		{
			setFun(successFun, failureFun);
			if(serviceHold)
			{
				serviceHold.getTotalRechargedFun();
			}
		}
		
		/**
		 * 获取累积消费的游戏币
		 * @param successFun
		 * @param failureFun
		 * 
		 */		
		public function getTotalPaied(successFun:Function = null, failureFun:Function = null) : void
		{
			setFun(successFun, failureFun);
			if(serviceHold)
			{
				serviceHold.getTotalPaiedFun();
			}
		}
		
		/**
		 * 返回函数
		 * @param TOF
		 * @param data
		 * 
		 */		
		public function payFun(TOF:Boolean, data:String = "") : void
		{
			if(TOF&&_callbackSuccess != null) 
			{
				if(data == "")	_callbackSuccess();
				else _callbackSuccess(data);
			}
			else if(!TOF&&_callbackFailure != null)  
			{
				if(data == "")	_callbackFailure();
				else _callbackFailure(data);
			}
		}
		
	}
}
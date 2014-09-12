package com.game.view.Role
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.db.protocal.Level_up_exp;
	import com.game.data.martial.MartialDetail;
	import com.game.data.player.structure.RoleModel;
	import com.game.data.shop.PaymentData;
	import com.game.data.shop.ShopSubmitData;
	import com.game.manager.LayerManager;
	import com.game.template.InterfaceTypes;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	import com.game.view.effect.GlowAnimationEffect;
	import com.game.view.effect.TextColorEffect;
	
	import flash.utils.getTimer;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class MartialComponent extends Component
	{
		private var _anti:Antiwear;
		
		public function get durationTime() : int
		{
			return _anti["durationTime"];
		}
		public function set durationTime(value:int) : void
		{
			_anti["durationTime"] = value;
		}
		public function get useMoney() : Boolean
		{
			return _anti["useMoney"];
		}
		public function set useMoney(value:Boolean) : void
		{
			_anti["useMoney"] = value;
		}
		public function get moneyType() : Boolean
		{
			return _anti["moneyType"];
		}
		public function set moneyType(value:Boolean) : void
		{
			_anti["moneyType"] = value;
		}
		
		
		private var _startDate:Date;
		private var _serverDate:Date;
		private var _calculateDate:Date;
		
		public function MartialComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			_serverDate = Data.instance.time.serverDate;
			
			_anti = new Antiwear(new binaryEncrypt());
			useMoney = false;
			durationTime = 0;
			moneyType = false;
			
			init();
		}
		
		override protected function init() : void
		{
			super.init();
			
			getUI();
			initEvent();
		}
		
		private var _roleImage:Image;
		private var _roleType:Image;
		private var _roleGrade:Image;
		private var _lessTime:TextField;
		private var _getExp:TextField;
		private var _lvUpStart:TextField;
		private var _lvUpArrow:TextField;
		private var _lvUpEnd:TextField;
		
		private var _threeBtn:Button;
		private var _twelveBtn:Button;
		private var _completeBtn:Button;
		private var _quickMartialBtn:Button;
		private var _startMartialBtn:Button;
		
		private var _levelInfo:Vector.<Object>;
		private var _getAllExp:int;
		private var _callback:Function;
		
		private var _threeEffect:GlowAnimationEffect;
		private var _twelveEffect:GlowAnimationEffect;
		private var _lvUpEffect:TextColorEffect;
		private function getUI() : void
		{
			_roleImage = this.searchOf("RoleImage");
			_roleType = this.searchOf("RoleType");
			_roleType.touchable = false;
			_roleGrade = this.searchOf("RoleGrade");
			_roleGrade.touchable = false;
			_roleImage.addEventListener(TouchEvent.TOUCH, setRoleNull);
			
			_lessTime = this.searchOf("LessTime");
			_getExp = this.searchOf("GetExp");
			_lvUpStart = this.searchOf("LvUpStart");
			_lvUpArrow = this.searchOf("LvUpArrow")
			_lvUpEnd = this.searchOf("LvUpEnd");
			
			_lvUpEffect = new TextColorEffect(_lvUpEnd, 0xFFFF00, 0xFF0000, 0x000000, .6);
			
			_threeBtn = this.searchOf("ThreeHoursBtn");
			_twelveBtn = this.searchOf("TwelveHoursBtn");
			_completeBtn = this.searchOf("CompleteBtn");
			_quickMartialBtn = this.searchOf("QuickMartialBtn");
			_startMartialBtn = this.searchOf("MartialBtn");
			
			_threeEffect = new GlowAnimationEffect(_threeBtn, 0x00FF00);
			_twelveEffect = new GlowAnimationEffect(_twelveBtn, 0x00FF00);
			
			_levelInfo = new Vector.<Object>();
			_levelInfo = Data.instance.db.interfaces(InterfaceTypes.GET_LEVEL_UP_EXP);
		}
		
		private function setRoleNull(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_roleImage);
			if(!touch) return;
			if(touch.tapCount == 2 && touch.phase == TouchPhase.ENDED)
			{
				if(this.roleModel == null) return;
				else if(_alreadyRole)
				{
					_view.tip.interfaces(InterfaceTypes.Show,
						"现在撤销修炼无法获得任何练功成果和返还消耗，是够确定撤销修炼？",
						function () : void
						{
							_view.removeFromFrameProcessList(_martialDetail.name);
							player.martialInfo.removeMartial(_roleModel.info.roleName);
							_alreadyRole = false;
							_view.prompEffect.play("撤销修炼！");
							revocateRole();
						},
						null, false);
				}
				else
				{
					revocateRole();
				}
			}
		}
		
		private function revocateRole() : void
		{
			_roleImage.visible = false;
			_roleType.visible = false;
			_roleGrade.visible = false;
			_lessTime.text = "";
			_getExp.text = "";
			_lvUpStart.text = "";
			_lvUpArrow.text = "";
			_lvUpEnd.text = "";
			_lvUpEffect.stop();
			_hasRole = false;
			setUnTouch();
			_quickMartialBtn.visible = false;
			_completeBtn.visible = false;
			_startMartialBtn.visible = true;
			//_view.roleSelect.renderRoles();
			if(_callback != null) _callback();
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "ThreeHoursBtn":
					threeMartial();
					break;
				case "TwelveHoursBtn":
					twelveMartial();
					break;
				case "MartialBtn":
					startMartial();
					break;
				case "QuickMartialBtn":
					quickMartial();
					break;
				case "CompleteBtn":
					completeMartial();
					break;
			}
		}
		
		private function threeMartial() : void
		{
			_lessTime.text = "3:0:0";
			_getAllExp = (_levelInfo[_roleModel.info.lv - 1] as Level_up_exp).exp_3hours;
			_getExp.text = _getAllExp.toString();
			_lvUpStart.text = _roleModel.info.lv.toString();
			_lvUpArrow.text = "—>";
			_lvUpEnd.text = _roleModel.getAllLv(_getAllExp, _roleModel.info.lv)[0].toString();
			durationTime = 3;
			useMoney = false;
			_threeEffect.play();
			_twelveEffect.stop();
			if(_roleModel.getAllLv(_getAllExp, _roleModel.info.lv)[1])
				_lvUpEffect.play();
			else
				_lvUpEffect.stop();
		}
		
		private function twelveMartial() : void
		{
			_lessTime.text = "12:0:0";
			_getAllExp = (_levelInfo[_roleModel.info.lv - 1] as Level_up_exp).exp_12hours;
			_getExp.text = _getAllExp.toString();
			_lvUpStart.text = _roleModel.info.lv.toString();
			_lvUpArrow.text = "—>";
			_lvUpEnd.text = _roleModel.getAllLv(_getAllExp, _roleModel.info.lv)[0].toString();
			durationTime = 12;
			useMoney = true;
			_threeEffect.stop();
			_twelveEffect.play();
			if(_roleModel.getAllLv(_getAllExp, _roleModel.info.lv)[1])
				_lvUpEffect.play();
			else
				_lvUpEffect.stop();
		}
		
		private function startMartial() : void
		{
			var info:String = "";
			if(useMoney)
			{
				if(_roleModel.getAllLv(_getAllExp, _roleModel.info.lv)[1])
				{
					info = "角色等级无法超过小宝，多余经验将会消失，是否确认继续练功？\n";
				}
				moneyType = false;
				info += "修炼12小时需要消耗599点券，是否花费点券？";
				var obj:ShopSubmitData = new ShopSubmitData("760", 1, 599);
				PaymentData.startPay(599, obj, paySuccess, info);
			}
			else
			{
				if(_roleModel.getAllLv(_getAllExp, _roleModel.info.lv)[1])
				{
					info = "角色等级无法超过小宝，多余经验将会消失，是否确认继续练功？\n";
				}
				info += "修炼3小时需要消耗" + (_levelInfo[_roleModel.getAllLv(_getAllExp, _roleModel.info.lv)[0] - 1] as Level_up_exp).gold + "金币，是否继续？";
				_view.tip.interfaces(InterfaceTypes.Show,
					info,
					function () : void
					{
						Starling.juggler.delayCall(canStartMartial, .1);
					}, 
					null, false);
			}
		}
		
		public function paySuccess(info:String = "") : void
		{
			
			if(moneyType)
			{
				_view.tip.interfaces(InterfaceTypes.Show, 
					"购买成功！",// + _roleModel.info.roleName + "完成练功！",
					null, null, false, true, false);
				completeMartial();
			}
			else
			{
				_view.tip.interfaces(InterfaceTypes.Show, 
					"购买成功！",// + _roleModel.info.roleName + "开始练功！",
					null, null, false, true, false);
				canStartMartial();
			}
		}
		
		private function canStartMartial() : void
		{
			if(durationTime == 3)
			{
				if(player.money < (_levelInfo[_roleModel.getAllLv(_getAllExp, _roleModel.info.lv)[0] - 1] as Level_up_exp).gold)
				{
					_view.tip.interfaces(InterfaceTypes.Show,
						"金币不足，无法修炼！",
						null, null, false, true, false);
					return;
				}
				else
				{
					player.money -= (_levelInfo[_roleModel.getAllLv(_getAllExp, _roleModel.info.lv)[0] - 1] as Level_up_exp).gold;
					_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
					_view.toolbar.checkRoleMartial();
				}
			}
			
			/*_startDate = new Date(_serverDate.fullYear, _serverDate.month, _serverDate.date, _serverDate.hours, _serverDate.minutes, _serverDate.seconds);
			_startDate.time += getTimer();*/
			//_startDate = Data.instance.time.returnTimeNow();
			//var str:String = _startDate.fullYear + "-" + (_startDate.month + 1) + "-" + _startDate.date + " " + _startDate.hours + ":" + _startDate.minutes + ":" + _startDate.seconds;
			var str:String = Data.instance.time.returnTimeNowStr();
			player.martialInfo.addMartial(_roleModel.info.roleName, str, durationTime);
			_martialDetail = player.martialInfo.getMartialRole(_roleModel.info.roleName);
			_startDate = Data.instance.time.returnTimeNow();
			checkDate();
			
			_startMartialBtn.visible = false;
			_quickMartialBtn.visible = true;
			_completeBtn.visible = false;
			addTouchable(_quickMartialBtn);
			setUnTouch();
			
			_alreadyRole = true;
			if(_callback != null) _callback();
			
			Log.Trace("开始练功保存");
			_view.controller.save.onCommonSave(false, 1, false);
			
			_view.prompEffect.play(_martialDetail.name + "开始练功，将在" + _martialDetail.duration + "小时后获得" + _getAllExp + "经验，升到" + _roleModel.getAllLv(_getAllExp, _roleModel.info.lv)[0] + "级！");
		}
		
		private function quickMartial() : void
		{
			moneyType = true;
			var costMoney:int = 400 - (12 * 2 - (_calculateDate.hours * 2 + Math.ceil(_calculateDate.minutes / 30))) / (12 * 2) * 400;
			var info:String = "您需要消耗" + costMoney + "点券才能达到速成，是否花费点券？";
			var obj:ShopSubmitData = new ShopSubmitData("761", costMoney, 1);
			PaymentData.startPay(costMoney, obj, paySuccess, info);
		}
		
		private function completeMartial() : void
		{
			_view.removeFromFrameProcessList(_martialDetail.name);
			_roleModel.addExp(_getAllExp);
			player.martialInfo.removeMartial(_roleModel.info.roleName);
			_view.prompEffect.play(_martialDetail.name + "获得" + _getAllExp + "经验，升到" + _roleModel.info.lv + "级！");
			_alreadyRole = false;
			_hasRole = false;
			if(_callback != null) _callback();
			changeData();
			Log.Trace("完成练功保存");
			_view.controller.save.onCommonSave(false, 1, false);
			_view.toolbar.checkRoleMartial();
		}
		
		private var _alreadyRole:Boolean;
		public function get alreadyRole() : Boolean
		{
			return _alreadyRole;
		}
		private var _martialDetail:MartialDetail;
		public function setData(martialDetail:MartialDetail, callback:Function = null) : void
		{
			if(_martialDetail != null) return;
			_martialDetail = martialDetail;
			durationTime = _martialDetail.duration;
			_callback = callback;
			_alreadyRole = true;
			setRole(_martialDetail.name);
			getRoleModel(_martialDetail.name);
			setLessDetail(_martialDetail);
			
			setUnTouch();
			_quickMartialBtn.visible = true;
			_completeBtn.visible = false;
			_startMartialBtn.visible = false;
			
			_startDate = setDate(Data.instance.time.analysisTime(_martialDetail.startTime));
			checkDate();
		}
		
		private function checkDate() : void
		{
			var nowDate:Date = Data.instance.time.returnTimeNow();
			var intervalTime:Number = nowDate.time - _startDate.time;
			if(intervalTime > _martialDetail.duration * 60 * 60 * 1000)
			{
				_startMartialBtn.visible = false;
				_quickMartialBtn.visible = false;
				_completeBtn.visible = true;
				addTouchable(_completeBtn);
				_lessTime.text = "0:0:0";
			}
			else
			{
				_calculateDate = new Date(_serverDate.fullYear, _serverDate.month, _serverDate.date, 0, 0, 0);
				_calculateDate.time += (_martialDetail.duration * 60 * 60 * 1000 - intervalTime);
				_startFrameTime = getTimer();
				_view.addToFrameProcessList(_martialDetail.name, showLessTime);
			}
		}
		
		private var _startFrameTime:Number;
		private var _endFrameTime:Number;
		private function showLessTime() : void
		{
			_endFrameTime = getTimer();
			_lessTime.text = _calculateDate.hours + ":" + _calculateDate.minutes + ":" + _calculateDate.seconds;
			_calculateDate.milliseconds -= (_endFrameTime - _startFrameTime);
			_startFrameTime = getTimer();
			
			if(_calculateDate.hours == 0 && _calculateDate.minutes == 0 && _calculateDate.seconds == 0)
				removeTime();
		}
		
		/**
		 * 删除剩余时间显示循环函数
		 * 
		 */		
		private function removeTime() : void
		{
			_view.removeFromFrameProcessList(_martialDetail.name);
			_lessTime.text = "0:0:0";
			_completeBtn.visible = true;
			_quickMartialBtn.visible = false;
			_startMartialBtn.visible = false;
			addTouchable(_completeBtn);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.checkRoleMartial();
		}
		
		/**
		 * 已经在存档中的角色设置详细参数
		 * @param martialDetail
		 * 
		 */		
		private function setLessDetail(martialDetail:MartialDetail) : void
		{
			if(martialDetail.duration == 3)
				_getAllExp = (_levelInfo[_roleModel.info.lv - 1] as Level_up_exp).exp_3hours;
			else
				_getAllExp = (_levelInfo[_roleModel.info.lv - 1] as Level_up_exp).exp_12hours;
			_getExp.text = _getAllExp.toString();
			_lvUpStart.text = _roleModel.info.lv.toString();
			_lvUpArrow.text = "—>";
			_lvUpEnd.text = _roleModel.getAllLv(_getAllExp, _roleModel.info.lv)[0].toString();
			if(_roleModel.getAllLv(_getAllExp, _roleModel.info.lv)[1])
				_lvUpEffect.play();
			else
				_lvUpEffect.stop();
		}
		
		/**
		 * 已经在存档中的角色设置roleModel参数
		 * @param name
		 * 
		 */		
		private function getRoleModel(name:String) : void
		{
			for each(var item:RoleModel in player.roleModels)
			{
				if(item.info.roleName == name)
				{
					_roleModel = item;
					break;
				}
			}
		}
		
		private function setUnTouch() : void
		{
			_threeEffect.stop();
			_twelveEffect.stop();
			removeTouchable(_threeBtn);
			removeTouchable(_twelveBtn);
			removeTouchable(_startMartialBtn);
		}
		
		private function setTouch() : void
		{
			_threeEffect.stop();
			_twelveEffect.stop();
			addTouchable(_threeBtn);
			addTouchable(_twelveBtn);
			addTouchable(_startMartialBtn);
		}
		
		private var _roleModel:RoleModel;
		public function get roleModel() : RoleModel
		{
			return _roleModel;
		}
		private var _hasRole:Boolean;
		public function get hasRole() : Boolean
		{
			return _hasRole;
		}
		public function changeData(roleModel:RoleModel = null, callback:Function = null) : void
		{
			_callback = callback;
			_roleModel = roleModel;
			if(_roleModel == null)
			{
				_roleImage.visible = false;
				_roleType.visible = false;
				_roleGrade.visible = false;
				_lessTime.text = "";
				_getExp.text = "";
				_lvUpStart.text = "";
				_lvUpArrow.text = "";
				_lvUpEnd.text = "";
				_lvUpEffect.stop();
				_hasRole = false;
				setUnTouch();
			}
			else 
			{
				setRole(_roleModel.info.roleName);
				setTouch();
				setDetail();
			}
			_quickMartialBtn.visible = false;
			_completeBtn.visible = false;
			_startMartialBtn.visible = true;
		}
		
		private function setDetail() : void
		{
			threeMartial();
		}
		
		private function setRole(name:String) : void
		{
			_roleImage.visible = true;
			_roleType.visible = true;
			_roleGrade.visible = true;
			_hasRole = true;
			checkGrade(name, _roleGrade);
			checkType(name, _roleType);
			checkImage(name, _roleImage);
		}
		
		private function setDate(lastTime:Array) : Date
		{
			var startDate:Date = new Date(lastTime[0], (int(lastTime[1]) - 1), lastTime[2], lastTime[3], lastTime[4], lastTime[5]);
			return startDate;
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new MartialComponent(_configXML, _titleTxAtlas);
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			super.destroy();
		}
		
		override public function resetView() : void
		{
			if(this.roleModel == null) return;
			else if(_alreadyRole)
			{
				_view.removeFromFrameProcessList(_martialDetail.name);
				player.martialInfo.removeMartial(_roleModel.info.roleName);
				_alreadyRole = false;
				revocateRole();
			}
			_martialDetail = null;
			_callback = null;
			_roleModel = null;
		}
	}
}
package com.game.view.daily
{
	import com.game.Data;
	import com.game.data.db.protocal.Daily_attendance;
	import com.game.data.player.structure.SignInInfo;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.TouchPhase;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class DayNumComponent extends Component
	{
		/**
		 * 当前配置数据 
		 */		
		private var _curDailyTemplateData:Daily_attendance;
		/**
		 * 今天累计签到日期
		 */		
		private var _signDay:int;
		
		/// UI
		/**
		 * 签到图标 
		 */		
		private var _signIcon:Image;
		/**
		 * 天数图标 
		 */		
		private var _dayImage:Image;
		
		private var _dayTF:TextField;		
		private var _diceTF:TextField;
		
		public function DayNumComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
			initEvent();
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "OneDay":
					onSignIn();
					break;
			}
		}
		
		/**
		 * 签到 
		 * 
		 */		
		protected function onSignIn() : void
		{
			var isUp:Boolean = Data.instance.daily.checkDiceReachUp(_curDailyTemplateData.dice);
			
			// 超上限
			if (isUp)
			{
				var content:String = "";
				
				_view.tip.interfaces(InterfaceTypes.Show,
					"骰子数快到上限了！现在签到会失去大量骰子！建议先消耗一些骰子再签到。请问是否继续领取？",
					callback, null);
			}
			else
			{
				callback();
			}
			
			function callback() : void
			{
				Data.instance.daily.setSignInInfo(_signDay, _curDailyTemplateData);
				_view.signIn.interfaces();
				_view.toolbar.checkDaily();
			}
		}
		
		override protected function initEvent():void
		{
			super.initEvent();
			
			var eventBind:ViewEventBind = new ViewEventBind(_dayImage, TouchPhase.ENDED, onClickeHandle, true);
			addListener(eventBind);
		}
		
		public function initData(templateData:Daily_attendance, signDay:int) : void
		{
			_curDailyTemplateData = templateData;
			_signDay = signDay;
			
			render();
		}
		
		protected function render() : void
		{
			var dayNum:int = _curDailyTemplateData.day;
			_dayTF.text = V.NUM_TO_CHINA[dayNum] + "天";
			_diceTF.text = _curDailyTemplateData.dice.toString();
			_dayImage.texture = this.getTexture(dayNum + "Day", "");
			
			panel.touchable = true;
			var signInInfo:SignInInfo = Data.instance.daily.getSignInInfo();
			if (Starling.context.driverInfo != "Disposed") panel.filter = null;
			// 当天签到过了
			if (_signDay == -1)
			{
				if (signInInfo.duration  >= _curDailyTemplateData.day)
				{
					_dayImage.touchable = false;
					_signIcon.visible = true;
				}
				else
				{
					panel.touchable = false;
					_signIcon.visible = false;
					if (Starling.context.driverInfo != "Disposed") panel.filter = new GrayscaleFilter();
				}
			}
			else
			{
				if (_signDay  > _curDailyTemplateData.day)
				{
					_dayImage.touchable = false;
					_signIcon.visible = true;
				}
				// 当天签到
				else if (_signDay == _curDailyTemplateData.day)
				{
					_dayImage.touchable = true;
					_signIcon.visible = false;
				}
				else
				{
					panel.touchable = false;
					_signIcon.visible = false;
					if (Starling.context.driverInfo != "Disposed") panel.filter = new GrayscaleFilter();
				}
			}
		}
		
		private function getUI() : void
		{
			_dayTF = this.searchOf("Tx_Day");
			_diceTF = this.searchOf("Tx_Dice");	
			_signIcon = this.searchOf("Sign");
			
			_dayImage = this.searchOf("OneDay");
			_dayImage.useHandCursor = true;
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new DayNumComponent(_configXML, _titleTxAtlas);
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			super.destroy();
		}
	}
}
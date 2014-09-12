package com.game.view.toolbar
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.player.structure.Player;
	import com.game.template.InterfaceTypes;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import flash.utils.getTimer;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;
	
	public class OnlineComponent extends Component
	{
		
		public function OnlineComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
			initEvent();
		}
		
		public var _onlineTimeBtn:Button;
		private var _onlineTimeText:TextField;
		private var _onlineTimeGet:Image;
		private var _onlineTimeBg:Image;
		private function getUI():void
		{
			_onlineTimeBtn = this.searchOf("OnlineTimeBtn") as Button;
			_onlineTimeText = this.searchOf("OnlineTimeText") as TextField;
			_onlineTimeGet = this.searchOf("OnlineTimeGet") as Image;
			_onlineTimeBg = this.searchOf("OnlineTimeBg") as Image;
			
			_view.addToFrameProcessList("onlineTime", onlineTimeShow);
		}
		
		private var _onlineStart:Number;
		private var _onlineEnd:Number;
		private function onlineTimeShow() : void
		{
			if(!player.onlineTimeInfo.isComplete && !player.onlineTimeInfo.isOver)
			{
				if(isNaN(_onlineStart)) _onlineStart = getTimer();
				_onlineTimeText.text = (player.onlineTimeInfo.useDate.hours * 60 + player.onlineTimeInfo.useDate.minutes) + ":" + player.onlineTimeInfo.useDate.seconds;
				_onlineEnd = getTimer();
				player.onlineTimeInfo.useDate.milliseconds -= (_onlineEnd - _onlineStart);
				_onlineStart = getTimer();
				
				if(player.onlineTimeInfo.useDate.hours == 0 && player.onlineTimeInfo.useDate.minutes == 0 && player.onlineTimeInfo.useDate.seconds == 0)
				{
					player.onlineTimeInfo.isComplete = true;
					_onlineTimeBtn.touchable = true;
					_onlineTimeText.text = "";
					_onlineTimeGet.visible = true;
					_view.toolbar.checkOnlineTime();
				}
			}
		}
		
		
		public function checkOnlineBtn() : void
		{
			if(player.checkLevelShow("1_2"))
			{
				this.panel.visible = true;
				//第一次
				if(player.onlineTimeInfo.nowRewardLevel == 0)
				{
					_onlineTimeBtn.touchable = true;
					_onlineTimeBtn.visible = true;
					_onlineTimeGet.visible = true;
					_onlineTimeText.visible = false;
					_onlineTimeBg.visible = true;
				}
				else
				{
					//在线时间达到要求
					if(player.onlineTimeInfo.isComplete)
					{
						_onlineTimeBtn.touchable = true;
						_onlineTimeBtn.visible = true;
						_onlineTimeGet.visible = true;
						_onlineTimeText.visible = false;
						_onlineTimeBg.visible = true;
					}
					else
					{
						//所有奖励都已领取
						if(player.onlineTimeInfo.isOver)
						{
							this.panel.visible = false;
						}
						else
						{
							_onlineTimeBtn.touchable = false;
							_onlineTimeBtn.visible = true;
							_onlineTimeText.visible = true;
							_onlineTimeGet.visible = false;	
							_onlineTimeBg.visible = true;
						}
					}
				}
			}
			else
			{
				this.panel.visible = false;
			}
		}
		
		/**
		 * 事件监听 
		 * @param e
		 * 
		 */		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				// 在线奖励
				case "OnlineTimeBtn":
					onlineTimeReward();
					break;
			}
		}
		
		
		public function onlineTimeReward() : void
		{
			var propID:Array = player.onlineTimeInfo.infoData[player.onlineTimeInfo.nowRewardLevel].prop_id.split("|");
			var propNum:Array = player.onlineTimeInfo.infoData[player.onlineTimeInfo.nowRewardLevel].number.split("|");
			propID.splice(0, 0, 0);
			propNum.splice(0, 0, player.onlineTimeInfo.getDiceNum());
			
			var resultList:Array = _view.props.checkData(propID, propNum);
			
			// 超上限
			if (!resultList[0])
			{
				var content:String = "";
				
				_view.tip.interfaces(InterfaceTypes.Show,
					resultList[1] + "数量达到最大值，建议消耗之后再领取！是否继续领取？",
					function () : void{Starling.juggler.delayCall(delayCallback, .01);},
					function () : void{_view.toolbar.interfaces(InterfaceTypes.UNLOCK);},
					false);
			}
			else
			{
				delayCallback();
			}
		}
		
		private function delayCallback() : void
		{
			_onlineStart = getTimer();
			player.onlineTimeInfo.addNextReward();
			checkOnlineBtn();
			Log.Trace("领取在线奖励保存");
			_view.controller.save.onCommonSave(false, 1, false);
			_view.toolbar.checkOnlineTime();
			if(player.onlineTimeInfo.isOver)
				_view.toolbar.interfaces(InterfaceTypes.REFRESH);
			else
				_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new OnlineComponent(_configXML, _titleTxAtlas);
		}
	}
}
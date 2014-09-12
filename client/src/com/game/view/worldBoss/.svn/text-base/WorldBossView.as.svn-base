package com.game.view.worldBoss
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.db.protocal.Prop;
	import com.game.data.db.protocal.Real_Boss;
	import com.game.data.save.RankSaveData;
	import com.game.data.save.SubmitData;
	import com.game.data.shop.PaymentData;
	import com.game.data.shop.ShopSubmitData;
	import com.game.manager.DebugManager;
	import com.game.manager.LayerManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.equip.PropTip;
	import com.game.view.ui.UIConfig;
	
	import flash.display.Bitmap;
	import flash.utils.getTimer;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class WorldBossView extends BaseView implements IView
	{
		private var _anti:Antiwear;
		private static const GET_REWARD_DATE:String = "2013-08-25 12:00:00";
		
		public function WorldBossView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.WORLD_BOSS;
			_loaderModuleName = V.WORLD_BOSS;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["useCount"] = 0;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
			}
		}
		
		override protected function init():void
		{
			if (!isInit)
			{
				super.init();
				
				initXML();
				initTexture();
				initComponent();
				initUI();
				getUI();
				initEvent();
				
				isInit = true;
			}
			
			render();
			
			_view.layer.setCenter(panel);
		}
		
		private var _positionXML:XML;
		private var _information:Vector.<Object>;
		private function initXML() : void
		{
			if(!_positionXML) _positionXML = getXMLData(V.WORLD_BOSS, GameConfig.WORLD_BOSS_RES, "WorldBossPosition");
			if(!_information) _information = Data.instance.db.interfaces(InterfaceTypes.GET_REAL_BOSS_DATA);
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.WORLD_BOSS, GameConfig.WORLD_BOSS_RES, "WorldBoss");			
				obj = getAssetsObject(V.WORLD_BOSS, GameConfig.WORLD_BOSS_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
			}
		}
		
		private function initComponent() : void
		{
			var name:String;
			var cp:Component;
			var layerName:String;
			for each(var items:XML in _positionXML.component.Items)
			{
				name = items.@name;
				if (!this.checkInComponent(name))
				{
					switch (name)
					{
						/*case "LevelKind":
							cp = new DoubleLevelKindComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;*/
					}
				}
			}
		}
		
		private function initUI() : void
		{
			var name:String;
			var obj:*;
			var layerName:String;
			for each(var items:XML in _positionXML.layer)
			{
				layerName = items.@layerName;
				for each(var element:XML in items.item)
				{
					name = element.@name;
					
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						obj["layerName"] = layerName;
						_uiLibrary.push(obj);
					}
				}
			}
		}
		
		
		public function get myRank():String
		{
			return _curRank.text;
		}
		private var _curRank:TextField;
		private var _curFightNum:TextField;
		private var _curPropNum:TextField;
		private var _curExpNum:TextField;
		private var _curGoldNum:TextField;
		private var _curSoulNum:TextField;
		private var _curTimeNum:TextField;
		private var _getRewardBtn:Button;
		private var _usePropBtn:Button;
		private var _newRecord:Image;
		private var _propTip:PropTip;
		private var _coldTimeTitle:TextField;
		private var _coldTime:TextField;
		public function get useCount() : int
		{
			return _anti["useCount"];
		}
		public function set useCount(value:int) : void
		{
			_anti["useCount"] = value;
		}
		private function getUI() : void
		{
			_curRank = this.searchOf("RankNum");
			_curFightNum = this.searchOf("FightNum");
			_curPropNum = this.searchOf("WineNum");
			_curExpNum = this.searchOf("ExpNum");
			_curGoldNum = this.searchOf("GoldNum");
			_curSoulNum = this.searchOf("SoulNum");
			_curTimeNum = this.searchOf("TimeNum");
			_getRewardBtn = this.searchOf("GetReward");
			_usePropBtn = this.searchOf("WindeBtn");
			_newRecord = this.searchOf("NewRecord");
			_newRecord.visible = false;
			_coldTimeTitle = this.searchOf("ColdTimeTitle");
			_coldTime = this.searchOf("ColdTime");
			_coldTimeTitle.visible = false;
			_coldTime.visible = false;
			
			_propTip = _view.ui.interfaces(UIConfig.PROP_TIP);
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "StartFightBtn":
					startFight();
					break;
				case "Close":
					hide();
					break;
				case "RankList":
					showRank();
					break;
				case "GetReward":
					getReward();
					break;
				case "WindeBtn":
					useProp();
					break;
			}
		}
		
		private function useProp() : void
		{
			if(_canUseProp)
			{
				useCount++;
				_curPropNum.text = "+" + useCount * 10 + "%";
				renderButton();
			}
			else
				_view.shop.interfaces(InterfaceTypes.GET_MALL, "烧酒", renderButton);
		}
		
		private function getReward() : void
		{
			if(_curRank.text == "无" || _curRank.text == "" || player.worldBossInfo.getReward == 1 || !_isTwoDay)	 return;
			var useData:Real_Boss = (_information[int(_curRank.text) - 1] as Real_Boss);
			var propID:Array = useData.reward.split("|");
			var propNum:Array = useData.reward_number.split("|");
			
			var resultList:Array = _view.props.checkData(propID, propNum);
			
			// 超上限
			if (!resultList[0])
			{
				var content:String = "";
				
				_view.tip.interfaces(InterfaceTypes.Show,
					resultList[1] + "数量达到最大值，建议消耗之后再领取！是否继续领取？",
					function () : void{Starling.juggler.delayCall(delayCallback, .01, useData);},
					null, false);
			}
			else
			{
				delayCallback(useData);
			}
		}
		
		private function delayCallback(data:Real_Boss) : void
		{
			player.money += int(data.gold);
			player.fight_soul += int(data.soul);
			
			var str:String = "";
			var propIDList:Array = data.reward.split("|");
			var propNumList:Array = data.reward_number.split("|");
			for(var i:int = 0; i < propIDList.length; i++)
			{
				Data.instance.pack.addNoneProp(int(propIDList[i]), int(propNumList[i]));
				str += "，" +　(Data.instance.db.interfaces(InterfaceTypes.GET_PROP_BY_ID, propIDList[i]) as Prop).name + "X" + propNumList[i];
			}
			
			_view.tip.interfaces(InterfaceTypes.Show,
				"恭喜您获得金币 X " + data.gold + "，战魂 X " + data.soul + " " + str,
				null, null, false, true, false);
			
			player.worldBossInfo.getReward = 1;
			renderButton();
			Log.Trace("领取真假小宝奖励保存");
			_view.controller.save.onCommonSave(false, 1, false);
		}
		
		private function showRank() : void
		{
			this.hide();
			_view.rank_list.interfaces();
		}
		
		private var _nowAllowChange:Number;
		private function startFight() : void
		{
			if(DebugManager.instance.gameMode == V.DEVELOP)
			{
				_nowAllowChange = _view.world.allowChange;
				Data.instance.pack.changePropNum(41, -useCount);
				_view.boss_fight.interfaces();
				hide();
				return;
			}
			
			if(player.worldBossInfo.isComplete == 0 || (player.worldBossInfo.isComplete == 1 && player.vipInfo.checkLevelThree()))
			{
				player.worldBossInfo.isComplete++;
				_nowAllowChange = _view.world.allowChange;
				Data.instance.pack.changePropNum(41, -useCount);
				_view.boss_fight.interfaces();
				hide();
			}
			else
			{
				var obj:ShopSubmitData = new ShopSubmitData("759", 1, 200);
				PaymentData.startPay(200, obj,
					function () : void
					{
						_nowAllowChange = _view.world.allowChange;
						Data.instance.pack.changePropNum(41, -useCount);
						_view.boss_fight.interfaces();
						hide();
					}, "是否花费200点卷再次挑战真假小宝？");
			}
		}
		
		private var _canUseProp:Boolean;
		private var _isTwoDay:Boolean
		/**
		 * 界面上按钮状态
		 * 
		 */		
		private function renderButton() : void
		{
			_isTwoDay = Data.instance.time.checkTwoDay(GET_REWARD_DATE, player.worldBossInfo.time);
			
			if(player.worldBossInfo.getReward == 1)
			{
				removeTouchable(_getRewardBtn);
				_getRewardBtn.touchable = true;
				_propTip.add({o:_getRewardBtn,m:{name:"",message:"今天已领取"}});
			}
			else if(_curRank.text == "无")
			{
				removeTouchable(_getRewardBtn);
				_getRewardBtn.touchable = true;
				_propTip.add({o:_getRewardBtn,m:{name:"",message:"你还未在排行榜上，请继续努力"}});
			}
			else
			{
				if(_isTwoDay)
				{
					_propTip.add({o:_getRewardBtn,m:{name:"",message:"可以领取奖励"}});
					addTouchable(_getRewardBtn);
				}
				else
				{
					removeTouchable(_getRewardBtn);
					_getRewardBtn.touchable = true;
					_propTip.add({o:_getRewardBtn,m:{name:"",message:"明天才能领取奖励"}});
				}
			}
			
			if(useCount >= 10)
			{
				removeTouchable(_usePropBtn);
				_canUseProp = true;
			}
			else if((player.pack.getPropNumById(41) - useCount) <= 0)
			{
				removeTouchable(_usePropBtn);
				_usePropBtn.touchable = true;
				_canUseProp = false;
			}
			else
			{
				addTouchable(_usePropBtn);
				_canUseProp = true;
			}
		}
		
		private function render() : void
		{
			useCount = 0;
			var allHurt:int = player.worldBossInfo.fightHurt;
			_curFightNum.text = allHurt.toString();
			_curExpNum.text = int(allHurt * .35).toString();
			_curGoldNum.text = int(allHurt * .125).toString();
			_curSoulNum.text = int(allHurt * .125).toString();
			_curTimeNum.text = returnTimeStr(player.worldBossInfo.fightTime.toString());
			
			
			_curPropNum.text = "+" + useCount * 10 + "%";
			_view.loadData.loadDataPlay();
			
			Data.instance.rank.callback = setRankList;
			//Data.instance.rank.getOneRankInfo(Data.instance.rank.testWorldBossID, Data.instance.rank.userName);
			Data.instance.rank.getOneRankInfo(Data.instance.rank.worldBossID, Data.instance.rank.userName);
		}
		
		private function returnTimeStr(time:String) : String
		{
			var result:String = "";
			var curTime:int = int(time);
			result = int(curTime / 60) + ":" + int(curTime % 60);
			
			return result;
		}
		/**
		 * 设置新纪录图标
		 * @param dataAry
		 * 
		 */		
		public function resetInterface(dataAry:Array) : void
		{
			if(dataAry == null)
			{
				_newRecord.visible = false;
				return;
			}
			
			var obj:Object = dataAry[0];
			if(int(obj.curScore) > int(obj.lastScore) && int(obj.curRank) <= 50)
				_newRecord.visible = true;
			else
				_newRecord.visible = false;
		}
		
		private var _nowScore:int;
		public function get nowScore() : int
		{
			return _nowScore;
		}
		private var _nowTime:int;
		public function get nowTime() : int
		{
			return _nowTime;
		}
		private function setRankList(data:Array) : void
		{
			var result:Boolean = false;
			_view.loadData.hide();
			for each(var item:Object in data)
			{
				if(int(item.index) == Data.instance.save.saveIndex && item.rank <= 50)
				{
					_view.loadData.loadDataPlay();
					Starling.juggler.delayCall(getRankFront, .1);
					_nowScore = int(item.score);
					_nowTime = int(item.extra.split("|")[1]);
					result = true;
					break;
				}
			}
			if(!result)
			{
				_nowScore = 0;
				_nowTime = 0;
				_curRank.text = "无";
			}
			renderButton();
			renderTime();
		}
		
		private function renderTime() : void
		{
			if(_isTwoDay)
			{
				_coldTimeTitle.visible = false;
				_coldTime.visible = false;
				if(_curRank.text != "无")
				{
					_coldTimeTitle.visible = true;
					if(player.worldBossInfo.getReward == 1)
						_coldTimeTitle.text = "今天已领取";
					else
						_coldTimeTitle.text = "可以领取奖励";
				}
			}
			else
			{
				if(_curRank.text == "无")
				{
					_coldTimeTitle.visible = false;
					_coldTime.visible = false;
				}
				else
				{
					_coldTimeTitle.visible = true;
					_coldTimeTitle.text = "领奖倒计时：";
					_coldTime.visible = true;
					_startTime = getTimer();
					var nowDate:Date = Data.instance.time.returnTimeNow();
					_countDate = new Date(2013, 1, 1, 23 - nowDate.hours, 59 - nowDate.minutes, 60 - nowDate.seconds);  
					_view.addToFrameProcessList("coldTime", coldTimeHandler);
				}
			}
		}
		
		private var _startTime:Number;
		private var _endTime:Number;
		private var _countDate:Date;
		private function coldTimeHandler():void
		{
			_endTime = getTimer();
			_countDate.time -= (_endTime - _startTime);
			_startTime = getTimer();
			
			_coldTime.text = _countDate.hours + ":" + _countDate.minutes + ":" + _countDate.seconds;
		}
		
		private function getRankFront() : void
		{
			Data.instance.rank.callback = setRankListFront;
			//Data.instance.rank.getRankListsData(Data.instance.rank.testWorldBossID, 50, 1);
			Data.instance.rank.getRankListsData(Data.instance.rank.worldBossID, 50, 1);
		}
		
		private function setRankListFront(data:Array) : void
		{
			_view.loadData.hide();
			for(var j:uint = 0; j < data.length; j++)
			{
				data[j].fightTime = data[j].extra.split("|")[1];
			}
			data = resetSortList(data);
			for(var i:int = 0; i < data.length; i++)
			{
				data[i].realRank = (i + 1);
			}
			for each(var item:Object in data)
			{
				if(item.index == Data.instance.save.saveIndex && int(item.uId) == Data.instance.pay.userID)
				{
					_curRank.text = item.realRank;
					break;
				}
			}
		}
		
		private function resetSortList(data:Array) : Array
		{
			var switchObj:Object;
			for(var i:uint = 0; i < data.length; i++)
			{
				for(var j:uint = i; j < data.length; j++)
				{
					if(int(data[i].rank) == int(data[j].rank))
					{
						if(int(data[i].fightTime) > int(data[j].fightTime))
						{
							switchObj = data[i];
							data[i] = data[j];
							data[j] = switchObj;
						}
					}
				}
			}
			return data;
		}
		
		/**
		 * 重新提交当前的伤害值到排行榜
		 * 
		 */		
		private function uploadScore() : void
		{
			player.countFormationFighting();
			if(player.fightingNum > player.maxFightingNum)
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"您的成绩正在提交审核中，请耐心等待。",
					null, null, false, true, false);
				RankSaveData.RankSave(Data.instance.rank.testWorldBossID, player.worldBossInfo.fightHurt, player.mainRoleModel.info.lv.toString());
			}
			else 
			{
				Data.instance.rank.submitCallback = null;
				RankSaveData.RankSave(Data.instance.rank.testWorldBossID, player.worldBossInfo.fightHurt, player.mainRoleModel.info.lv.toString());
				RankSaveData.RankSave(Data.instance.rank.worldBossID, player.worldBossInfo.fightHurt, player.mainRoleModel.info.lv.toString());
			}
		}
		
		override public function hide() : void
		{
			if(!isNaN(_nowAllowChange))
			{
				_view.world.allowChange = _nowAllowChange;
				_nowAllowChange = NaN;
			}
			super.hide();
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else
			{
				textures = _titleTxAtlas.getTextures(name);
			}
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			if (type == "public")
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			
			return texture;
		}
	}
}
package com.game.view.playerFight
{
	import com.engine.core.Log;
	import com.engine.ui.controls.Grid;
	import com.game.Data;
	import com.game.data.db.protocal.Arena;
	import com.game.data.db.protocal.Prop;
	import com.game.data.save.RankSaveData;
	import com.game.data.shop.PaymentData;
	import com.game.data.shop.ShopSubmitData;
	import com.game.manager.DebugManager;
	import com.game.manager.FontManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import flash.display.Bitmap;
	import flash.utils.getTimer;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class PlayerFightView extends BaseView implements IView
	{
		private var _saveContent:Vector.<Object>;
		public function PlayerFightView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.PLAYER_FIGHT;
			_loaderModuleName = V.PLAYER_FIGHT;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if(type == "") type = InterfaceTypes.Show;
			
			switch(type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
			}
		}
		
		override protected function init() : void
		{
			if(!isInit)
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
			
			initFightPlayer();
			initContent();
			
			_view.layer.setCenter(this.panel);
		}
		
		private var _positionXML:XML;
		private var _moneyData:Vector.<Object>;
		private var _arenaData:Vector.<Object>;
		private function initXML() : void
		{
			if(!_positionXML) _positionXML = getXMLData(V.PLAYER_FIGHT, GameConfig.PLAYER_FIGHT_RES, "PlayerFightPosition");
			if(!_moneyData)
			{
				_moneyData = new Vector.<Object>();
				_moneyData = Data.instance.db.interfaces(InterfaceTypes.GET_LEVEL_UP_EXP);
			}
			if(!_arenaData)
			{
				_arenaData = new Vector.<Object>();
				_arenaData = Data.instance.db.interfaces(InterfaceTypes.GET_ARENA_DATA);
			}
		}
		
		private var _titleTxAtlas:TextureAtlas;
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.PLAYER_FIGHT, GameConfig.PLAYER_FIGHT_RES, "PlayerFight");			
				obj = getAssetsObject(V.PLAYER_FIGHT, GameConfig.PLAYER_FIGHT_RES, "Textures");
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
						/*case "ChangePage":
							cp = new ChangePageComponent(items, _titleTxAtlas);
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
		
		private var _nowRankLv:int;
		public function get nowRankLv() : int
		{
			return _nowRankLv;
		}
		private var _rivalScore:int;
		public function get rivalScore() : int
		{
			return _rivalScore;
		}
		public function set rivalScore(value:int) : void
		{
			_rivalScore = value;
		}
		private var _nowScore:int;
		private var _nowPosition:int;
		private var _nowLvTF:TextField;
		private var _timeTF:TextField;
		private var _fightTime:TextField;
		private var _myFightingNum:TextField;
		private var _updateListBtn:Button;
		private var _infoContent:Sprite;
		private var _curData:Array;
		private function getUI() : void
		{
			_nowLvTF = this.searchOf("MyRankDetail");
			_timeTF = this.searchOf("NextTimeDetail");
			_fightTime = this.searchOf("CanFightDetail");
			_updateListBtn = this.searchOf("UpdatePlayer");
			_myFightingNum = this.searchOf("MyFightDetail");
			
			_saveContent = new Vector.<Object>();
			_infoContent = new Sprite();
			_infoContent.x = 360;
			_infoContent.y = 360;
			panel.addChild(_infoContent);
			_curData = new Array();
		}
		
		public function addFightContent(type:int, info:String, num:int) : void
		{
			var obj:Object = new Object();
			obj.type = type;
			obj.info = info;
			obj.num = num;
			_saveContent.push(obj);
			while(_saveContent.length > 3)
			{
				_saveContent.splice(0, 1);
			}
		}
		
		private function initContent() : void
		{
			removeContent();
			for(var i:int = _saveContent.length - 1; i >= 0; i--)
			{
				var tf:TextField = addNewText(-10, 35 * (_saveContent.length - i - 1), 275, 25, 0x85300C);
				_infoContent.addChild(tf);
				var textureType:Texture;
				if(_saveContent[i].type == 1)
				{
					textureType = getTexture("VictoryImage", "");
					tf.text = "你挑战" + _saveContent[i].info + "，你胜利了，升至" + _saveContent[i].num + "名";
				}
				else
				{
					textureType = getTexture("LoseImage", "");
					tf.text = "你挑战" + _saveContent[i].info + "，你失败了，排名不变";
				}
				var img:Image = new Image(textureType);
				img.x = -40;
				img.y = 35 * (_saveContent.length - i - 1) - 5;
				_infoContent.addChild(img);
			}
		}
		
		private function removeContent():void
		{
			while(_infoContent.numChildren > 0)
			{
				_infoContent.removeChildAt(0, true);
			}
		}
		
		public function addNewText(xPos:int, yPos:int, wid:int, hei:int, color:uint) : TextField
		{
			var tf:TextField = new TextField(wid, hei, "");			
			tf.color = color;
			tf.hAlign = HAlign.CENTER;
			tf.vAlign = VAlign.CENTER;
			tf.fontSize = 17;
			tf.kerning = true;
			tf.autoScale = true;
			tf.x = xPos;
			tf.y = yPos;
			tf.fontName = FontManager.instance.font.fontName; 
			
			return tf;
		}
 		
		private function initFightPlayer(isSuccess:Boolean = true) : void
		{
			if(DebugManager.instance.gameMode == V.DEVELOP)
			{
				_nowRankLv = 1;
				noPlayerList();
			}
			else
			{
				if(isSuccess)
				{
					_view.loadData.loadDataPlay();
					Data.instance.rank.callback = checkRankByOwn;
					Data.instance.rank.getRankListByOwn(Data.instance.rank.playerFightID, Data.instance.save.saveIndex, 20);
				}
				else
				{
					_view.loadData.hide();
					_view.tip.interfaces(InterfaceTypes.Show,
						"无法获取排行榜信息！",
						null, null, false, true, false);
					removeTouchable(searchOf("UpdatePlayer") as Button);
					removeTouchable(searchOf("ColdDownBtn") as Button);
					removeTouchable(searchOf("GetRewardBtn") as Button);
				}
			}
		}
		
		private function checkRankByOwn(data:Array) : void
		{
			_curData = data;
			if(data.length == 0)
			{
				Data.instance.rank.callback = checkRankByLast;
				Data.instance.rank.getRankListsData(Data.instance.rank.playerFightID, 20, 500);
			}
			else
			{
				showInfomation(data);
			}
		}
		
		private function checkRankByLast(data:Array) : void
		{
			_curData = data;
			if(data.length == 0)
			{
				Data.instance.rank.submitCallback = initFightPlayer;
				RankSaveData.RankSave(Data.instance.rank.playerFightID, 1, player.getPlayerFightInfo());
			}
			else
			{
				showInfomation(data);
			}
		}
		
		
		private var _fightPlayerList:Array;
		/**
		 * 显示从服务器返回的数据
		 * @param data
		 * 
		 */		
		private function showInfomation(data:Array) : void
		{
			_view.loadData.hide();
			baseShow(data);
			getShowData(data);
			renderPlayer();
			checkShow();
			renderText();
			renderButton();
			renderTitle();
		}
		
		/**
		 * 天下第一的称号
		 * 
		 */		
		private function renderTitle() : void
		{
			if(_nowRankLv == 1 && !player.roleTitleInfo.checkTitle(V.ROLE_NAME[3]))
			{
				player.roleTitleInfo.addNewTitle(V.ROLE_NAME[3]);
				_view.tip.interfaces(InterfaceTypes.Show,
					"恭喜您获得“天下第一”的称号！",
					null, null, false, true, false);
				//_view.prompEffect.play("恭喜您获得“天下第一”的称号！");
			}
			if(_nowRankLv != 1 && player.roleTitleInfo.checkTitle(V.ROLE_NAME[3]))
			{
				if(player.roleTitleInfo.nowTitle == V.ROLE_NAME[3])
					player.roleTitleInfo.nowTitle = "";
				player.roleTitleInfo.removeTitle(V.ROLE_NAME[3]);
				_view.tip.interfaces(InterfaceTypes.Show,
					"很遗憾，您失去了“天下第一”的称号！",
					null, null, false, true, false);
				player.mainRoleModel.beginCount();
				_view.role.interfaces(InterfaceTypes.REFRESH);
				//_view.prompEffect.play("很遗憾，您失去了“天下第一”的称号！");
			}
		}
		
		private function renderText() : void
		{
			_fightTime.text = (10 - player.playerFightInfo.fightTime).toString();
			_myFightingNum.text = "我的战力：" + player.fightingNum;
		}
		
		private function renderButton() : void
		{
			if(player.playerFightInfo.getReward == 0 && _nowRankLv <= 100)
				addTouchable(searchOf("GetRewardBtn") as Button);
			else
				removeTouchable(searchOf("GetRewardBtn") as Button);
			
			if(_playerGrid.touchable == false && player.playerFightInfo.fightTime < 10)
				addTouchable(searchOf("ColdDownBtn") as Button);
			else
				removeTouchable(searchOf("ColdDownBtn") as Button);
			
			if(_nowRankLv == 1)
				removeTouchable(searchOf("UpdatePlayer") as Button);
			else
				addTouchable(searchOf("UpdatePlayer") as Button);
		}
		
		/**
		 * 基础信息显示
		 * @param data
		 * 
		 */		
		private function baseShow(data:Array) : void
		{
			var result:Boolean = false;
			for each(var item:Object in data)
			{
				if(item.uId == Data.instance.pay.userID && item.index == Data.instance.save.saveIndex)
				{
					_nowPosition = data.indexOf(item);
					_nowLvTF.text = item.rank;
					_nowRankLv = int(item.rank);
					_nowScore = int(item.score);
					result = true;
					break;
				}
			}
			if(result == false)
			{
				_nowPosition = 20;
				_nowLvTF.text = "无";
				_nowScore = 0;
				_nowRankLv = 10001;
			}
		}
		
		/**
		 * 检测界面显示
		 * 
		 */		
		private function checkShow() : void
		{
			//没有数据，打自己
			if(_fightPlayerList.length == 0)
			{
				//removeFrameFun();
				noPlayerList();
			}
			//有数据
			
			//当天PK数小于10次
			if(player.playerFightInfo.fightTime < 10)
			{
				//除第一次外的PK
				if(player.playerFightInfo.fightTime != 0)
					initTime();
					//每天第一次PK
				else
					removeFrameFun();
			}
			else
			{
				_view.removeFromFrameProcessList("playerFight");
				_playerGrid.filter = new GrayscaleFilter();
				_playerGrid.touchable = false;
			}
		}
		
		/**
		 * 对获得的数据进行分析处理
		 * @param data
		 * 
		 */		
		private function getShowData(data:Array) : void
		{
			_fightPlayerList = new Array();
			for each(var newItem:Object in data)
			{
				if(int(newItem.rank) <= _nowRankLv && data.indexOf(newItem) < _nowPosition)
				{
					if(newItem.uId == Data.instance.pay.userID && newItem.index == Data.instance.save.saveIndex){}
					else _fightPlayerList.push(newItem);
				}
			}
			
			while(_fightPlayerList.length > 10)
			{
				_fightPlayerList.splice(0, 1);
			}
			
			var count:int = 1;
			while(_fightPlayerList.length > 5)
			{
				_fightPlayerList.splice(count, 1);
				if(_nowRankLv > 20)
					count++;
			}
			_fightPlayerList.reverse();
		}
		
		/**
		 * 没有返回数据
		 * 
		 */		
		private function noPlayerList() : void
		{
			if(_nowRankLv == 1)
			{
				_fightPlayerList = new Array();
				var obj:Object = new Object();
				obj.uId = Data.instance.pay.userID;
				obj.userName = Data.instance.pay.userName;
				obj.index = Data.instance.save.saveIndex;
				obj.score = _nowScore - 1;
				obj.rank = 1;
				obj.extra = player.getPlayerFightInfo();
				
				_fightPlayerList.push(obj);
				renderPlayer();
			}
		}
		
		private var _startTime:Number;
		private var _endTime:Number;
		private var _countDownDate:Date;
		/**
		 * 倒计时设置
		 * 
		 */		
		private function initTime() : void
		{
			var isStart:Boolean = false;
			var intervalTime:Number;
			var nowDate:Date = Data.instance.time.returnTimeNow();
			var startDate:Date = setDate(Data.instance.time.analysisTime(player.playerFightInfo.time));
			intervalTime = nowDate.time - startDate.time;
			
			if(intervalTime < 15 * 60 * 1000)
			{
				isStart = true;
				_countDownDate = new Date(nowDate.fullYear, nowDate.month, nowDate.date, 0, 0, 0);
				_countDownDate.time += (15 * 60 * 1000 - intervalTime);
			}
			
			if(isStart)
			{	
				_startTime = getTimer();
				_view.addToFrameProcessList("playerFight", onFrameFun);
				_playerGrid.filter = new GrayscaleFilter();
				_playerGrid.touchable = false;
			}
			else
			{
				removeFrameFun();
			}
		}
		
		private function onFrameFun() : void
		{
			_endTime = getTimer();
			_countDownDate.time -= (_endTime - _startTime);
			_startTime = getTimer();
			_timeTF.text = _countDownDate.minutes + ":" + _countDownDate.seconds;
			
			if(_countDownDate.hours == 0 && _countDownDate.minutes == 0 && _countDownDate.seconds == 0)
				removeFrameFun();
		}
		
		private function removeFrameFun() : void
		{
			_view.removeFromFrameProcessList("playerFight");
			_playerGrid.filter = null;
			_playerGrid.touchable = true;
			_timeTF.text = "0:0";
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.checkPlayerFight();
		}
		
		private var _playerGrid:Grid;
		/**
		 * 渲染可挑战的玩家信息
		 * 
		 */		
		public function renderPlayer() : void
		{
			if (!_playerGrid)
			{
				_playerGrid = new Grid(PlayerFightItemRender, 1, 5, 85, 72, 8.5, 6);
				_playerGrid["layerName"] = "BackGround";
				_playerGrid.x = 340;
				_playerGrid.y = 145;
				panel.addChild(_playerGrid);
				_uiLibrary.push(_playerGrid);
			}
			
			_playerGrid.setData(_fightPlayerList);
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "Close":
					this.hide();
					break;
				case "RankListBtn":
					showRankList();
					break;
				case "ColdDownBtn":
					resetTime();
					break;
				case "UpdatePlayer":
					updatePlayer();
					break;
				case "GetRewardBtn":
					getReward();
					break;
			}
		}
		
		private function getReward() : void
		{
			var useData:Arena = (_arenaData[int(_nowRankLv) - 1] as Arena);
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
		
		private function delayCallback(data:Arena) : void
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
			
			player.playerFightInfo.getReward = 1;
			renderButton();
			
			Log.Trace("竞技场领取奖励保存");
			_view.controller.save.onCommonSave(false, 1, false);
		}
		
		private function updatePlayer() : void
		{
			var costMoney:int = _moneyData[player.mainRoleModel.info.lv - 1].gold * .5;
			_view.tip.interfaces(InterfaceTypes.Show,
				"是否花费" + costMoney + "金币刷新排行榜？",
				function () : void
				{
					if(player.money > costMoney)
					{
						player.money -= costMoney;
						_view.loadData.loadDataPlay();
						updateList();
						/*Data.instance.rank.playerFightCallback = updateList;
						Data.instance.rank.getRankListByOwn(Data.instance.rank.playerFightID, Data.instance.save.saveIndex, 20);*/
					}
					else
					{
						Starling.juggler.delayCall(
							function () : void
							{
								_view.tip.interfaces(InterfaceTypes.Show,
									"金币不足，无法刷新排行榜！",
									null, null, false, true, false);
							},
							.01);
					}
				},
				null, false);
		}
		
		private function updateList() : void
		{
			_view.loadData.hide();
			_fightPlayerList = new Array();
			for each(var newItem:Object in _curData)
			{
				if(int(newItem.rank) <= _nowRankLv)
				{
					if(newItem.uId == Data.instance.pay.userID && newItem.index == Data.instance.save.saveIndex){}
					else _fightPlayerList.push(newItem);
				}
			}
			
			_fightPlayerList.sort(sortByFighting);
			renderPlayer();
		}
		
		private function sortByFighting(x:Object, y:Object) : Number
		{
			var result:Number = 0;
			if(int(x.extra.split("|")[2]) < int(y.extra.split("|")[2]))
				result = -1;
			else
				result = 1;
			return result;
		}
		
		/**
		 * 刷新冷却时间
		 * 
		 */		
		private function resetTime() : void
		{
			if(_playerGrid.touchable == false && player.playerFightInfo.fightTime < 10)
			{
				var cost:int = getCost();
				var obj:ShopSubmitData = new ShopSubmitData("762", cost, 1);
				PaymentData.startPay(cost, obj,
					function () : void
					{
						var nowDate:Date = Data.instance.time.returnTimeNow();
						nowDate.time -= 15 * 60 * 1000;
						player.playerFightInfo.time = Data.instance.time.returnInputTimeStr(nowDate);
						checkShow();
						renderButton();
					}, "是否花费" + cost + "点卷更新挑战时间？");
				
			}
			else
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"当前不需要刷新冷却时间！",
					null, null, false, true, false);
			}
		}
		
		private function getCost() : int
		{
			var result:int = 0;
			result = Math.ceil((_countDownDate.minutes * 60 + _countDownDate.seconds) / (15 * 60) * 100);
			return result;
		}
		
		/**
		 * 排行榜
		 * 
		 */		
		private function showRankList() : void
		{
			_view.player_fight_list.interfaces();
		}
		
		override public function hide() : void
		{
			_view.removeFromFrameProcessList("playerFight");
			super.hide();
		}
		
		private function setDate(lastTime:Array) : Date
		{
			var startDate:Date = new Date(lastTime[0], (int(lastTime[1]) - 1), lastTime[2], lastTime[3], lastTime[4], lastTime[5]);
			return startDate;
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
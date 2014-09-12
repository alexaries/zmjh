package com.game.view.map
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.engine.event.EventTypes;
	import com.engine.ui.controls.DragOut;
	import com.game.data.db.protocal.Adventures;
	import com.game.data.fight.FightConfig;
	import com.game.data.map.AutoFightData;
	import com.game.data.weather.WeatherChangeData;
	import com.game.manager.LayerManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.Base;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.LevelEvent.AdventuresConfig;
	import com.game.view.ViewEventBind;
	import com.game.view.equip.PropTip;
	import com.game.view.map.player.PlayerEntity;
	import com.game.view.map.player.PlayerStatus;
	import com.game.view.ui.UIConfig;
	import com.game.view.weather.WeatherEffect;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class MapView extends BaseView implements IView
	{
		private var _anti:Antiwear;
		/**
		 * 地图摄像头
		 */
		private var _mapCamera:MapCamera;
		/**
		 * 当前关卡 
		 */		
		private var _curLevel:String;
		public function get curLevel() : String
		{
			return _curLevel;
		}
		/**
		 * 声音资源 
		 */		
		private var _curSoundRes:String;		
		/**
		 * 默认按钮纹理 
		 */		
		private var _defaultBtnTexture:Texture;
		/**
		 * 导向纹理 
		 */		
		private var _orientedTexture:Texture; 
		
		// 地图信息
		private var _mapInfo:MapInfo;
		public function get mapInfo() : MapInfo
		{
			return _mapInfo;
		}
		
		// 场景ID
		private var _sceneId:int;
		public function get sceneId() : int
		{
			return _sceneId;
		}
		
		// 当前关卡等级
		private var _curLV:int;
		public function get curLV() : int
		{
			return 	_curLV;
		}
		
		// 困难模式
		private var _kind:int;
		public function get kind() : int
		{
			return _kind;
		}
		
		//方向组件 	
		private var _oriented:OrientedComponent;
		public function get oriented() : OrientedComponent
		{
			return _oriented;
		}
		
		// 层级
		private var _mapLayers:MapLayer;
		public function get mapLayers() : MapLayer
		{
			return _mapLayers;
		}
		
		// 角色 
		private var _playerRole:PlayerEntity;
		public function get playerRole() : PlayerEntity
		{
			return _playerRole;
		}
		public function set playerRole(value:PlayerEntity) : void
		{
			_playerRole = value
		}
		
		/**
		 * 是否开启黑暗模式
		 */		
		private var _allowSun:Boolean;
		public function get allowSun() : Boolean
		{
			return _allowSun;
		}
		public function set allowSun(value:Boolean) : void
		{
			_allowSun = value;
			//initBlack();
		}
		
		/**
		 * 是否开启黑夜模式
		 */		
		private var _allowBlack:Boolean;
		public function get allowBlack() : Boolean
		{
			return _allowBlack;
		}
		public function set allowBlack(value:Boolean) : void
		{
			_allowBlack = value;
			_weatherEffect.initWeatherBlack();
		}
		/**
		 * 是否开启下雨模式
		 */		
		private var _allowRain:Boolean;
		public function get allowRain() : Boolean
		{
			return _allowRain;
		}
		public function set allowRain(value:Boolean) : void
		{
			_allowRain = value;
			_weatherEffect.initWeatherRain();
		}
		
		/**
		 * 是否开启雷雨模式
		 */		
		private var _allowThunder:Boolean;
		public function get allowThunder() : Boolean
		{
			return _allowThunder;
		}
		
		public function set allowThunder(value:Boolean) : void
		{
			_allowThunder = value;
			_weatherEffect.initWeatherThunder();
		}
		
		/**
		 * 是否开启大风模式
		 */		
		private var _allowWind:Boolean;
		public function get allowWind() : Boolean
		{
			return _allowWind;
		}
		public function set allowWind(value:Boolean) : void
		{
			_allowWind = value;
			_weatherEffect.initWeatherWind();
		}
		
		private var _weatherList:Vector.<Boolean>;
		
		public function get weatherList() : Vector.<Boolean>
		{
			return _weatherList;
		}
		public function set weatherList(value:Vector.<Boolean>) : void
		{
			_weatherList = value;
			initWeather();
		}
		
		/**
		 * 扫荡模式下是第几波
		 */
		private var _fightCount:int;
		
		public function get fightCount() : int
		{
			return _fightCount;
		}
		public function set fightCount(value:int) : void
		{
			_fightCount = value;
		}
		
		/**
		 * 是否开启自动扫荡模式
		 */		
		private var _autoLevel:Boolean;
		public function get autoLevel() : Boolean
		{
			return _autoLevel;
		}
		
		private var _weatherEffect:WeatherEffect;
		public function get weatherEffect() : WeatherEffect
		{
			return _weatherEffect;
		}
		
		public function get weatherTime() : int
		{
			return _anti["weatherTime"];
		}
		
		public function set weatherTime(value:int) : void
		{
			_anti["weatherTime"] = value;
		}
		
		public var isClose:Boolean;
		
		public function MapView()
		{
			_layer = LayerTypes.CONTENT;
			_moduleName = V.MAP;
			_mapCamera = new MapCamera();
			isClose = true;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["weatherTime"] = 0;
			
			super();
		}
		
		private function initWeatherList() : void
		{
			_weatherList = new Vector.<Boolean>();
			_weatherList.push(false, false, false, false, false);
		}
		
		public function initWeather() : void
		{
			allowSun = false;
			allowBlack = false;
			allowRain = false;
			allowThunder = false;
			allowWind = false;
			if(_weatherList[0] == true)
				allowSun = true;
			if(_weatherList[1] == true)
				allowBlack = true;
			if(_weatherList[2] == true)
				allowRain = true;
			if(_weatherList[3] == true)
				allowThunder = true;
			if(_weatherList[4] == true)
				allowWind = true;
		}
		
		/**
		 * 获得当前天气状态
		 * @return 返回0，1，2，3，4
		 * 
		 */		
		public function getWeatherStatus() : int
		{
			var returnCount:int = 0;
			for(var i:int = 0; i < _weatherList.length; i++)
			{
				if(_weatherList[i] == true)
				{
					returnCount = i;
					break;
				}
			}
			return returnCount;
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			Log.Trace("Map:" + type + "---" + args);
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_autoLevel = false;
					preShow(args);
					break;
				case InterfaceTypes.THROW_DICE_RESULT:
					throwDiceResult(args[0]);
					break;
				case InterfaceTypes.THROW_FREE_DICE_RESULT:
					throwDiceResult(args[0], true);
					break;
				case InterfaceTypes.SKIP_LEVEL:
					//_autoLevel = true;
					preShow(args);
					break;
				case InterfaceTypes.SET_EFFECT:
					setEffect();
					break;
			}
		}
		
		protected function preShow(args:Array) : void
		{
			Log.Trace("Map preShow!");
			initWeatherList();
			
			_loadResources = [];
			_sceneId = args[0];
			_curLV = args[1];
			_kind = args[2];
			
			_curLevel = _sceneId + "_" + _curLV;
			_loadBaseName = "map_" + _curLevel;
			_loaderModuleName = _loadBaseName;
			
			_curSoundRes = "map_" + _sceneId;
			
			if (_curLV == 4) _curSoundRes = "map_hide";
			
			_loadResources.push(_curSoundRes);
			
			_view.load.smallLoadProgressBar('', 0, 0, 0);
			show();
			
		}
		
		/**
		 * 投掷筛子点数 
		 * @param diceNum
		 * 
		 */		
		private function throwDiceResult(diceNum:uint, isFree:Boolean = false) : void
		{
			weatherTime--;
			Log.Trace("当前剩余天气模式次数：" + weatherTime);
			if((this.allowRain || this.allowThunder) && !isFree) diceNum *= 2;
			var startNode:Node = new Node();
			startNode.preIndex = playerRole.preNode;
			startNode.curIndex = new Point(_mapInfo.playerPosition.gx, _mapInfo.playerPosition.gy);
			var PathInfos:SingleLineInfo;
			//正常模式
			/*if(!_autoLevel)
			{*/
				PathInfos = MapUtils.getRoadInfo(startNode, diceNum, _mapInfo.roadItems);
				if(isFree)
					playerRole.setPath(PathInfos, _mapInfo.roadItems, true);
				else
					playerRole.setPath(PathInfos, _mapInfo.roadItems)
			/*}
			//扫荡模式
			else 
			{
				PathInfos = MapUtils.getRoadInfo(startNode, _mapInfo.roadItems.length , _autoRoad);
				playerRole.setPath(PathInfos, _autoRoad);
			}*/
		}
		
		override protected function init() : void
		{
			Log.Trace("Map init!");
			isClose = false;
			_view.load.hide();
			
			super.init();
			_view.toolbar.interfaces(InterfaceTypes.Show, "map");
			_view.toolbar.interfaces(InterfaceTypes.CHECK_EXP);
			_view.world.interfaces(InterfaceTypes.HIDE);
			_view.daily.interfaces(InterfaceTypes.HIDE_ALL);
			
			Log.Trace("Dialog show!");
			_view.dialog.interfaces(InterfaceTypes.Show, "level", _curLevel, "start", showGuide);
			
			_mapInfo = new MapInfo(_view, _loadBaseName, _curLevel);
			_weatherEffect = new WeatherEffect();
			
			playSound();
			initUI();
			initEvent();
			
			//初始化天气系统，前三关没有天气系统
			initWeatherPara();
			_view.weather.initWeather(_curLevel);
			
			
			//扫荡模式
			//if(_autoLevel) startCount();
			
			/*if(_TDmode){
				startCount();
				throwDiceResult(_mapInfo.roadItems.length);
			}*/
			
			//1级向导
			if(_view.first_guide.isGuide)
			{
				if(_curLevel == "1_1")
					_view.first_guide.setFunc();
				else if(_curLevel == "1_2")
					_view.first_guide.setFunc(true);
			}
		}
		
		private function initWeatherPara() : void
		{
			_allowSun = false;
			_allowBlack = false;
			_allowRain = false;
			_allowThunder = false;
			_allowWind = false;
		}
		
		private function showGuide() : void
		{
			Log.Trace("Map Guide!");
			if(_curLevel == "1_1" || _curLevel == "1_2" || _curLevel == "1_3"){}
			else
				_view.guide.interfaces(InterfaceTypes.CHECK_GUIDE, "level", _curLevel, "enter", function () : void {_view.guide.showWeatherGuide(_curLevel);});
			
			LayerManager.instance.gpu_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
			
		}
		
		/**
		 * 播放背景音乐 
		 * 
		 */		
		public function playSound() : void
		{
			var soundResName:String = "scene_" + _sceneId + GameConfig.MAP_SOUND_RES[_sceneId] + ".mp3";
			
			if (_curLV == 4) soundResName = "hideV122.mp3";
			
			var sound:Sound = getAssetsData(_curSoundRes, soundResName) as Sound;
			_view.sound.playSound(sound, _curSoundRes, true);
		}
		

	
		/**
		 * 键盘侦听，空格投掷骰子
		 * 
		 * @param e
		 * 
		 */		
		private function onKeyDowns(e:KeyboardEvent) : void
		{
			
			if(!_view.toolbar.panel.touchable || _view.layer.checkTipMask() || _view.layer.checkTopMask() || _view.first_guide.isGuide || _view.get_role_guide.isGuide){
				return;	
			}
				
			
			switch(e.keyCode)  
			{
				case Keyboard.SPACE:
					Log.Trace("roll the dice!");
					_view.dice.interfaces(InterfaceTypes.RANDOM_DICE);
					break;
				case Keyboard.ESCAPE:
					Log.Trace("ready to quit?");
					_view.tip.interfaces(
						InterfaceTypes.Show,
						"是否离开关卡？",
						_view.toolbar.onComeBack, closeThis);
					_view.toolbar.panel.touchable = false;
					break;
			}
		}
		
		private function closeThis() : void
		{
			_view.toolbar.panel.touchable = true;
		}
		
		private function initUI() : void
		{
			initLayer();
			initPlayer();
			initTexture();
			initRender();
		}
		
		/**
		 * 层级 
		 * 
		 */		
		private function initLayer() : void
		{
			if (!_mapLayers) _mapLayers = new MapLayer(panel);			
			_mapLayers.initLayer();
		}
		
		/**
		 * 角色 
		 * 
		 */		
		private function initPlayer() : void
		{
			Log.Trace("Player init!");
			playerRole = new PlayerEntity(_mapInfo.playerPosition.ix, _mapInfo.playerPosition.iy);
			playerRole.reset();
			playerRole.x = _mapInfo.playerPosition.ix;
			playerRole.y = _mapInfo.playerPosition.iy;
			_mapLayers.playerLayer.addChild(playerRole);
			add(playerRole);
			_mapCamera.initCamera(this, playerRole, _mapInfo.mapWidth, _mapInfo.mapHeight);
			playerRole.addEventListener(PlayerStatus.MOVE_COMPLETE, onPlayerComplete);
			playerRole.addEventListener(PlayerStatus.STEP_COMPLETE, onPlayerStep);
		}
		
		/******************************move step*******************************/
		private function onPlayerStep(e:Event) : void
		{
			var node:Node = e.data["node"];
			var callback:Function = e.data["callback"];
			
			trigStepHandle(node, callback);
		}
		
		private function trigStepHandle(node:Node, callback:Function = null) : void
		{
			for each(var item:Prop in  _mapInfo.roadItems)
			{
				if (item.ix == node.curIndex.x && item.iy == node.curIndex.y)
				{
					// 当前目的点的格子类型
					onTrigStepEvent(item, callback);
					break;	
				}
			}
		}
		
		/**
		 * 触发事件 
		 * 
		 */		
		protected function onTrigStepEvent(prop:Prop, callback:Function = null, onSkip:Boolean = false) : void
		{
			var id:int = prop.id;
			var type:String = prop.file;
			if(playerRole.useFreeDice && !onSkip)
			{
				if (callback != null) callback();
				return;
			}
			switch (id)
			{
				// Boss
				case 0:
					if((this.allowThunder || this.allowWind) && callback != null)
						delayStartComplete(prop, onWeatherBoss);
					else 
						onWeatherBoss();
					break;
				// 精英
				case 8:
					if((this.allowThunder || this.allowWind) && callback != null)
						delayStartComplete(prop, onWeatherECS);
					else
						onWeatherECS();
					break;
				// 传送
				case 15:
					if((this.allowThunder || this.allowWind) && callback != null)
						delayStartComplete(prop, onWeatherTransmit);
					else
						onWeatherTransmit();
					break;
				// 切换
				case 101:
					if((this.allowThunder || this.allowWind) && callback != null)
						delayStartComplete(prop, onWeatherSwitch);
					else
						onWeatherSwitch();
					break;
				default:
					if (callback != null) callback();
					break;
			}
			
			function onWeatherBoss() : void
			{
				_view.fight.interfaces(InterfaceTypes.Show, _curLevel, FightConfig.BOSS_MONSTER, _kind, onBossComplete);
			}
			
			function onWeatherECS() : void
			{
				_view.fight.interfaces(InterfaceTypes.Show, _curLevel, FightConfig.ECS_MONSTER, _kind, onECSComplete);
			}
			
			function onWeatherTransmit() : void
			{
				onTransmit(prop, onTransmitComplete);
			}
			
			function onWeatherSwitch() : void
			{
				switchRoad(prop, onTransmitComplete);
			}
			
			// 精英战斗结束后
			function onECSComplete() : void
			{
				if (callback != null) callback(true);
				_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
			}
			
			// boss战斗结束后
			function onBossComplete(result:int) : void
			{
				// 当战斗胜利，判断是否开启下一关卡
				if (result == V.WIN)
				{
					if(_kind == 2)
						player.dailyThingInfo.setThingComplete(2);
					_view.controller.LVSelect.passLevel(_sceneId, _curLV, _kind);
					_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
				}
				
				_view.world.interfaces();
				close();
			}
			// 传送结束后
			function onTransmitComplete() : void
			{
				if (callback != null) callback(true);
				_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
			}
		}
		
		/**
		 * 转换地图XML配置
		 * @param prop
		 * @param callback
		 * 
		 */		
		private function switchRoad(prop:Prop, callback:Function):void
		{
			onTransmit(prop, callback);
			_mapInfo.resetMapConfig(prop.args["xml"]);
			initRoad();
			_mapLayers.propLayer.flatten();
		}
		
		/**
		 * 传送点 
		 * @param e
		 * 
		 */		
		private function onTransmit(prop:Prop, callback:Function) : void
		{
			var ix:int = prop.args["ix"];
			var iy:int = prop.args["iy"];
			
			var point:Point = MapUtils.getRoadPoint(ix, iy);
			playerRole.x = point.x;
			playerRole.y = point.y;
			
			callback();
			
			playerRole.reset();
			_mapInfo.playerPosition.gx = ix;
			_mapInfo.playerPosition.gy = iy;
			
			_view.weather.setSun();
		}
		
		
		
		/****************************move complete*****************************/
		private function onPlayerComplete(e:Event) : void
		{
			var node:Node = e.data[0] as Node;
			var isBlock:Boolean = e.data[1];
			
			// 如果中断（精英或者boss） 则不处理
			if (isBlock) return;
			
			trigCompelteHandle(node);
		}
		
		private var _curItem:Prop;
		private var _curCallback:Function;
		private function trigCompelteHandle(node:Node) : void
		{
			for each(var item:Prop in  _mapInfo.roadItems)
			{
				if (item.ix == node.curIndex.x && item.iy == node.curIndex.y)
				{
					// 当前目的点的格子类型
					_curItem = item;
					if(this.allowThunder || this.allowWind)
						delayStartComplete(item, onTriComplete);
					else 
						onTriComplete();
					break;
				}
			}
			
			function onTriComplete() : void
			{
				onTrigCompleteEvent(item);
			}
		}
		
		private var _hitRoad:Vector.<Prop>;
		public function get hitRoad() : Vector.<Prop>
		{
			return _hitRoad;
		}
		private var _curState:String;
		private function delayStartComplete(prop:Prop, callback:Function) : void
		{
			_curCallback = callback;
			_view.toolbar.interfaces(InterfaceTypes.LOCK);
			_curState = playerRole.State;
			getHitRoad(prop);
			if(this.allowThunder) 
			{
				playerRole.State = PlayerStatus.ZMHP;
				_weatherEffect.renderLight();
				Starling.juggler.delayCall(WeatherChangeData.onAddThunderEffect, .2, _curState, _curCallback);
			}
			else if(this.allowWind)
			{
				WeatherChangeData.onAddWindEffect(_curState, _curCallback);
			}
		}
		
		/**
		 * 被风吹起落地后触发事件
		 * @param prop
		 * 
		 */
		public function alreadyFly(prop:Prop) : void
		{
			onTrigCompleteEvent(prop);
		}
		
		/**
		 * 获得打雷或者吹风的路点
		 * @param prop
		 * 
		 */		
		private function getHitRoad(prop:Prop) : void
		{
			_hitRoad = new Vector.<Prop>();
			for(var i:int = 0; i < _mapInfo.roadItems.length; i++)
			{
				if(Math.abs(_mapInfo.roadItems[i].ix - prop.ix) < 6 && Math.abs(_mapInfo.roadItems[i].iy - prop.iy) < 4)
				{
					_hitRoad.push(_mapInfo.roadItems[i]);
				}
			}
		}
		
		/**
		 * 跳跃点
		 * @param prop
		 * 
		 */		
		private function onJump(prop:Prop) : void
		{
			var ix:int = prop.args["ix"];
			var iy:int = prop.args["iy"];
			
			var point:Point = MapUtils.getRoadPoint(ix, iy);

			playerRole.jumpTransmit(point.x,
				point.y,
				function () : void
				{
					playerRole.reset();
					_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
				}
			);
			_mapInfo.playerPosition.gx = ix;
			_mapInfo.playerPosition.gy = iy;
			
			_view.weather.setSun();
		}
		
		/**
		 * 触发事件 
		 * 
		 */		
		protected function onTrigCompleteEvent(prop:Prop) : void
		{
			Starling.juggler.delayCall(delayTrigCompleteEvent, .2, prop);
		}
		
		private function delayTrigCompleteEvent(...args) : void
		{
			var prop:Prop = args[0] as Prop;
			var type:String = prop.file;
			var id:int = prop.id;
			
			//最后一个点是精英、BOSS或者跳转点，一定触发事件，不判断是否是如意骰子走到的
			onTrigStepEvent(prop, null, true);
			
			//测试
			//type = "Vortex";
			/*if(prop.type == "跳跃")
			{
				onJump(prop);
				return;
			}*/
			switch (id)
			{
				// 普通战斗
				case 3:
					_view.fight.interfaces(InterfaceTypes.Show, _curLevel, FightConfig.COMMON_MONSTER, _kind);
					break;
				// 装备
				case 5:
					_view.openItemBox.interfaces(InterfaceTypes.Show, _curLevel, V.EQUIP_ITEMBOX, _kind);
					break;
				// 路点
				case 6:
					_view.weather.setSun();
					_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
					break;
				// 金币
				case 12:
					_view.openItemBox.interfaces(InterfaceTypes.Show, _curLevel, V.MONEY_ITEMBOX, _kind);
					break;
				// 隐藏
				case 9:
					_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
					if (_kind == 1) return;
					_view.weather.setSun();
					HideLVMap.instance.checkEntryConditions(_sceneId, _curLV, _kind);
					break;
				// 求签
				case 11:
					_view.weather.resetWeather();
					break;
				// 奇遇
				case 13:
					_view.adventures.interfaces(InterfaceTypes.Show, AdventuresConfig.RANDOM, _curLevel, _kind);
					break;
				// 道具
				case 14:
					_view.openItemBox.interfaces(InterfaceTypes.Show, _curLevel, V.PROP_ITEMBOX, _kind);
					break;
				// 跳跃
				case 100:
					onJump(prop);
					break;
				default:
					defaultFun(id);
					break;
			}
		}
		
		private function defaultFun(id:int):void
		{
			if(id != 0 && id != 8 && id != 15 && id != 101)
			{
				_view.weather.setSun();
				_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
			}
		}
		
		private function initTexture() : void
		{
			_defaultBtnTexture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, "ComeBack_1");
			_orientedTexture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, "RoadSign");
		}
		
		/**
		 * 渲染 
		 * 
		 */		
		private function initRender() : void
		{
			Log.Trace("Road init!");
			renderBG();
			
			// 道具
			initRoad();
			
			if (!_oriented) _oriented = new OrientedComponent(this, _orientedTexture);
		}
		
		private function initRoad() : void
		{
			// 道具
			var texture:Texture;
			var image:Image;
			for each(var item:Prop in  _mapInfo.roadItems)
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, item.file);
				item.imageTexture = texture;
				
				if (item.id != 6 && !(item.id == 9 && (_kind == 1)))
				{
					_mapLayers.propLayer.addChild(item);
				}
			}
		}
		
		private var _bg1:Image;
		private var _bg2:Image;
		private var _bg3:Image;
		private var _bg4:Image;
		private var _bp:Bitmap;
		private var _bpAtf:ByteArray;
		private var _curSwfName:String;
		protected function renderBG() : void
		{
			var bgData:Object = MapConfig.BG[_curLevel];
			
			clearTextureMemory();
			
			_curSwfName = _curLevel.replace("_", "p");
			_curSwfName += GameConfig.MAP_RES[_curLevel];
			
			if(_curLevel == "3_4" || _curLevel == "4_4")
				atfMap(bgData);
			else
				normalMap(bgData);
		}
		
		private function normalMap(bgData:Object) : void
		{
			switch (bgData["total"])
			{
				case 1:
					_bg1 = createNormalMapImage("BackGroud");
					break;
				case 2:
					_bg1 = createNormalMapImage("BackGroud1");
					_bg2 = createNormalMapImage("BackGroud2");
					
					if (bgData[2] == "right") _bg2.x = _bg1.width - 1;
					else _bg2.y = _bg1.height - 1;
					break;
				case 4:
					_bg1 = createNormalMapImage("BackGroud1");
					_bg2 = createNormalMapImage("BackGroud2");
					_bg3 = createNormalMapImage("BackGroud3");
					_bg4 = createNormalMapImage("BackGroud4");
					
					_bg2.x = _bg1.width - 1;
					_bg3.y = _bg1.height - 1;
					_bg4.x = _bg2.x;
					_bg4.y = _bg3.y;
					
					break;
			}
		}
		
		private function createNormalMapImage(backGround:String) : Image
		{
			_bp = getAssetsObject(_loadBaseName, _curSwfName + ".swf", backGround) as Bitmap;
			var texture:Texture = Texture.fromBitmap(_bp as Bitmap);
			var bgImg:Image = new Image(texture);
			bgImg.blendMode = BlendMode.NONE;
			_mapLayers.propLayer.addChild(bgImg);
			_bp.bitmapData.dispose();
			
			bgImg.width = bgImg.width / .75;
			bgImg.height = bgImg.height / .75;
			
			return bgImg;
		}
		
		private function atfMap(bgData:Object) : void
		{
			switch (bgData["total"])
			{
				case 1:
					_bg1 = createAtfMapImage("BackGroud");
					
					break;
				case 2:
					_bg1 = createAtfMapImage("BackGroud1");
					_bg2 = createAtfMapImage("BackGroud2");
					
					if (bgData[2] == "right") _bg2.x = bgData["width"] - 1;
					else _bg2.y = bgData["height"];
					break;
				case 4:
					_bg1 = createAtfMapImage("BackGroud1");
					_bg2 = createAtfMapImage("BackGroud2");
					_bg3 = createAtfMapImage("BackGroud3");
					_bg4 = createAtfMapImage("BackGroud4");
					
					_bg2.x = bgData["width"] - 1;
					_bg3.y = bgData["height"] - 1;
					_bg4.x = _bg2.x;
					_bg4.y = _bg3.y;	
					
					break;
			}
		}
		
		private function createAtfMapImage(backGround:String) : Image
		{
			_bpAtf = getAssetsObject(_loadBaseName, _curSwfName + ".swf", backGround) as ByteArray;
			var texture:Texture = Texture.fromAtfData(_bpAtf as ByteArray);
			var bgImg:Image = new Image(texture);
			bgImg.blendMode = BlendMode.NONE;
			_mapLayers.propLayer.addChild(bgImg);
			_bpAtf.clear();
			
			bgImg.width = bgImg.width / .75;
			bgImg.height = bgImg.height / .75;
			
			return bgImg;
		}
		
		private var _propTip:PropTip;
		private var _weatherEffectShow:MovieClip;
		private var _weatherData:Object;
		private function setEffect() : void
		{
			if(!_weatherEffectShow) _weatherEffectShow = _view.toolbar.interfaces(InterfaceTypes.GET_DATA);
			if(!_weatherData) _weatherData = _view.weather.weatherData;
			if(!_propTip) _propTip = _view.ui.interfaces(UIConfig.PROP_TIP);
			//trace(getWeatherStatus());
			//_propTip.removeProp(_weatherData[getWeatherStatus()].wea_name);
			_propTip.add({o:_weatherEffectShow,m:{name:_weatherData[getWeatherStatus()].wea_name, message:_weatherData[getWeatherStatus()].wea_message}});
			_weatherEffectShow.currentFrame = getWeatherStatus();
			
			if(_curLevel == "1_1" || _curLevel == "1_2" || _curLevel == "1_3")
			{
				if(_weatherEffectShow.parent) _weatherEffectShow.parent.removeChild(_weatherEffectShow);
			}
			else
			{
				if(!_weatherEffectShow.parent) _view.toolbar.panel.addChild(_weatherEffectShow);
			}
		}
		
		/**
		 * 每帧调用 
		 * 
		 */
		override public function update():void
		{
			super.update();
			_mapCamera.update();
		}
		
		override public function close() : void
		{
			isClose = true;
			if (!playerRole) return;
			
			_mapCamera.clear();
			clearPlayer();
			clearTextureMemory();
			_view.toolbar.interfaces(InterfaceTypes.CHECK_EXP);
			LayerManager.instance.gpu_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
			if(_mapLayers) _mapLayers.clear();
			
			if (_mapInfo)
			{
				_mapInfo.clear();
				_mapInfo = null;
			}

			super.close();
		}
		
		private function clearPlayer() : void
		{
			if (!playerRole) return;
			
			remove(playerRole);
			playerRole.clear();
			playerRole.removeEventListeners();
			playerRole = null;
		}
		
		/**
		 * 清除地图纹理 
		 * 
		 */		
		private function clearTextureMemory() : void
		{
			for(var i:uint = 1; i < 5; i++)
			{
				if(this["_bg" + i] as Image)
				{
					(this["_bg" + i] as Image).texture.dispose();
					(this["_bg" + i] as Image).dispose();
				}
			}
			if (_bp) 
			{
				_bp.bitmapData.dispose();
				_bp = null;
			}
			if(_bpAtf)
				_bpAtf = null;
			
			if (_defaultBtnTexture) _defaultBtnTexture.dispose();
			if (_orientedTexture) _orientedTexture.dispose();
			
			_weatherEffect.removeAll();
		}
		
		override public function hide():void
		{
			super.hide();
		}
		
		private var autoFightData:AutoFightData;
		/**
		 * 扫荡模式初始化
		 * 
		 */		
		private function startCount() : void
		{
			autoFightData = new AutoFightData();
			autoFightData.startCount();
		}
		
		/**
		 * 随机仍骰子
		 * 
		 */		
		public function skipLevel() : void
		{
			_view.dice.interfaces(InterfaceTypes.AUTO_DICE);
		}
	}
}
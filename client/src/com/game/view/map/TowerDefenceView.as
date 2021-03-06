package com.game.view.map
{
	import com.engine.core.Log;
	import com.engine.event.EventTypes;
	import com.engine.ui.controls.DragOut;
	import com.game.data.db.protocal.Adventures;
	import com.game.data.fight.FightConfig;
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
	import com.game.view.map.player.PlayerStatus;
	import com.game.view.map.player.TDPlayerEntity;
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
	
	public class TowerDefenceView extends BaseView implements IView
	{
		/**
		 * 地图摄像头
		 */
		private var _mapCamera:TDMapCamera;
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
		private var _mapInfo:TDmapInfo;
		public function get mapInfo() : TDmapInfo
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
		private var _oriented:TDOrientedComponent;
		public function get oriented() : TDOrientedComponent
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
		private var _playerRole:TDPlayerEntity;
		public function get playerRole() : TDPlayerEntity
		{
			return _playerRole;
		}
		public function set playerRole(value:TDPlayerEntity) : void
		{
			_playerRole = value
		}
		
	
		
		public var isClose:Boolean;
		
		public function TowerDefenceView()
		{
			_layer = LayerTypes.CONTENT;
			_moduleName = V.MAP;
			_mapCamera = new TDMapCamera();
			isClose = true;
			super();
		}
		
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					preShow(args);
					break;
			}
		}
		
		protected function preShow(args:Array) : void
		{

			_loadResources = [];
			_sceneId = args[0];
			_curLV = args[1];
			
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
			var startNode:Node = new Node();
			startNode.preIndex = playerRole.preNode;
			startNode.curIndex = new Point(_mapInfo.playerPosition.gx, _mapInfo.playerPosition.gy);
			var PathInfos:SingleLineInfo;

			PathInfos = TDMapUtils.getRoadInfo(startNode,_autoRoad.length , _autoRoad);
			playerRole.setPath(PathInfos, _autoRoad);

			
		}
		
		override protected function init() : void
		{
			isClose = false;
			_view.load.hide();
			
			super.init();
			_view.toolbar.hide();
			_view.world.interfaces(InterfaceTypes.HIDE);
			_view.daily.interfaces(InterfaceTypes.HIDE_ALL);
		
			_mapInfo = new TDmapInfo(_view, _loadBaseName, _curLevel);

			playSound();
			initUI();
			initEvent();
			
			

			startCount();
			throwDiceResult(_mapInfo.roadItems.length);
			
		}
		
		
		/**
		 * 播放背景音乐 
		 * 
		 */		
		public function playSound() : void
		{
			var soundResName:String = "scene_" + _sceneId + "V122.mp3";
			
			if (_curLV == 4) soundResName = "hideV122.mp3";
			
			var sound:Sound = getAssetsData(_curSoundRes, soundResName) as Sound;
			_view.sound.playSound(sound, _curSoundRes, true);
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
			playerRole = new TDPlayerEntity(_mapInfo.playerPosition.ix, _mapInfo.playerPosition.iy);
			playerRole.reset();
			playerRole.x = _mapInfo.playerPosition.ix;
			playerRole.y = _mapInfo.playerPosition.iy;
			_mapLayers.playerLayer.addChild(playerRole);
			add(playerRole);
			_playerRole.alpha=1;
			_mapCamera.initCamera(this, playerRole, _mapInfo.mapWidth, _mapInfo.mapHeight);
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
			for each(var item:TDprop in  _mapInfo.roadItems)
			{
				if (item.ix == node.curIndex.x && item.iy == node.curIndex.y)
				{
					// 当前目的点的格子类型
					onTDStepEvent(item, callback);
					break;	
				}
			}
		}
		
		private function onTDStepEvent(prop:TDprop, callback:Function = null):void{
			var type:String = prop.file;
			switch (type)
			{
				case "Boss":
					_view.world.interfaces();
					close();
					break;
				// 传送
				case "Transmit":
					onTransmit(prop, onTransmitComplete);
					
					break;
				default:
					if (callback != null) callback();
			}
			
			function onTransmitComplete() : void
			{
				if (callback != null) callback(true);
				_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
			}
		}

		/**
		 * 传送点 
		 * @param e
		 * 
		 */		
		private function onTransmit(prop:TDprop, callback:Function) : void
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
		
		
	
		
		/**
		 * 跳跃点
		 * @param prop
		 * 
		 */		
		private function onJump(prop:TDprop) : void
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
			renderBG();
			
			// 道具
			var texture:Texture;
			var image:Image;
			for each(var item:TDprop in  _mapInfo.roadItems)
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, item.file);
				item.imageTexture = texture;
				
				if (item.type == "Boss" && !(item.type == "隐藏" && (_kind == 1)))
				{	
					_mapLayers.propLayer.addChild(item);
				}
				
/*				if (item.type != "路点" && !(item.type == "隐藏" && (_kind == 1)))
				{	
					_mapLayers.propLayer.addChild(item);
				}*/
			}
			
			if (!_oriented) _oriented = new TDOrientedComponent(this, _orientedTexture);
	

			_rockTowerTexture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, "Fight");
			_rockTowerBtn= new Image(_rockTowerTexture);
			_rockTowerBtn.x=500;
			_rockTowerBtn.y=510;
			_rockTowerBtn.name="rockTower";
			
			_gunTowerTexture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, "Transmit");
			_gunTowerBtn= new Image(_gunTowerTexture);
			_gunTowerBtn.x=570;
			_gunTowerBtn.y=500;
			_gunTowerBtn.name="gunTower";
			
			panel.addChild(_rockTowerBtn);
			panel.addChild(_gunTowerBtn);
			
			_dragOut = new DragOut([_rockTowerBtn,_gunTowerBtn]);
			_dragOut.addEventListener(DragOut.PUT_TOWER, onPutTower);

		}
		
		private function onPutTower(e:Event) : void
		{
			var ix:int=Math.ceil((e.data.x-_mapLayers.mapLayer.x - _mapInfo.titleWidth/2 - _mapInfo.mpx)/mapInfo.titleWidth);
			var iy:int=Math.ceil((e.data.y-_mapLayers.mapLayer.y - _mapInfo.titleHeight/2 - _mapInfo.mpy)/mapInfo.titleHeight);
			
			for each(var item:TDprop in  _mapInfo.roadItems)
			{
				if(item.ix==ix && item.iy==iy){
					return;
				}
			}
			
			for each(var tower:* in _towerArr){
				if(tower.ix==ix && tower.iy==iy){
					return;
				}
			}

			switch(e.data.name){
				case "rockTower":
					var rocktower:TDrockTower= new TDrockTower(this);
					rocktower.ix=ix;
					rocktower.iy=iy;
					_rockBulletTexture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, "stone");
					rocktower.setTexture(_rockTowerTexture,_rockBulletTexture);
					_mapLayers.propLayer.addChild(rocktower);
					_mapLayers.propLayer.flatten();
					_towerArr.push(rocktower);
					break;
				case "gunTower":
					var guntower:TDgunTower= new TDgunTower(this);
					guntower.ix=ix;
					guntower.iy=iy;
					_gunBulletTexture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, "bullet");
					guntower.setTexture(_gunTowerTexture,_gunBulletTexture);
					_mapLayers.propLayer.addChild(guntower);
					_mapLayers.propLayer.flatten();
					_towerArr.push(guntower);
					break;
			}

		}
		

		
		private function getIndexX(X:int):int{
			var ix:int = Math.ceil((X  - mapInfo.mpx)/mapInfo.titleWidth);
			return ix
		}
		
		private function getIndexY(Y:int):int{
			var iy:int = Math.ceil((Y  - mapInfo.mpy)/mapInfo.titleHeight);
			return iy
		}
		
		private var _rockTowerTexture:Texture;
		private var _gunTowerTexture:Texture;
		private var _rockBulletTexture:Texture;
		private var _gunBulletTexture:Texture;
		private var _rockTowerBtn:Image;
		private var _gunTowerBtn:Image;
		private var _dragOut:DragOut;
		
		
		private var _towerArr:Array=[];
		private var texture1:Texture;
		private var bg1:Image;
		private var texture2:Texture;
		private var bg2:Image;
		private var texture3:Texture;
		private var bg3:Image;
		private var texture4:Texture;
		private var bg4:Image;
		private var bp:Bitmap;
		private var bpAtf:ByteArray;
		protected function renderBG() : void
		{
			var bgData:Object = MapConfig.BG[_curLevel];
			
			clearTextureMemory();
			
			var curSwfName:String = _curLevel.replace("_", "p");
			curSwfName += GameConfig.MAP_RES[_curLevel];
			
			if(_curLevel == "3_4" || _curLevel == "4_4")
				atfMap(bgData, curSwfName);
			else
				normalMap(bgData, curSwfName);
		}
		
		private function normalMap(bgData:Object, curSwfName:String) : void
		{
			switch (bgData["total"])
			{
				case 1:
					bp = getAssetsObject(_loadBaseName, curSwfName + ".swf", "BackGroud") as Bitmap;
					texture1 = Texture.fromBitmap(bp as Bitmap);
					bg1 = new Image(texture1);
					bg1.blendMode = BlendMode.NONE;
					_mapLayers.propLayer.addChild(bg1);
					bp.bitmapData.dispose();
					
					bg1.width = bg1.width / .75;
					bg1.height = bg1.height / .75;
					
					break;
				case 2:
					bp = getAssetsObject(_loadBaseName, curSwfName + ".swf", "BackGroud1") as Bitmap;
					texture1 = Texture.fromBitmap(bp as Bitmap);
					bg1 = new Image(texture1);
					bg1.blendMode = BlendMode.NONE;
					
					_mapLayers.propLayer.addChild(bg1);
					bp.bitmapData.dispose();
					
					bp = getAssetsObject(_loadBaseName, curSwfName + ".swf", "BackGroud2") as Bitmap;
					texture2 = Texture.fromBitmap(bp as Bitmap);
					bg2 = new Image(texture2);
					bg2.blendMode = BlendMode.NONE;
					_mapLayers.propLayer.addChild(bg2);
					bp.bitmapData.dispose()
					
					bg1.width = bg1.width / .75;
					bg1.height = bg1.height / .75;
					bg2.width = bg2.width / .75;
					bg2.height = bg2.height / .75;
					
					if (bgData[2] == "right") bg2.x = bg1.width - 1;
					else bg2.y = bg1.height - 1;
					break;
				case 4:
					bp = getAssetsObject(_loadBaseName, curSwfName + ".swf", "BackGroud1") as Bitmap;
					texture1 = Texture.fromBitmap(bp as Bitmap);
					bg1 = new Image(texture1);
					bg1.blendMode = BlendMode.NONE;
					_mapLayers.propLayer.addChild(bg1);
					bp.bitmapData.dispose();
					bp = getAssetsObject(_loadBaseName, curSwfName + ".swf", "BackGroud2") as Bitmap;
					texture2 = Texture.fromBitmap(bp as Bitmap);
					bg2 = new Image(texture2);
					bg2.blendMode = BlendMode.NONE;
					_mapLayers.propLayer.addChild(bg2);
					bp.bitmapData.dispose();
					bp = getAssetsObject(_loadBaseName, curSwfName + ".swf", "BackGroud3") as Bitmap;
					texture3 = Texture.fromBitmap(bp as Bitmap);
					bg3 = new Image(texture3);
					bg3.blendMode = BlendMode.NONE;
					_mapLayers.propLayer.addChild(bg3);
					bp.bitmapData.dispose();
					bp = getAssetsObject(_loadBaseName, curSwfName + ".swf", "BackGroud4") as Bitmap;
					texture4 = Texture.fromBitmap(bp as Bitmap);
					bg4 = new Image(texture4);
					bg4.blendMode = BlendMode.NONE;
					_mapLayers.propLayer.addChild(bg4);
					bp.bitmapData.dispose();
					bg1.width = bg1.width / .75;
					bg1.height = bg1.height / .75;
					bg2.width = bg2.width / .75;
					bg2.height = bg2.height / .75;
					bg3.width = bg3.width / .75;
					bg3.height = bg3.height / .75;
					bg4.width = bg4.width / .75;
					bg4.height = bg4.height / .75;
					
					bg2.x = bg1.width - 1;
					bg3.y = bg1.height - 1;
					bg4.x = bg2.x;
					bg4.y = bg3.y;
					
					break;
			}
		}
		
		private function atfMap(bgData:Object, curSwfName:String) : void
		{
			switch (bgData["total"])
			{
				case 1:
					bpAtf = getAssetsObject(_loadBaseName, curSwfName + ".swf", "BackGroud") as ByteArray;
					texture1 = Texture.fromAtfData(bpAtf as ByteArray);
					bg1 = new Image(texture1);
					bg1.blendMode = BlendMode.NONE;
					_mapLayers.propLayer.addChild(bg1);
					bpAtf.clear();
					
					bg1.width = bg1.width / .75;
					bg1.height = bg1.height / .75;
					
					break;
				case 2:
					bpAtf = getAssetsObject(_loadBaseName, curSwfName + ".swf", "BackGroud1") as ByteArray;
					texture1 = Texture.fromAtfData(bpAtf as ByteArray);
					bg1 = new Image(texture1);
					bg1.blendMode = BlendMode.NONE;
					
					_mapLayers.propLayer.addChild(bg1);
					bpAtf.clear();
					
					bpAtf = getAssetsObject(_loadBaseName, curSwfName + ".swf", "BackGroud2") as ByteArray;
					texture2 = Texture.fromAtfData(bpAtf as ByteArray);
					bg2 = new Image(texture2);
					bg2.blendMode = BlendMode.NONE;
					_mapLayers.propLayer.addChild(bg2);
					bpAtf.clear();
					
					bg1.width = bg1.width / .75;
					bg1.height = bg1.height / .75;
					bg2.width = bg2.width / .75;
					bg2.height = bg2.height / .75;
					
					if (bgData[2] == "right") bg2.x = bgData["width"] - 1;
					else bg2.y = bgData["height"];
					break;
				case 4:
					bpAtf = getAssetsObject(_loadBaseName, curSwfName + ".swf", "BackGroud1") as ByteArray;
					texture1 = Texture.fromAtfData(bpAtf as ByteArray);
					bg1 = new Image(texture1);
					bg1.blendMode = BlendMode.NONE;
					_mapLayers.propLayer.addChild(bg1);
					bpAtf.clear();
					
					bpAtf = getAssetsObject(_loadBaseName, curSwfName + ".swf", "BackGroud2") as ByteArray;
					texture2 = Texture.fromAtfData(bpAtf as ByteArray);
					bg2 = new Image(texture2);
					bg2.blendMode = BlendMode.NONE;
					_mapLayers.propLayer.addChild(bg2);
					bpAtf.clear();
					
					bpAtf = getAssetsObject(_loadBaseName, curSwfName + ".swf", "BackGroud3") as ByteArray;
					texture3 = Texture.fromAtfData(bpAtf as ByteArray);
					bg3 = new Image(texture3);
					bg3.blendMode = BlendMode.NONE;
					_mapLayers.propLayer.addChild(bg3);
					bpAtf.clear();
					
					bpAtf = getAssetsObject(_loadBaseName, curSwfName + ".swf", "BackGroud4") as ByteArray;;
					texture4 = Texture.fromAtfData(bpAtf as ByteArray);
					bg4 = new Image(texture4);
					bg4.blendMode = BlendMode.NONE;
					_mapLayers.propLayer.addChild(bg4);
					bpAtf.clear();
					
					bg1.width = bg1.width / .75;
					bg1.height = bg1.height / .75;
					bg2.width = bg2.width / .75;
					bg2.height = bg2.height / .75;
					bg3.width = bg3.width / .75;
					bg3.height = bg3.height / .75;
					bg4.width = bg4.width / .75;
					bg4.height = bg4.height / .75;
					
					bg2.x = bgData["width"] - 1;
					bg3.y = bgData["height"] - 1;
					bg4.x = bg2.x;
					bg4.y = bg3.y;	
					
					break;
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
			for each(var tower:* in _towerArr){
				tower.TowerAttack(playerRole)
			}
		}
		
		override public function close() : void
		{
			isClose = true;
			if (!playerRole) return;
			disposeTowerArr();
			_mapCamera.clear();
			clearPlayer();
			clearTextureMemory();
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
		 * 清空轨迹图片数组
		 */	
		private function disposeTowerArr():void{
			while(_towerArr.length>0){
				var tempTower:*=_towerArr[0];
				_towerArr.splice(0,1);
				panel.removeChild(tempTower);
				tempTower.destroy();
				tempTower=null;
				
			}
		}
		
		/**
		 * 清除地图纹理 
		 * 
		 */		
		private function clearTextureMemory() : void
		{
			if (bg1) bg1.dispose();
			if (texture1) texture1.dispose();
			
			if (bg2) bg2.dispose();
			if (texture2) texture2.dispose();
			
			if (bg3) bg3.dispose();
			if (texture3) texture3.dispose();
			
			if (bg4) bg4.dispose();
			if (texture4) texture4.dispose();
			
			if (bp) 
			{
				bp.bitmapData.dispose();
				bp = null;
			}
			if(bpAtf)
				bpAtf = null;
			
			if (_defaultBtnTexture) _defaultBtnTexture.dispose();
			if (_orientedTexture) _orientedTexture.dispose();

		}
		
		override public function hide():void
		{
			super.hide();
		}
		
		
		private var _pointList:Vector.<int>;
		private var _pointLength:Vector.<int>;
		private var _pointCount:int;
		private var _pointChange:int;
		/**
		 * 扫荡模式初始化
		 * 
		 */		
		private function startCount() : void
		{
			_pointList = new Vector.<int>(20);
			_pointLength = new Vector.<int>(20);
			_roadCorner = new Vector.<TDprop>();
			_pointChange = 0;
			countRoad();
			//_view.auto_fight.interfaces(InterfaceTypes.Show, countRoad);
		}
		
		private var _autoRoad:Vector.<TDprop>;
		private var _oneRoadX:Vector.<TDprop>;
		private var _oneRoadInit:Vector.<TDprop>;
		private var _roadCorner:Vector.<TDprop>;
		private var _nowProp:TDprop;
		private var _lastProp:TDprop;
		private var _cornerProp:TDprop;
		/**
		 * 开始计算扫荡模式的路径
		 * 
		 */		
		private function countRoad() : void
		{
			_autoRoad = new Vector.<TDprop>();
			_oneRoadX = new Vector.<TDprop>();
			_oneRoadInit = new Vector.<TDprop>();
			_pointCount = 0;
			for(var j:int = 0; j < _mapInfo.roadItems.length; j++)
			{
				_oneRoadInit.push(_mapInfo.roadItems[j]);
			}
			for(var i:int = 0; i < _oneRoadInit.length; i++)
			{
				//boss点坐标
				if(_oneRoadInit[i].type == "Boss")
				{
					_autoRoad.push(_oneRoadInit[i]);
					_lastProp = _oneRoadInit[i];
				}
					//起点坐标
				else if(_oneRoadInit[i].type == "路点" && _oneRoadInit[i].ix == _mapInfo.playerPosition.gx && _oneRoadInit[i].iy == _mapInfo.playerPosition.gy)
				{
					_autoRoad.push(_oneRoadInit[i]);
					_nowProp = _oneRoadInit[i];
					_oneRoadInit.splice(_oneRoadInit.indexOf(_oneRoadInit[i]), 1);
				}
			}
			//开始计算
			getRoad();
		}
		
		/**
		 * 获得自动路径
		 * 
		 */		
		private function getRoad() : void
		{
			//获得当前相邻的坐标点
			for(var i:int = _oneRoadInit.length - 1; i >= 0; i--)
			{
				if((_oneRoadInit[i].ix == _nowProp.ix + 1 && _oneRoadInit[i].iy == _nowProp.iy)|| (_oneRoadInit[i].ix == _nowProp.ix - 1  && _oneRoadInit[i].iy == _nowProp.iy) || (_oneRoadInit[i].ix == _nowProp.ix && _oneRoadInit[i].iy == _nowProp.iy + 1) || (_oneRoadInit[i].ix == _nowProp.ix && _oneRoadInit[i].iy == _nowProp.iy - 1))
				{
					_oneRoadX.push(_oneRoadInit[i]);
				}
			}
			//只有一个相邻的坐标，直接放入
			if(_oneRoadX.length == 1)
			{
				_autoRoad.push(_oneRoadX[0]);
				_nowProp = _oneRoadX[0];
				_oneRoadInit.splice(_oneRoadInit.indexOf(_oneRoadX[0]), 1);
				//trace(_nowProp.ix, _nowProp.iy);
			}
				//不止一个相邻的坐标
			else if(_oneRoadX.length > 1)
			{
				var count:int = _pointList[_pointCount];
				_cornerProp = _nowProp;
				
				if(_roadCorner.indexOf(_cornerProp) == -1)
				{
					_roadCorner.push(_cornerProp);
					_pointLength[_pointCount] = _oneRoadX.length;
				}
				
				Log.Trace("分叉点：x:" + _cornerProp.ix.toString() + ",y:" + _cornerProp.iy.toString() + "；第" + (count+1).toString() + "次进入该分叉点");
				
				_autoRoad.push(_oneRoadX[count]);
				_nowProp = _oneRoadX[count];
				_oneRoadInit.splice(_oneRoadInit.indexOf(_oneRoadX[count]), 1);
				
				_pointCount++;
			}
				//没有能继续的坐标，返回到前一个分叉坐标
			else
			{
				//trace(false);
				while(_autoRoad[_autoRoad.length - 1] != _cornerProp)
				{
					_oneRoadInit.push(_autoRoad.pop());
				}
				_nowProp = _cornerProp;
				_pointCount--;
				_pointList[_pointCount]++;
				//前一个分叉坐标的所有分叉都不能继续，继续返回再上一个分叉坐标，直到有分叉坐标可以走
				while(_pointList[_pointCount] >= _pointLength[_pointCount])
				{
					_pointList[_pointCount] = 0;
					_roadCorner.pop();
					_nowProp = _cornerProp = _roadCorner.pop();
					while(_autoRoad[_autoRoad.length - 1] != _cornerProp)
					{
						_oneRoadInit.push(_autoRoad.pop());
					}
					_pointCount--;
					_pointList[_pointCount]++;
				}
				getRoad();
				return;
			}
			
			while(_oneRoadX.length > 0)
			{
				_oneRoadX.pop();
			}
			//已经到达Boss点坐标
			if(_nowProp.ix != _lastProp.ix || _nowProp.iy != _lastProp.iy)
			{
				getRoad();
			}

			
		}

	}
}
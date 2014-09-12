package com.game.view.plugin
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.manager.LayerManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.map.player.PlayerEntity;
	import com.game.view.map.player.PlayerStatus;
	
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class RunGameView extends BaseView implements IView
	{
		private var _anti:Antiwear;
		
		public function RunGameView()
		{
			_moduleName = V.RUN_GAME;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.RUN_GAME;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["score"] = 0;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch(type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
			}
		}
		
		override protected function init() : void
		{
			if (!this.isInit)
			{
				super.init();
				isInit = true;
				initXML();
				initTexture();
				initComponent();
				initUI();
				getUI();
				initPlayer();
				initEvent();
				LayerManager.instance.gpu_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
				LayerManager.instance.gpu_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUps);
				
			}
			initRender();
			
			//_view.layer.setCenter(panel);
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.RUN_GAME, GameConfig.RUN_GAME_RES, "RunGamePosition");
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.RUN_GAME, GameConfig.RUN_GAME_RES, "RunGame");
				obj = getAssetsObject(V.RUN_GAME, GameConfig.RUN_GAME_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
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
		
		private var _runGameOverInfoComponent:RunGameOverInfoComponent;
		
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
					if(name == "RunGameOverInfo")
					{
						cp = new RunGameOverInfoComponent(items, _titleTxAtlas);
						_components.push(cp);
					}
					if(name == "coin_line")
					{
						cp = new CoinLine(items, _titleTxAtlas);
						_components.push(cp);
					}
					if(name == "coin_arc")
					{
						cp = new CoinArc(items, _titleTxAtlas);
						_components.push(cp);
					}
					if(name == "coin_circle")
					{
						cp = new CoinCircle(items, _titleTxAtlas);
						_components.push(cp);
					}
					if(name == "coin_arrow")
					{
						cp = new CoinArrow(items, _titleTxAtlas);
						_components.push(cp);
					}
				}
			}
		}
		private var _skyBG1:Image;
		private var _skyBG2:Image;
		
		private var _houseBG1:Image;
		private var _houseBG2:Image;
		
		private var _roof1:Image;
		private var _roof2:Image;
		
		private function getUI() : void
		{
			//天空背景
			_skyBG1 = this.searchOf("skyBG");
			_skyBG2 = new Image(_skyBG1.texture);
			_skyBG2.x = _skyBG1.width-1;//拼接有白边，向左移1像素
			_skyBG2.y = 0;
			this.panel.addChildAt(_skyBG2, 0);
			
			_houseBG1 = this.searchOf("houseBG1");
			_houseBG2 = this.searchOf("houseBG2");
			
			_roof1 = this.searchOf("roof");
			_roof2 = new Image(_roof1.texture);
			_roof2.x = _roof1.width;
			_roof2.y = 466;
			this.panel.addChild(_roof2);
			
			_coinNum = this.searchOf("coin");
			_coldTime = this.searchOf("coldTime");
			_progressBar = this.searchOf("ProgressBar");
			_progressBg = this.searchOf("BarBg");
			
			coinLine = this.searchOfCompoent("coin_line") as CoinLine;
			coinArc = this.searchOfCompoent("coin_arc") as CoinArc;
			coinCircle = this.searchOfCompoent("coin_circle") as CoinCircle;
			coinArrow = this.searchOfCompoent("coin_arrow") as CoinArrow;
			
			_runGameOverInfoComponent = this.searchOf("runGameOverInfo") as RunGameOverInfoComponent;
			_runGameOverInfoComponent.hide();
			

		}
		
		private var _playerEntity:PlayerRun;
		private function initPlayer() : void
		{
			if (!_playerEntity)
				_playerEntity = new PlayerRun(_view);
			panel.addChild(_playerEntity);
			add(_playerEntity);
		}
		
		
		
		private function initRender() : void
		{
			renderText();
			renderPlayer();
			renderStart();
		}
		
		/**
		 * 渲染文本框
		 * 
		 */		
		private function renderText() : void
		{
			_rewardDate = new Date(2000, 0, 1, 0, Math.floor(MAX_TIME/60), (MAX_TIME % 60 + 1));
			//setTimeCount();
			MAX_TIME = 180;
			_coldTime.text = MAX_TIME.toString();
			_coinNum.text = "0";
		}
		
		/**
		 * 渲染角色
		 * 
		 */		
		private function renderPlayer() : void
		{
			_playerEntity.addEvent();
			_playerEntity.restart();
			_playerEntity.setDirection(PlayerMC.QUICKRIGHT);
			_playerEntity.x = LayerManager.instance.width/3;
			_playerEntity.y = LayerManager.instance.height - 40;
			//Starling.juggler.delayCall(function () : void {_playerEntity.setDirection(PlayerMC.QUICKRIGHT)}, 3);
		}
		
		private var _timer:Timer;
		
		private function renderStart() : void
		{
			_startTime = getTimer();
			_rewardCountTime = 0;
			_timer = new Timer(2500);
			_timer.addEventListener(TimerEvent.TIMER, initItems);
			_timer.start();
			_view.addToFrameProcessList("RunGame", renderBg);
		}

		/**
		 * 倒计时显示框
		 */		
		private var _coldTime:TextField;
		private var _progressBar:Image;
		private var _progressBg:Image;
		
		private var _coinNum:TextField;
		
		/**
		 * 游戏初始时间
		 * @return 
		 * 
		 */		
		public function get MAX_TIME() : int
		{
			if (!_anti["MAX_TIME"])
			{
				_anti["MAX_TIME"] = 180;
			}
			
			return _anti["MAX_TIME"];
		}
		
		public function set MAX_TIME(value:int) : void
		{
			_anti["MAX_TIME"] = value;
		}
		
		/**
		 * 游戏获得金币
		 * @return 
		 * 
		 */		
		public function get reward_money() : int
		{
			if (!_anti["reward_money"])
			{
				_anti["reward_money"] = 0;
			}
			
			return _anti["reward_money"];
		}
		
		public function set reward_money(value:int) : void
		{
			_anti["reward_money"] = value;
		}
		
		/**
		 * 上一次采样时间
		 */		
		private var _startTime:int;
		/**
		 * 采样时间
		 */	
		private var _intervalTime:int;
		/**
		 * 游戏经过时间
		 */		
		private var _rewardCountTime:int;
		/**
		 * 游戏倒计时
		 */		
		private var _coldTimeCount:int;
		/**
		 * 时间显示
		 */		
		private var _rewardDate:Date;
		
		/**
		 * 屏幕卷动速度
		 */	
		private var _speedNum:Number;
		
		/**
		 * 游戏主循环
		 */	
		private function renderBg() : void
		{
			_intervalTime = getTimer() - _startTime;
			_startTime = getTimer();
			_rewardCountTime += _intervalTime;
			
			//倒计时
			_rewardDate.milliseconds -= _intervalTime;
			setTimeCount();
			
			_speedNum = int(_rewardCountTime/7000)+20;
/*			if(_playerEntity.curState == PlayerStatus.DJ)
				_playerEntity.x -= _speedNum;*/

			_skyBG1.x-=_speedNum/10;
			_skyBG2.x-=_speedNum/10;
			//拼接有白边，向左移1像素
			if(_skyBG1.x < -_skyBG1.width+1)
				_skyBG1.x = _skyBG2.x + _skyBG2.width-1;
			if(_skyBG2.x < -_skyBG2.width+1)
				_skyBG2.x = _skyBG1.x + _skyBG1.width-1;
			
			_houseBG1.x-=_speedNum/5;
			_houseBG2.x-=_speedNum/5;
			if(_houseBG1.x < -_houseBG1.width+1)
				_houseBG1.x = _houseBG2.x + _houseBG2.width-1;
			if(_houseBG2.x < -_houseBG2.width+1)
				_houseBG2.x = _houseBG1.x + _houseBG1.width-1;
			
			_roof1.x-=_speedNum;
			_roof2.x-=_speedNum;
			if(_roof1.x < -_roof1.width)
				_roof1.x = _roof2.x + _roof2.width;
			if(_roof2.x < -_roof2.width)
				_roof2.x = _roof1.x + _roof1.width;
			
			var radomNum:int=Math.floor(Math.random()*1000);
			var radomType:int=Math.floor(Math.random()*4);
				
	/*		if(radomNum>990){
				initItems();
				Starling.juggler.delayCall(initRocks,2);
			}*/
			
			//initBombs();
			
			judgeHit();
			barriersMoveAndHit();
		}
		private var coinLine:CoinLine;
		private var coinArc:CoinArc;
		private var coinCircle:CoinCircle;
		private var coinArrow:CoinArrow;
		
		private var _coinCompoentArr:Array = [];
		private var _initCount:int;
		private var _randomBarrier:int;
		
		private function initItems(e:TimerEvent):void{
			if(_initCount==0){
				_randomBarrier =Math.floor(Math.random()*3)
			}
	
			if(_initCount==_randomBarrier){
				initBarrier();
			}else{
				initCoinSets();
			}
			
			_initCount=(_initCount+1)%3;
			
		}
		
		//随机生成任一形状的金币
		private function initCoinSets():void{
			switch(Math.floor(Math.random()*4)){
				case 0:
					initCoinLine();
					break;
				case 1:
					initCoinArc();
					break;
				case 2:
					initCoinArrow();
					break;
				case 3:
					initCoinCircle();
					break;
				
			}
		}
		
		
		//随机生成任一障碍
		private function initBarrier():void{
			switch(Math.floor(Math.random()*3)){
				case 0:
					//initBombs();
					//initDarts();
					initRocks();
					break;
				case 1:
					initBombs();
					//initDarts();
					break;
				case 2:
					initDarts();
					//initBombs();
					break;
				
			}
		}
		
		/**
		 * 生成直线状金币群
		 * 
		 */	
		private function initCoinLine():void{
			var _coinLine:CoinLine = coinLine.copy() as CoinLine;
			_coinLine.coinValue=10+int(_rewardCountTime/60000)*5;
			panel.addChild(_coinLine.panel);
			_coinCompoentArr.push(_coinLine);
			_coinLine.panel.x=940;
			_coinLine.panel.y=170;
		}
		
		/**
		 * 生成弧线状金币群
		 * 
		 */	
		private function initCoinArc():void{
			var _coinArc:CoinArc = coinArc.copy() as CoinArc;
			_coinArc.coinValue=10+int(_rewardCountTime/60000)*5;
			panel.addChild(_coinArc.panel);
			_coinCompoentArr.push(_coinArc);
			_coinArc.panel.x=940;
			_coinArc.panel.y=170;
		}
		
		/**
		 * 生成环形状金币群
		 * 
		 */	
		private function initCoinCircle():void{
			var _coinCircle:CoinCircle = coinCircle.copy() as CoinCircle;
			_coinCircle.coinValue=10+int(_rewardCountTime/60000)*5;
			panel.addChild(_coinCircle.panel);
			_coinCompoentArr.push(_coinCircle);
			_coinCircle.panel.x=940;
			_coinCircle.panel.y=140;
		}
		
		/**
		 * 生成箭头状金币群
		 * 
		 */	
		private function initCoinArrow():void{
			var _coinArrow:CoinArrow = coinArrow.copy() as CoinArrow;
			_coinArrow.coinValue=10+int(_rewardCountTime/60000)*5;
			panel.addChild(_coinArrow.panel);
			_coinCompoentArr.push(_coinArrow);
			_coinArrow.panel.x=940;
			_coinArrow.panel.y=140;
		}
		
		private var _barrierArr:Array = [];
		
		/**
		 * 生成滚石
		 * 
		 */
		private function initRocks() : void{
			var rockNum:int=0;
			if(_rewardCountTime>60*1000){
				rockNum=2;
			}
			
			for(var i:int=0;i<=rockNum;i++){
				var obj:Image = new Image(getTexture(ROCK, ""));
				obj.x= 950+150*i;
				obj.y= LayerManager.instance.height-110;
				obj.pivotX=obj.width*0.5;
				obj.pivotY=obj.height*0.5;
				obj.data=["rock"];
				_barrierArr.push(obj);
				panel.addChild(obj);
				
				var dustFrames:Vector.<Texture> = this.getTextures("dust","");
				var dustEffect:MovieClip = new MovieClip(dustFrames, 12);
				dustEffect.x=948+150*i;
				dustEffect.y=LayerManager.instance.height-70;
				_dustArr.push(dustEffect);
				panel.addChild(dustEffect);
				Starling.juggler.add(dustEffect);
			}

		}
		
		/**
		 *生成飞镖
		 * 
		 */
		private function initDarts() : void{
			var dartNum:int=0;
			if(_rewardCountTime>90*1000){
				dartNum=2;
			}
			var randomY:int=Math.ceil(Math.random()*2);
			for(var i:int=0;i<=dartNum;i++){
				for(var j:int=0;j<3;j++){
					var obj:Image = new Image(getTexture(DART, ""));
					obj.scaleX=0.6;
					obj.scaleY=0.6;
					obj.x= 950+Math.ceil(Math.random()*150)+200*i;
					obj.y= 195*randomY+j*40;
					obj.data=["dart"];
					_barrierArr.push(obj);
					panel.addChild(obj);
				}
			}

		}
		
		
		/**
		 * 生成掉落炸弹
		 * 
		 */
		private function initBombs() : void{
			var bombNum:int=0;
			if(_rewardCountTime>60*1000){
				bombNum=2;
			}
			for(var i:int=0;i<=bombNum;i++){
				var obj:Image = new Image(getTexture(BOMB, ""));
				obj.x=970+93*i;
				obj.y=50-54*i;
				obj.data=["bomb"];
				_barrierArr.push(obj);
				panel.addChild(obj);
			}
	
		}
		
		
		
		private function barriersMoveAndHit():void{
			
			for(var dust:int=_dustArr.length-1; dust>=0 ; dust--){
				if(_dustArr[dust].x > 0){
					_dustArr[dust].x-= _speedNum;
				}else{
					disposeMC(_dustArr[dust],_dustArr);
				}
			}
			
			for (var i:int=_barrierArr.length-1 ; i >=0  ; i--){
				//检测物品是否超屏，超屏则移除,未超屏则移动
				if(_barrierArr[i].x > 0){
					switch(_barrierArr[i].data[0]){
						case "bomb":
							_barrierArr[i].x-=_speedNum;
							_barrierArr[i].y+=_speedNum/1.6;
							if(Math.abs(_barrierArr[i].x + _barrierArr[i].width * .5 - _playerEntity.x) < (_barrierArr[i].width * .4 + _playerEntity.width * .3 ) 
								&& Math.abs( _barrierArr[i].y + _barrierArr[i].height * .5 - _playerEntity.y + _playerEntity.height * .5) < (_barrierArr[i].height * .4 + _playerEntity.height * .3)){
								addHitMC(_playerEntity.x-30,_playerEntity.y-150);
								disposeBarrierArr();
								_playerEntity.setDirection(PlayerMC.DIE);
								gameOver();
							}
							break;
						case "rock":
							_barrierArr[i].rotation-=0.6;
							_barrierArr[i].x-= _speedNum;
							if(Math.abs(_barrierArr[i].x  - _playerEntity.x) < (140 * .4 + _playerEntity.width * .3 ) 
								&& Math.abs( _barrierArr[i].y  - _playerEntity.y + _playerEntity.height * .5) < (144 * .4 + _playerEntity.height * .3)){
								addHitMC(_playerEntity.x-30,_playerEntity.y-150);
								disposeBarrierArr();
								_playerEntity.setDirection(PlayerMC.DIE);
								gameOver();
							}
							break;
						default:
							_barrierArr[i].x-= _speedNum;
							if(Math.abs(_barrierArr[i].x + _barrierArr[i].width * .5 - _playerEntity.x) < (_barrierArr[i].width * .4 + _playerEntity.width * .3 ) 
								&& Math.abs( _barrierArr[i].y + _barrierArr[i].height * .5 - _playerEntity.y + _playerEntity.height * .5) < (_barrierArr[i].height * .4 + _playerEntity.height * .3)){
								addHitMC(_playerEntity.x-30,_playerEntity.y-150);
								disposeBarrierArr();
								_playerEntity.setDirection(PlayerMC.DIE);
								gameOver();
								return;
							}
							break;
					}
					
				}else{
					disposeItem(_barrierArr[i],_barrierArr);
				}
			}
			
			
		}
		
		
		
		/**
		 * 添加击打效果MC
		 * @param x,y
		 * 
		 */	
		private function addHitMC(x:int,y:int):void{
				var bombFrames:Vector.<Texture> = this.getTextures("bz","");
				var bombEffect:MovieClip = new MovieClip(bombFrames, 8);
				bombEffect.x=x-90;
				bombEffect.y=y-40;
				panel.addChild(bombEffect);
				//addBlinkEffect();
				Starling.juggler.add(bombEffect);
				Starling.juggler.delayCall(disposeEffect, 0.6, bombEffect);
				//disposeItemArr();
		}
		
		
		private function disposeEffect(effect:MovieClip):void{
			effect.stop();
			panel.removeChild(effect);
			effect.texture.dispose();
			effect.dispose();
			effect = null;
		}
		
	
		
		private function get score() : int
		{
			return _anti["score"];
		}
		private function set score(value:int) : void
		{
			_anti["score"] = value;
		}
		
		/**
		 * 碰撞检测
		 */	
		private function judgeHit() : void
		{
			for (var coinId:int=_coinCompoentArr.length-1;coinId>=0;coinId--){
				reward_money+=_coinCompoentArr[coinId].hitTest(_playerEntity);
				//trace(_score);
				_coinNum.text = reward_money.toString();
				if(_coinCompoentArr[coinId].panel.x>-600){
					_coinCompoentArr[coinId].panel.x-=_speedNum;
				}else{
					_coinCompoentArr[coinId].destroy();
					_coinCompoentArr.splice(coinId,1);
				}
			}
			
		}
		
		/**
		 * 设置倒计时
		 * 
		 */		
		private function setTimeCount() : void
		{
			_coldTimeCount = _rewardDate.getSeconds() + _rewardDate.getMinutes() * 60;
			_coldTime.text = _coldTimeCount.toString();
			_progressBar.width = (_coldTimeCount + _rewardDate.milliseconds * .001 - 1) / MAX_TIME * _progressBg.width;
			if(_rewardDate.minutes == 0 && _rewardDate.seconds == 0)
			{
				gameOver();
			}
		}
		
		
		private function gameOver():void{
			_timer.stop();
			
			//_playerEntity.restart();
			
			
			//清空尘土数组
			while(_dustArr.length>0){
				var tempMC:MovieClip=_dustArr[0];
				_dustArr.splice(0,1);
				tempMC.stop();
				panel.removeChild(tempMC);
				tempMC.texture.dispose();
				tempMC.dispose();
				tempMC = null;
			}
			
			
			_view.removeFromFrameProcessList("RunGame");
			LayerManager.instance.gpu_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
			LayerManager.instance.gpu_stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUps);
			//Starling.juggler.delayCall(returnToWorld,3);
			Starling.juggler.delayCall(setGameOverInfo,1);
			
		}
		

		
		
		/**
		 * 清空金币数组
		 */	
		private function disposeCoinArr():void{
			while(_coinCompoentArr.length>0){
				var tempImage:*=_coinCompoentArr[0];
				_coinCompoentArr.splice(0,1);
				panel.removeChild(tempImage);
				tempImage.texture.dispose();
				tempImage.dispose();
				tempImage=null;
				
			}
		}
		
		
		/**
		 * 清空障碍数组
		 */	
		private function disposeBarrierArr():void{
			while(_barrierArr.length>0){
				var tempImage:Image=_barrierArr[0];
				_barrierArr.splice(0,1);
				panel.removeChild(tempImage);
				tempImage.texture.dispose();
				tempImage.dispose();
				tempImage=null;
			}
			

		}
		
		
		/**
		 * 游戏结束信息显示
		 * 
		 */		
		private function setGameOverInfo() : void
		{
			_runGameOverInfoComponent.showing(this.reward_money, _rewardDate.minutes * 60 + _rewardDate.seconds);
			//_view.tip.interfaces(InterfaceTypes.Show,"游戏结束，欢迎明天再来!",onComeBack,onComeBack);
		}
		
		private function returnToWorld() : void
		{
			
			_view.run_game.close();
			_view.run_game.destroy();
			_view.world.interfaces(InterfaceTypes.REFRESH);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.checkPluginGame();
		}
		
		/**
		 * 重写关闭函数
		 * 
		 */		
		override public function close() : void
		{
			panel.removeEventListeners();
			juggle.purge();
			clearPlayer();
			disposeCoinArr();
			disposeBarrierArr();
			clearResource();
			super.close();
		}
		
		/**
		 * 清除图片资源
		 * 
		 */		
		private function clearResource() : void
		{
			_titleTxAtlas.dispose();
			_titleTxAtlas = null;
			
			_roof1.texture.dispose();
			_roof1.dispose();
			_roof1=null;
			
			_roof2.texture.dispose();
			_roof2.dispose();
			_roof2=null;
			
			_houseBG1.texture.dispose();
			_houseBG1.dispose();
			_houseBG1=null;
			
			_houseBG2.texture.dispose();
			_houseBG2.dispose();
			_houseBG2=null;
			
			_skyBG1.texture.dispose();
			_skyBG1.dispose();
			_skyBG1=null;
			
			_skyBG2.texture.dispose();
			_skyBG2.dispose();
			_skyBG2=null;
			
		}
		
		/**
		 * 清除玩家资源
		 * 
		 */		
		private function clearPlayer() : void
		{
			if (!_playerEntity) return;
			remove(_playerEntity);
			_playerEntity.removed();
			_playerEntity.clear();
			_playerEntity.removeEventListeners();
			_playerEntity = null;
		}
		
		
		private static const BOMB:String = "bomb";
		private static const ROCK:String = "bigRock";
		private static const DART:String = "Dart";
		private var _dustArr:Array = [];
		
		
		


		
		

		
		
		/**
		 * 物品删除自身
		 * @param image
		 * 
		 */
		private function disposeItem(image:Image,arr:Array):void{
			arr.splice(arr.indexOf(image),1);
			panel.removeChild(image);
			image.texture.dispose();
			image.dispose();
			image=null;
		}
		
		/**
		 * MC播放结束删除自身
		 * @param mc
		 * 
		 */		
		private function disposeMC(mc:MovieClip,arr:Array) : void
		{
			arr.splice(arr.indexOf(mc),1);
			mc.stop();
			panel.removeChild(mc);
			mc.texture.dispose();
			mc.dispose();
			mc = null;
		}
		

		
		
		


		
		/**
		 * 键盘按下
		 * 
		 * @param e
		 * 
		 */		
		private function onKeyDowns(e:KeyboardEvent) : void
		{
			if(!panel.visible || player == null)
			{
				return;
			}
			switch(e.keyCode)
			{
				case Keyboard.W:
					_playerEntity.setJump();
					break;
			}
		}
		
		
		/**
		 * 键盘松开
		 * @param e
		 * 
		 */		
		private function onKeyUps(e:KeyboardEvent) : void
		{
			if(player == null || !panel.visible) return;
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.pluginGame.interfaces(InterfaceTypes.GetTextures, name);
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
				texture = _view.pluginGame.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			return texture;
		}
		
		override public function resetView() : void
		{
			LayerManager.instance.gpu_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
			LayerManager.instance.gpu_stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUps);
			
			super.resetView();
		}
	}
}
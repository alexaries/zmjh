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
	import com.game.view.Role.RoleLabelComponent;
	import com.game.view.ViewEventBind;
	
	import flash.display.Bitmap;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class MoveGameView extends BaseView implements IView
	{
		public static const FREEDOM:String = "freedom";
		public static const LEGS:String = "legs";
		public static const GINSENG:String = "ginseng";
		public static const DICE:String = "dice";
		public static const BOMB:String = "bomb";
		public static const BEER:String = "beer";
		public static const STONE:String = "stone";
		public static const BAOZI:String = "baozi";
		private static const DIGIT:String = "go_00";
		
		private var _anti:Antiwear;
		
		private var _positionXML:XML;
		private var _titleTxAtlas:TextureAtlas;
		/**
		 * 满汉全席个数显示框
		 */		
		private var _legs:TextField;
		/**
		 * 雪山人参个数显示框
		 */		
		private var _ginseng:TextField;
		/**
		 * 如意骰子个数显示框
		 */		
		private var _freedom:TextField;
		/**
		 * 骰子个数显示框
		 */
		private var _dice:TextField;
		/**
		 * 倒计时显示框
		 */		
		private var _coldTime:TextField;
		private var _progressBar:Image;
		private var _progressBg:Image;
		/**
		 * 游戏初始时间
		 * @return 
		 * 
		 */		
		public function get MAX_TIME() : int
		{
			if (!_anti["MAX_TIME"])
			{
				_anti["MAX_TIME"] = 40;
			}
			
			return _anti["MAX_TIME"];
		}
		
		public function set MAX_TIME(value:int) : void
		{
			_anti["MAX_TIME"] = value;
		}
		
		public function get legsCount() : int
		{
			return _anti["legsCount"];
		}
		public function set legsCount(value:int) : void
		{
			_anti["legsCount"] = value;
		}
		
		public function get ginsengCount() : int
		{
			return _anti["ginsengCount"];
		}
		
		public function set ginsengCount(value:int) : void
		{
			_anti["ginsengCount"] = value
		}
		
		public function get freedomCount() : int
		{
			return _anti["freedomCount"];
		}
		
		public function set freedomCount(value:int) : void
		{
			_anti["freedomCount"] = value
		}
		
		public function get diceCount() : int
		{
			return _anti["diceCount"];
		}
		
		public function set diceCount(value:int) : void
		{
			_anti["diceCount"] = value
		}
		
		/**
		 * 游戏倒计时
		 */		
		private var _coldTimeCount:int;
		
		/**
		 * 物品数组
		 */		
		private var _rewardArr:Array = [];
		/**
		 * 玩家元件
		 */		
		private var _player:PlayerMC;
		
		/**
		 * 物品出现时间
		 */		
		private var _rewardStartTime:int;
		private var _rewardIntervalTime:int;
		/**
		 * 记录时间
		 */		
		private var _rewardCountTime:int;
		
		/**
		 * 物品掉落数组
		 */		
		private var _rewardFallArr:Array = [];
		private var _rewardRemoveArr:Array = [];
		/**
		 * 时间显示
		 */		
		private var _rewardDate:Date;
		
		private var _pressLeft:Boolean = false;
		private var _pressRight:Boolean = false;
		
		/**
		 * 倒计时3秒
		 */	
		private var _countDownCount:int;
		
		/**
		 * 物品数组
		 */		
		private var _rewardInitArr:Array = [];
		
		/**
		 * 物品数据
		 */		
		private var _data:Object;
		
		private var _startLeft:uint = 0;
		private var _intervalLeft:uint = 0;
		
		private var _startRight:uint = 0;
		private var _intervalRight:uint = 0;
		
		private var _gameOverInfoComponent:GameOverInfoComponent;
		
		private var _coldDownDigit:MovieClip;
		
		public function MoveGameView()
		{
			_moduleName = V.MOVE_GAME;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.MOVE_GAME;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["legsCount"] = 0;
			_anti["freedomCount"] = 0;
			_anti["ginsengCount"] = 0;
			_anti["diceCount"] = 0;
			
			LayerManager.instance.gpu_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
			LayerManager.instance.gpu_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUps);
			
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
				initMC();
				initReward();
				initPlayer();
				initEvent();
				initData();
			}
			
			initRender();
			_view.layer.setCenter(panel);
		}
		
		private function initXML() : void
		{
			_positionXML = getXMLData(V.MOVE_GAME, GameConfig.MOVE_GAME_RES, "MoveGamesPosition");
		}
		
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.MOVE_GAME, GameConfig.MOVE_GAME_RES, "MoveGames");
				obj = getAssetsObject(V.MOVE_GAME, GameConfig.MOVE_GAME_RES, "Textures");
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
					if(name == "GameOverInfo")
					{
						cp = new GameOverInfoComponent(items, _titleTxAtlas);
						_components.push(cp);
					}
				}
			}
		}
		
		private function getUI() : void
		{
			_legs = this.searchOf("Legs");
			_ginseng = this.searchOf("Ginseng");
			_freedom = this.searchOf("FreedomDice");
			_dice = this.searchOf("Dice");
			_coldTime = this.searchOf("coldTime");
			_progressBar = this.searchOf("ProgressBar");
			_progressBg = this.searchOf("BarBg");
			
			_gameOverInfoComponent = this.searchOf("gameOverInfo") as GameOverInfoComponent;
			_gameOverInfoComponent.hide();
			/*
			if (!_gameOverInfoComponent)
			{
				var Recover:GameOverInfoComponent = this.searchOfCompoent("GameOverInfo") as GameOverInfoComponent;
				_gameOverInfoComponent = Recover.copy() as GameOverInfoComponent;
				
				_view.layer.top.addChild(_gameOverInfoComponent.panel);
				_view.layer.setCenter(_gameOverInfoComponent.panel);
				//_gameOverInfoComponent.hide();
			}*/
		}
		
		private function initMC() : void
		{
			var digitFrames:Vector.<Texture> = this.getTextures(DIGIT, V.PUBLIC);
			_coldDownDigit = new MovieClip(digitFrames);
			_coldDownDigit.touchable = false;
			_coldDownDigit.stop();
		}
		
		/**
		 * 物品数组初始化
		 * 
		 */		
		private function initReward() : void
		{
			_rewardArr = [];
			_rewardArr.push(DICE);
			_rewardArr.push(FREEDOM);
			_rewardArr.push(LEGS);
			_rewardArr.push(GINSENG);
			_rewardArr.push(BEER);
			_rewardArr.push(STONE);
			_rewardArr.push(BOMB);
			_rewardArr.push(BAOZI);
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
		
		/**
		 * 重写关闭函数
		 * 
		 */		
		override public function close() : void
		{
			panel.removeEventListeners();
			juggle.purge();
			resetReward();
			clearPlayer();
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
			
			_coldDownDigit.texture.dispose();
			_coldDownDigit.dispose();
			_coldDownDigit = null;
		}

		/**
		 * 清除玩家资源
		 * 
		 */		
		private function clearPlayer() : void
		{
			if (!_player) return;
			remove(_player);
			_player.removed();
			_player.clear();
			_player.removeEventListeners();
			_player = null;
		}
		
		/**
		 * 物品掉落数组重新设置
		 * 
		 */		
		private function resetReward() : void
		{
			while(_rewardFallArr.length != 0)
			{
				var obj_1:Image = _rewardFallArr.shift();
				obj_1.parent.removeChild(obj_1);
				obj_1.removeEventListeners();
				_rewardFallArr.splice(0, 1);
				obj_1.texture.dispose();
				obj_1.dispose();
				obj_1 = null; 
			}
			while(_rewardRemoveArr.length != 0)
			{
				var obj_2:Image = _rewardRemoveArr.shift();
				obj_2.parent.removeChild(obj_2);
				obj_2.removeEventListeners();
				_rewardRemoveArr.splice(0, 1);
				obj_2.texture.dispose();
				obj_2.dispose();
				obj_2 = null;
			}
		}
		
		/**
		 * 初始化玩家
		 *   
		 */		
		private function initPlayer() : void
		{
			if (!_player)
			{
				_player = new PlayerMC(_view);
			}
			panel.addChild(_player);
			add(_player);
		}
		
		/**
		 * 初始化掉落物品的数据
		 * 
		 */		
		private function initData() : void
		{
			_data = Data.instance.db.interfaces(InterfaceTypes.GET_SMALLGAME_FALL);
		}
		
		/**
		 * 键盘按下
		 * @param e
		 * 
		 */		
		private function onKeyDowns(e:KeyboardEvent) : void
		{
			if(!panel.visible || _player == null)
			{
				return;
			}
			switch(e.keyCode)
			{
				case Keyboard.A:
					onLeftJudge();
					break;
				case Keyboard.D:
					onRightJudge();
					break;
				case Keyboard.W:
					_player.setJump();
					break;
			}
		}
		
		/**
		 * 向左移动判断
		 * 
		 */		
		private function onLeftJudge() : void
		{
			if(_pressLeft)	return;
			_pressLeft = true;
			_intervalLeft = getTimer() - _startLeft;
			_startLeft = getTimer();
			if(_intervalLeft < 200)
			{
				_player.invertState == 1?_player.setDirection(PlayerMC.QUICKLEFT):_player.setDirection(PlayerMC.QUICKRIGHT);
			}
			else
			{
				_player.invertState == 1?_player.setDirection(PlayerMC.LEFT):_player.setDirection(PlayerMC.RIGHT);
			}
		}
		
		/**
		 * 向右移动判断
		 * 
		 */		
		private function onRightJudge() : void
		{
			if(_pressRight) return;
			_pressRight = true;
			_intervalRight = getTimer() - _startRight;
			_startRight = getTimer();
			if(_intervalRight < 200)
			{
				_player.invertState == 1?_player.setDirection(PlayerMC.QUICKRIGHT):_player.setDirection(PlayerMC.QUICKLEFT);
			}
			else
			{
				_player.invertState == 1?_player.setDirection(PlayerMC.RIGHT):_player.setDirection(PlayerMC.LEFT);
			}
		}
		
		/**
		 * 键盘松开
		 * @param e
		 * 
		 */		
		private function onKeyUps(e:KeyboardEvent) : void
		{
			if(_player == null || !panel.visible) return;
			if(e.keyCode == Keyboard.A)
			{
				_pressLeft = false;
			}
			else if(e.keyCode == Keyboard.D)
			{
				_pressRight = false;
			}
			if(_pressLeft == false && _pressRight == false)
			{
				_player.setDirection(PlayerMC.RESET);
			}
		}
		
		/**
		 * 渲染
		 * 
		 */		
		private function initRender() : void
		{
			renderData();
			renderText();
			renderPlayer();
			renderStart();
		}
		
		/**
		 * 初始化该次游戏掉落的所有物品
		 * 
		 */		
		private function renderData() : void
		{
			_rewardInitArr = [];
			for(var i:uint = MAX_TIME + 10; i > 0 ; i--)
			{
				for(var j:uint = 0; j < _data.length; j++)
				{
					if(i != 0 && i % _data[j].interval_time == 0)
					{
						_rewardInitArr.push([_data[j].id, _data[j].falling_mode, i - Math.floor(Math.random() * _data[j].interval_time)]);
					}
				}
			}
		}
		
		/**
		 * 渲染文本框
		 * 
		 */		
		private function renderText() : void
		{
			_rewardDate = new Date(2000, 0, 1, 0, Math.floor(MAX_TIME/60), (MAX_TIME % 60 + 1));
			legsCount = 0;
			ginsengCount = 0;
			freedomCount = 0;
			diceCount = 0;
			setTextCount();
			setTimeCount();
			MAX_TIME = 40;
			_coldTime.text = MAX_TIME.toString();
		}
		
		/**
		 * 设置物品文本框数值
		 * 
		 */		
		private function setTextCount() : void
		{
			_legs.text = legsCount.toString();
			_ginseng.text = ginsengCount.toString();
			_freedom.text = freedomCount.toString();
			_dice.text = diceCount.toString();
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
				resetReward();
				_player.restart();
				_player.setDirection(PlayerMC.RESET);
				panel.removeEventListener(Event.ENTER_FRAME, onRewardFrameHandler);
				LayerManager.instance.gpu_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
				LayerManager.instance.gpu_stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUps);
				setGameOverInfo();
			}
		}
		
		/**
		 * 游戏结束信息显示
		 * 
		 */		
		private function setGameOverInfo() : void
		{
			_gameOverInfoComponent.showing(this.legsCount, this.ginsengCount, this.freedomCount, this.diceCount);
			//_view.tip.interfaces(InterfaceTypes.Show,"游戏结束，欢迎明天再来!",onComeBack,onComeBack);
		}
		
		/**
		 * 渲染玩家
		 * 
		 */		
		private function renderPlayer() : void
		{
			_player.addEvent();
			_player.restart();
			_player.setDirection(PlayerMC.RESET);
			_player.x = LayerManager.instance.width >> 1;
			_player.y = LayerManager.instance.height - 40;
		}
		
		/**
		 * 开始小游戏
		 * 
		 */		
		private function renderStart() : void
		{
			_countDownCount = 3;
			panel.addChildAt(_coldDownDigit, panel.numChildren - 1);
			_coldDownDigit.x = panel.width * .5 - _coldDownDigit.width * .5;
			_coldDownDigit.y = panel.height * .5 - _coldDownDigit.height * .5;
			_coldDownDigit.currentFrame = _countDownCount;
			juggle.delayCall(delayedStart, 3);
			juggle.delayCall(changeText, 1);
		}
		
		/**
		 * 延迟3秒的文本框提示
		 * 
		 */		
		private function changeText() : void
		{
			_countDownCount--;
			if(_countDownCount < 0)
			{
				_coldDownDigit.parent.removeChild(_coldDownDigit);
				return;
			}
			_coldDownDigit.currentFrame = _countDownCount;
			juggle.delayCall(changeText, 1);
		}
		
		/**
		 * 延迟3秒开始游戏
		 * 
		 */		
		private function delayedStart() : void
		{
			_rewardStartTime = getTimer();
			_rewardCountTime = 0;
			panel.addEventListener(Event.ENTER_FRAME, onRewardFrameHandler);
		}
		
		/**
		 * 小游戏主循环
		 * @param e
		 * 
		 */		
		private function onRewardFrameHandler(e:Event) : void
		{
			_rewardIntervalTime = getTimer() - _rewardStartTime;
			_rewardStartTime = getTimer();
			_rewardCountTime += _rewardIntervalTime;
			
			//倒计时
			_rewardDate.milliseconds -= _rewardIntervalTime;
			setTimeCount();
			
			//添加物品
			for(var i:uint = _rewardInitArr.length - 1; i > 0; i--)
			{
				if(_rewardInitArr[i][2] == int(_rewardCountTime * .001))
				{
					var obj:Image = new Image(_titleTxAtlas.getTexture(_rewardArr[_rewardInitArr[i][0] - 1]));
					setRewardPos(obj);
					obj.data[4] = _rewardInitArr[i][1];
					obj.name = _rewardArr[_rewardInitArr[i][0] - 1];
					panel.addChild(obj);
					_rewardFallArr.push(obj);
					addRewardEvent(obj);
					_rewardInitArr.splice(i, 1);
				}
			}
			
			//碰撞检测
			judgeHit();
			//异常判断
			judgeParams();
		}
		
		/**
		 * 判断数据是否异常
		 * 
		 */		
		private function judgeParams() : void
		{
			judgeTime();
			judgeDice();
			judgeFreedom();
			judgeGinseng();
			judgeLeg();
		}
		
		/**
		 * 时间数据异常判断
		 * @param count
		 * 
		 */		
		private function judgeTime() : void
		{
			if(_data[7] == null) return;
			if(_coldTimeCount > MAX_TIME + int(MAX_TIME / _data[7].interval_time) * 5)
			{
				dataError();
			}
		}
		
		/**
		 * 随机骰子数据异常判断
		 * 
		 */		
		private function judgeDice() : void
		{
			if(_data[0] == null || _data[7] == null) return;
			if(diceCount > int((MAX_TIME + int(MAX_TIME / _data[7].interval_time) * 5) / _data[0].interval_time))
			{
				dataError();
			}
		}
		
		/**
		 * 如意骰子数据异常判断
		 * 
		 */		
		private function judgeFreedom() : void
		{
			if(_data[1] == null || _data[7] == null) return;
			if(freedomCount > int((MAX_TIME + int(MAX_TIME / _data[7].interval_time) * 5) / _data[1].interval_time))
			{
				dataError();
			}
		}
		
		/**
		 * 满汉全席数据异常判断
		 * 
		 */		
		private function judgeLeg() : void
		{
			if(_data[2] == null || _data[7] == null) return;
			if(freedomCount > int((MAX_TIME + int(MAX_TIME / _data[7].interval_time) * 5) / _data[2].interval_time))
			{
				dataError();
			}
		}
		
		/**
		 * 人参数据异常判断
		 * 
		 */		
		private function judgeGinseng() : void
		{
			if(_data[3] == null || _data[7] == null) return;
			if(freedomCount > int((MAX_TIME + int(MAX_TIME / _data[7].interval_time) * 5) / _data[3].interval_time))
			{
				dataError();
			}
		}
		
		/**
		 * 数据异常显示
		 * 
		 */		
		private function dataError() : void
		{
			resetReward();
			_player.restart();
			_player.setDirection(PlayerMC.RESET);
			panel.removeEventListener(Event.ENTER_FRAME, onRewardFrameHandler);
			_view.tip.interfaces(InterfaceTypes.Show, 
				"数据异常，请刷新页面重新开始游戏", 
				null, null, true);
		}
		
		/**
		 * 物品添加移动事件 
		 * @param obj
		 * 
		 */		
		private function addRewardEvent(obj:Image) : void
		{
			obj.addEventListener(Event.ENTER_FRAME, onRewardEnterFrameHandler);
		}
		
		/**
		 * 设置物品运动路径
		 * @param obj
		 * 
		 */		
		private function setRewardMoveType(obj:Image) : void
		{
			switch(obj.data[4])
			{
				case 1:
					obj.x = obj.data[0] + Math.sin(obj.y * .01 + obj.data[1]) * obj.data[2];
					break;
				default:
					break;
			}
			obj.y += obj.data[3];
		}
		
		
		/**
		 * 物品掉落移动函数
		 * @param e
		 * 
		 */		
		private function onRewardEnterFrameHandler(e:Event) : void
		{
			//游戏结束删除物品
			if(!panel.hasEventListener(Event.ENTER_FRAME)) onAlpha(Image(e.currentTarget));
			setRewardMoveType(Image(e.currentTarget));
			//物品掉落到地板
			if(Image(e.currentTarget).y > LayerManager.instance.height - Image(e.currentTarget).height - 30)
			{
				onAlpha(Image(e.currentTarget));
			}
		}
		
		/**
		 * 设置物品的初始位置
		 * @param obj
		 * 
		 */		
		private function setRewardPos(obj:Image) : void
		{
			//随机
			obj.x = _player.width + Math.random() * (LayerManager.instance.width - _player.width * 2);
			obj.y = -obj.height;
			//记录初始位置，曲线运动点，下落速度
			obj.data = [obj.x, Math.random() * 2 * Math.PI, Math.random() * 50 + 100, getTweenTime(obj)];
			//onLimitX(obj);
		}
		
		/**
		 * 物品X轴位置限制判断
		 * @param obj
		 * 
		 */		
		private function onLimitX(obj:Image) : void
		{
			if(obj.x < obj.data[2])
			{
				obj.data[0] = obj.data[2];
			}
			else if(obj.x > LayerManager.instance.width - obj.data[2] - obj.width)
			{
				obj.data[0] = LayerManager.instance.width - obj.data[2] - obj.width;
			}
		}
		
		/**
		 * 掉落的速度
		 * @return 
		 * 
		 */		
		private function getTweenTime(obj:Image) : Number
		{
			//随机
			return Math.random() * 7 + 3;
		}
		
		/**
		 * 透明度改变
		 * @param obj
		 * 
		 */		
		private function onAlpha(obj:Image) : void
		{
			obj.removeEventListener(Event.ENTER_FRAME, onRewardEnterFrameHandler);
			juggle.removeTweens(obj);
			_rewardFallArr.splice(_rewardFallArr.indexOf(obj), 1);
			_rewardRemoveArr.push(obj);
			var t:Tween = new Tween(obj, 1, Transitions.LINEAR);
			t.animate("alpha", 0);
			t.onComplete = onRemoveSelf;
			t.onCompleteArgs = [obj];
			juggle.add(t);
		}
		
		/**
		 * 缓动结束删除自身
		 * @param obj
		 * 
		 */		
		private function onRemoveSelf(obj:Image) : void
		{
			juggle.removeTweens(obj);
			obj.texture.dispose();
			obj = null;
		}
		
		/**
		 * 碰撞检测
		 * 
		 */		
		private function judgeHit() : void
		{
			for(var i:uint = 0; i < _rewardFallArr.length; i++)
			{
				if(Math.abs(_rewardFallArr[i].x + _rewardFallArr[i].width * .5 - _player.x) < (_rewardFallArr[i].width * .5 + _player.width * .3) && Math.abs(_rewardFallArr[i].y - (_player.y - _player.height * .5)) < (_rewardFallArr[i].height * .5 + _player.height * .3))
				{
					addRewardCount(_rewardFallArr[i].name);
					onAlpha(_rewardFallArr[i]);
					break;
				}
			}
		}
		
		/**
		 * 玩家获得物品判断
		 * @param name
		 * 
		 */		
		private function addRewardCount(name:String) : void
		{
			switch(name)
			{
				case DICE:
					diceCount++;
					break;
				case FREEDOM:
					freedomCount++;
					break;
				case LEGS:
					legsCount++;
					break;
				case GINSENG:
					ginsengCount++;
					break;
				case BOMB:
					if(freedomCount > 0) freedomCount--;
					if(legsCount > 0) legsCount--;
					if(ginsengCount > 0) ginsengCount--;
					if(diceCount > 0) diceCount--;
					_player.setDirection(PlayerMC.BOMB);
					break;
				case BEER:
					_player.setDirection(PlayerMC.BEER);
					break;
				case STONE:
					_player.setDirection(PlayerMC.STONE);
					break;
				case BAOZI:
					_rewardDate.seconds += 5;
					MAX_TIME +=5;
					break;
			}
			setTextCount();
		}

	}
}
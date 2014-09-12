package com.game.view.map.player
{
	import com.engine.utils.Key;
	import com.engine.utils.SPInput;
	import com.game.Data;
	import com.game.View;
	import com.game.manager.FontManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Base;
	import com.game.view.Entity;
	import com.game.view.map.MapUtils;
	import com.game.view.map.MapView;
	import com.game.view.map.Node;
	import com.game.view.map.Prop;
	import com.game.view.map.SingleLineInfo;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	import starling.animation.IAnimatable;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class PlayerEntity extends Entity
	{
		private var _view:View;
		private static const JUMPOFFSET:int = 80;
		// 动画播放时间
		public static const PLAY_TIME:int = 10;		
		// 移动时间
		public static const STEP_TIME:Number = 0.5;		
		// 人物y轴偏移
		public static const OFFSETY:int = 10;
		// 扫荡模式移动时间
		public static const STEP_TIME_AUTO:Number = .01;
		// 下雨模式移动时间
		public static const STEP_TIME_RAIN:Number = .5;
		//如意骰子移动时间
		public static const STEP_TIME_DICE:Number = 1;
		// role库
		private var _roleLibrary:Object;
		// 当前role
		private var _curRole:MovieClip;
		// 当前scale
		private var _curScaleX:int = 1;
		// 当前状态是否改变
		private var _isChanged:Boolean = false;
		
		// 当前状态
		private var _curState:String;
		public function get curState() : String
		{
			return this._curState;
		}
		
		// 前节点
		private var _preNode:Point;
		public function get preNode() : Point
		{
			return _preNode;
		}
		public function set preNode(value:Point) : void
		{
			_preNode = value;
		}
		
		public var step_time:Number = .75;
		
		private var _playerShadow:Image;
		
		private var _playerTitleShow:MovieClip;
		
		/**
		 * 设置状态 
		 * @param state
		 * 
		 */		
		public function set State(state:String) : void
		{
			if (_curState != state)
			{
				_curState = state;
				_isChanged = true;
			}
		}
		
		public function get State() : String
		{
			return _curState;
		}

		public function PlayerEntity(x:Number = 0, y:Number = 0, type:String = 'player')
		{
			_view = View.instance;			
			_roleLibrary = {};
			
			super(x, y, type);
		}
		
		/**
		 * 添加到对象池 
		 * 
		 */		
		override public function added() : void
		{
			super.added();
			
			init();
			
			State = PlayerStatus.ZMDJ;
			
			//设置玩家播放速度
			//setSpeed(_view.world.allowChange);
		}
		
		private function addTitle() : void
		{
			var titleName:String = Data.instance.player.player.roleTitleInfo.nowTitle;
			if(titleName != "")
			{
				if(_playerTitleShow == null)
				{
					var textureName:String = V.ROLE_TITLE[titleName];
					var frames:Vector.<Texture> = _view.other_effect.interfaces(InterfaceTypes.GetTextures, textureName);
					_playerTitleShow = new MovieClip(frames, 10);
					_playerTitleShow.x = -_playerTitleShow.width * .5;
					_playerTitleShow.y = -_playerTitleShow.height - _curRole.height + 25;
					_playerTitleShow.play();
					this.addChild(_playerTitleShow);
					Starling.juggler.add(_playerTitleShow);
				}
				this.setChildIndex(_playerTitleShow, this.numChildren - 1);
			}
		}
		
		public function reset() : void
		{
			State = PlayerStatus.ZMDJ;
			if(_playerShadow && _playerShadow.parent)	_playerShadow.parent.removeChild(_playerShadow);
			_preNode = null;
			_curNode = null;
		}
		
		private function init() : void
		{
			_roleLibrary[PlayerStatus.BMDJ] = getMovieClip(PlayerStatus.BMDJ, PLAY_TIME, 2);
			_roleLibrary[PlayerStatus.BMZ] = getMovieClip(PlayerStatus.BMZ, PLAY_TIME);
			_roleLibrary[PlayerStatus.CMDJ] = getMovieClip(PlayerStatus.CMDJ, PLAY_TIME, 2);
			_roleLibrary[PlayerStatus.CMZ] = getMovieClip(PlayerStatus.CMZ, PLAY_TIME);
			_roleLibrary[PlayerStatus.ZMZ] = getMovieClip(PlayerStatus.ZMZ, PLAY_TIME);
			_roleLibrary[PlayerStatus.ZMDJ] = getMovieClip(PlayerStatus.ZMDJ, PLAY_TIME, 2);
			
			_roleLibrary[PlayerStatus.BMH] = getMovieClip(PlayerStatus.BMH, PLAY_TIME, 3);
			_roleLibrary[PlayerStatus.ZMH] = getMovieClip(PlayerStatus.ZMH, PLAY_TIME, 3);
			_roleLibrary[PlayerStatus.CMH] = getMovieClip(PlayerStatus.CMH, PLAY_TIME, 3);
			
			_roleLibrary[PlayerStatus.ZMBP] = getMovieClip(PlayerStatus.ZMBP, PLAY_TIME, 4);
			_roleLibrary[PlayerStatus.ZMHP] = getMovieClip(PlayerStatus.ZMHP, PLAY_TIME, 3);
			
			_roleLibrary[PlayerStatus.JUMP] = getMovieClip(PlayerStatus.JUMP, PLAY_TIME, 3);
			_roleLibrary[PlayerStatus.ZMT] = getMovieClip(PlayerStatus.ZMT, PLAY_TIME, 3);
			_roleLibrary[PlayerStatus.BMT] = getMovieClip(PlayerStatus.BMT, PLAY_TIME, 3);
			
			_roleLibrary[PlayerStatus.FEI] = getMovieClip(PlayerStatus.FEI, PLAY_TIME, 3);
			
			var texture:Texture = textureAtlas.getTexture("yz");
			_playerShadow = new Image(texture);
			_playerShadow.pivotX = _playerShadow.width * .5;
			_playerShadow.pivotY = _playerShadow.height * .5;
		}
		
		/**
		 * 获取对应的动作序列 
		 * @param name
		 * @param fps
		 * @return 
		 * 
		 */		
		private function getMovieClip(name:String, fps:Number, isDJ:int = 1) : MovieClip
		{
			var mp:MovieClip;		
			var frames:Vector.<Texture>;
			if(Data.instance.player.player.mainRoleModel.nowUseFashion == "")
				frames = textureAtlas.getTextures(name);
			else
				frames = newTextureAtlas.getTextures(name);
			
			mp = new MovieClip(frames, fps);
			
			//走路动画：2-1-2-3-4-5-4-3（可以直接接到待机动画的1）
			//待机动画：1-2-3-4-5-4-3-2
			if (isDJ == 2)
			{
				mp.addFrame(frames[3]);
				mp.addFrame(frames[2]);
				mp.addFrame(frames[1]);
			}
			else if(isDJ == 3)
			{
				
			}
			else if(isDJ == 4)
			{
				mp.addFrameAt(5, frames[5]);
				mp.addFrameAt(5, frames[4]);
				mp.addFrameAt(5, frames[3]);
				mp.addFrameAt(5, frames[2]);
				mp.addFrameAt(5, frames[1]);
				mp.addFrameAt(5, frames[0]);
			}
			else
			{
				mp.addFrameAt(0, frames[1]);
				mp.addFrame(frames[3]);
				mp.addFrame(frames[2]);
			}
			
			mp.pivotX = mp.width/2;
			mp.pivotY = mp.height - OFFSETY;
			
			if(name == PlayerStatus.CMH)	mp.pivotX = mp.width/1.3;
			
			if(name == PlayerStatus.ZMBP) 
			{
				mp.loop = false;
				mp.pivotX = mp.width/1.8;
				mp.pivotY = mp.width/1.2;
			}
			
			return mp;
		}
		
		/**
		 * 纹理 
		 * @return 
		 * 
		 */
		private var _sTextureAtlas:TextureAtlas;
		private function get textureAtlas() : TextureAtlas
		{
			if (!_sTextureAtlas)
			{
				var ba:ByteArray = _view.res.getAssetsObject(V.PUBLIC, V.PLAYER, GameConfig.PLAYER_RES, "Textures") as ByteArray;
				var texture:Texture = Texture.fromAtfData(ba);	
				var xml:XML = getXMLData(V.PLAYER, GameConfig.PLAYER_RES, "Player") as XML;			
				_sTextureAtlas = new TextureAtlas(texture, xml);
				/*ba.clear();
				ba = null;*/
			}
			
			return _sTextureAtlas;
		}
		
		private var _newTextureAtlas:TextureAtlas;
		private function get newTextureAtlas() : TextureAtlas
		{
			if (!_newTextureAtlas)
			{	
				var ba:ByteArray = _view.res.getAssetsObject(V.PUBLIC, V.PLAYER_NEW, GameConfig.PLAYER_NEW_RES, "Textures") as ByteArray;
				var texture:Texture = Texture.fromAtfData(ba);
				var xml:XML = getXMLData(V.PLAYER_NEW, GameConfig.PLAYER_NEW_RES, "PlayerNew") as XML;			
				_newTextureAtlas = new TextureAtlas(texture, xml);
				/*ba.clear();
				ba = null;*/
			}
			
			return _newTextureAtlas;
		}
		
		
		
		// 设置路径
		private var _curSingleLineInfo:SingleLineInfo;
		private var _roads:Vector.<Prop>;
		private var _useFreeDice:Boolean;
		public function get useFreeDice() : Boolean
		{
			return _useFreeDice;
		}
		private var _onlyOneWay:Boolean;
		public function setPath(info:SingleLineInfo, roads:Vector.<Prop>, useFreeDice:Boolean = false) : void
		{
			_curSingleLineInfo = info;
			_roads = roads;
			_useFreeDice = useFreeDice;
			_onlyOneWay = true;
			
			step_time = STEP_TIME;
			//if(_view.map.autoLevel) step_time = STEP_TIME_AUTO;

			if(_view.map.allowRain || _view.map.allowThunder) step_time = STEP_TIME_RAIN;
			if(_useFreeDice) step_time = STEP_TIME_DICE;
			
			checkOneWay();
			
			if(_useFreeDice)	checkFreeMove();
			else  checkMove();
		}
		private var nodePoint:Point;
		private function checkFreeMove() : void
		{
			if (!_curSingleLineInfo || _curSingleLineInfo.roadPoints.length == 0) 
			{
				setMove();
				return;
			}
			
			_isArrive = false;
			nodePoint = new Point();
			
			var lastNode:Vector.<Node> = new Vector.<Node>();
			
			var node:Vector.<Node> = new Vector.<Node>();
			var targetNode:Vector.<Node> = new Vector.<Node>();
			
			var nextNode:Vector.<Node> = new Vector.<Node>();
			var nextTargetNode:Vector.<Node> = new Vector.<Node>();
			
			if(_onlyOneWay)
			{
				while(_curSingleLineInfo.roadPoints.length > 0)
				{
					lastNode = _curSingleLineInfo.roadPoints.shift();
				}
				nodePoint.x = lastNode[0].preIndex.x;
				nodePoint.y = lastNode[0].preIndex.y;
				if(_curNode)
				{
					lastNode[0].preIndex.x =_curNode.curIndex.x;
					lastNode[0].preIndex.y =_curNode.curIndex.y;
				}
				targetNode = getNodes(lastNode);
				_curNode = targetNode[0];
				setMove();
			}
			else 
			{
				node = _curSingleLineInfo.roadPoints.shift();
				targetNode = getNodes(node);
				
				if (targetNode.length == 1)
				{
					_curNode = targetNode[0];
					if(_curSingleLineInfo.roadPoints.length != 0)
					{
						if(getNodes(_curSingleLineInfo.roadPoints[0]).length == 1)
						{
							checkFreeMove();
						}
						else
						{
							setMove();
						}
					}
					else
					{
						setMove();
					}
				}
				else 
				{
					if (!_curNode)
					{
						_curNode = new Node();
						_curNode.curIndex =  new Point((view as MapView).mapInfo.playerPosition.gx, (view as MapView).mapInfo.playerPosition.gy);
					}
					_curRole.alpha = 0.8;
					_view.map.oriented.setPosition(_curNode, targetNode, new Point(this.x, this.y), oriendtedCallback);	
				}
			}
		}
		
		private function checkOneWay() : void
		{
			for(var i:int = 0; i < _curSingleLineInfo.roadPoints.length; i++)
			{
				if(_curSingleLineInfo.roadPoints[i].length > 1)
				{
					_onlyOneWay = false;
					break;
				}
			}
		}
		
		/**
		 * 每帧调用 
		 * 
		 */		
		override public function update():void
		{
			super.update();

			handleState();
		}
		
		private function resetNode() : void
		{
			_curNode.preIndex.x = nodePoint.x;
			_curNode.preIndex.y = nodePoint.y;
		}
		
		/**
		 * 移动到目的地 
		 * isBlock @ 是否是中断行走（精英，boss）
		 */
		private function onComplete(isBlock:Boolean = false) : void
		{
			if (_curSingleLineInfo.roadPoints.length == 0)
			{
				_isArrive = true;
				if (view)
				{
					(view as MapView).mapInfo.playerPosition.gx = _curNode.curIndex.x;
					(view as MapView).mapInfo.playerPosition.gy = _curNode.curIndex.y;
				}
				if(_useFreeDice && _onlyOneWay) resetNode();
				onMoveCompleteSetStatus();
				_preNode = new Point(_curNode.preIndex.x, _curNode.preIndex.y);
				if(_playerShadow.parent)	_playerShadow.parent.removeChild(_playerShadow);
				this.dispatchEventWith(PlayerStatus.MOVE_COMPLETE, false, [_curNode, isBlock]);
			}
			else
			{
				this.dispatchEventWith(PlayerStatus.STEP_COMPLETE, false, {"node":_curNode, "callback":checkComplete});
				// 当碰到BOSS, 中断过程，回到开始
				function checkComplete(clear:Boolean = false) : void
				{
					if (!clear)
					{
						(view as MapView).mapInfo.playerPosition.gx = _curNode.curIndex.x;
						(view as MapView).mapInfo.playerPosition.gy = _curNode.curIndex.y;
						if(_useFreeDice)  checkFreeMove();
						else 	checkMove();
					}
					else
					{
						while (_curSingleLineInfo.roadPoints.length > 0)
						{
							_curSingleLineInfo.roadPoints.pop();
						}
						
						onComplete(true);
					}
				}
			}
		}
		
		/**
		 * 当 移动完毕设置角色站立状态
		 * 
		 */		
		private function onMoveCompleteSetStatus() : void
		{
			switch (_curState)
			{
				case PlayerStatus.BMZ:
				case PlayerStatus.BMH:
					State = PlayerStatus.BMDJ;
					break;
				case PlayerStatus.CMZ:
				case PlayerStatus.CMH:
					State = PlayerStatus.CMDJ;
					break;
				case PlayerStatus.ZMZ:
				case PlayerStatus.ZMH:
					State = PlayerStatus.ZMDJ;
					break;
			}
			//使用如意骰子时，设置人物待机方向
			if(_useFreeDice)
			{
				if(_curNode.curIndex.x == _curNode.preIndex.x && _curNode.curIndex.y >= _curNode.preIndex.y)
				{
					State = PlayerStatus.ZMDJ;
				}
				else if(_curNode.curIndex.x == _curNode.preIndex.x && _curNode.curIndex.y < _curNode.preIndex.y)
				{
					State = PlayerStatus.BMDJ;
				}
				else if(_curNode.curIndex.x >= _curNode.preIndex.x && _curNode.curIndex.y == _curNode.preIndex.y)
				{
					_curScaleX = 1;
					State = PlayerStatus.CMDJ;
				}
				else if(_curNode.curIndex.x < _curNode.preIndex.x && _curNode.curIndex.y == _curNode.preIndex.y)
				{
					_curScaleX = -1;
					State = PlayerStatus.CMDJ;
				}
			}
		}
		
		/**
		 * 检测下一格移动 
		 */		
		private var _isArrive:Boolean = true;
		private var _curNode:Node;
		private var _curPoint:Point = new Point();
		private function checkMove() : void
		{
			if (!_curSingleLineInfo || _curSingleLineInfo.roadPoints.length == 0) return;
			
			_isArrive = false;
			// 弹出一个路径
			var node:Vector.<Node> = _curSingleLineInfo.roadPoints.shift();
			var targetNode:Vector.<Node> = getNodes(node);
			
			targetNode = repeatPoint(targetNode);
			
			if (targetNode.length == 1)
			{
				_curNode = targetNode[0];
				setMove();
			}
			// 分叉路口
			else
			{
				if (!_curNode) 
				{
					_curNode = new Node();
					_curNode.curIndex =  new Point((view as MapView).mapInfo.playerPosition.gx, (view as MapView).mapInfo.playerPosition.gy);
				}
				//_curRole.alpha = 0.8;
				_view.map.oriented.setPosition(_curNode, targetNode, new Point(this.x, this.y), oriendtedCallback);	
			}

		}
		
		/**
		 * 删除重复的路点
		 * @param targetNode
		 * @return 
		 * 
		 */		
		private function repeatPoint(targetNode:Vector.<Node>) : Vector.<Node>
		{
			var resultList:Vector.<int> = new Vector.<int>();
			var resultNode:Vector.<Node> = targetNode;
			for(var i:int = resultNode.length - 1; i >= 0; i--)
			{
				for(var j:int = (i - 1); j >= 0; j--)
				{
					if(comparePoint(resultNode[i].curIndex, resultNode[j].curIndex) && comparePoint(resultNode[i].preIndex, resultNode[j].preIndex))
					{
						resultList.push(i);
						break;
					}
				}
			}
			
			for(var k:int = 0; k < resultList.length; k++)
			{
				resultNode.splice(resultList[k], 1);
			}
			
			return resultNode;
		}
		
		/**
		 * 比较重复的路点
		 * @param onePoint
		 * @param twoPoint
		 * @return 
		 * 
		 */		
		private function comparePoint(onePoint:Point, twoPoint:Point) : Boolean
		{
			var result:Boolean = false;
			if(onePoint.x == twoPoint.x && onePoint.y == twoPoint.y)
			{
				result = true;
			}
			return result;
		}
		
		private function oriendtedCallback(node:Node) : void
		{
			_curRole.alpha = 1;
			_curNode = node;
			if(_useFreeDice)
			{
				if(_curSingleLineInfo.roadPoints.length > 0 && getNodes(_curSingleLineInfo.roadPoints[0]).length > 1)
				{
					setMove()
				}
				else	checkFreeMove();
			}
			else 	setMove();
		}
		
		private function getNodes(BigNode:Vector.<Node>) : Vector.<Node>
		{
			var nodes:Vector.<Node> = new Vector.<Node>();
			
			for each(var item:Node in BigNode)
			{
				if (!_curNode || (item.preIndex.x == _curNode.curIndex.x && item.preIndex.y == _curNode.curIndex.y))
				{
					nodes.push(item);
				}
			}
			
			return nodes;
		}
		
		private function getNextNodes(BigNode:Vector.<Node>) : Vector.<Node>
		{
			var nodes:Vector.<Node> = new Vector.<Node>();
			
			return nodes;
		}
		
		// 移动
		private var _tween:Tween;
		private var _tweenJumpStart:Tween;
		private var _tweenJumpEnd:Tween;
		private function setMove() : void
		{
			if (!_curNode) return;
			
			setDirection((view as MapView).mapInfo.playerPosition.gx, (view as MapView).mapInfo.playerPosition.gy);
			
			if(!_useFreeDice)
			{
				_tween = new Tween(this, step_time);
				_tween.moveTo(
					_curNode.curIndex.x * (view as MapView).mapInfo.titleWidth + (view as MapView).mapInfo.titleWidth/2 + (view as MapView).mapInfo.mpx,
					_curNode.curIndex.y * (view as MapView).mapInfo.titleHeight + (view as MapView).mapInfo.titleHeight/2 + (view as MapView).mapInfo.mpy
				);
				_tween.onComplete = onComplete;
				
				view.juggle.add(_tween);
			}
			else 
			{
				jumpStart(_curNode.curIndex.x * (view as MapView).mapInfo.titleWidth + (view as MapView).mapInfo.titleWidth/2 + (view as MapView).mapInfo.mpx, 
					_curNode.curIndex.y * (view as MapView).mapInfo.titleHeight + (view as MapView).mapInfo.titleHeight/2 + (view as MapView).mapInfo.mpy);
			}
		}
		
		
		private function jumpStart(xPos:Number, yPos:Number, callbackFun:Function = null) : void
		{
			if(xPos == this.x && yPos == this.y)
			{
				if(callbackFun != null) callbackFun();
				else onComplete();
				return;
			}
			var newCallback:Function = new Function();
			if(callbackFun == null) newCallback = onComplete;
			else newCallback = callbackFun;
			
			var lastDistance:Number = Math.sqrt(Math.pow((this.x - xPos),2) + Math.pow((this.y - yPos), 2)) / 500 * step_time + .4;
			var bigHigh:Number = (yPos <= this.y ? yPos:this.y);
			var startTime:Number = JUMPOFFSET / (Math.abs(yPos - this.y) + JUMPOFFSET * 2) * lastDistance;
			if(yPos <=  this.y) startTime = lastDistance - startTime; 
			
			var xPosition:Number;
			if(xPos <= this.x)	xPosition  = xPos + (this.x - xPos) * (1 - startTime/lastDistance);
			else	xPosition = this.x + (xPos - this.x) * startTime/lastDistance;
			
			TweenMax.to(this, 
				lastDistance,
				{
					bezierThrough:[{x:xPosition, y:(bigHigh - JUMPOFFSET)},
						{x:xPos, y:yPos}], 
					ease:Linear.easeNone,
					onComplete:function () : void
					{
						if(_playerShadow && _playerShadow.parent)	_playerShadow.parent.removeChild(_playerShadow);
						newCallback();
					}
				});
			
			_playerShadow.x = this.x;
			_playerShadow.y = this.y;
			(view as MapView).mapLayers.mapLayer.addChild(_playerShadow);
			_tween = new Tween(_playerShadow, lastDistance);
			_tween.moveTo(
				xPos,
				yPos
			);
			view.juggle.add(_tween);
			return;
			/*
			_tweenJumpStart = new Tween(this, startTime);
			_tweenJumpStart.moveTo(
				xPosition,
				bigHigh - JUMPOFFSET
			);
			_tweenJumpStart.onComplete = jumpEnd;
			_tweenJumpStart.onCompleteArgs = [xPos, yPos, callbackFun, (lastDistance - startTime)];
			view.juggle.add(_tweenJumpStart);
			*/
			
			
		}
		
		/*private function jumpEnd(xPos:Number, yPos:Number, callback:Function, startTime:Number) : void
		{
			_tweenJumpEnd = new Tween(this, startTime);
			_tweenJumpEnd.moveTo(
				xPos,
				yPos
			);
			if(callback == null) _tweenJumpEnd.onComplete = onComplete;
			else _tweenJumpEnd.onComplete = callback;
			
			view.juggle.add(_tweenJumpEnd);
		}*/
		
		public function jumpTransmit(xPos:Number, yPos:Number, callback:Function) : void
		{
			setJumpDirection(xPos, yPos);
			jumpStart(xPos, yPos, callback);
		}
		
		public function flyTransmit(xPos:Number, yPos:Number, callback:Function = null) : void
		{
			jumpStart(xPos, yPos, callback);
		}
		
		private function setJumpDirection(xPos:Number, yPos:Number) : void
		{
			if (!_curNode) return;
			
			var curPoint:Point = MapUtils.getRoadPoint(_curNode.curIndex.x, _curNode.curIndex.y);
			
			// 左
			if (curPoint.x > xPos)
			{
				_curScaleX = -1;
				State = PlayerStatus.JUMP;
			}
			// 右
			else if (curPoint.x < xPos)
			{
				_curScaleX = 1;
				State = PlayerStatus.JUMP;
			}
			// 下
			else if (curPoint.y > yPos)
			{
				State = PlayerStatus.BMT;
			}
			// 上
			else if (curPoint.y < yPos)
			{
				State = PlayerStatus.ZMT;
			}
			else
			{
				//throw new Error("error");
			}
		}
		
		/**
		 * 设置人物方向 
		 * 
		 */		
		private function setDirection(xPos:Number, yPos:Number) : void
		{
			if (!_curNode) return;
			
			var curPoint:Point = new Point(xPos, yPos);
			
			//trace(curPoint.x, _curNode.curIndex.x, curPoint.y, _curNode.curIndex.y);
			
			// 左
			if (curPoint.x > _curNode.curIndex.x)
			{
				_curScaleX = -1;
				State = PlayerStatus.CMZ;
				if(_view.map.allowRain || _view.map.allowThunder) State = PlayerStatus.CMH;
				if(_useFreeDice) State = PlayerStatus.JUMP;
			}
			// 右
			else if (curPoint.x < _curNode.curIndex.x)
			{
				_curScaleX = 1;
				State = PlayerStatus.CMZ;
				if(_view.map.allowRain || _view.map.allowThunder) State = PlayerStatus.CMH;
				if(_useFreeDice) State = PlayerStatus.JUMP;
			}
			// 下
			else if (curPoint.y > _curNode.curIndex.y)
			{
				State = PlayerStatus.BMZ;
				if(_view.map.allowRain || _view.map.allowThunder) State = PlayerStatus.BMH;
				if(_useFreeDice) State = PlayerStatus.BMT;
			}
			// 上
			else if (curPoint.y < _curNode.curIndex.y)
			{
				State = PlayerStatus.ZMZ;
				if(_view.map.allowRain || _view.map.allowThunder) State = PlayerStatus.ZMH;
				if(_useFreeDice) State = PlayerStatus.ZMT;
			}
			else
			{
				//throw new Error("error");
			}
		}
		
		/**
		 * 处理状态 
		 * 
		 */
		private function handleState() : void
		{
			if (!_isChanged) return;
			
			removeFromStage(_curRole);
			
			_curRole = this._roleLibrary[_curState];
			addToStage(_curRole);
			addTitle();
			
			_curRole.scaleX = _curScaleX;
		}
		
		public function setStop() : void
		{
			_curRole.pause();
		}
		
		public function setPlay() : void
		{
			_roleLibrary[PlayerStatus.ZMBP].currentFrame = 0;
		}
		
		/*******************底层舞台操作*************************/
		
		private function removeFromStage(obj:DisplayObject) : void
		{
			if (!obj) return;
			
			if (obj.parent) obj.parent.removeChild(obj);
			
			if (obj is IAnimatable) view.juggle.remove(obj as IAnimatable);
		}
		
		private function addToStage(obj:DisplayObject) : void
		{
			if (!obj) return;
			
			if (!obj.parent) addChild(obj);
			
			if (obj is IAnimatable) view.juggle.add(obj as IAnimatable);
		}
		
		override public function removed() : void
		{
			if (view) view.juggle.remove(_curRole);
			
			super.removed();
		}
		
		protected function getXMLData(ModelName:String, SWFName:String, fileName:String) : XML
		{
			var xmlData:XML;
			var bytes:ByteArray = _view.res.getAssetsObject(V.PUBLIC, ModelName, SWFName, fileName) as ByteArray;
			xmlData = XML(bytes.toString());
			
			return xmlData;
		}
		
		public function clear() : void
		{
			for each(var mc:MovieClip in _roleLibrary)
			{
				mc.removeEventListeners();
				mc.texture.dispose();
				mc.dispose();
				mc = null;
			}
			
			if(_sTextureAtlas != null)
			{
				_sTextureAtlas.dispose();
				_sTextureAtlas = null;
			}
			if(_newTextureAtlas != null)
			{
				_newTextureAtlas.dispose();
				_newTextureAtlas = null;
			}
			
			_curRole.removeEventListeners();
			_curRole.dispose();
			_curRole = null;
			
			this.dispose();
		}
		
		/**
		 * 设置玩家播放速度
		 * @param speed
		 * 
		 */		
		public function setSpeed(speed:Number) : void
		{
			_roleLibrary[PlayerStatus.BMDJ].fps = PLAY_TIME * speed;
			_roleLibrary[PlayerStatus.BMZ].fps = PLAY_TIME * speed;
			_roleLibrary[PlayerStatus.CMDJ].fps = PLAY_TIME * speed;
			_roleLibrary[PlayerStatus.CMZ].fps = PLAY_TIME * speed;
			_roleLibrary[PlayerStatus.ZMZ].fps = PLAY_TIME * speed;
			_roleLibrary[PlayerStatus.ZMDJ].fps = PLAY_TIME * speed;
			
			step_time = STEP_TIME / speed;
		}
	}
}
package com.game.view.plugin
{
	import com.game.Data;
	import com.game.View;
	import com.game.manager.LayerManager;
	import com.game.template.GameConfig;
	import com.game.template.V;
	import com.game.view.Entity;
	import com.game.view.map.player.PlayerStatus;
	
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import starling.animation.IAnimatable;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class PlayerMC extends Entity
	{
		public static const LEFT:String = "LEFT";
		public static const RIGHT:String = "RIGHT";
		public static const QUICKLEFT:String = "QUICKLEFT";
		public static const QUICKRIGHT:String = "QUICKRIGHT";
		public static const BOMB:String = "BOMB";
		public static const STONE:String = "STONE";
		public static const BEER:String = "BEER";
		public static const RESET:String = "RESET";
		public static const DIE:String = "DIE";
		
		// 动画播放时间
		public static const PLAY_TIME:int = 10;
		
		// 人物y轴偏移
		public static const OFFSETY:int = 10;
		
		private var _view:View;
		// role库
		private var _roleLibrary:Object;
		// 当前role
		private var _curRole:MovieClip;
		private var _shadow:MovieClip;
		
		// 当前scale
		private var _curScaleX:int = 1;
		// 当前状态是否改变
		private var _isChanged:Boolean = false;
		
		private var _moveSpeedX:Number = 150;
		private var _moveSpeedXState:Number = 150;
		
		private var _jumpState:Boolean = false;
		public function get JumpState() : Boolean
		{
			return _jumpState;
		}
		private var _moveSpeedY:Number;
		private var _moveSpeedYState:Number = 15;
		
		// 当前状态
		private var _curState:String;
		private var _releaseState:int = 0;
		
		private static const GRAVITY:Number = 19.8;
		/**
		 * 玩家运动时间
		 */		
		private var _startTime:int;
		private var _intervalTime:int;
		/**
		 * 玩家跳起总共的时间
		 */		
		private var t:Number;
		/**
		 * 玩家挑起后经过的时间
		 */		
		private var _totalTime:Number = 0;
		/**
		 * 醉酒状态
		 */		
		private var _invertState:int = 1;
		public function get invertState() : int
		{
			return _invertState;
		}
		private var _bomState:Boolean = false;
		
		private var _preState:String;
		
		public function get curState() : String
		{
			return this._curState;
		}
		
		public function set State(state:String) : void
		{
			if (_curState != state)
			{
				_curState = state;
				_isChanged = true;
			}
		}
		
		public function PlayerMC(view:View, x:Number = 0, y:Number = 0, type:String = 'player')
		{
			_view = view;
			_roleLibrary = {};
			
			t = _moveSpeedYState / GRAVITY;
			
			super(x, y, type);
		}
		
		public function restart():void
		{
			_invertState = 1;
			_bomState = false;
			_moveSpeedX = _moveSpeedXState;
		}
		
		override public function added() : void
		{
			super.added();
			
			init();
			
			State = PlayerStatus.DJ;
		}
		
		private function init() : void
		{
			_roleLibrary[PlayerStatus.CMDJ] = getMovieClip(PlayerStatus.CMDJ, PLAY_TIME, 1);
			_roleLibrary[PlayerStatus.CMZ] = getMovieClip(PlayerStatus.CMZ, PLAY_TIME);
			_roleLibrary[PlayerStatus.DJ] = getMovieClip(PlayerStatus.DJ, PLAY_TIME, 1);
			_roleLibrary[PlayerStatus.PAO] = getMovieClip(PlayerStatus.PAO, PLAY_TIME, 3);
			_roleLibrary[PlayerStatus.JZ] = getMovieClip(PlayerStatus.JZ, PLAY_TIME, 2);
			_roleLibrary[PlayerStatus.JZP] = getMovieClip(PlayerStatus.JZP, PLAY_TIME, 3);
			_roleLibrary[PlayerStatus.JUMP] = getMovieClip(PlayerStatus.JUMP, PLAY_TIME, 3);
			_roleLibrary[PlayerStatus.BZ] = getMovieClip(PlayerStatus.BZ, PLAY_TIME, 3);
			_roleLibrary[PlayerStatus.YUN] = getMovieClip(PlayerStatus.YUN, PLAY_TIME, 4);
			_roleLibrary[PlayerStatus.SHADOW] = getMovieClip(PlayerStatus.SHADOW, PLAY_TIME, 3);
		}
		
		private function getMovieClip(name:String, fps:Number, isState:uint = 0) : MovieClip
		{
			var mp:MovieClip;
			
			var frames:Vector.<Texture>;
			if(Data.instance.player.player.mainRoleModel.nowUseFashion == "")
				frames = textureAtlas.getTextures(name);
			else
				frames = newTextureAtlas.getTextures(name);
			//var frames:Vector.<Texture> = textureAtlas.getTextures(name);
			mp = new MovieClip(frames, fps);
			
			//走路动画：2-1-2-3-4-5-4-3（可以直接接到待机动画的1）
			//待机动画：1-2-3-4-5-4-3-2

			if (isState == 0)
			{
				mp.addFrameAt(0, frames[1]);
				mp.addFrame(frames[3]);
				mp.addFrame(frames[2]);
			}
			else if(isState == 1)
			{
				mp.addFrame(frames[3]);
				mp.addFrame(frames[2]);
				mp.addFrame(frames[1]);
			}
			
			mp.pivotX = mp.width/2;
			mp.pivotY = mp.height - OFFSETY;
			
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
		
		override public function update() : void
		{
			super.update();
			
			handleState();
		}
		
		/**
		 * 设置人物方向 
		 * 
		 */		
		public function setDirection(dir:String) : void
		{
			switch(dir)
			{
				case "LEFT":
					if(_bomState) break;
					_curScaleX = -1;
					_releaseState = 1;
					_invertState == 1 ? State = PlayerStatus.CMZ:State = PlayerStatus.JZP;
					_jumpState ? State = PlayerStatus.JUMP:null;
					_preState = dir;
					break;
				case "QUICKLEFT":
					if(_bomState) break;
					_curScaleX = -1;
					_releaseState = 2;
					_invertState == 1 ? State = PlayerStatus.PAO:State = PlayerStatus.JZP;
					_jumpState ? State = PlayerStatus.JUMP:null;
					_preState = dir;
					break;
				case "RIGHT":
					if(_bomState) break;
					_curScaleX = 1;
					_releaseState = 1;
					_invertState == 1 ? State = PlayerStatus.CMZ:State = PlayerStatus.JZP;
					_jumpState ? State = PlayerStatus.JUMP:null;
					_preState = dir;
					break;
				case "QUICKRIGHT":
					if(_bomState) break;
					_curScaleX = 1;
					_releaseState = 2;
					_invertState == 1 ? State = PlayerStatus.PAO:State = PlayerStatus.JZP;
					_jumpState ? State = PlayerStatus.JUMP:null;
					_preState = dir;
					break;
				case "STONE":
					Starling.juggler.delayCall(resetMoveSpeedX, 3);
					_moveSpeedX = 0;
					_bomState = true;
					State = PlayerStatus.YUN;
					break;
				case "BOMB":
					Starling.juggler.delayCall(resetMoveSpeedX, 1);
					_moveSpeedX = 0;
					_curScaleX = 1;
					_bomState = true;
					State = PlayerStatus.BZ;
					break;
				case "BEER":
					_invertState = -_invertState;
					if(_bomState) break;
					_invertState == 1 ? State = PlayerStatus.DJ:State = PlayerStatus.JZ;
					_jumpState ? State = PlayerStatus.JUMP:null;
					_preState != null ? setDirection(changeState()):null;
					break;
				case "RESET":
					if(_bomState) break;
					_releaseState = 0;
					_invertState == 1 ? State = PlayerStatus.DJ:State = PlayerStatus.JZ;
					_jumpState ? State = PlayerStatus.JUMP:null;
					_preState = dir;
					break;
			}
		}
		
		private function changeState() : String
		{
			if(_preState == "QUICKLEFT")
			{
				return "QUICKRIGHT";
			}
			else if(_preState == "QUICKRIGHT")
			{
				return "QUICKLEFT";
			}
			else if(_preState == "LEFT")
			{
				return "RIGHT";
			}
			else if(_preState == "RIGHT")
			{
				return "LEFT";
			}
			else
			{
				return _preState;
			}
		}
		
		/**
		 * 玩家跳起
		 * 
		 */		
		public function setJump() : void
		{
			if(_jumpState || _bomState) return;
			_jumpState = true;
			_totalTime = 0;
			State = PlayerStatus.JUMP;
		}
		
		/**
		 * 晕眩状态结束
		 * 
		 */		
		private function resetMoveSpeedX() : void
		{
			_bomState = false;
			_moveSpeedX = _moveSpeedXState;
			setDirection("RESET");
		}
		
		/**
		 * 玩家移动循环函数
		 * @param e
		 * 
		 */		
		private function onFrameHandler(e:Event) : void
		{
			_intervalTime = getTimer() - _startTime;
			_startTime = getTimer();
			setMoveX(_intervalTime * .001);
			if(_jumpState) setMoveY(_intervalTime * .001);
		}
		
		/**
		 * 添加事件
		 * 
		 */		
		public function addEvent() : void
		{
			if(!this.hasEventListener(Event.ENTER_FRAME)) this.addEventListener(Event.ENTER_FRAME, onFrameHandler);
		}
		
		/**
		 * 删除事件
		 * 
		 */		
		public function removeEvent() : void
		{
			if(this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, onFrameHandler);
		}
		
		/**
		 * 人物X轴移动
		 * @param num
		 * 
		 */		
		public function setMoveX(num:Number) : void
		{
			this.x += _curScaleX * _moveSpeedX * num * _releaseState;
			positionLimitX();
		}
		
		/**
		 * 人物X轴范围限制
		 * 
		 */		
		private function positionLimitX() : void
		{
			if(_curState != PlayerStatus.DJ && _curState != PlayerStatus.JUMP && _curState != PlayerStatus.PAO && _curState!= PlayerStatus.JZ && _curState!= PlayerStatus.JZP && _curState!= PlayerStatus.BZ && _curState!= PlayerStatus.YUN)
			{
				if(this.x < this.width * .5)
				{
					this.x = this.width * .5;
				}
				else if( this.x > LayerManager.instance.width - this.width * .5)
				{
					this.x = LayerManager.instance.width - this.width * .5;
				}
			}
			else
			{
				if(this.x < this.width * .35)
				{
					this.x = this.width * .35;
				}
				else if(this.x > LayerManager.instance.width - this.width * .35)
				{
					this.x = LayerManager.instance.width - this.width * .35;
				}
			}
		}
		
		/**
		 * 人物Y轴移动
		 * @param num
		 * 
		 */		
		private function setMoveY(num:Number) : void
		{
			_totalTime += num;
			_moveSpeedY = _moveSpeedYState - GRAVITY * _totalTime;  
			if(_totalTime < t * 2 - .1)
			{
				this.y -= _moveSpeedY;
				positionLimitY();
			}
			else
			{
				_jumpState = false;
				this.y = LayerManager.instance.height - 40;
				setDirection(_preState);
			}
		}
		
		/**
		 * 人物Y轴范围限制
		 * @param num
		 * 
		 */		
		private function positionLimitY() : void
		{
			if(this.y > LayerManager.instance.height - 50)
			{
				this.y = LayerManager.instance.height - 50;
			}
		}
		
		private function handleState() : void
		{
			if (!_isChanged) return;
			
			removeFromStage(_curRole);
			
			_curRole = this._roleLibrary[_curState];
			addToStage(_curRole);
			
			_curRole.scaleX = _curScaleX;
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
		
	}
}
package com.game.view.endless
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.db.protocal.Endless;
	import com.game.data.fight.FightModelStructure;
	import com.game.data.fight.structure.Battle_EnemyModel;
	import com.game.data.fight.structure.Battle_WeModel;
	import com.game.data.fight.structure.DefendRoundData;
	import com.game.data.fight.structure.FightResult;
	import com.game.data.fight.structure.FightRound;
	import com.game.data.player.structure.RoleModel;
	import com.game.manager.DebugManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.effect.EffectShow;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.effect.FightEffectConfig;
	import com.game.view.fight.FightRoleComponent;
	
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.utils.getTimer;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class EndlessFightView extends BaseView implements IView
	{
		private var _modelStructure:FightModelStructure;
		public function EndlessFightView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.ENDLESS_FIGHT;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		private var _curLevel:int;
		public function get curLevel() : int
		{
			return _curLevel;
		}
		private var _curMonsterType:int;
		private var _callback:Function;
		private var _useProp:Boolean;
		private var _isQuitFight:Boolean;
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_curLevel = args[0];
					_curMonsterType = args[1];
					_callback = args[2];
					_view.fightEffect.interfaces();
					_useProp = false;
					this.show();
					break;
				case InterfaceTypes.INIT_FIGHT:
					initFight(args[0]);
					break;
				case InterfaceTypes.BEGIN_RUN:
					beginRun(args[0]);
					break;
				case InterfaceTypes.REFRESH:
					_view.fightEffect.interfaces();
					_useProp = true;
					this.show();
					break;
			}
		}
		
		override protected function init() : void
		{
			super.init();
			
			this.hide();
			initData();
			initXML();
			initTexture();
			initComponent();
			initUI();
			initEvent();
			
			playSound();
			beginFight();
		}
		
		private var _sound:Sound;
		private function playSound() : void
		{
			if (!_sound) _sound = getAssetsData(V.FIGHT, GameConfig.FIGHT_SOUND_RES) as Sound;
			_view.sound.playSound(_sound, V.FIGHT, true);			
		}
		
		private function initData() : void
		{
			_view.controller.fight.endlessFightData(_curLevel, _curMonsterType);
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			if (!_positionXML)
				_positionXML = this.getXMLData(V.FIGHT, GameConfig.FIGHT_RES, "EndlessFightPosition");
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
				var textureXML:XML = getXMLData(V.FIGHT, GameConfig.FIGHT_RES, "Fight");			
				obj = getAssetsObject(V.FIGHT, GameConfig.FIGHT_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
			}
		}
		
		private var _fightResultPanel:EndlessFightResultComponent;
		private var _speedMovieClip:MovieClip;
		private var _nowLv:TextField;
		private var _detail_1:TextField;
		private var _detail_2:TextField;
		private var _detail_3:TextField;
		private var _timeDetail:TextField;
		private var _lvDetail:TextField;
		private var _effectShow:EffectShow;
		private var _success:MovieClip;
		private var _victory:Image;
		private var _detailBg:Image;
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
			
			if (!_fightResultPanel)
			{
				var component:Component = this.searchOfCompoent("FightResult");
				_fightResultPanel = component.copy() as EndlessFightResultComponent;
				panel.addChild(_fightResultPanel.panel);
				_view.layer.setCenter(_fightResultPanel.panel);
				_fightResultPanel.hide();
			}
			
			_view.layer.setCenter(panel);
			
			//设置加速按钮
			if(!_speedMovieClip)
				_speedMovieClip = this.searchOf("Speed_Num");
			
			_mainRole = player.getRoleModel(V.MAIN_ROLE_NAME);
			_roleLv = _mainRole.model.lv;
			
			removeTouchable(this.searchOf("Reset_Button"));
			
			//加速按钮显示判断
			removeTouchable(this.searchOf("Speed_Mode"));
			if(DebugManager.instance.gameMode == V.DEVELOP)
				_view.world.allowChange = 3;
			else
				_view.world.allowChange = 1.5;
			_view.fightEffect.setSpeed();
			_speedMovieClip.currentFrame = 1;
			
			
			if(!_nowLv)
			{
				_nowLv = this.searchOf("NowLv") as TextField;
			}
			
			if(_curMonsterType == 1)
				_nowLv.text = "第" + _curLevel.toString() + "关";
			else 
				_nowLv.text = "隐藏关";
			
			if(!_effectShow)
			{
				_effectShow = new EffectShow(panel);
			}
			
			if(!_success)
			{
				var textures:Vector.<Texture> = _view.other_effect.interfaces(InterfaceTypes.GetTextures, "light");
				_success = new MovieClip(textures);
				_success.x = 230;
				_success.y = 0;
			}
			
			if(!_victory)
			{
				var victoryTexture:Texture = _titleTxAtlas.getTexture("VictoryImage");
				_victory = new Image(victoryTexture);
				_victory.x = 420;
				_victory.y = 155;
			}			
			
			if(!_detail_1)
				_detail_1 = this.searchOf("Detail_1") as TextField;
			
			if(!_detail_2)
				_detail_2 = this.searchOf("Detail_2") as TextField;
			
			if(!_detail_3)
				_detail_3 = this.searchOf("Detail_3") as TextField;
			
			if(!_timeDetail)
				_timeDetail = this.searchOf("TimeDetail") as TextField;
			
			if(!_lvDetail)
				_lvDetail = this.searchOf("LvDetail") as TextField;
			
			if(!_detailBg)
				_detailBg = this.searchOf("BossBg") as Image;
		}
		
		private var _mainRole:RoleModel;
		private var _roleLv:int;
		
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
						case "Player":
							cp = new FightRoleComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "FightResult":
							cp = new EndlessFightResultComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
					}
				}	
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "Close":
					this.hide();
					break;
				case "Return_Button":
					closeFight();
					break;
			}
		}
		
		private function closeFight() : void
		{
			isJuggler = false;
			_view.tip.interfaces(InterfaceTypes.Show,
				"退出就无法继续闯关，而且只能获得之前一关的奖励，是否确定退出？",
				comfireQuit, cancelQuit, false);
		}
		
		private function comfireQuit() : void
		{
			isJuggler = true;
			_fightProcessData = null;
			_fightResult = null;
			//juggle.purge();
			_fightResultPanel.quitEndless(_curLevel);
		}
		
		private function cancelQuit() : void
		{
			isJuggler = true;
		}

		
		private var endlessData:Object;
		/**
		 * 开始战斗 
		 * 
		 */
		protected function beginFight() : void
		{
			endlessData = Data.instance.db.interfaces(InterfaceTypes.GET_ENDLESS_BY_ID, _curLevel);
			_view.controller.fight.getEndlessInitFight(initFight);
		}
		
		private var _startTime:int;
		private var _endTime:int;
		private var _useTime:int;
		public function get useTime() : int
		{
			return _useTime;
		}
		public function startTimeCount() : void
		{
			_useTime = 0;
			_startTime = getTimer();
			_view.addToFrameProcessList("EndlessTime", countTime);
		}
		
		private var _intervalTime:int;
		private function countTime() : void
		{
			_intervalTime = int(endlessData.time - useTime * .001);
			_timeDetail.text = (_intervalTime < 0?0:_intervalTime).toString();
			_endTime = getTimer();
			_useTime += (_endTime - _startTime);
			_startTime = getTimer();
		}
		
		public function stopTimeCount() : Boolean
		{
			var result:Boolean = false;
			_view.removeFromFrameProcessList("EndlessTime");
			result = _view.controller.fight.countEndlessTime(_curLevel, _useTime);
			_useTime = 0;
			return result;
		}
		
		private function initFight(data:FightModelStructure) : void
		{
			_modelStructure = data;
			var meItem:Component;
			var enemyItem:Component;
			for(var i:int = 1; i <= 3; i++)
			{
				meItem = searchOf("my" + i);
				if (data.Me[i] && data.Me[i] is Battle_WeModel)
				{
					meItem.panel.visible = true;
					meItem.initRender((data.Me[i] as Battle_WeModel), V.ME);
				}
				else
				{
					meItem.panel.visible = false;
				}
				
				enemyItem = searchOf("enemy" + i);
				if (data.Enemy[i] && data.Enemy[i] is Battle_EnemyModel)
				{
					enemyItem.panel.visible = true;
					enemyItem.initRender((data.Enemy[i] as Battle_EnemyModel), V.ENEMY);
				}
				else
				{
					enemyItem.panel.visible = false;
				}
			}
		}
		
		public function setFightRoleStatus(IsAttacking:Boolean = false) : void
		{
			var meItem:FightRoleComponent;
			var enemyItem:FightRoleComponent;
			for(var i:int = 1; i <= 3; i++)
			{
				meItem = searchOf("my" + i);
				meItem.setOnAttack(false);
				enemyItem = searchOf("enemy" + i);
				enemyItem.setOnAttack(false);
			}
		}
		
		/**
		 * 开始播放战斗过程 
		 * @param data
		 * 
		 */
		private var _fightProcessData:Vector.<Vector.<FightRound>>;
		private var _fightResult:FightResult;
		private function beginRun(data:Object) : void
		{
			addTouchable(this.searchOf("Return_Button"));
			isJuggler = true;
			if((endlessData as Endless).time != 0 && _curMonsterType == 1)
			{
				_detail_1.visible = true;
				_detail_2.visible = true;
				_detail_3.visible = true;
				_detailBg.visible = true;
				_lvDetail.visible = true;
				_timeDetail.visible = true;
				_lvDetail.text = (_curLevel + 5).toString();
				_timeDetail.text = endlessData.time.toString();
				
				juggle.delayCall(startTimeCount, 1);
			}
			else
			{
				_detail_1.visible = false;
				_detail_2.visible = false;
				_detail_3.visible = false;
				_detailBg.visible = false;
				_lvDetail.visible = false;
				_timeDetail.visible = false;
			}
			
			this.display();
			
			_fightResultPanel.hide();
			
			_fightProcessData = data["process"];
			_fightResult = data["result"];
			
			PlayBigProcess();
		}

		private function PlayBigProcess() : void
		{
			if(_fightProcessData == null) return;
			// 播放结束
			if (_fightProcessData.length == 0)
			{
				//removeTouchable(this.searchOf("Return_Button"));
				Log.Trace("播放完毕!");
				if(_fightResult.result == V.WIN)
				{
					_effectShow.addShowObj(_success);
					_effectShow.start();
					this.panel.addChild(_victory);
					
					juggle.delayCall(lastCall, .8);
				}
				else if(_fightResult.result == V.LOSE)
				{
					_fightResultPanel.endlessResult(_fightResult, _curLevel, _modelStructure, _useProp);
				}
				return;
			}
			
			var bigProcess:Vector.<FightRound> = _fightProcessData.shift();
			
			PlaySmallProcess(bigProcess);
		}
		
		private function lastCall() : void
		{
			if(_victory.parent) _victory.parent.removeChild(_victory);
			_fightResultPanel.endlessResult(_fightResult, _curLevel, _modelStructure, _useProp);
		}
		
		private function PlaySmallProcess(process:Vector.<FightRound>) : void
		{
			if(_fightProcessData == null) return;
			//最后一个小回合开始后退出闯关按钮不可点
			if(_fightProcessData.length == 0 && process.length == 1)
				removeTouchable(this.searchOf("Return_Button"));
			
			// 小回合播放结束
			if (process.length == 0)
			{
				PlayBigProcess();
				return;
			}
			
			var fightRound:FightRound = process.shift();
			
			// 攻击者
			var attackItem:FightRoleComponent;
			
			if (fightRound.attack.position == V.ME)
			{		
				attackItem = searchOf("my" + fightRound.attack.index);
			}
			else
			{
				attackItem = searchOf("enemy" + fightRound.attack.index);
			}
			
			var defends:Vector.<FightRoleComponent> = new Vector.<FightRoleComponent>();
			// 被攻击者（有可能没有如攻击者处于晕阙 睡眠）
			if (fightRound.defend)
			{
				var defendItem:FightRoleComponent;
				
				for each(var defend:DefendRoundData in fightRound.defend)
				{
					if (defend.position == V.ME)
					{
						defendItem = searchOf("my" + defend.index);	
					}
					else
					{
						defendItem = searchOf("enemy" + defend.index);
					}
					
					defends.push(defendItem);
				}
			}
			
			_view.fightEffect.interfaces(FightEffectConfig.PLAY, fightRound, attackItem, defends, callback, V.ENDLESS_FIGHT);
			
			function callback() : void
			{
				//PlaySmallProcess(process);
				//延迟0.01秒避免Bug发生
				juggle.delayCall(PlaySmallProcess, .01, process);
			}
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
			if (type == "pack")
			{
				texture = getTextureFromSwf2(GameConfig.FIGHT_RES, name);
			}
			else if (type == "public")
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			
			return texture;
		}
		
		override protected function getTextureFromSwf2(swf:String, name:String, moduleName:String = "") : Texture
		{
			var texture:Texture;
			
			if (moduleName == "") moduleName = V.FIGHT;
			var bd:Bitmap = getAssetsObject(moduleName, swf, name) as Bitmap;
			texture = Texture.fromBitmap(bd as Bitmap);
			
			return texture;
		}
		
		/**
		 * 每帧调用 
		 * 
		 */
		override public function update():void
		{
			super.update();
		}
		
		override public function close():void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
package com.game.view.fight
{
	import com.engine.core.Log;
	import com.game.data.fight.CountFightManager;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.FightModelStructure;
	import com.game.data.fight.FightTypeData;
	import com.game.data.fight.structure.Battle_EnemyModel;
	import com.game.data.fight.structure.Battle_WeModel;
	import com.game.data.fight.structure.DefendRoundData;
	import com.game.data.fight.structure.FightConfigStructure;
	import com.game.data.fight.structure.FightResult;
	import com.game.data.fight.structure.FightRound;
	import com.game.data.fight.structure.SpecialEnemyData;
	import com.game.data.player.structure.RoleModel;
	import com.game.manager.LayerManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.Base;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.effect.FightEffectConfig;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.media.Sound;
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.GrayscaleFilter;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class FightView extends BaseView implements IView
	{
		
		// 当前场景
		private var _curLevel:String;
		public function get curLevel() : String
		{
			return _curLevel;
		}
		
		// 当前怪物种类
		private var _monsterType:String;
		public function get monsterType() : String
		{
			return _monsterType;
		}
		
		// 当前困难度
		private var _difficult:int;
		public function get difficult() : int
		{
			return _difficult;
		}
		
		private var _fightCompleteCallback:Function;
		
		public function FightView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.FIGHT;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					/*_view.world.allowSkip = _view.map.autoLevel;*/
					_curLevel = args[0];
					_monsterType = args[1];
					_difficult = args[2];
					_fightCompleteCallback = args.length >= 4 ? args[3] : null;
					_view.fightEffect.interfaces();
					checkDialog();
					break;
				case InterfaceTypes.INIT_FIGHT:
					initFight(args[0]);
					break;
				case InterfaceTypes.BEGIN_RUN:
					beginRun(args[0]);
					break;
				case InterfaceTypes.REFRESH:
					_view.fightEffect.interfaces();
					this.show();
					break;
			}
		}
		
		private function checkDialog() : void
		{
			switch (_monsterType)
			{
				// 精英怪
				case FightConfig.ECS_MONSTER:
					_view.dialog.interfaces(
						InterfaceTypes.Show,
						"level",
						_curLevel,
						"elite_front",
						show);
					break;
				// boss
				case FightConfig.BOSS_MONSTER:
					_view.dialog.interfaces(
						InterfaceTypes.Show,
						"level",
						_curLevel,
						"boss_front",
						show);
					break;
				default:
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
			/*if (_view.map.autoLevel) return;*/
			if (!_sound) _sound = getAssetsData(V.FIGHT, GameConfig.FIGHT_SOUND_RES) as Sound;
			_view.sound.playSound(_sound, V.FIGHT, true);			
		}
		
		private function initData() : void
		{
			_view.controller.fight.reqFightData(_curLevel, _difficult, _monsterType);
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			if (!_positionXML)
			{
				_positionXML = this.getXMLData(_loadBaseName, GameConfig.FIGHT_RES, "FightPosition");
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
				var textureXML:XML = getXMLData(_loadBaseName, GameConfig.FIGHT_RES, "Fight");			
				obj = getAssetsObject(_loadBaseName, GameConfig.FIGHT_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
			}
		}
		
		private var _fightResultPanel:FightResultComponent;
		private var _speedMovieClip:MovieClip;
		private var _speedButton:Button;
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
				_fightResultPanel = component.copy() as FightResultComponent;
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
			
			_speedButton = this.searchOf("Speed_Mode");
			
			//加速按钮显示判断
			if(_roleLv < 15)	_speedButton.filter = new GrayscaleFilter();
			else	_speedButton.filter = null;
			
			trace(_view.world.allowChange, _view.world.speedChange);
			_view.fightEffect.setSpeed();
			if(_view.world.allowChange == _view.world.speedChange)	_speedButton.filter = new GrayscaleFilter();
			else 	_speedButton.filter = null;
		}
		
		private var _mainRole:RoleModel;
		private var _roleLv:int;
		
		/**
		 * 战斗加速
		 * @param e
		 * 
		 */		
		private function addSpeed() : void	
		{
			if(_view.world.allowChange < _view.world.speedChange)
			{
				_view.world.allowChange += .5;
				_view.fightEffect.setSpeed();
				_speedMovieClip.currentFrame += 1;
				_view.prompEffect.play("当前加速" + _view.world.allowChange + "倍！");
				trace(_view.world.allowChange);
				if(_view.world.allowChange == _view.world.speedChange)	_speedButton.filter = new GrayscaleFilter();
			}
			else
			{
				if(_roleLv < 15)	_view.prompEffect.play("等级达到15级将开启1.5倍加速！");
				else if(_roleLv >= 15 && _roleLv < 40)		_view.prompEffect.play("已达到当前可加速的最大倍速！等级达到40级将开启2倍加速！");
				else	_view.prompEffect.play("已达到当前可加速的最大倍速！");
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
						case "Player":
							cp = new FightRoleComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "FightResult":
							cp = new FightResultComponent(items, _titleTxAtlas);
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
				case "Reset_Button":
					resetSpeed();
					break;
				case "Speed_Mode":
					addSpeed();
					break;
			}
		}
		
		/**
		 * 回到正常速度
		 * 
		 */		
		private function resetSpeed() : void
		{
			_view.world.allowChange = 1;
			_view.fightEffect.setSpeed();
			_speedMovieClip.currentFrame = 0;
			if(_roleLv < 15)	_speedButton.filter = new GrayscaleFilter();
			else	_speedButton.filter = null;
		}
		
		/**
		 * 开始战斗 
		 * 
		 */
		protected function beginFight() : void
		{
			_view.controller.fight.getInitFight(initFight);
		}
		
		private var _hasMoonCake:Boolean;
		private function initFight(data:FightModelStructure) : void
		{
			_hasMoonCake = false;
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
					
					Log.Trace("FightEnemy:" + (data.Enemy[i] as Battle_EnemyModel).enemyModel.name);
					if(data.Enemy[i] && (data.Enemy[i] as Battle_EnemyModel).enemyModel.name == V.MOON_ENEMY && SpecialEnemyData.isInMoonActivity())
						_hasMoonCake = true;
				}
				else
				{
					enemyItem.panel.visible = false;
				}
			}
			Log.Trace("Have MoonCake:" + _hasMoonCake);
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
			this.display();
			
			_fightResultPanel.hide();
			
			_fightProcessData = data["process"];
			_fightResult = data["result"];
			
			//跳过战斗
			/*if(_view.world.allowSkip)
			{
				showInfo(data);
				_fightResultPanel.showResult(_fightResult, _monsterType, _curLevel, _difficult, _fightCompleteCallback);
				return;
			}*/
			
			if(_view.first_guide.isFightStart)
			{
				_view.first_guide.callback = function () : void{_view.guide.showAccelerateGuide(PlayBigProcess);};
				_view.first_guide.setFunc();
				_view.first_guide.isFightStart = false;
			}
			else
			{
				PlayBigProcess();
			}
		}
		
		/**
		 * 跳过战斗的界面显示
		 * @param data
		 * 
		 */		
		private function showInfo(data:Object) : void
		{
			for(var j:int = 1; j <= 3; j++)
			{
				if(!(data.model.Me[j] is Battle_WeModel)) continue;
				(searchOf("my" + j) as FightRoleComponent).setLastHp(data.model.Me[j].countCharacterModel.hp);
				//(searchOf("my" + j) as FightRoleComponent).setLastMp(data.model.Me[j].countCharacterModel.mp);
			}
			for(var i:int = 1; i <= 3; i++)
			{
				if(!(data.model.Enemy[i] is Battle_EnemyModel)) continue;
				(searchOf("enemy" + i) as FightRoleComponent).setLastHp(data.model.Enemy[i].countEnemyModel.hp);
				//(searchOf("enemy" + i) as FightRoleComponent).setLastMp(data.model.Enemy[i].countEnemyModel.mp);
			}
		}
		
		private function PlayBigProcess() : void
		{
			// 播放结束
			if (_fightProcessData.length == 0)
			{
				Log.Trace("播放完毕!");
				
				_fightResultPanel.showResult(_fightResult, _monsterType, _curLevel, _difficult, _fightCompleteCallback, _hasMoonCake);
				return;
			}
			
			var bigProcess:Vector.<FightRound> = _fightProcessData.shift();
			
			
			PlaySmallProcess(bigProcess);
		}
		
		private function PlaySmallProcess(process:Vector.<FightRound>) : void
		{
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
			
			_view.fightEffect.interfaces(FightEffectConfig.PLAY, fightRound, attackItem, defends, callback);
			
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
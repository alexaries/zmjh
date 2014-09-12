package com.game.view.playerKilling
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
	import com.game.data.playerKilling.Battle_PlayerKillingModel;
	import com.game.data.playerKilling.PlayerKillingFightModelStructure;
	import com.game.data.save.RankSaveData;
	import com.game.manager.DebugManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.effect.EffectShow;
	import com.game.view.effect.FightEffectConfig;
	import com.game.view.fight.FightResultComponent;
	import com.game.view.fight.FightRoleComponent;
	
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.utils.getTimer;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class PlayerKillingFightView extends BaseView implements IView
	{
		private static const WIN_MONEY:int = 1500;
		private static const WIN_SOUL:int = 1500;
		private static const LOSE_MONEY:int = 500;
		private static const LOSE_SOUL:int = 500;
		
		private var _modelStructure:PlayerKillingFightModelStructure;
		public function PlayerKillingFightView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.ENDLESS_FIGHT;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		private var _rivalName:String;
		private var _rivalRank:int;
		private var _rivalUID:String;
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_rivalName = args[0];
					_rivalRank = args[1];
					_rivalUID = args[2];
					_view.fightEffect.interfaces();
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
			_view.controller.fight.playerKillingFightData();
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			if (!_positionXML)
				_positionXML = this.getXMLData(V.FIGHT, GameConfig.FIGHT_RES, "PlayerFightPosition");
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
		
		private var _nowAllowChange:Number;
		private var _fightResultPanel:PlayerKillingResultComponent;
		private var _speedMovieClip:MovieClip;
		private var _success:MovieClip;
		private var _victory:Image;
		private var _myUID:TextField;
		private var _enemyUID:TextField;
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
				_fightResultPanel = component.copy() as PlayerKillingResultComponent;
				panel.addChild(_fightResultPanel.panel);
				_view.layer.setCenter(_fightResultPanel.panel);
				_fightResultPanel.hide();
			}
			
			_nowAllowChange = _view.world.allowChange;
			
			//设置加速按钮
			if(!_speedMovieClip)
				_speedMovieClip = this.searchOf("Speed_Num");
			
			removeTouchable(this.searchOf("Reset_Button"));
			
			//加速按钮显示判断
			removeTouchable(this.searchOf("Speed_Mode"));
			_view.world.allowChange = 1.5;
			_view.fightEffect.setSpeed();
			_speedMovieClip.currentFrame = 1;
			
			_view.layer.setCenter(panel);

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
			
			_myUID = this.searchOf("MyUID");
			_enemyUID = this.searchOf("EnemyUID");
			
			_myUID.text = "UID:" + Data.instance.pay.userID;
			_enemyUID.text = "UID:" + _rivalUID;
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
							cp = new PlayerKillingResultComponent(items, _titleTxAtlas);
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
			}
		}
		
		/**
		 * 开始战斗 
		 * 
		 */
		protected function beginFight() : void
		{
			_view.controller.fight.getPlayerKillingInitFight(initFight);
		}
		
		private function initFight(data:PlayerKillingFightModelStructure) : void
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
				if (data.Enemy[i] && data.Enemy[i] is Battle_PlayerKillingModel)
				{
					enemyItem.panel.visible = true;
					enemyItem.initRender((data.Enemy[i] as Battle_PlayerKillingModel), V.ENEMY, true);
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
			_view.loadData.hide();
			
			this.display();
			
			_fightResultPanel.hide();
			
			_fightProcessData = data["process"];
			_fightResult = data["result"];
			
			if(DebugManager.instance.gameMode == V.RELEASE)
				savePKData();
			
			PlayBigProcess();
		}
		
		private var _isCheat:Boolean;
		public function get isCheat() : Boolean
		{
			return _isCheat;
		}
		private function savePKData() : void
		{
			if(_fightResult.result == V.WIN)
			{
				player.countFormationFighting();
				if(player.fightingNum <= player.maxFightingNum && player.fightingNum > 0)
				{
					var lastScore:int = _view.player_fight.rivalScore + 1;
					Data.instance.rank.submitCallback = null;
					RankSaveData.RankSave(Data.instance.rank.playerFightID, lastScore, player.getPlayerFightInfo());
					_view.player_fight.addFightContent(1, _rivalName, (_rivalRank - 1 <= 0?1:_rivalRank - 1));
					_isCheat = false;
				}
				else
					_isCheat = true;
				
				player.money += WIN_MONEY;
				player.fight_soul += WIN_SOUL;
			}
			else if(_fightResult.result == V.LOSE)
			{
				player.money += LOSE_MONEY;
				player.fight_soul += LOSE_SOUL;
				_view.player_fight.addFightContent(2, _rivalName, 0);
				_isCheat = false;
			}
			
			player.playerFightInfo.time = Data.instance.time.returnTimeNowStr();
			player.playerFightInfo.fightTime++;
			player.dailyThingInfo.checkPlayerFight();
			
			Log.Trace("竞技场PK数据保存");
			_view.controller.save.onCommonSave(false, 1, false);
			_view.controller.save.onSaveFighting();
		}
		
		private function PlayBigProcess() : void
		{
			// 播放结束
			if (_fightProcessData.length == 0)
			{
				_view.world.allowChange = _nowAllowChange;
				_nowAllowChange = NaN;
				Log.Trace("播放完毕!");
				_fightResultPanel.showResult(_fightResult);
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
			
			_view.fightEffect.interfaces(FightEffectConfig.PLAY, fightRound, attackItem, defends, callback, V.PLAYER_KILLING_FIGHT);
			
			function callback() : void
			{
				//PlaySmallProcess(process);
				//延迟0.01秒避免Bug发生
				Starling.juggler.delayCall(PlaySmallProcess, .01, process);
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
			bd.bitmapData.dispose();
			bd = null;
			
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
package com.game.view.worldBoss
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.DataList;
	import com.game.data.fight.CountFightManager;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.FightModelStructure;
	import com.game.data.fight.structure.Battle_EnemyModel;
	import com.game.data.fight.structure.Battle_WeModel;
	import com.game.data.fight.structure.DefendRoundData;
	import com.game.data.fight.structure.FightConfigStructure;
	import com.game.data.fight.structure.FightResult;
	import com.game.data.fight.structure.FightRound;
	import com.game.data.player.structure.RoleModel;
	import com.game.data.save.RankSaveData;
	import com.game.data.save.SubmitData;
	import com.game.manager.DebugManager;
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
	import com.game.view.fight.FightResultComponent;
	import com.game.view.fight.FightRoleComponent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.media.Sound;
	import flash.utils.getTimer;
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
	
	public class WorldBossFightView extends BaseView implements IView
	{
		public function WorldBossFightView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.BOSS_FIGHT;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
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
		
		private var _allHurt:int;
		private function initData() : void
		{
			_view.controller.fight.reqBossFightData();
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			if (!_positionXML)
			{
				_positionXML = this.getXMLData(V.FIGHT, GameConfig.FIGHT_RES, "WorldBossPosition");
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
				var textureXML:XML = getXMLData(V.FIGHT, GameConfig.FIGHT_RES, "Fight");			
				obj = getAssetsObject(V.FIGHT, GameConfig.FIGHT_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
			}
		}
		
		private var _fightResultPanel:WorldBossResultComponent;
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
				_fightResultPanel = component.copy() as WorldBossResultComponent;
				panel.addChild(_fightResultPanel.panel);
				_view.layer.setCenter(_fightResultPanel.panel);
				_fightResultPanel.hide();
			}
			
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
							cp = new WorldBossResultComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
					}
				}	
			}
		}
		
		/**
		 * 开始战斗 
		 * 
		 */
		protected function beginFight() : void
		{
			_view.controller.fight.getBossInitFight(initFight);
		}
		
		private var _modelStructure:FightModelStructure;
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
		private var _countDate:Date;
		private var _startTime:Number;
		private var _endTime:Number;
		private function beginRun(data:Object) : void
		{
			this.display();
			
			_fightResultPanel.hide();
			
			_fightProcessData = data["process"];
			_fightResult = data["result"];
			
			var process:Vector.<FightRound> = _fightProcessData[_fightProcessData.length - 1];
			
			_countDate = new Date(2013, 7, 21, 0, 0, 0);
			_startTime = getTimer();
			_view.addToFrameProcessList("countTime", countTime);
			
			PlayBigProcess();
		}
		
		private function countTime():void
		{
			_endTime = getTimer();
			_countDate.time += (_endTime - _startTime);
			_startTime = getTimer();
		}
		
		public function startSave() : void
		{
			_view.removeFromFrameProcessList("countTime");
			var isCheat:Boolean = false;
			var costTime:int = _countDate.hours * 3600 + _countDate.minutes * 60 + _countDate.seconds;
			var info:String = player.mainRoleModel.info.lv + "|" + costTime;
 			player.countFormationFighting();
			if(player.fightingNum > player.maxFightingNum || player.fightingNum < 0)
			{
				Log.Trace("战斗值数据异常，当前值为：" + player.fightingNum + " 理论最大值为：" + player.maxFightingNum);
				RankSaveData.RankSave(Data.instance.rank.testWorldBossID, _modelStructure.allHurt, info);
				isCheat = true;
			}
			else
			{
				Log.Trace("NowScore:" + _view.world_boss.nowScore + "  Hurt:" + _modelStructure.allHurt + "   NowTime:" +  costTime + "   BeforeTime:" + _view.world_boss.nowTime);
				//提交游戏分数
				//在排行榜上并且伤害大于之前的伤害 或者 不在排行榜上
				if((_view.world_boss.nowScore != 0 && _modelStructure.allHurt > _view.world_boss.nowScore) || (_view.world_boss.nowScore != 0 && _modelStructure.allHurt == _view.world_boss.nowScore && costTime < _view.world_boss.nowTime) || _view.world_boss.nowScore == 0)
				{
					Log.Trace("提交排名");
					Data.instance.rank.submitCallback = resetInterface;
					RankSaveData.RankSave(Data.instance.rank.worldBossID, _modelStructure.allHurt, info);
				}
				else
					resetInterface();
				
				RankSaveData.RankSave(Data.instance.rank.testWorldBossID, _modelStructure.allHurt, info);
				isCheat = false;
			}
			
			if(isCheat)
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"您的成绩正在提交审核中，请耐心等待。",
					null, null, false, true, false);
			}
			
			player.worldBossInfo.fightHurt = _modelStructure.allHurt;
			player.worldBossInfo.fightTime = costTime;
			
			//分配经验，战魂，金币
			_modelStructure.assignOtherTypeExp(_modelStructure.allHurt * DataList.littleList[35]);
			player.fight_soul += (_modelStructure.allHurt * (DataList.littleList[12] + .005));
			player.money += (_modelStructure.allHurt * (DataList.littleList[12] + .005));
			player.dailyThingInfo.setThingComplete(8);
			Log.Trace("真假小宝结束保存");
			_view.controller.save.onCommonSave(false, 1, false);
		}
		
		private function resetInterface(data:Array = null) : void
		{
			_view.world_boss.resetInterface(data);
		}
		
		private function PlayBigProcess() : void
		{
			// 播放结束 
			if (_fightProcessData.length == 0)
			{
				Log.Trace("播放完毕!");
				var info:String = Data.instance.pack.addUpgradeProp(2, false);
				startSave();
				_fightResultPanel.showResult(_modelStructure, info);
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
			
			_view.fightEffect.interfaces(FightEffectConfig.PLAY, fightRound, attackItem, defends, callback, V.BOSS_FIGHT);
			
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
			bd.bitmapData.dispose();
			bd = null;
			
			return texture;
		}
		
	}
}
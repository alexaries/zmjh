package com.game.view.LevelEvent
{
	import com.engine.core.Log;
	import com.engine.utils.Utilities;
	import com.game.data.db.protocal.Adventures;
	import com.game.data.fight.FightConfig;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.effect.EventEffectConfig;
	import com.game.view.effect.protocol.FightEffectConfigData;
	import com.game.view.effect.protocol.FightEffectPlayer;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class AdventuresView extends BaseView implements IView
	{
		public static const CHICKEN_ID:int = 2;
		public static const ADVENTURE_DELAY_TIME:int = 10;
		public var adventureDelayTime:int = 10;
		
		
		public function AdventuresView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.ADVENTURES;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		private var _type:String;
		private var _event:String;
		private var _curLevel:String;
		private var _kind:int;
		public function interfaces(type:String = "", ...args) : *
		{
			Log.Trace("Adventure Start!" + args + "---" + type);
			if (type == "") type = InterfaceTypes.Show;
			_view.eventEffect.interfaces();
			switch (type)
			{
				case InterfaceTypes.Show:
					_type = args[0];
					_curLevel = args[1];
					_kind = args[2];
					this.show();
					break;
				case InterfaceTypes.SPECIFIC_ADVENTURE:
					_type = args[0];
					_event = args[1];
					this.show();
					break;
			}
		}
		
		private function onPlaySpecial(specialName:String) : void
		{
			getSpecialAdventures(specialName);
			getPlayData();
			onPlay();
		}
		
		override protected function init():void
		{
			if (!isInit)
			{
				isInit = true;
				super.init();
				
				initUI();
				initData();
			}
			
			Log.Trace("Adventure Select!" + _type);
			switch (_type)
			{
				case AdventuresConfig.RANDOM:
					onRandom();
					break;
				case AdventuresConfig.SPECIAL:
					switch (_event)
					{
						case AdventuresConfig.CHICKEN_EVENT:
							onCheckChickenEvent();
							break;
						case AdventuresConfig.DOG:
							onDogEvent();
							break;
					}
					break;
			}
		}
		
		private function initUI() : void
		{
			
		}
		
		private function onCheckChickenEvent() : void
		{
			var num:int = player.pack.getPropNumById(CHICKEN_ID);
			
			if (num > 0)
			{
				_view.toolbar.interfaces(InterfaceTypes.LOCK);
				onPlaySpecial(_event);
				player.pack.setPropNum(num-1, CHICKEN_ID);
			}
			// 没有足够的数量
			else
			{
				_view.tip.interfaces(
					InterfaceTypes.Show,
					"没有足够的满汉全席，是否移步到商城购买？",
					gotoMall, returnThis);
				
				hide();
			}
		}
		
		private function returnThis() : void
		{
			_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
		}
		
		private function gotoMall() : void
		{
			_view.tip.hide();
			_view.shop.interfaces(InterfaceTypes.GET_MALL, "满汉全席", resetRender);
		}
		
		private function resetRender() : void
		{
			_view.tip.hide();
			_view.layer.setTipMaskHide();
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
		
		private function onDogEvent() : void
		{
			onPlaySpecial(_event);
		}
		
		private function onRandom() : void
		{
			getRandomAdventures();
			if(_curTargetAdventures.name == "恶犬袭击" || _curTargetAdventures.name == "叫花鸡")
			{
				Log.Trace("Adventure Main!" + _curTargetAdventures.name);
				getPlayData();
				onPlay();
			}
			else
			{
				Log.Trace("Adventure Other!");
				otherAdventure();
			}
			/*if(_view.map.autoLevel)	
			{
				_view.map.fightCount++;
				_view.auto_fight.addContent("第" + _view.map.fightCount + "波\n");
				onPlayComplete(null);
				_view.map.skipLevel();
			}
			else	*/
			
		}
		
		/**
		 * 其他奇遇事件
		 * 
		 */		
		private function otherAdventure() : void
		{
			Log.Trace("Adventure:" + _curTargetAdventures.name);
			switch(_curTargetAdventures.name)
			{
				case "战斗":
					_view.fight.interfaces(InterfaceTypes.Show, _curLevel, FightConfig.COMMON_MONSTER, _kind);
					break;
				case "金钱":
					_view.openItemBox.interfaces(InterfaceTypes.Show, _curLevel, V.MONEY_ITEMBOX, _kind);
					break;
				case "宝箱":
					_view.openItemBox.interfaces(InterfaceTypes.Show, _curLevel, V.EQUIP_ITEMBOX, _kind);
					break;
				case "宝袋":
					_view.openItemBox.interfaces(InterfaceTypes.Show, _curLevel, V.PROP_ITEMBOX, _kind);
					break;
				case "求签":
					if(_curLevel == "1_1" || _curLevel == "1_2" || _curLevel == "1_3")
					{
						_view.fight.interfaces(InterfaceTypes.Show, _curLevel, FightConfig.COMMON_MONSTER, _kind);
						break;
					}
					else
					{
						_view.weather.resetWeather();
						break;
					}
					break;
				default:
					_view.fight.interfaces(InterfaceTypes.Show, _curLevel, FightConfig.COMMON_MONSTER, _kind);
					break;
			}
			//_view.fight.interfaces(InterfaceTypes.Show, _curLevel, FightConfig.COMMON_MONSTER, _kind);
			//_view.weather.resetWeather();
			//_view.openItemBox.interfaces(InterfaceTypes.Show, _curLevel, V.EQUIP_ITEMBOX, _kind);
			//_view.openItemBox.interfaces(InterfaceTypes.Show, _curLevel, V.PROP_ITEMBOX, _kind);
			//_view.openItemBox.interfaces(InterfaceTypes.Show, _curLevel, V.MONEY_ITEMBOX, _kind);
		}
		
		private var _adventuresData:Vector.<Object>;
		private function initData() : void
		{
			_adventuresData = _view.controller.adventures.getAdventuresConfigData() as Vector.<Object>;
			
		}
		
		private var _curTargetAdventures:Adventures;
		private function getRandomAdventures() : void
		{
			var curRade:Number = 0;
			var random:Number = Math.random();
			for (var i:int = 0; i <　_adventuresData.length; i++)
			{
				var item:Adventures = _adventuresData[i] as Adventures;
				curRade += item.rate;
				
				if (random <= curRade)
				{
					_curTargetAdventures = item;
					break;
				}
			}
			
			if(_curTargetAdventures == null || i == _adventuresData.length)
			{
				Log.Trace("Adventures Lost");
				_curTargetAdventures = _adventuresData[0] as Adventures;
			}
		}
		
		private function getSpecialAdventures(adventuresName:String) : void
		{
			for (var i:int = 0; i <　_adventuresData.length; i++)
			{
				if ((_adventuresData[i] as Adventures).name == adventuresName)
				{
					_curTargetAdventures = _adventuresData[i] as Adventures;
					break;
				}
			}
			
			if (i == _adventuresData.length) throw new Error("error");
		}
		
		private var _playData:FightEffectConfigData;
		private function getPlayData() : void
		{
			if(_curTargetAdventures.name == "恶犬袭击" && player.roleFashionInfo.checkFashionUse(V.MAIN_ROLE_NAME) != "")
				_playData = _view.eventEffect.getEventEffectData("时装" +_curTargetAdventures.name);
			else
				_playData = _view.eventEffect.getEventEffectData(_curTargetAdventures.name);
		}
		
		private var _play:AdventuresEffectPlayer;
		private function onPlay() : void
		{
			if (!_play) _play = new AdventuresEffectPlayer();
			
			var texture_index:int = EventEffectConfig.TEXTURE_INDEX[_curTargetAdventures.name];
			var atlas:TextureAtlas = (texture_index == 2 ? _view.eventEffect.titleTxAtlas2 : _view.eventEffect.titleTxAtlas1);
			if(_curTargetAdventures.name == "恶犬袭击" && player.roleFashionInfo.checkFashionUse(V.MAIN_ROLE_NAME) != "")
				atlas = _view.eventEffect.titleTxAtlas3;
			_play.addEventListener(Event.COMPLETE, onPlayComplete);
			_play.initData(_playData, atlas, adventureDelayTime);
			panel.addChild(_play);
			_play.x = _playData.X;
			_play.y = _playData.Y;
		}
		
		private function onPlayComplete(e:Event) : void
		{
			countResult();
			this.hide();
			
			if(_view.first_guide.isGuide)
				_view.first_guide.setFunc();
		}
		
		private function countResult() : void
		{
			_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
			_view.controller.adventures.setRoleModelDataByAdventures(_curTargetAdventures);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			
			switch (_curTargetAdventures.name)
			{
				case AdventuresConfig.CHICKEN_EVENT:
					_view.prompEffect.play("所有角色体力增加30%");
					break;
				case AdventuresConfig.DOG:
					_view.prompEffect.play("所有角色体力减少20%");
					break;
			}
			_view.weather.setSun();
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
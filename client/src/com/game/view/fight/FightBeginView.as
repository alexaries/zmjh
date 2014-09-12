package com.game.view.fight
{
	import com.game.data.playerKilling.PlayerKillingFightBeginPlayer;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.fight.begin.FightBeginPlayData;
	import com.game.view.fight.begin.FightBeginPlayer;
	
	import starling.core.Starling;
	import starling.events.Event;

	public class FightBeginView extends BaseView implements IView
	{
		private var _data:Object;
		
		private var _effectData:FightBeginPlayData;
		
		private var _fightType:String;
		public function get fightType() : String
		{
			return _fightType;
		}
		
		public function FightBeginView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.FIGHT_BEGIN;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				
				case InterfaceTypes.Show:
					_data = args[0];
					_fightType = (args.length >= 2?args[1]:V.FIGHT);
					this.show();
					break;
			}
		}
		
		override protected function init() : void
		{
			super.init();
			
			initXML();
			initUI();
		}
		
		private var _positionXML:XML;
		protected function initXML() : void
		{
			if (!_positionXML)
			{
				_positionXML = getXMLData(V.FIGHT_EFFECT, GameConfig.FE_RES, "BeforePlay");
			}
			
			if (!_effectData)
			{
				_effectData = new FightBeginPlayData();
				_effectData.initData(_positionXML);
			}
		}
		
		private var _player:FightBeginPlayer;
		private var _playerKilling:PlayerKillingFightBeginPlayer;
		private function initUI() : void
		{
			if(_fightType == V.PLAYER_KILLING_FIGHT)
			{
				if(!_playerKilling)
				{
					_playerKilling = new PlayerKillingFightBeginPlayer();
					_playerKilling.initData(_effectData);
					panel.addChild(_playerKilling);
				}
				_playerKilling.addEventListener(FightBeginPlayer.COMPLETE, onComplete);
				_playerKilling.start(_data);
			}
			else
			{
				if (!_player)
				{
					_player = new FightBeginPlayer();
					_player.initData(_effectData);
					panel.addChild(_player);
				}
				_player.addEventListener(FightBeginPlayer.COMPLETE, onComplete);
				_player.start(_data);
			}
		}
		
		private function onComplete(e:Event = null) : void
		{
			if(_fightType == V.FIGHT)
				_view.fight.interfaces(InterfaceTypes.BEGIN_RUN, _data);
			else if(_fightType == V.ENDLESS_FIGHT)
				_view.endless_fight.interfaces(InterfaceTypes.BEGIN_RUN, _data);
			else if(_fightType == V.PLAYER_KILLING_FIGHT)
				_view.player_killing_fight.interfaces(InterfaceTypes.BEGIN_RUN, _data);
			else if(_fightType == V.BOSS_FIGHT)
				_view.boss_fight.interfaces(InterfaceTypes.BEGIN_RUN, _data);
			
			this.hide();
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
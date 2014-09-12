package com.game.manager
{
	import com.game.View;
	import com.game.data.player.structure.Player;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;

	public class BackStageManager
	{
		private var _player:Player;
		private var _view:View;
		
		public function BackStageManager(s : Singleton)
		{
			_view = View.instance;
			if (_instance != null)
			{
				throw new Error("DebugManager 是单例！");
			}
			initUI();
			_view.controller.player.reqPlayerData(initPlayer);
		}
		
		private function initPlayer() : void
		{
			_player = _view.controller.player.getPlayerData();
			inOutputPanel("骰子：" + _player.dice.toString());
			inOutputPanel("战魂：" + _player.fight_soul.toString());
			for(var i:uint = 0; i < _player.roles.length; i++)
			{
				inOutputPanel("角色：" + _player.roles[i].roleName);
				inOutputPanel("等级：" + _player.roles[i].lv);
				inOutputPanel("经验：" + _player.roles[i].exp);
				inOutputPanel("品质：" + _player.roles[i].quality);
			}
		}
		
		private var _panel:Sprite;
		private var _outPut:TextField;
		private function initUI() : void
		{
			_panel = new Sprite();
			LayerManager.instance.cpu_stage.addChild(_panel);
			
			_outPut = new TextField();
			_outPut.type = TextFieldType.DYNAMIC;
			_panel.addChild(_outPut);
			_outPut.width = 500;
			_outPut.height= 500; 
			_outPut.maxChars = 1000;
			_outPut.wordWrap = true;
			_outPut.background = true;
			_outPut.visible = false;
			_outPut.addEventListener(Event.CHANGE, onOutPutChange);
			_outPut.addEventListener(TextEvent.TEXT_INPUT, onOutPutChange);
			
			
			LayerManager.instance.cpu_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onOutPutChange(e:*) : void
		{
			_outPut.scrollV = _outPut.maxScrollV;
		}
		
		public function inOutputPanel(info:String) : void
		{
			_outPut.appendText("\n" + info);
			_outPut.scrollV = _outPut.maxScrollV;
		}
		
		private function onKeyUp(e:KeyboardEvent) : void
		{
			if(e.keyCode == Keyboard.F3)
			{
				//_outPut.visible = !_outPut.visible;
			}
		}
		
		private static var _instance : BackStageManager;
		public static function get instance () : BackStageManager
		{
			if (null == _instance)
			{
				_instance = new BackStageManager(new Singleton());
			}
			
			return _instance;
		}
	}
}

class Singleton {}
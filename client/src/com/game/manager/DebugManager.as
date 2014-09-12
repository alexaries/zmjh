package com.game.manager
{
	import com.engine.utils.Key;
	import com.engine.utils.Utilities;
	import com.game.template.V;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;

	public class DebugManager
	{
		/**
		 * 调试面板输出 
		 */
		private var _debugOutput:Function;
		public function get debugOutput() : Function
		{
			return _debugOutput;
		}
		public function set debugOutput(value:Function) : void
		{
			_debugOutput = value;
		}
		
		
		/**
		 * 战斗数值设定
		 */		
		public var fight:Object;
		
		// 目前版本是发布版本还是开发版本
		private var _mode:String;
		public function set gameMode(type:String) : void
		{
			if (type == V.DEVELOP) debugOutput = trace;
			_mode = type;
		}
		public function get gameMode() : String
		{
			return _mode;
		}
		
		private var _debug:Object;
		public function set debug(value:Object) : void
		{
			_debug = value;
			
			debugOutput = _debug["DebugOutput"];
			fight = _debug["Fight"];
		}
		
		public function DebugManager(s : Singleton)
		{
			if (_instance != null)
			{
				throw new Error("DebugManager 是单例！");
			}
			
			debugOutput = trace;
			fight = new Object();
			
			initUI();
		}
		
		private var _panel:Sprite;
		private var _outPut:TextField;
		protected function initUI() : void
		{
			_panel = new Sprite();
			LayerManager.instance.cpu_stage.addChild(_panel);
			
			_outPut = new TextField();
			_outPut.type = TextFieldType.INPUT;
			_panel.addChild(_outPut);
			_outPut.width = 300;
			_outPut.height= 500; 
			_outPut.maxChars = 1000;
			_outPut.wordWrap = true;
			_outPut.background = true;
			_outPut.visible = false;
			_outPut.addEventListener(Event.CHANGE, onOutPutChange);
			_outPut.addEventListener(TextEvent.TEXT_INPUT, onOutPutChange);
			debugOutput = inOutputPanel;
			
			_outPut.text = "begin";
			
			LayerManager.instance.cpu_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onOutPutChange(e:*) : void
		{
			_outPut.scrollV = _outPut.maxScrollV;
		}
		
		/**
		 * 开启或者释放面板 
		 * @param e
		 * 
		 */		
		private function onKeyUp(e:KeyboardEvent) : void
		{
			if (e.keyCode == Key.F2)
			{
				_outPut.visible = !_outPut.visible;
			}
		}
		
		public function inOutputPanel(info:String) : void
		{
			_outPut.appendText("\n" + info);
			_outPut.scrollV = _outPut.maxScrollV;
			/*if(_outPut.numLines>100){
				var m:int=_outPut.getLineOffset(1);
				_outPut.replaceText(0,m,"");
			}*/
		}
		
		private static var _instance : DebugManager;
		public static function get instance () : DebugManager
		{
			if (null == _instance)
			{
				_instance = new DebugManager(new Singleton());
			}
			
			return _instance;
		}
	}
}

class Singleton {}
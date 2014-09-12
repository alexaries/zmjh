package com.game.view.talk
{
	import com.engine.core.Log;
	import com.game.manager.LayerManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.dialog.Word;
	
	import flash.ui.Keyboard;
	
	import starling.display.Image;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class TalkView extends BaseView implements IView
	{
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		
		private var _curWordsData:Vector.<Word>;
		
		public function TalkView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.TALK;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			Log.Trace("Talk!" + type + "---" + args);
			switch (type)
			{
				case InterfaceTypes.Show:
					_curWordsData = args[0];
					show();
					break;
			}
		}
		
		private var _curFrame:int;
		override protected function init() : void
		{
			Log.Trace("Talk Init!");
			if (!isInit)
			{
				super.init();
				isInit = true;
				
				initXML();
				initComponent();
				initUI();
				getUI();
				
			}
			
			_curFrame = 0;
			play();
		}
		
		override protected function initEvent():void
		{
			this.panel.addEventListener(TouchEvent.TOUCH, onTouch);
			LayerManager.instance.gpu_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
		}
		
		
		/**
		 * 键盘按下
		 * 
		 * @param e	
		 * 
		 */		
		private function onKeyDowns(e:KeyboardEvent) : void
		{
			switch(e.keyCode)
			{
				case Keyboard.ENTER:
					_curFrame = _curWordsData.length;
					this.hide();
					_view.dialog.playDialog();
					break;
			}
		}
		
		override protected function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this.panel);
			
			if (touch && touch.phase == TouchPhase.ENDED)
			{
				play();
			}
		}
		
		private function play() : void
		{
			initEvent();
			// 播放完毕
			if (_curWordsData.length == _curFrame)
			{
				this.hide();
				_view.dialog.playDialog();
				Log.Trace("Talk Complete!");
			}
			else
			{
				Log.Trace("Talk Play!" + _curFrame);
				// left
				switch (_curWordsData[_curFrame].position)
				{
					case LEFT:
						_left.start(_curWordsData[_curFrame]);
						_right.hide();
						break;
					case RIGHT:
						_left.hide();
						_right.start(_curWordsData[_curFrame]);
						break;
				}
				
				_curFrame++;
			}
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.DIALOG, GameConfig.DIALOG_RES, "TalkPosition");
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
						case "LeftTalk":
							cp = new LeftTalkComponent(items, _view.dialog.TxAtlas1);
							_components.push(cp);
							break;
						case "RightTalk":
							cp = new RightTalkComponent(items, _view.dialog.TxAtlas1);
							_components.push(cp);
							break;
					}
				}
			}
		}
		
		private function initUI() : void
		{
			setMask();
			
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
		}
		
		// 設置遮罩层
		private var _mask:Image;
		private function setMask() : void
		{
			if(_mask == null)
			{
				_mask = new Image(_view.layer.maskTexture);
				_mask.alpha = 0.4;
				panel.addChildAt(_mask, 0);
			}
		}
		
		private var _left:LeftTalkComponent;
		private var _right:RightTalkComponent;
		private function getUI() : void
		{
			_left = this.searchOf("LeftTalk");
			_right = this.searchOf("RightTalk");
		}
		
		override public function hide():void{
			this.panel.removeEventListener(TouchEvent.TOUCH, onTouch);
			LayerManager.instance.gpu_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
			super.hide();
		}
	}
}
package com.game.view.tip
{
	import com.engine.core.Log;
	import com.game.manager.LayerManager;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import flash.ui.Keyboard;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class GameTipComponent extends Component
	{
		public function GameTipComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
			initEvent();
			
		}
		
		private var _contentTF:TextField;
		private var _okBtn:Button;
		private var _cancelBtn:Button;
		private var _position:int;
		private function getUI() : void
		{
			_contentTF = this.searchOf("TipWord");
			_okBtn = this.searchOf("OkBt");
			_cancelBtn = this.searchOf("Cancel");
			if(_view.tip.positionXML == null)
				_position = 0;
			else
				_position = (int(_view.tip.positionXML.component.Items.layer.item[1].@x) + int(_view.tip.positionXML.component.Items.layer.item[2].@x)) * .5;
		}
		
		private var _content:String;
		private var _okCB:Function;
		private var _cancelCB:Function;
		// 是否终止游戏
		private var _isStop:Boolean;
		private var _okVisible:Boolean;
		private var _cancelVisible:Boolean;
		public function showTip(content:String, OkCallback:Function, CancelCallback:Function, isStop:Boolean, OkVisible:Boolean, CancelVisible:Boolean) : void
		{
			this.display();
			
			_content = content;
			_okCB = OkCallback;
			_cancelCB = CancelCallback;
			_isStop = isStop;
			_okVisible = OkVisible;
			_cancelVisible = CancelVisible;
			
			_contentTF.text = content;
			
			LayerManager.instance.gpu_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
			//_okBtn.visible = _cancelBtn.visible = !_isStop;
			
			if(_okVisible)
			{
				_okBtn.visible = true;
				_cancelBtn.x = _view.tip.positionXML.component.Items.layer.item[2].@x;
			}
			else
			{
				_okBtn.visible = false;
				_cancelBtn.x = _position;
			}
			
			if(_cancelVisible)
			{
				_cancelBtn.visible = true;
				_okBtn.x = _view.tip.positionXML.component.Items.layer.item[1].@x;
			}
			else
			{
				_cancelBtn.visible = false;
				_okBtn.x = _position;
			}
			
			if(_isStop)
			{
				_cancelBtn.visible = false;
				_okBtn.visible = false;
			}
			
		}
		
		/**
		 * 键盘侦听，回车确定，ESC取消
		 * 
		 * @param e
		 * 
		 */		
		private function onKeyDowns(e:KeyboardEvent) : void
		{
			
			switch(e.keyCode)  
			{
				case Keyboard.ENTER:
					if (_okCB != null && _okBtn.visible) {
						Starling.juggler.delayCall(_okCB, .01);
						Log.Trace("确定退出");
						hide();	
					}else if (_okCB == null && _okBtn.visible){
						Log.Trace("确定退出无回调");
						hide();	
					}
	

					break;
				case Keyboard.ESCAPE:
					if (_cancelCB != null && _cancelBtn.visible){
						Starling.juggler.delayCall(_cancelCB, .01);
						Log.Trace("取消退出");
						hide();
					}else if (_cancelCB == null && _cancelBtn.visible){
						Log.Trace("取消退出无回调");
						hide();	
					}
				
					break;
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				// 确认
				case "OkBt":
					if (_okCB != null) Starling.juggler.delayCall(_okCB, .01);
					hide();
					break;
				// 取消
				case "Cancel":
					if (_cancelCB != null) Starling.juggler.delayCall(_cancelCB, .01);
					hide();
					break;
			}
		}
		
		
		override public function hide():void
		{
			super.hide();
			LayerManager.instance.gpu_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
			_view.tip.hide();
		}
		
		public function setAccelerate(content:String) : void
		{
			this.display();
			_contentTF.text = content;
			_okBtn.visible = false;
			_cancelBtn.visible = false;
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new GameTipComponent(_configXML, _titleTxAtlas);
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			super.destroy();
		}
	}
}
package com.game.view.cartoon
{
	import com.engine.core.Log;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.save.SaveConfig;
	
	import flash.display.BitmapData;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class CartoonView extends BaseView implements IView
	{
		private var _cartoonType:String;
		private var _mask:Image;
		private var _newPlayer:CartoonPlay;
		private var _hideLV:CartoonPlay;
		private var _endBoss:CartoonPlay;
		private var _firstInit:Boolean;
		
		public function CartoonView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.CARTOON;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			Log.Trace("Cartoon Show!" + type + "---" + args);
			switch (type)
			{
				case InterfaceTypes.Show:
					_cartoonType = args[0];
					_firstInit = false;
					show();
					break;
				case InterfaceTypes.INIT:
					_firstInit = true;
					show();
					break;
			}
		}
		
		override protected function init():void
		{
			Log.Trace("Cartoon Init!");
			if (!isInit)
			{
				super.init();
				isInit = true;
			}
			
			if(_firstInit)
				return;
			
			initRender();
			
			Log.Trace("Cartoon Select!" + _cartoonType);
			switch (_cartoonType)
			{
				case CartoonConfig.NEW_PLAYER_START:
					onNewPlayerStart();
					break;
				case CartoonConfig.HIDE_LEVEL:
					onHideLVStart();
					break;
				case CartoonConfig.END_BOSS:
					onEndBossStart();
					break;
			}
		}
		
		private function initRender() : void
		{
			Log.Trace("Cartoon Render!");
			
			var textures:Vector.<Texture>;
			
			if (!_newPlayer)
			{
				textures = _view.dialog.TxAtlas1.getTextures("Start");
				_newPlayer = new CartoonPlay(textures);
				panel.addChild(_newPlayer);
			}
			
			if (!_hideLV)
			{
				textures = _view.dialog.TxAtlas2.getTextures("Hide");
				_hideLV = new CartoonPlay(textures);
				panel.addChild(_hideLV);
			}
			
			if (!_endBoss)
			{
				textures = _view.dialog.TxAtlas2.getTextures("End");
				_endBoss = new CartoonPlay(textures);
				panel.addChild(_endBoss);
			}
			
			_mask = new Image(_view.layer.maskTexture);
			panel.addChildAt(_mask, 0);
		}
		
		/**
		 * 新玩家 
		 * 
		 */		
		private function onNewPlayerStart() : void
		{
			Log.Trace("Cartoon NewPlayer!");
			_newPlayer.addEventListener(CartoonPlay.COMPLETE, onNewPlayerComplete);
			_newPlayer.start();
		}
		
		private function onNewPlayerComplete(e:Event) : void
		{
			Log.Trace("Cartoon NewPlayer Complete!");
			_newPlayer.clear();
			_view.dialog.playDialog();
			this.close();
		}
		
		/**
		 *  隐藏关卡
		 * 
		 */		
		private function onHideLVStart() : void
		{
			Log.Trace("Cartoon HideLV!");
			_hideLV.addEventListener(CartoonPlay.COMPLETE, onHideLVStartComplete);
			_hideLV.start();
		}
		
		private function onHideLVStartComplete() : void
		{
			Log.Trace("Cartoon HideLV Complete!");
			_hideLV.clear();
			_view.dialog.playDialog();
			this.close();
		}
		
		
		private var _commonDelay:DelayedCall;
		/**
		 * 4-4隐藏地图最终BOSS 
		 * 
		 */		
		private function onEndBossStart() : void
		{
			Log.Trace("Cartoon EndBoss Start!");
			_endBoss.addEventListener(CartoonPlay.COMPLETE, onEndBossComplete);
			_endBoss.start();
			_commonDelay = Starling.juggler.delayCall(onEndBossComplete, 5);
		}
		
		private function onEndBossComplete() : void
		{
			Log.Trace("Cartoon EndBoss End!");
			if(_commonDelay) 
				Starling.juggler.remove(_commonDelay);
			_endBoss.clear();
			_view.dialog.playDialog();
			this.close();
		}
		
		override public function close():void
		{
			Log.Trace("Cartoon Close!");
			_mask.dispose();
			_newPlayer = null;
			_hideLV = null;
			_endBoss = null;
			
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
package com.game.view.dice
{
	import com.engine.core.Log;
	import com.engine.event.EventTypes;
	import com.game.manager.LayerManager;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.Base;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import starling.display.Button;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class DiceView extends Base implements IView
	{
		
		public function DiceView()
		{
			_moduleName = V.TIP;
			_layer = LayerTypes.TOP;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch (type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
				case InterfaceTypes.RANDOM_DICE:
					onDiceClick(args[0]);
					break;
				case InterfaceTypes.AUTO_DICE:
					onAutoDice(args[0]);
					break;
				case InterfaceTypes.COMFIRE_DICE:
					onComfireDice();
					break;
			}
		}
		
		override protected function init() : void
		{
			if (!isInit)
			{
				isInit = true;
				super.init();
				
				initUI();
				initEvent();
			}
		}
		
		private function initUI() : void
		{
			initTexture(); 
			initRender();
		}
		
		private var _diceRunTextures:Vector.<Texture>;
		private var _diceStandTextures:Vector.<Texture>;
		private var _diceBtnTexture:Texture;
		private function initTexture() : void
		{
			_diceRunTextures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, "dice_run_");
			_diceStandTextures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, "dice_");
			_diceBtnTexture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, "DiceBtn_1");;
		}
		
		private var _diceRun:DiceEntity;
		private var _diceBtn:Button;
		private function initRender() : void
		{
			_diceRun = new DiceEntity(_diceRunTextures, _diceStandTextures, _view.layer.width/2, _view.layer.height/2);
			this.add(_diceRun);
			panel.addChild(_diceRun);
			
			this.hide();
		}
		
		private function onComfireDice() : void
		{
			player.dice -= 1;
			_view.toolbar.interfaces(InterfaceTypes.LOCK);
			if (!_diceRun.isPlay) 
			{
				this.display();
				_diceRun.curRandomPoint = 5;
				_diceRun.isPlay = true;
			}
		}
		
		private var _setTbarDiceStatus:Function;
		private function onDiceClick(callback:Function) : void
		{
			_setTbarDiceStatus = callback;

			if (player.dice > 0)
			{
				// 扣除色子个数
				player.dice -= 1;
				_view.toolbar.interfaces(InterfaceTypes.LOCK);
				if (!_diceRun.isPlay) 
				{
					this.display();
					_diceRun.curRandomPoint = Math.random() * 6;
					_diceRun.isPlay = true;
				}
			}
			else
			{
				_view.tip.interfaces(
					InterfaceTypes.Show,
					"您现在的骰子不足，如果还想继续游戏的话，可以按确定去购买骰子。提示：您还可以随时点骰子旁边的加号来购买骰子哦。",
					function () : void
					{
						_view.buy_dice.interfaces();
					},
					returnThis);
			}
		}
		
		private function returnThis() : void
		{
			_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
		}
		
		/**
		 * 自动扔骰子
		 * @param callback
		 * 
		 */		
		private function onAutoDice(callback:Function) : void
		{
			_setTbarDiceStatus = callback;
			if (player.dice > 0)
			{
				// 扣除色子个数
				player.dice -= 1;
				_diceRun.curRandomPoint = Math.random() * 6;
				_diceRun.checkAuto();
				//_diceRun.isPlay = false;
			}
			else
			{
				_view.tip.interfaces(
					InterfaceTypes.Show,
					"您现在的骰子不足，如果还想继续游戏的话，可以按确定去购买骰子。提示：您还可以随时点骰子旁边的加号来购买骰子哦。",
					function () : void
					{
						_view.buy_dice.interfaces();
					},
					leaveLevel);
			}
		}
		
		private function leaveLevel() : void
		{
			_view.toolbar.onComeBack();
			_view.auto_fight.hide();
		}
		
		override protected function initEvent() : void
		{
			super.initEvent();
			
			_diceRun.addEventListener(EventTypes.DICE_STOP, onDiceStop);
		}
		
		private function onDiceStop(e:Event) : void
		{
			var info:String = "当前骰子点数：" + e.data;
			Log.Trace(info);
			_view.map.interfaces(InterfaceTypes.THROW_DICE_RESULT, e.data);
			
			this.hide();
		}
		
		override public function update() : void
		{
			super.update();
		}
		
		override public function close() : void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
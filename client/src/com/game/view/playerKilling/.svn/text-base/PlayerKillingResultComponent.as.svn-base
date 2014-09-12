package com.game.view.playerKilling
{
	import com.game.data.fight.structure.FightResult;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class PlayerKillingResultComponent extends Component
	{
		
		public function PlayerKillingResultComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
		}
		
		private var _winImage:Image;
		private var _loseImage:Image;
		private var _money:TextField;
		private var _soul:TextField;
		public function initUI() : void
		{
			if (!_winImage) _winImage = searchOf("VictoryImage");
			if (!_loseImage) _loseImage = searchOf("FailImage");
			if (!_money) _money = searchOf("Tx_Money");
			_money.fontName = "宋体";
			_money.bold = true;
			if (!_soul) _soul = searchOf("Tx_FihgtSoul");
			_soul.fontName = "宋体";
			_soul.bold = true;
			
			_view.layer.setCenter(panel);
		}
		
		private var _callback:Function;
		private var _fightResult:FightResult;
		public function showResult(result:FightResult, callback:Function = null):void
		{
			_callback = callback;
			_fightResult = result;
			
			initUI();
			initEvent();
			display();
			
			render();
		}
		
		private function render() : void
		{
			
			_winImage.visible = (_fightResult.result == V.WIN);
			_loseImage.visible = (_fightResult.result == V.LOSE);
			
			switch (_fightResult.result)
			{
				case V.WIN:
					_money.text = "+ 1500";
					_soul.text = "+ 1500";
					break;
				case V.LOSE:
					_money.text = "+ 500";
					_soul.text = "+ 500";
					break;
			}
			
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "OkButton":
					onWin();
					break;
			}
		}
		
		private function onWin() : void
		{
			this.hide();
			_view.player_killing_fight.hide();
			_view.world.interfaces(InterfaceTypes.REFRESH);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.checkPlayerFight();
			_view.player_fight.interfaces();
			if(_view.player_killing_fight.isCheat)
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"您的成绩正在提交审核中，请耐心等待。",
					null, null, false, true, false);
			}
		}
		
		private function onLose() : void
		{
			this.hide();
			_view.player_killing_fight.hide();
			_view.world.interfaces(InterfaceTypes.REFRESH);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.checkPlayerFight();
			_view.player_fight.interfaces();
		}
		
		override public function copy() : Component
		{
			return new PlayerKillingResultComponent(_configXML, _titleTxAtlas);
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
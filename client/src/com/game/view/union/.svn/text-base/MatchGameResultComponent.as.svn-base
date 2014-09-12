package com.game.view.union
{
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;
	
	public class MatchGameResultComponent extends Component
	{
		public function MatchGameResultComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
		}
		
		private var _isWined:Boolean;
		private var _callBack:Function;
		private var _reward:int;
		
		private var _winImage:Image;
		private var _loseImage:Image;

		private var _forceTxt:TextField;
		public function initUI() : void
		{
			if (!_winImage) _winImage = searchOf("VictoryImage");
			if (!_loseImage) _loseImage = searchOf("FailImage");
			if (!_forceTxt) _forceTxt = searchOf("forceTxt");
			_view.layer.setCenter(panel);
		}
		
		public function showResult(callBack:Function,iswined:Boolean,reward:int) : void
		{
			_callBack = callBack;
			_isWined = iswined;
			_reward = reward;
			initUI();
			initEvent();
			display();
			render();
		}
		
		private function render() : void
		{
			_winImage.visible = _isWined;
			_loseImage.visible = !_isWined;
			if(_isWined){
				_forceTxt.text = "修为 +" + _reward.toString() ;
			}else{
				_forceTxt.text = "挑战失败..." ;	
			}
			
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "OkButton":
					closeView();
					break;
			}
		}
		
		private function closeView() : void
		{
			_view.match_game.hide();
			this.hide();
			_callBack(_isWined);
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new MatchGameResultComponent(_configXML, _titleTxAtlas);
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
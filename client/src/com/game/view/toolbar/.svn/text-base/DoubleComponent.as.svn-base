package com.game.view.toolbar
{
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;
	
	public class DoubleComponent extends Component
	{
		public function DoubleComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
			initEvent();
		}
		
		private var _doubleLevelTxt:TextField;
		public function get doubleLevelTxt() : TextField
		{
			return _doubleLevelTxt;
		}
		private var _doubleLevelBtn:Button;
		public function get doubleLevelBtn() : Button
		{
			return _doubleLevelBtn;
		}
		private var _doubleLevelBg:Image;
		private function getUI():void
		{
			_doubleLevelTxt = this.searchOf("DoubleLevelText");
			_doubleLevelBtn = this.searchOf("DoubleLevelBtn");
			_doubleLevelBg = this.searchOf("DoubleLevelBg");
		}
		
		public function checkDoubleLevelBtn() : void
		{
			if(_view.toolbar.status == "world")
			{
				_doubleLevelBtn.touchable = true;
				if(!isNaN(_view.double_level.intervalTime) && _view.double_level.intervalTime < 60 * 60 * 1000)
				{
					_view.toolbar.checkStretchShow(5, "双倍副本可进入");
					_view.toolbar.deformTip.addNewDeform(doubleLevelBtn, "DoubleLevel");
				}
				else 
				{
					_view.toolbar.checkStretchShow(5);
					_view.toolbar.deformTip.removeDeform("DoubleLevel");
				}
				
				
				if(player.checkLevelShow("1_3"))
					panel.visible = true;
				else
					panel.visible = false;
				
			}
			else if(_view.toolbar.status == "map")
			{
				setDoubleLevelBtnStatus();
				doubleLevelBtn.touchable = false;
			}
			
			//if(player.doubleLevelInfo.level == "0_0")
			
			
			function setDoubleLevelBtnStatus () : void 
			{
				if(_view.map.curLevel == player.doubleLevelInfo.level)
				{
					if(_view.double_level.isStartDouble)
					{
						panel.visible = true;
						_view.toolbar.deformTip.removeDeform("DoubleLevel");
					}
					else
					{
						panel.visible = false;
					}
				}
				else
				{
					panel.visible = false;
				}
			}
		}
		
		/**
		 * 事件监听 
		 * @param e
		 * 
		 */		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				// 双倍副本
				case "DoubleLevelBtn":
					onOpenDoubleLevel();
					break;
			}
		}
		
		private function onOpenDoubleLevel() : void
		{
			player.doubleLevelInfo.firstSave();
			_view.double_level.interfaces();
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new DoubleComponent(_configXML, _titleTxAtlas);
		}
	}
}
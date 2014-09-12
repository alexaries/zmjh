package com.game.view.toolbar
{
	import com.game.View;
	import com.game.template.GameConfig;
	
	import starling.display.Button;
	import starling.text.TextField;

	public class SaveGameComponent
	{
		private var _view:View;
		
		// 保存按钮
		private var _btn:Button;
		// cd
		private var _cd:TextField;
		
		public function SaveGameComponent(btn:Button, cd:TextField)
		{
			_btn = btn;
			_cd = cd;
			
			_view = View.instance;
		}
		
		public function resetPara() : void
		{
			_curCD = 0;
			_view.controller.save.isCanSend = true;
			_view.removeFromTimeProcessList("SaveGameComponent");
			init();
		}
		
		public function init() : void
		{
			_cd.text = "";
			_btn.touchable = true;
		}
		
		private var _curCD:int;
		public function beginSave() : void
		{
			_btn.touchable = false;
			_curCD = GameConfig.SAVE_DELAY;
			_cd.text = "(" + _curCD + ")";
			
			_view.addToTimeProcessList(
				"SaveGameComponent",
				function () : void
				{
					--_curCD;
					_cd.text = "(" + _curCD + ")";
					
					// 保存CD时间到
					if (_curCD <= 0)
					{
						_view.controller.save.isCanSend = true;
						_view.removeFromTimeProcessList("SaveGameComponent");
						init();
					}
				});
		}
		
		/**
		 * 销毁 
		 * 
		 */		
		public function destroy() : void
		{
			_btn = null;
			_cd = null;
		}
	}
}
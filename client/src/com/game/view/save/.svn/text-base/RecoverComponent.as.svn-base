package com.game.view.save
{
	import com.engine.core.Log;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import starling.textures.TextureAtlas;

	public class RecoverComponent extends Component
	{
		// 当前是存储还是读取
		private var _tipType:String;
		// 当前存档位置
		private var _curIndex:int;
		
		public function RecoverComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			initEvent();
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Cancel":
					hide();
					break;
				case "Ok":
					hide();
					onOK();
					break;
			}
		}
		
		private function onOK() : void
		{
			switch (_tipType)
			{
				case SaveConfig.NEW_PLAYER_SAVE:
					onNewPlayerSave();
					break;
			}
		}
		
		private function onNewPlayerSave() : void
		{
			_view.loadData.loadDataPlay();
			_view.controller.save.onNewGame(onGetSaveData, _curIndex);
		}
		
		private function onGetSaveData(result:*) : void
		{
			_view.loadData.hide();
			_view.save.hide();
			_view.start.hide();
			
			// 开始加载
			if (_view.save.saveType != SaveConfig.TOOLBAR_SAVE) _view.publicRes.interfaces();
		}
		
		public function onShow(index:int) : void
		{
			_curIndex = index;
			this.panel.visible = true;
			
			_tipType = _view.save.saveType;
			
			Log.Trace("tipType:" + _tipType);
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new RecoverComponent(_configXML, _titleTxAtlas);
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
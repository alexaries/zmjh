package com.game.view.save
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class TipComponent extends Component
	{
		
		public function TipComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
			this.initEvent();
		}
		
		private var _content:TextField;
		private function getUI() : void
		{
			_content = this.searchOf("Tx_Tip");
		}
		
		// 当前是存储还是读取
		private var _tipType:String;
		// 当前存档位置
		private var _curIndex:int;
		public function onShow(index:int) : void
		{
			_curIndex = index;
			this.panel.visible = true;
			
			_tipType = _view.save.saveType;
			
			Log.Trace("tipType:" + _tipType);
			
			switch (_tipType)
			{
				case SaveConfig.TOOLBAR_SAVE:
				case SaveConfig.SAVE:
				case SaveConfig.NEW_PLAYER_SAVE:
					_content.text = "是否覆盖这个存档?";
					break;
				case SaveConfig.GET:
					_content.text = "是否读取该存档?";
					break;
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "CancelBt":
					hide();
					break;
				case "OkBt":
					hide();
					onOK();
					break;
			}
		}
		
		private function onOK() : void
		{
			switch (_tipType)
			{
				case SaveConfig.GET:
					_view.loadData.loadDataPlay();
					_view.controller.save.getSaveData(onGetSaveData, _curIndex);
					break;
				case SaveConfig.SAVE:
				case SaveConfig.TOOLBAR_SAVE:
					onCommonSave();
					break;
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
		
		private function onCommonSave() : void
		{
			_view.loadData.loadDataPlay();
			
			var data:XML = player.getPlayerOfXML();
			_view.controller.save.saveSet(onGetSaveData, data, _curIndex);
		}
		
		private function onGetSaveData(result:*) : void
		{
			Log.Trace("onGetSaveData:" + result);
			_view.loadData.hide();
			_view.save.hide();
			_view.start.hide();
			
			// 开始加载
			if (_view.save.saveType != SaveConfig.TOOLBAR_SAVE) _view.publicRes.interfaces();
		}
		
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new TipComponent(_configXML, _titleTxAtlas);
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
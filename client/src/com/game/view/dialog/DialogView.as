package com.game.view.dialog
{
	import com.engine.core.Log;
	import com.game.controller.Base;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.cartoon.CartoonConfig;
	import com.game.view.save.SaveConfig;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class DialogView extends BaseView implements IView
	{
		private var _curDialogType:String;
		private var _itemType:String;
		private var _sceneType:String;
		
		private var _dialogConfig:XML;
		private var _firstInit:Boolean;
		private function initData() : void
		{
			_dialogConfig =  this.getXMLData(V.DIALOG, GameConfig.DIALOG_RES, "DialogConfig");
		}
		
		private var _dialogs:Vector.<Dialog>;
		public function get dialogs() : Vector.<Dialog>
		{
			return _dialogs;
		}
		public function DialogView()
		{
			_moduleName = V.DIALOG;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		private var _callback:Function;
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			Log.Trace("Dialog!" + type + "---" + args);
			switch (type)
			{
				case InterfaceTypes.Show:
					_curDialogType = args[0];
					_itemType = args[1];
					_sceneType = args[2];
					if (args.length >= 3) _callback = args[3];		
					_firstInit = false;
					show();
					break;
				case InterfaceTypes.INIT:
					_firstInit = true;
					show();
					break;
			}
		}
		
		override protected function show():void
		{
			this.initLoad();
		}
		
		private var _curFrame:int;
		override protected function init():void
		{
			Log.Trace("Dialog init!");
			if (!isInit)
			{
				super.init();
				isInit = true;
				
				initData();
				parseData();
				initTxAtlas1();
				initTxAtlas2();
			}
			
			if(_firstInit)
				return;
			
			getData();
			
			_curFrame = 0;
			playDialog();
		}
		
		public function playDialog() : void
		{
			/*if(_view.map.autoLevel)
			{
				this.hide();
				if(_callback != null) _callback();	
				return;
			}*/
			Log.Trace("NowFrame:" + _curFrame);
			// 播放完毕
			if (!_sceneData || _sceneData.sceneItems.length == _curFrame)
			{
				Log.Trace("Dialog Complete!");
				this.hide();
				if(_callback != null)
					_callback();
				return;
			}
			
			var baseItem:BaseSceneItemDialogData = _sceneData.sceneItems[_curFrame];
			
			Log.Trace("Dialog Play!" + baseItem.type);
			switch (baseItem.type)
			{
				case DialogConfig.CARTOON:
					onCartoon();
					break;
				case DialogConfig.WORD:
					_view.talk.interfaces(InterfaceTypes.Show, (baseItem as WordDialogData).words);
					break;
			}
			
			_curFrame++;
		}
		
		/**
		 * 动漫播放 
		 * 
		 */		
		private function onCartoon() : void
		{
			var cartoonType:String;
			Log.Trace("onCartoon!" + _curDialogType);
			switch (_curDialogType)
			{
				case "new_player":
					cartoonType = CartoonConfig.NEW_PLAYER_START;
					_view.cartoon.interfaces(InterfaceTypes.Show, cartoonType);
					break;
				case "level":
					if (_itemType == "1_4" || _itemType == "2_4" || _itemType == "3_4")
					{
						cartoonType = CartoonConfig.HIDE_LEVEL;
						_view.cartoon.interfaces(InterfaceTypes.Show, cartoonType);
					}
					else if (_itemType == "4_4")
					{
						cartoonType = CartoonConfig.END_BOSS;
						_view.cartoon.interfaces(InterfaceTypes.Show, cartoonType);
					}
					Log.Trace("Dialog Level!" + _itemType);
					break;
			}
			Log.Trace("CartoonType:" + cartoonType);
		}
		
		private var _sceneData:SceneDialogData;
		private function getData() : void
		{
			var dialog:Dialog;
			var i:int;
			for (i = 0; i < _dialogs.length; i++)
			{
				if (_dialogs[i].type == _curDialogType)
				{
					dialog = _dialogs[i];
					break;
				}
			}			
			if (!dialog)
			{
				Log.Trace("No Dialog");
				throw new Error("error");
			}
			
			var dialogItem:DialogItemData;
			for (i = 0; i < dialog.items.length; i++)
			{
				if (_curDialogType == "new_player")
				{
					dialogItem = dialog.items[0];
					break;
				}
				else if (dialog.items[i].type == _itemType)
				{
					dialogItem = dialog.items[i];
					break;
				}
			}			
			if (!dialogItem) throw new Error("error");
			
			_sceneData = null;
			for (i = 0; i < dialogItem.scenes.length; i++)
			{
				if (dialogItem.scenes[i].type == _sceneType)
				{
					_sceneData = dialogItem.scenes[i];
					break;
				}
			}			
		}
		
		private function parseData() : void
		{
			_dialogs = new Vector.<Dialog>();
			
			var dialog:Dialog;
			for each(var item:XML in _dialogConfig.dialog)
			{
				dialog = new Dialog();
				dialog.initData(item);
				_dialogs.push(dialog);
			}
		}
		
		private var _TxAtlas1:TextureAtlas;
		public function get TxAtlas1() : TextureAtlas
		{
			initTxAtlas1();
			
			return 	_TxAtlas1;
		}
		
		private var _TxAtlas2:TextureAtlas;
		public function get TxAtlas2() : TextureAtlas
		{
			initTxAtlas2();
			
			return _TxAtlas2;
		}		
		
		private function initTxAtlas1() : void
		{
			var textureXML:XML;
			var texture:Texture;
			var obj:ByteArray;
			
			if (!_TxAtlas1)
			{
				textureXML = getXMLData(V.DIALOG, GameConfig.DIALOG_RES, "dialog1");
				obj = getAssetsObject(V.DIALOG, GameConfig.DIALOG_RES, "Textures1") as ByteArray;
				texture = Texture.fromAtfData(obj);
				_TxAtlas1 = new TextureAtlas(texture, textureXML);
			}
		}
		
		private function initTxAtlas2() : void
		{
			var textureXML:XML;
			var texture:Texture;
			var obj:ByteArray;
			
			Log.Trace("TxAtlas2 Init!");
			if (!_TxAtlas2)
			{
				textureXML = getXMLData(V.DIALOG, GameConfig.DIALOG_RES, "dialog2");
				obj = getAssetsObject(V.DIALOG, GameConfig.DIALOG_RES, "Textures2") as ByteArray;
				texture = Texture.fromAtfData(obj);
				_TxAtlas2 = new TextureAtlas(texture, textureXML);
			}
			Log.Trace("TxAtlas2 End!");
		}
	}
}
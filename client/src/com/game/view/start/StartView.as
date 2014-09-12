package com.game.view.start
{
	import com.engine.core.Log;
	import com.engine.net.GameServerFor4399;
	import com.game.Data;
	import com.game.data.start.StartData;
	import com.game.manager.DebugManager;
	import com.game.manager.ResCacheManager;
	import com.game.manager.URIManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.save.SaveConfig;
	
	import flash.media.Sound;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class StartView extends BaseView implements IView
	{
		private var _versionTF:TextField;
		
		public function StartView()
		{
			_layer = LayerTypes.CONTENT;
			_moduleName = V.START;
			_loaderModuleName = V.LOAD;
			
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
			}
		}
		
		override protected function init():void
		{
			if (!isInit)
			{
				_view.prompEffect.interfaces();
				super.init();				
				isInit = true;
				
				getSound();
				initXML();
				initUI();
				getUI();
				initEvent();
				
				promptRenderMode();
				
				initData();
			}
			
			render();
			playSound();
		}
		
		private function initData() : void
		{
			StartData.initData();
		}
		
		/**
		 * 开始渲染 
		 * 
		 */		
		private function render() : void
		{
			_versionTF.text = "V" + ResCacheManager.instance.onVersion();
		}
		
		/**
		 *渲染模式 
		 * 
		 */		
		private function promptRenderMode() : void
		{
			// 判断是否使用硬件渲染 
			var isHW:Boolean = Starling.context.driverInfo.toLowerCase().indexOf("software") == -1;
			
			/*
			if (!isHW)
			{
				var info:String = "您的电脑可能无法流畅运行游戏的所有特效，请您谅解。";
				_view.tip.interfaces(
					InterfaceTypes.Show,
					info,
					null,
					null);
			}*/
			
			Log.Trace("渲染模式:" + Starling.context.driverInfo);
		}
		
		private function playSound() : void
		{
			_view.sound.playSound(_sound, "start", true);
		}
		
		private var _sound:Object;
		private function getSound() : void
		{
			_sound = getAssetsData(V.START, GameConfig.START_RES);
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.LOAD, GameConfig.LOAD_RES, "StartPosition");
		}
		
		private function initUI() : void
		{
			var name:String;
			var obj:*;
			var layerName:String;
			for each(var items:XML in _positionXML.layer)
			{
				layerName = items.@layerName;
				for each(var element:XML in items.item)
				{
					name = element.@name;
					
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						obj["layerName"] = layerName;
						_uiLibrary.push(obj);
					}
				}
			}
			
			_view.layer.setCenter(panel);
		}
		
		private function getUI() : void
		{
			_versionTF = this.searchOf("Tx_Version");
			_versionTF.fontName = V.SONG_TI;
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				// 新的开始
				case "NewGame":
					onNewGame();
					break;
				// 读取存档
				case "GetRecord":
					onGetRecord();
					break;
				// 游戏帮助
				case "Help":
					break;
				// 关于我们
				case "About":
					var info:String = typeof(GameServerFor4399.instance.serviceHold);
					DebugManager.instance.inOutputPanel("serviceHold:" + info);
					break;
				case "Quit":
					onQuit();
					break;
				case "Forum":
					URIManager.openForumURL();
					break;
				default:
					trace(name);
			}
		}
		
		private function onQuit() : void
		{
			_view.controller.save.quitGame(callback);
			
			function callback() : void
			{
				Log.Trace("onQuit");
			}
		}
		
		/**
		 * 新的开始 
		 * 
		 */		
		private function onNewGame() : void
		{
			
			if (DebugManager.instance.gameMode == V.DEVELOP)
			{
				this.hide();
				_view.publicRes.interfaces();
				return;
			}
			
			_view.save.interfaces(InterfaceTypes.Show, SaveConfig.NEW_PLAYER_SAVE);
		}
		
		/**
		 *读取文档 
		 * 
		 */		
		private function onGetRecord() : void
		{
			if (DebugManager.instance.gameMode == V.DEVELOP)
			{
				this.hide();
				_view.publicRes.interfaces();
				return;
			}
			
			_view.save.interfaces(InterfaceTypes.Show, SaveConfig.GET);
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;		
			textures = _view.load.interfaces(InterfaceTypes.GetTextures, name);
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			texture = _view.load.interfaces(InterfaceTypes.GetTexture, name);	
			return texture;
		}
		
		override public function close():void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
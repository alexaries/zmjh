package com.game.view.preload
{
	import com.engine.core.Log;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.Base;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.save.SaveConfig;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.Font;
	import flash.utils.getTimer;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class PreLoadView extends BaseView implements IView
	{
		public function PreLoadView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.PRELOAD;
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			var result:*;
			
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
				case InterfaceTypes.GetTextures:
					result = getTextures(args[0], '');
					break;
				case InterfaceTypes.GetTexture:
					result = getTexture(args[0], '');
					break;
			}
			
			return result;
		}
		
		override protected function show():void
		{
			_loadResources = GameConfig.instance.ASSETS[_moduleName]["module"];
			
			if (_view.load.isInit) loadBar = _view.load.loadProgressBar;
			
			super.show();
		}
		
		override protected function init() : void
		{
			super.init();
			
			initTexture();
			beginInitEnvironment();
		}
		
		/**
		 * 初始化环境 
		 * 
		 */		
		public function beginInitEnvironment() : void
		{
			var T:int = getTimer();
			
			_view.roleRes.interfaces();
			_view.roleLVUp.interfaces();
			_view.roleGain.interfaces();
			_view.passLV.interfaces();
			_view.ui.interfaces();
			_view.icon.interfaces();
			_view.freeDice.interfaces();
			_view.dice.interfaces();
			
			_view.freeDice.hide();
			_view.dice.hide();
			
			_view.controller.db.init();
			
			_view.controller.player.reqPlayerData(onLoadPlayerComplete);			
			
			// 初次加载完后，检测是否播放新玩家
			checkNewPlayer();
			
			trace("模块执行时间：" + (getTimer() - T));
		}
		
		private function checkNewPlayer() : void
		{
			if (_view.save.saveType == SaveConfig.NEW_PLAYER_SAVE)
			{
				_view.dialog.interfaces(
					InterfaceTypes.Show,
					"new_player",
					"",
					"start"
				);	
			}
		}
		
		/**
		 * 加载玩家数据完成后 
		 * 
		 */		
		protected function onLoadPlayerComplete() : void
		{			
			_view.world.interfaces();
		}
		
		private var _textureXML:XML;
		private var _textureTitle:Texture;
		private var _titleTxAtlas:TextureAtlas;
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				
				_textureXML = getXMLData(V.PUBLIC, "Public.swf", "public");
				
				obj = _view.res.getAssetsObject(V.PUBLIC, "Public.swf", "Textures");
				_textureTitle = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(_textureTitle, _textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
				//var HKHB:Class = _view.res.getAssetsClass(V.PUBLIC, "Public.swf", "HKHB") as Class;
				//_view.font.setDefaultFont(HKHB);
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var vec:Vector.<Texture>;
			
			vec = _titleTxAtlas.getTextures(name);
			
			return vec;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			
			texture = _titleTxAtlas.getTexture(name);
			
			return texture;
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
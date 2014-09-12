package com.game.view.effect
{
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Base;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.effect.protocol.FightEffectConfigData;
	import com.game.view.effect.protocol.FightEffectUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class EventEffectView extends BaseView implements IView
	{
		private var _titleTxAtlas1:TextureAtlas;
		public function get titleTxAtlas1() : TextureAtlas
		{
			return _titleTxAtlas1;
		}
		
		private var _titleTxAtlas2:TextureAtlas;
		public function get titleTxAtlas2() : TextureAtlas
		{
			return _titleTxAtlas2;
		}
		
		private var _titleTxAtlas3:TextureAtlas;
		public function get titleTxAtlas3() : TextureAtlas
		{
			return _titleTxAtlas3;
		}
		
		public function EventEffectView()
		{
			_moduleName = V.EVENT_EFFECT;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					if (isInit) return;
					isInit = true;
					this.show();
					break;
			}
		}
		
		override protected function show():void
		{
			initLoad();
		}
		
		override protected function init():void
		{
			initTexture();
			initData();
		}
		
		protected function initTexture() : void
		{
			var textureXML:XML;
			var obj:ByteArray;
			var textureTitle:Texture;
			
			if (!_titleTxAtlas1)
			{
				textureXML = getXMLData(V.EVENT_EFFECT, GameConfig.EE_RES, "EventEffect1");
				obj = getAssetsObject(V.EVENT_EFFECT, GameConfig.EE_RES, "Textures1") as ByteArray;
				textureTitle = Texture.fromAtfData(obj);
				_titleTxAtlas1 = new TextureAtlas(textureTitle, textureXML);
				/*obj.clear();*/
			}
			
			if (!_titleTxAtlas2)
			{
				textureXML = getXMLData(V.EVENT_EFFECT, GameConfig.EE_RES, "EventEffect2");
				obj = getAssetsObject(V.EVENT_EFFECT, GameConfig.EE_RES, "Textures2") as ByteArray;
				textureTitle = Texture.fromAtfData(obj);
				_titleTxAtlas2 = new TextureAtlas(textureTitle, textureXML);
				/*obj.clear();*/
			}
			
			if (!_titleTxAtlas3)
			{
				textureXML = getXMLData(V.EVENT_EFFECT, GameConfig.EE_RES, "EventEffect3");
				obj = getAssetsObject(V.EVENT_EFFECT, GameConfig.EE_RES, "Textures3") as ByteArray;
				textureTitle = Texture.fromAtfData(obj);
				_titleTxAtlas3 = new TextureAtlas(textureTitle, textureXML);
				/*obj.clear();*/
			}
			/*obj = null;*/
		}
		
		private var _configData:XML;
		private function initData() : void
		{
			if (!_configData)
			{
				_configData =  getXMLData(V.EVENT_EFFECT, GameConfig.EE_RES, "EventEffectConfig");
			}
			
			parseConfig();
		}
		
		private var _eventEffect:Vector.<FightEffectConfigData>;
		private function parseConfig() : void
		{
			_eventEffect = FightEffectUtils.parseXML(_configData);
		}
		
		public function getEventEffectData(effectName:String) : FightEffectConfigData
		{
			var configData:FightEffectConfigData;
			
			for each(var item:FightEffectConfigData in _eventEffect)
			{
				if (item.name == effectName)
				{
					configData = item;
					break;
				}
			}
			
			if (!configData) throw new Error("没找到战斗特效");
			
			return configData;
		}
	}
}
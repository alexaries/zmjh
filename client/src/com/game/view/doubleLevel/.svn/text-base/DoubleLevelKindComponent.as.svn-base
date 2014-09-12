package com.game.view.doubleLevel
{
	import com.game.template.V;
	import com.game.view.Component;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class DoubleLevelKindComponent extends Component
	{
		public function DoubleLevelKindComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
			initEvent();
		}
		private var _lsk:MovieClip;
		public function get lsk() : MovieClip
		{
			return _lsk;
		}
		
		private function getUI() : void
		{
			_lsk = searchOf("SimpleBtn");
		}
		
		public function set currentFrame(value:int) : void
		{
			if (!_lsk.touchable) return;
			
			switch (value)
			{
				// 未选中，开启
				case 0:
					_lsk.currentFrame = 1;
					break;
				// 选中
				case 1:
					_lsk.currentFrame = 0;
					break;
				// 未开启
				case 2:
					_lsk.currentFrame = 2;
					break;
			}
		}
		
		// 困难模式
		private var _hardType:int;
		public function set hardKind(value:int) : void
		{
			_hardType = value;
			
			checkCurHardType();
		}
		
		private var _textures:Vector.<Texture>;
		private function checkCurHardType() : void
		{
			var texture:Texture;
			
			switch (_hardType)
			{
				case V.SIMPLE_LV:
					_textures = _titleTxAtlas.getTextures("SimpleBtn");
					break;
				case V.COMMON_LV:
					_textures = _titleTxAtlas.getTextures("HardBtn");
					break;
				case V.HARD_LV:
					_textures = _titleTxAtlas.getTextures("HardestBtn");
					break;
			}
			
			for (var i:int = 0; i < _lsk.numFrames; i++)
			{
				_lsk.setFrameTexture(i, _textures[i]);
			}
			
			_lsk.currentFrame = _lsk.currentFrame;
			
			_lsk.readjustSize();
		}
		
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new DoubleLevelKindComponent(_configXML, _titleTxAtlas);
		}
	}
}
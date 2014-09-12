package com.game.view.LevelEvent
{
	import com.engine.ui.core.BaseSprite;
	import com.game.view.effect.protocol.FightEffectConfigData;
	import com.game.view.effect.protocol.FightEffectFrameData;
	import com.game.view.effect.protocol.FightEffectMovieClip;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class AdventuresEffectPlayer extends BaseSprite
	{
		private var _data:FightEffectConfigData;
		private var _atlas:TextureAtlas;
		
		private var _frames:int;
		
		public var position:String;
		
		public var type:String;
		public function AdventuresEffectPlayer()
		{
		}
		
		public function initData(data:FightEffectConfigData, atlas:TextureAtlas, frames:int) : void
		{
			_data = data;
			_atlas = atlas;
			_frames = frames;
			
			initTexture();
			initUI();
		}
		
		private var _textures:Vector.<Texture>;
		private function initTexture() : void
		{
			_textures = new Vector.<Texture>();
			
			var frame:FightEffectFrameData;
			var texture:Texture;
			var textureName:String;
			for (var i:int = 0, len:int = _data.frames.length; i < len; i++)
			{
				frame = _data.frames[i];
				textureName = _data.texture_name  + '_' + frame.frame_index;
				texture = _atlas.getTexture(textureName);
				_textures.push(texture);
			}
		}
		
		private var _content:FightEffectMovieClip;
		private function initUI() : void
		{
			_content = new FightEffectMovieClip(_textures, _frames);
			_content.addEventListener(Event.COMPLETE, onPlayComplete);
			_content.initData(_data);
			addChild(_content);
			Starling.juggler.add(_content);
		}
		
		private function onPlayComplete(e:Event) : void
		{
			clear();
			this.dispatchEventWith(Event.COMPLETE);
		}
		
		public function clear() : void
		{
			Starling.juggler.remove(_content);
			_content.removeEventListener(Event.COMPLETE, onPlayComplete);
			_content.parent.removeChild(_content);
			_content.dispose();
			_content = null;
		}
	}
}
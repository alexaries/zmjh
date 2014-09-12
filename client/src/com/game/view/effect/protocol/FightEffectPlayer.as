package com.game.view.effect.protocol
{	
	import com.engine.ui.core.BaseSprite;
	import com.game.View;
	import com.game.view.fight.FightRoleComponent;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class FightEffectPlayer extends BaseSprite
	{
		private var _data:FightEffectConfigData;
		private var _atlas:TextureAtlas;
		
		private var _frames:int;
		
		public var position:String;
		
		public var type:String;
		
		public function FightEffectPlayer()
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
			View.instance.fightEffect.addAnimatable(_content);
			//Starling.current.juggler.add(_content);
		}
		
		private function onPlayComplete(e:Event) : void
		{
			clear();
			this.dispatchEventWith(Event.COMPLETE);
		}
		
		public function clear() : void
		{
			View.instance.fightEffect.removeAnimatable(_content);
			//Starling.current.juggler.remove(_content);
			_content.removeEventListener(Event.COMPLETE, onPlayComplete);
			_content.parent.removeChild(_content);
			_content.dispose();
			_content = null;
		}
		
	}
}
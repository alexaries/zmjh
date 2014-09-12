package com.game.view.effect.protocol
{
	import starling.display.MovieClip;
	import starling.textures.Texture;

	public class FightEffectMovieClip extends MovieClip
	{
		public function FightEffectMovieClip(textures:Vector.<Texture>, fps:Number=12)
		{
			super(textures, fps);
			
			this.loop = false;
			this.visible = false;
		}
		
		private var _data:FightEffectConfigData;
		public function initData(data:FightEffectConfigData) : void
		{
			_data = data;
		}
		
		override public function advanceTime(passedTime:Number):void
		{
			super.advanceTime(passedTime);
			
			this.readjustSize();
			setCurrentFramePos();
		} 
		
		private var _curFightFrameData:FightEffectFrameData;
		protected function setCurrentFramePos() : void
		{			
			_curFightFrameData = this._data.frames[this.currentFrame];
			this.x = _curFightFrameData.X;
			this.y = _curFightFrameData.Y;
			
			//trace("FightEffectMovieClip:", currentFrame);
			
			if (!this.visible) this.visible = true;
		}
	}
}
package com.game.view.fight.begin
{
	import com.engine.ui.core.BaseSprite;
	import com.game.View;
	import com.game.view.fight.begin.tl.TL_ALPHA;
	import com.game.view.fight.begin.tl.TL_MOVE;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class FightBeginEffectItem extends BaseSprite
	{
		private var _data:FightBeginEffectItemData;
		public function get data() : FightBeginEffectItemData
		{
			return _data;
		}
		
		private var _view:View = View.instance;
		
		public function FightBeginEffectItem()
		{
			super();
		}
		
		public function setData(data:FightBeginEffectItemData) : void
		{
			_data = data;
			this.name = _data.name;
			
			createObj();
		}
		
		public function start() : void
		{
			_curPlayIndex = 0;
			onPlay();
		}
		
		private var _curPlayIndex:int;
		private function onPlay() : void
		{
			// 播放完毕
			if (_curPlayIndex  >= _data.effects.length)
			{
				return;
			}
			
			var effect:BaseBeginEffect = _data.effects[_curPlayIndex];
			switch (effect.type)
			{
				case "Stand":
					onPlayStand(effect as StandEffect);
					break;
				case "TL":
					onPlayTL(effect as TLEffect);
					break;
				case "AM":
					onPlayAM(effect as AMEffect);
					break;
			}
			
			_curPlayIndex ++;
		}
		
		/**
		 * 动画 
		 * @param effect
		 * 
		 */		
		private function onPlayAM(effect:AMEffect) : void
		{
			
		}
		
		/**
		 * 站立 
		 * @param effect
		 * 
		 */		
		private function onPlayStand(effect:StandEffect) : void
		{
			_image.alpha = 1;
			_image.x = effect.X;
			_image.y = effect.Y;

			var tween:Tween = new Tween(_image, effect.duration/24);
			tween.moveTo(_image.x, _image.y);
			tween.onComplete = onPlay;
			Starling.juggler.add(tween);
		}
		
		/**
		 * 缓动
		 * @param effect
		 * 
		 */		
		private function onPlayTL(effect:TLEffect) : void
		{
			switch (effect.tlType)
			{
				case "alpha":
					onPlayTLAlpha(effect.tl as TL_ALPHA);
					break;
				case "move":
					onPlayTLMove(effect.tl as TL_MOVE);
					break;
			}
		}
		
		private function onPlayTLAlpha(effect:TL_ALPHA) : void
		{
			_image.alpha = effect.begin_alpha;
			var tween:Tween = new Tween(_image, effect.duration/24);
			tween.fadeTo(effect.end_alpha);
			tween.onComplete = onPlay;
			Starling.juggler.add(tween);
		}
		
		private function onPlayTLMove(effect:TL_MOVE) : void
		{
			var tween:Tween = new Tween(_image, effect.duration/24);
			tween.moveTo(effect.EX, effect.EY);
			tween.onComplete = onPlay;
			Starling.juggler.add(tween);
		}
		
		private function createObj() : void
		{
			switch (_data.item_type)
			{
				case "IMG":
					createIMG();
					break;
				case "MC":
					break;
			}
		}
		
		private var _image:Image;
		public function get image() : Image
		{
			return _image;
		}
		
		private function createIMG() : void
		{
			var texture:Texture;
			if (_data.texture_name == "") texture = Texture.empty();
			else texture = _view.fightEffect.titleTxAtlas2.getTexture(_data.texture_name);
			_image = new Image(texture);
			_image.smoothing = TextureSmoothing.NONE;
			_image.name = _data.name;
			_image.data = _data;
			this.addChild(_image);
			
			if (_data.name == "BG") _image.width = 940;
		}
	}
}
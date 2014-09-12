package com.game.view.effect
{
	import com.game.manager.FontManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class PrompEffectView extends BaseView implements IView
	{
		private var _containList:Array;
		public function PrompEffectView()
		{
			_moduleName = V.PROMP_EFFECT;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					initUI();
					break;
			}
		}
		
		private var _bgTexture:Texture;
		private function initUI() : void
		{
			_containList = new Array();
			_bgTexture = _view.load.interfaces(InterfaceTypes.GetTexture, "StateTipBg");
		}
		
		private function createTF() : TextField
		{
			var propTF:TextField;			
			propTF = new TextField(940, 40, "");
			propTF.fontName = FontManager.instance.font ? FontManager.instance.font.fontName : "宋体";
			propTF.vAlign = VAlign.CENTER;
			propTF.hAlign = HAlign.CENTER;
			propTF.color = 0xffffff;
			propTF.fontSize = 25;
			propTF.touchable = false;
			
			return propTF;
		}
		
		private function createBG() : Image
		{
			var image:Image = new Image(_bgTexture);
			return image;
		}
		
		public function play(info:String = '') : void
		{
			var contain:Sprite = new Sprite();
			
			var propTF:TextField = createTF();
			propTF.text = info;
			propTF.alpha = 1;
			contain.addChild(propTF);
			
			var bg:Image = createBG();
			contain.addChildAt(bg, 0);
			var len:int = propTF.textBounds.width;
			bg.width = len + 60;				
			bg.x = GameConfig.CAMERA_WIDTH/2 - bg.width/2;
			
			contain.alpha = 1;
			_view.layer.top.addChild(contain);
			_view.layer.setCenter(contain);
			contain.y -= 70;
			
			var tween:Tween = new Tween(contain, 1);
			tween.moveTo(contain.x, contain.y - 120);
			tween.fadeTo(0);
			tween.delay = 1.5;
			tween.onComplete = function () : void
			{
				if(propTF.parent) propTF.parent.removeChild(propTF);
				propTF.dispose();
				propTF = null;
				
				if(bg.parent) bg.parent.removeChild(bg);
				bg.dispose();
				bg = null;
				
				_containList.splice(_containList.indexOf(contain), 1);
				
				if(contain.parent) contain.parent.removeChild(contain);
				contain.dispose();
				contain = null;
			};
			Starling.juggler.add(tween);
			
			_containList.push(contain);
		}
		
		/**
		 * 每帧调用 
		 * 
		 */
		override public function update():void
		{
			super.update();
		}
		
		override public function close():void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
		
		public function removeText() : void
		{
			for each(var item:Sprite in _containList)
			{
				item.visible = false;
			}
		}
	}
}
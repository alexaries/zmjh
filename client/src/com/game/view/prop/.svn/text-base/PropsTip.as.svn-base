package com.game.view.prop
{
	import com.engine.ui.controls.TipTextField;
	import com.engine.ui.core.BaseSprite;
	import com.engine.ui.core.Scale9Image;
	import com.engine.ui.core.Scale9Textures;
	import com.game.Data;
	import com.game.data.player.structure.PropModel;
	
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import starling.utils.HAlign;

	public class PropsTip extends BaseSprite
	{
		private static const LEFT_GAP:Number=11;
		private static const TEXT_VGAP:Number=-1;
		
		public function get data() : Object
		{
			return _data;
		}
		
		public function PropsTip()
		{
		}
		
		private var _bgTexture:Texture;
		private var _moneyTexture:Texture;
		private var _lineTexture:Texture;
		public function init(bgTexture:Texture, moneyTx:Texture, line:Texture) : void
		{
			_bgTexture = bgTexture;
			_moneyTexture = moneyTx;
			_lineTexture = line;
			
			initUI();
			initEvent();
		}
		
		private var _bg:Scale9Image;
		private var _propsNameTF:TipTextField;
		private var _baseAttribute:TipTextField;
		private var _countTF:TipTextField;
		private function initUI() : void
		{
			var textures:Scale9Textures = new Scale9Textures(_bgTexture, new Rectangle(20, 20, 50, 50));
			_bg = new Scale9Image(textures);
			_bg.alpha = 1;
			_bg.width = 187;
			this.addChild(_bg);
			
			//道具名称
			_propsNameTF = createTextField(180);
			_propsNameTF.x = LEFT_GAP;
			_propsNameTF.y = 10;
			_propsNameTF.fontSize = 15;
			_propsNameTF.color = 0x66CC33;
			this.addChild(_propsNameTF);
			
			_baseAttribute = createTextField(170, 35);
			_baseAttribute.x = LEFT_GAP;
			this.addChild(_baseAttribute);
			
			_countTF = createTextField(170, 35);
			_countTF.x = LEFT_GAP;
			this.addChild(_countTF);
		}
		
		private function initEvent() : void
		{
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this);
			
			if (touch)
			{
				hide();
			}
		}
		
		private var _data:PropModel;
		public function setData(data:PropModel) : void
		{
			_data = data;
			
			initRender();
		}
		
		private function initRender() : void
		{
			_propsNameTF.text = _data.config.name;

			_baseAttribute.text = _data.config.message;
			
			var count:int = Data.instance.player.player.pack.getPropNumById(_data.id);
			if(_data.config.restrict != 1)
				_countTF.text = "当前拥有" + count + "个";
			else
				_countTF.text = "";
			
			resetCompose();

		}
		
		private function resetCompose() : void
		{
			_baseAttribute.y = _propsNameTF.y + _propsNameTF.height + TEXT_VGAP;
			
			if(_data.config.restrict != 1)
			{
				_countTF.y = _baseAttribute.y + _baseAttribute.height + TEXT_VGAP;
				_bg.height = _countTF.y + _countTF.height + 10;
			}
			else
			{
				_bg.height = _baseAttribute.y + _baseAttribute.height + 10;
			}
		}
		
		public function hide():void
		{
			if (this.parent) this.parent.removeChild(this);
		}
		
		protected function createTextField(W:int=90, H:int=19, Col:Number=0Xffffff, Str:String='', Size:uint=12, HAl:String=HAlign.LEFT, Auto:Boolean=true, Wor:Boolean=true) : TipTextField
		{
			var mytext:TipTextField=new TipTextField(W,H,Str);
			mytext.color=Col;
			mytext.fontSize=Size;
			mytext.hAlign=HAl;
			return mytext;
		}
	}
}
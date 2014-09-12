package com.game.view.upgrade
{
	import com.game.template.InterfaceTypes;
	import com.game.view.Component;
	
	import starling.display.MovieClip;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class TitleSelectComponent extends Component
	{
		public var isSelect:Boolean;
		public function TitleSelectComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);init();
		}
		
		override protected function init() : void
		{
			super.init();
			getUI();
			initEvent();
		}
		
		private var _selectItem:MovieClip;
		private var _titleNameTF:TextField;
		private function getUI():void
		{
			isSelect = false;
			_selectItem = this.searchOf("TitleSelectBtn");
			_selectItem.useHandCursor = true;
			_selectItem.addEventListener(TouchEvent.TOUCH, onTouchHandler);
			_titleNameTF = this.searchOf("TitleName");
			_titleNameTF.touchable = false;
		}
		
		private var _titleData:Object;
		override public function setGridData(data:*) : void
		{
			_titleData = data;
			_titleNameTF.text = _titleData.name;
		}
		
		private function onTouchHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_selectItem);
			if(!touch)
			{
				if(!isSelect)
					_selectItem.currentFrame = 0;
				else
					_selectItem.currentFrame = 1;
				return;
			}
			if(touch.phase == TouchPhase.ENDED)
				onClick();
			if(touch.phase == TouchPhase.HOVER)
				hoverBtn();
		}
		
		private function hoverBtn():void
		{
			_selectItem.currentFrame = 1;
		}
		
		public function onClick():void
		{
			isSelect = true;
			_selectItem.currentFrame = 1;
			_view.upgrade.clickTitle(this);
		}
		
		public function leaveBtn() : void
		{
			_selectItem.currentFrame = 0;
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public") 
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else
			{
				textures = _titleTxAtlas.getTextures(name);
			}
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			if (type == "public")
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			return texture;
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new TitleSelectComponent(_configXML, _titleTxAtlas);
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			super.destroy();
		}
	}
}
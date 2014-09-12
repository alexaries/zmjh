package com.game.view.tip
{
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class AccelerateView extends BaseView implements IView
	{
		private var _content:String;
		private var _okFun:Function;
		private var _cancelFun:Function;
		// 是否终止游戏
		private var _isStop:Boolean;
		
		private var _okVisible:Boolean;
		private var _cancelVisible:Boolean;
		
		public var isOpen:Boolean;
		
		public function AccelerateView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.TIP;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_content = args[0];
					this.show();
					break;
				case InterfaceTypes.HIDE:
					hide();
					break;
			}
		}
		
		override protected function init() : void
		{
			if (!isInit)
			{
				super.init();
				isInit = true;
				
				initXML();
				initComponent();
				initUI();
				initEvent();
				
				setMask();
			}
			
			showGameTip();
		}
		
		private var _mask:Image;
		private function setMask() : void
		{
			_mask = new Image(_view.layer.maskTexture);
			_mask.alpha = 0.4;
			panel.addChildAt(_mask, 0);
		}
		
		protected function showGameTip() : void
		{
			if(!isOpen)
			{
				isOpen = true;
				display();
				if(!_mask.parent) this.panel.addChildAt(_mask, 0);
				_gameTips.setAccelerate(_content);
			}
		}
		
		override public function display() : void
		{
			panel.visible = true;
			panel.alpha = 1;
			
			// add
			var type:String = "add" + _layer + "Child";
			if (!panel.parent) _view.layer[type](panel, sign);
			
			_view.layer.top.setChildIndex(panel, _view.layer.top.numChildren - 1);
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.LOAD, GameConfig.LOAD_RES, "TipPosition", V.LOAD);
		}
		
		public function get positionXML() : XML
		{
			return _positionXML;
		}
		
		private function initComponent() : void
		{
			var name:String;
			var cp:Component;
			var layerName:String;
			for each(var items:XML in _positionXML.component.Items)
			{
				name = items.@name;
				if (!this.checkInComponent(name))
				{
					switch (name)
					{
						case "GameTip":
							cp = new GameTipComponent(items, _view.load.titleTxAtlas);
							_components.push(cp);
							break;
					}
				}
			}
		}
		
		private var _gameTips:GameTipComponent;
		private function initUI() : void
		{			
			_gameTips = this.searchOfCompoent("GameTip").copy() as GameTipComponent;
			panel.addChild(_gameTips.panel);
			_gameTips.hide();
			
			_view.layer.setCenter(_gameTips.panel);
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture> = _view.load.interfaces(InterfaceTypes.GetTexture, name);		
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture = _view.load.interfaces(InterfaceTypes.GetTexture, name);
			return texture;
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
			if(isOpen)
			{
				isOpen = false;
				panel.visible = false;
			}
		}
	}
}
package com.game.view.tip
{
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class TipView extends BaseView implements IView
	{
		private var _content:String;
		private var _okFun:Function;
		private var _cancelFun:Function;
		// 是否终止游戏
		private var _isStop:Boolean;
		
		private var _okVisible:Boolean;
		private var _cancelVisible:Boolean;
		
		public function TipView()
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
					_okFun = args[1];
					_cancelFun = args[2];
					_isStop = (args.length >= 4 ? args[3] : false);
					_okVisible = (args.length >= 5 ? args[4] : true);
					_cancelVisible = (args.length >= 6 ? args[5] : true);
					this.show();
					break;
				case InterfaceTypes.HIDE:
					this.hide();
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
			}
			
			showGameTip();
		}
		
		protected function showGameTip() : void
		{
			if (!this.panel.visible) display();
			
			_gameTip.showTip(_content, _okFun, _cancelFun, _isStop, _okVisible, _cancelVisible);
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
		
		private var _gameTip:GameTipComponent;
		private function initUI() : void
		{			
			_gameTip = this.searchOfCompoent("GameTip").copy() as GameTipComponent;
			panel.addChild(_gameTip.panel);
			_gameTip.hide();
			
			_view.layer.setCenter(_gameTip.panel);
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
			super.hide();
		}
	}
}
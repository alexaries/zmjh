package com.game.view.dice
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.Base;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;

	public class FreeDiceView extends BaseView implements IView
	{
		private var _anti:Antiwear;
		public static const FREE_DICE_ID:int = 1;
		
		//private var _curPoints:uint;
		public function get curPoints() : uint
		{
			return _anti["curPoints"];
		}
		public function set curPoints(value:uint) : void
		{
			_anti["curPoints"] = value;
		}
		
		public function FreeDiceView()
		{
			_moduleName = V.FREE_DICE;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.PUBLIC;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["curPoints"] = 0;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch (type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
				case InterfaceTypes.SPECIFIC_DICE:
					startFreeDice();
					break;
			}
		}
		
		override protected function init() : void
		{
			if (!isInit)
			{
				isInit = true;
				super.init();
				
				initXML();
				initUI();
				getUI();
				initEvent();
			}
			
			hide();
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.PUBLIC, GameConfig.PUBLIC_RES, "FreeDomDicePosition");
		}
		
		private function initUI() : void
		{
			var name:String;
			var obj:DisplayObject;
			
			for each(var items:XML in _positionXML.layer)
			{
				for each(var element:XML in items.item)
				{
					name = element.@name;
					
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						_uiLibrary.push(obj);
					}
				}
			}
			
			_view.layer.setCenter(this.panel);
		}
		
		private var _selectedBG:Image;
		private function getUI() : void
		{
			if (!_selectedBG)
			{
				_selectedBG = this.searchOf("SelectDiceBg");
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			var sceneID:int;
			switch (name)
			{
				case "OkButton":
					onPlayFreeDice();
					break;
				case "CancelButton":
					this.hide();
					_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
					break;
				case "DiceOne":
					curPoints = 1;
					checkCurPoints(name);
					break;
				case "DiceTwo":
					curPoints = 2;
					checkCurPoints(name);
					break;
				case "DiceThree":
					curPoints = 3;
					checkCurPoints(name);
					break;
				case "DiceFour":
					curPoints = 4;
					checkCurPoints(name);
					break;
				case "DiceFive":
					curPoints = 5;
					checkCurPoints(name);
					break;
				case "DiceSix":
					curPoints = 6;
					checkCurPoints(name);
					if(_view.first_guide.isGuide)
						_view.first_guide.setFunc();
					break;
			}
		}
		
		protected function checkCurPoints(name:String) : void
		{
			if (!_selectedBG) return;
			
			var btn:Button = this.searchOf(name);
			_selectedBG.x = btn.x;
			_selectedBG.y = btn.y;
		}
		
		protected function startFreeDice() : void
		{
			if(_view.first_guide.isGuide)
				_view.first_guide.setFunc();
			
			var num:int = player.pack.getPropNumById(FREE_DICE_ID);
			
			if (num > 0)
			{
				curPoints = 1;
				checkCurPoints("DiceOne");
				this.display();
			}
			else
			{
				_view.tip.interfaces(
					InterfaceTypes.Show,
					"没有足够的如意骰子，是否移步到商城购买？",
					gotoMall, returnThis);
			}
		}
		
		private function returnThis() : void
		{
			_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
		}
		private function gotoMall() : void
		{
			_view.tip.hide();
			_view.shop.interfaces();
		}
		
		private function onPlayFreeDice() : void
		{
			var num:int = player.pack.getPropNumById(FREE_DICE_ID);
			player.pack.setPropNum(num-1, FREE_DICE_ID);
			_view.toolbar.interfaces(InterfaceTypes.LOCK);
			_view.map.interfaces(InterfaceTypes.THROW_FREE_DICE_RESULT, curPoints);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);

			this.hide();
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture> = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			return texture;
		}
		
		override public function update() : void
		{
			super.update();
		}
		
		override public function close() : void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
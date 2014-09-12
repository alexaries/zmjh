package com.game.view.midAutumn
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import feathers.controls.TextInput;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.core.ITextEditor;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class ContributeMoonCakeView extends BaseView implements IView
	{
		private var _anti:Antiwear;
		private function get nowNum() : int
		{
			return _anti["nowNum"];
		}
		private function set nowNum(value:int) : void
		{
			_anti["nowNum"] = value;
		}
		
		private function get propNum() : int
		{
			return _anti["propNum"];
		}
		private function set propNum(value:int) : void
		{
			_anti["propNum"] = value;
		}
		public function ContributeMoonCakeView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.CONTRIBUTE_MOONCAKE;
			_loaderModuleName = V.MID_AUTUMN;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["nowNum"] = 0;
			_anti["propNum"] = 0;
			
			super();
		}
		
		public function interfaces(type:String="", ...args):*
		{
			if (type == "") type = InterfaceTypes.Show;
			switch(type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
			}
		}
		
		override protected function init() : void
		{
			if(!this.isInit)
			{
				super.init();
				isInit = true;
				initXML();
				initTexture();
				initComponent();
				initUI();
				getUI();
				initEvent();
			}
			render();
			_view.layer.setCenter(panel);
		}
		
		private function render() : void
		{
			renderTF();
			renderBtn();
		}
		
		private function renderBtn() : void
		{
			if(nowNum > 0)
				addTouchable(_contributeMoonCakeBtn);
			else
				removeTouchable(_contributeMoonCakeBtn);
		}
		
		private function renderTF() : void
		{
			propNum = player.pack.getPropNumById(49);
			if(propNum > 0)
				nowNum = 1;
			else 
				nowNum = 0;
			_input.text = nowNum.toString();
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(_loaderModuleName, GameConfig.MID_AUTUMN_RES, "ContributeMoonCakePosition");
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				_titleTxAtlas = _view.mid_autumn.titleTxAtlas;
			}
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
					/*if(name == "PassGame")
					{
					cp = new FlipGameOverComponent(items, _titleTxAtlas);
					_components.push(cp);
					}*/
				}
			}
		}
		
		protected function initUI() : void
		{
			initLayout();
			
			display();
			_view.layer.setCenter(panel);
		}
		
		private function initLayout() : void
		{
			var name:String;
			var obj:*;			
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
		}
		
		private var _input:TextInput;
		private var _contributeMoonCakeBtn:Button;
		private function getUI() : void
		{
			if(!_input) _input = addText(153, 63, 40, 30, "1");
			_contributeMoonCakeBtn = this.searchOf("ContributeMoonCakeBtn");
		}
		
		override public function setTextEditor() : ITextEditor
		{
			var editor:StageTextTextEditor = new StageTextTextEditor();
			editor.fontFamily = "DFPHaiBaoW12-GB";
			editor.fontSize = 12;
			editor.color = 0xFFFFFF;
			editor.textAlign  = "center";
			editor.maxChars = 3;
			editor.restrict="0-9";
			return editor;
		}
		
		override public function inputChangeHandler(e:Event) : void
		{
			nowNum = int(_input.text);
			nowNum = _view.mid_autumn.checkMoonCake(nowNum);
			_input.text = nowNum.toString();
			if(nowNum > propNum)
			{
				nowNum = propNum;
				_input.text = nowNum.toString();
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "Close":
					hide();
					break;
				case "ContributeMoonCakeBtn":
					contributeMoonCake();
					break;
				case "Down_Press":
					reduceNum();
					break;
				case "Up_Press":
					addNum();
					break;
			}
		}
		
		private function addNum():void
		{
			if(nowNum < propNum)
			{
				nowNum++;
				_input.text = nowNum.toString();
			}
		}
		
		private function reduceNum():void
		{
			if(nowNum > 1)
			{
				nowNum--;
				_input.text = nowNum.toString();
			}
		}
		
		private function contributeMoonCake():void
		{
			if(nowNum <= 0)
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"请选择大于0的整数！",
					null, null, false, true, false);
				render();
			}
			else
			{
				_view.prompEffect.play("成功贡献" + nowNum + "个月饼");
				Data.instance.pack.changePropNum(49, -nowNum);
				player.midAutumnInfo.moonCakeUse += nowNum;
				render();
				_view.mid_autumn.interfaces(InterfaceTypes.REFRESH);
				_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			else
				textures = _titleTxAtlas.getTextures(name);
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			if (type == "public")
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			else if(type == "icon")
				texture = _view.icon.interfaces(InterfaceTypes.GetTexture, name);
			else
				texture = _titleTxAtlas.getTexture(name);
			return texture;
		}
	}
}
package com.game.view.midAutumn
{
	import com.game.Data;
	import com.game.data.db.protocal.Festivals;
	import com.game.data.player.structure.RoleInfo;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.equip.PropTip;
	import com.game.view.ui.UIConfig;
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class MidAutumnView extends BaseView implements IView
	{
		public function MidAutumnView()
		{
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.MID_AUTUMN;
			_moduleName = V.MID_AUTUMN;
			
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
				case InterfaceTypes.REFRESH:
					render();
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
		
		private var _positionXML:XML;
		private var _instructionXML:XML;
		private var _infoData:Vector.<Object>;
		private function initXML() : void
		{
			_positionXML = getXMLData(_loaderModuleName, GameConfig.MID_AUTUMN_RES, "MidAutumnPosition");
			_instructionXML = getXMLData(_loaderModuleName, GameConfig.MID_AUTUMN_RES, "MidAutumnInstructionPosition");
			_infoData = new Vector.<Object>();
			_infoData = Data.instance.db.interfaces(InterfaceTypes.GET_FESTIVALS_DATA);
		}
		
		private var _titleTxAtlas:TextureAtlas;
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(_loaderModuleName, GameConfig.MID_AUTUMN_RES, "MidAutumn");
				obj = getAssetsObject(_loaderModuleName, GameConfig.MID_AUTUMN_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
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
		
		private function initUI() : void
		{
			var name:String;
			var obj:*;
			var layerName:String;
			for each(var items:XML in _positionXML.layer)
			{
				layerName = items.@layerName;
				for each(var element:XML in items.item)
				{
					name = element.@name;
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						obj["layerName"] = layerName;
						_uiLibrary.push(obj);
					}
				}
			}
		}
		
		private var _nowMoonCakeTF:TextField;
		private var _alreadyMoonCakeTF:TextField;
		private var _contributeBtn:Button;
		private var _firstProp:Image;
		private var _allGift:Vector.<MidAutumnItem>;
		private var _barUp:Image;
		private var _propTip:PropTip;
		private function getUI() : void
		{
			_nowMoonCakeTF = this.searchOf("NowMoonCakeDetail");
			_alreadyMoonCakeTF = this.searchOf("AlreadyMoonCakeDetail");
			_contributeBtn = this.searchOf("ContributeBtn");
			_barUp = this.searchOf("BarUp");
			_allGift = new Vector.<MidAutumnItem>();
			for(var i:uint = 0; i < _infoData.length; i++)
			{
				var gift:MidAutumnItem = new MidAutumnItem();
				gift.setData(this.searchOf("Gift_" + (i + 1)), _infoData[i] as Festivals);
				_allGift.push(gift);
				
				(this.searchOf("NeedMoonCake_" + (i + 1)) as TextField).text = "月饼\n" + (_infoData[i] as Festivals).number + "个"; 
			}
			
			_propTip = _view.ui.interfaces(UIConfig.PROP_TIP);
			_propTip.add({o:_contributeBtn,m:{name:"", 
				message:"贡献月饼达到指定数额就可以点击上面的礼包获取奖励，累积的月饼越多后面得到的奖励越丰富。"}}); 
		}
		
		private function render() : void
		{
			renderTF();
			renderBtn();
			renderGift();
		}
		
		private var _barList:Array = [0, 30, 90, 150, 210, 270];
		private var _barWidth:Array = [30, 60, 60, 60, 60, 75];
		private function renderGift() : void
		{
			var name:String = "";
			var nowGift:int = 0;
			for(var i:int = _allGift.length - 1; i >= 0; i--)
			{
				if(player.midAutumnInfo.moonCakeUse >= _infoData[i].number)
				{
					_allGift[i].setTouchable();
				}
				else
				{
					_allGift[i].setUnTouchable();
					nowGift = i;
				}
			}
			for(var j:uint = 0; j < player.midAutumnInfo.alreadyGet.length; j++)
			{
				if(int(player.midAutumnInfo.alreadyGet[j]) == 1)
				{
					_allGift[j].setUnTouchable();
				}
			}
			
			var count:int = (nowGift >= 1?(_infoData[nowGift].number - _infoData[nowGift - 1].number):_infoData[nowGift].number);
			var num:int = (nowGift >= 1?(player.midAutumnInfo.moonCakeUse - _infoData[nowGift - 1].number):player.midAutumnInfo.moonCakeUse);
			_barUp.width = _barList[nowGift] + _barWidth[nowGift] * num / count;
			if(_barUp.width > 345) _barUp.width = 345;
		}
		
		private function renderTF() : void
		{
			_nowMoonCakeTF.text = player.pack.getPropNumById(49).toString();
			_alreadyMoonCakeTF.text = player.midAutumnInfo.moonCakeUse.toString();
		}
		
		private function renderBtn() : void
		{
			if(player.pack.getPropNumById(49) <= 0 || player.midAutumnInfo.moonCakeUse >= _infoData[5].number)
				removeTouchable(_contributeBtn);
			else
				addTouchable(_contributeBtn);
		}
		
		public function checkMoonCake(count:int) : int
		{
			var result:int = count;
			if(player.midAutumnInfo.moonCakeUse + count > int(_infoData[5].number))
				result = int(_infoData[5].number) - player.midAutumnInfo.moonCakeUse;
			
			return result;
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "Close":
					hide();
					break;
				case "ContributeBtn":
					contributeMoonCake();
					break;
			}
		}
		
		private function contributeMoonCake() : void
		{
			_view.contribute_mooncake.interfaces();
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
			else
				texture = _titleTxAtlas.getTexture(name);
			return texture;
		}
	}
}
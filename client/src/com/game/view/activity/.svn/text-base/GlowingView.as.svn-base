package com.game.view.activity
{
	import com.game.Data;
	import com.game.data.Activity.ActivityDetail;
	import com.game.data.db.protocal.Gift_package;
	import com.game.data.db.protocal.Prop;
	import com.game.data.player.structure.Player;
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
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class GlowingView extends BaseView implements IView
	{
		public function GlowingView()
		{
			_moduleName = V.GLOWING
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.ACTIVITY;
			
			super();
		}
		
		private var _preLoad:Boolean;
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch(type)
			{
				case InterfaceTypes.Show:
					_preLoad = false;
					this.show();
					break;
				case InterfaceTypes.HIDE:
					_preLoad = true;
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
			
			initRender();
			
			_view.layer.setCenter(panel);
		}
		
		private var _positionXML:XML;
		private var _giftData:Object;
		private function initXML() : void
		{
			_positionXML = getXMLData(_loaderModuleName, GameConfig.ACTIVITY_RES, "GlowingPosition");
			_giftData = Data.instance.db.interfaces(InterfaceTypes.GET_GIFT_DATA);
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(_loaderModuleName, GameConfig.ACTIVITY_RES, "Activity");
				obj = getAssetsObject(_loaderModuleName, GameConfig.ACTIVITY_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
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
					if(name == "PassGame")
					{
						/*cp = new FlipGameOverComponent(items, _titleTxAtlas);
						_components.push(cp);*/
					}
				}
			}
		}
		
		private var _propTip:PropTip;
		private var _btnList:Vector.<Button>;
		private var _infoList:Vector.<Prop>;
		private var _alreadyList:Vector.<Image>;
		private function getUI() : void
		{
			_propTip = _view.ui.interfaces(UIConfig.PROP_TIP);
			
			_btnList = new Vector.<Button>();
			_btnList.push(this.searchOf("10Btn") as Button);
			_btnList.push(this.searchOf("20Btn") as Button);
			_btnList.push(this.searchOf("30Btn") as Button);
			_btnList.push(this.searchOf("40Btn") as Button);
			_btnList.push(this.searchOf("50Btn") as Button);
			_btnList.push(this.searchOf("70Btn") as Button);
			_btnList.push(this.searchOf("100Btn") as Button);
			_btnList.push(this.searchOf("120Btn") as Button);
			_btnList.push(this.searchOf("130Btn") as Button);
			
			_alreadyList = new Vector.<Image>();
			_alreadyList.push(this.searchOf("AlreadyGet1") as Image);
			_alreadyList.push(this.searchOf("AlreadyGet2") as Image);
			_alreadyList.push(this.searchOf("AlreadyGet3") as Image);
			_alreadyList.push(this.searchOf("AlreadyGet4") as Image);
			_alreadyList.push(this.searchOf("AlreadyGet5") as Image);
			_alreadyList.push(this.searchOf("AlreadyGet6") as Image);
			_alreadyList.push(this.searchOf("AlreadyGet7") as Image);
			_alreadyList.push(this.searchOf("AlreadyGet8") as Image);
			_alreadyList.push(this.searchOf("AlreadyGet9") as Image);
			
			_infoList = new Vector.<Prop>();
			for(var i:int = 0; i < 8; i++)
			{
				_infoList.push(Data.instance.db.interfaces(InterfaceTypes.GET_PROP_BY_ID, 23 + i));
			}
			
			_infoList.push(Data.instance.db.interfaces(InterfaceTypes.GET_PROP_BY_ID, 55));
			
			for(var j:int = 0; j < _btnList.length; j++)
			{
				_propTip.add({o:_btnList[j], m:{name:_infoList[j].name, message:_infoList[j].message}});
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					_view.activity.interfaces();
					break;
				case "10Btn":
					addGlowing(23);
					break;
				case "20Btn":
					addGlowing(24);
					break;
				case "30Btn":
					addGlowing(25);
					break;
				case "40Btn":
					addGlowing(26);
					break;
				case "50Btn":
					addGlowing(27);
					break;
				case "70Btn":
					addGlowing(28);
					break;
				case "100Btn":
					addGlowing(29);
					break;
				case "120Btn":
					addGlowing(30);
					break;
				case "130Btn":
					addGlowing(55);
					break;
			}
		}
		
		/**
		 * 获得礼包，并且添加到存档
		 * @param count
		 * 
		 */		
		private function addGlowing(count:int) : void
		{
			Data.instance.pack.addNoneProp(count, 1);
			Data.instance.player.player.activityInfo.addActivity(count);
			
			_view.prompEffect.play("领取成功，请到道具栏打开礼包哦！");
			
			initRender();
			_view.toolbar.checkActivity();
			//_view.toolbar.interfaces(InterfaceTypes.REFRESH);
		}
		
		/**
		 * 初始化领取按钮
		 * 
		 */		
		private function initRender() : void
		{
			resetButton();
			
			var _mainRole:RoleModel = player.getRoleModel(V.MAIN_ROLE_NAME);
			var roleLv:int = _mainRole.model.lv;
			var count:int = Math.floor(roleLv / 10);
			for(var j:int = _btnList.length - 1; j >= count; j--)
			{
				removeTouchable(_btnList[j]);
			}
			if(roleLv < 70)   removeTouchable(_btnList[5]);
			if(roleLv < 100)   removeTouchable(_btnList[6]);
			if(roleLv < 120)   removeTouchable(_btnList[7]);
			if(roleLv < 130)	removeTouchable(_btnList[8]);
			
			var activities:Vector.<ActivityDetail> = Data.instance.player.player.activityInfo.activities;
			for(var i:int = 0; i < activities.length; i++)
			{
				switch(activities[i].id)
				{
					case 23:
						removeTouchable(this.searchOf("10Btn") as Button);
						_alreadyList[0].visible = true;
						break;
					case 24:
						removeTouchable(this.searchOf("20Btn") as Button);
						_alreadyList[1].visible = true;
						break;
					case 25:
						removeTouchable(this.searchOf("30Btn") as Button);
						_alreadyList[2].visible = true;
						break;
					case 26:
						removeTouchable(this.searchOf("40Btn") as Button);
						_alreadyList[3].visible = true;
						break;
					case 27:
						removeTouchable(this.searchOf("50Btn") as Button);
						_alreadyList[4].visible = true;
						break;
					case 28:
						removeTouchable(this.searchOf("70Btn") as Button);
						_alreadyList[5].visible = true;
						break;
					case 29:
						removeTouchable(this.searchOf("100Btn") as Button);
						_alreadyList[6].visible = true;
						break;
					case 30:
						removeTouchable(this.searchOf("120Btn") as Button);
						_alreadyList[7].visible = true;
						break;
					case 55:
						removeTouchable(this.searchOf("130Btn") as Button);
						_alreadyList[8].visible = true;
						break;
				}
			}
		}
		
		public function getStatus() : Boolean
		{
			var result:Boolean = false;
			initRender();
			for(var i:int = 0; i < _btnList.length; i++)
			{
				if(_btnList[i].touchable == true)
				{
					result = true;
					break;
				}
			}
			return result;
		}
		
		public function checkDeform() : void
		{
			
		}
		
		/**
		 * 重新设置按钮状态
		 * 
		 */		
		private function resetButton() : void
		{
			addTouchable(this.searchOf("10Btn") as Button);
			addTouchable(this.searchOf("20Btn") as Button);
			addTouchable(this.searchOf("30Btn") as Button);
			addTouchable(this.searchOf("40Btn") as Button);
			addTouchable(this.searchOf("50Btn") as Button);
			addTouchable(this.searchOf("70Btn") as Button);
			addTouchable(this.searchOf("100Btn") as Button);
			addTouchable(this.searchOf("120Btn") as Button);
			
			for(var i:int = 0; i < _alreadyList.length; i++)
			{
				_alreadyList[i].visible = false;
			}
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
	}
}
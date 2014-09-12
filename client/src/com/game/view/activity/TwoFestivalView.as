package com.game.view.activity
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.manager.URIManager;
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
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class TwoFestivalView extends BaseView implements IView
	{
		private var _anti:Antiwear;
		private function get twoFestivalTime() : String
		{
			if(_anti["twoFestivalTime"] == "")
				_anti["twoFestivalTime"] = "2013-09-16";
			return _anti["twoFestivalTime"];
		}
		
		public function TwoFestivalView()
		{
			_moduleName = V.TWO_FESTIVAL;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.ACTIVITY;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["twoFestivalTime"] = "";
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
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
				initText();
				initEvent();
			}
			
			initRender();
			
			_view.layer.setCenter(panel);
		}
		
		private function initRender() : void
		{
			resetState();
			Data.instance.activity.successFun = getActivity;
			Data.instance.activity.resetFun = resetState;
			renderButton();
		}
		
		private function renderButton() : void
		{
			var date:Date = Data.instance.time.returnTimeNow();
			var intervalTime:int = Data.instance.time.disDayNum(twoFestivalTime, Data.instance.time.curTimeStr.split(" ")[0]);
			if( intervalTime <= 23 && intervalTime >= 0)
			{
				if(intervalTime == 0 && date.hours < 10)
					removeTouchable(_submitBtn);
				else
					addTouchable(_submitBtn);
			}
			else
				removeTouchable(_submitBtn);
			
			if( intervalTime <= 23 && intervalTime >=0)
			{
				if((intervalTime == 0 && date.hours < 10) || (intervalTime == 23 && date.hours >= 16))
					removeTouchable(_activityBtn);
				else
					addTouchable(_activityBtn);
			}
			else
				removeTouchable(_activityBtn);
			
			if( intervalTime <= 22 && intervalTime >=0)
			{
				if((intervalTime == 0 && date.hours < 10))
					removeTouchable(_touchImg);
				else
					addTouchable(_touchImg);
			}
			else
				removeTouchable(_touchImg);
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(_loaderModuleName, GameConfig.ACTIVITY_RES, "TwoFestivalPosition");
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
					/*if(name == "PassGame")
					{
					cp = new FlipGameOverComponent(items, _titleTxAtlas);
					_components.push(cp);
					}*/
				}
			}
		}
		
		private var _placeTF:TextField;
		private var _touchImg:Image;
		private var _submitBtn:Button;
		private var _activityBtn:Button;
		private function getUI() : void
		{
			_placeTF = this.searchOf("DetailPlace");
			_placeTF.underline = true;
			
			var lightWhite:Texture = Texture.fromColor(_placeTF.textBounds.width + 10, _placeTF.textBounds.height + 5, 0xffffffff);
			_touchImg = new Image(lightWhite);
			_touchImg.x = _placeTF.x;
			_touchImg.y = _placeTF.y;
			_touchImg.alpha = 0;
			this.panel.addChild(_touchImg);
			_touchImg.useHandCursor = true;
			_touchImg.addEventListener(TouchEvent.TOUCH, onRenderPlace);
			
			_submitBtn = this.searchOf("Submit");
			_activityBtn = this.searchOf("GetActivation")
		}
		
		private function onRenderPlace(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_touchImg);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				URIManager.openScoreURL();
			}
		}
		
		private var _input:TextInput;
		private function initText() : void
		{
			_input = addText(195, 120, 240, 30, "");
		}
		
		override public function setTextEditor() : ITextEditor
		{
			var editor:StageTextTextEditor = new StageTextTextEditor();
			editor.fontFamily = "宋体";
			editor.fontSize = 15;
			editor.color = 0xFFFFFF;
			editor.textAlign  = "center";
			return editor;
		}
		
		/**
		 * 激活成功
		 * @param str
		 * 
		 */		
		private function getActivity(str:String) : void
		{
			switch(str)
			{
				case "197":
					_view.prompEffect.play("领取双节礼包成功，请到道具栏打开礼包哦！");
					Data.instance.pack.addNoneProp(50, 1);
					player.activityInfo.addActivity(50);
					break;
			}
			
			Log.Trace("双节礼包领取保存");
			_view.controller.save.onCommonSave(false, 1, false);
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					_view.activity.interfaces();
					break;
				case "Submit":
					getTwo();
					break;
				case "GetActivation":
					URIManager.openIntegrationURL();
					break;
			}
		}
		
		/**
		 * 开始发送激活码
		 * 
		 */		
		private function getTwo() : void
		{
			setState();
			setData();
		}
		
		/**
		 * 发送激活码后界面状态
		 * 
		 */		
		private function setState() : void
		{
			_view.tip.interfaces(InterfaceTypes.Show, 
				"系统正在处理当中，请稍等...",
				null, null, true);
			this.panel.touchable = false;
		}
		
		/**
		 * 收到返回的数据重新设置界面状态
		 * 
		 */		
		private function resetState() : void
		{
			_view.tip.interfaces(InterfaceTypes.HIDE);
			this.panel.touchable = true;
			_input.text = "";
			if(!_input.parent) 	this.panel.addChild(_input);
		}
		
		/**
		 * 发送激活码数据
		 * 
		 */		
		private function setData() : void
		{
			if(_input.text == "") 
			{
				resetState();
				_view.tip.interfaces(InterfaceTypes.Show,
					"请输入激活码！",
					null, null, false, true, false);
				return;
			}
			
			Data.instance.activity.urlData(_input.text);
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
		
		override public function hide() : void
		{
			if(_input && _input.parent) 	_input.parent.removeChild(_input);
			super.hide();
		}
	}
}
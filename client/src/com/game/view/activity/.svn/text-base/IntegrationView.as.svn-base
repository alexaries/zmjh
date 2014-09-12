package com.game.view.activity
{
	import com.adobe.crypto.MD5;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.manager.DebugManager;
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
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class IntegrationView extends BaseView implements IView
	{
		private static const KEYS:String = "0228acacd1c0ad3470a72e5f4e3847c3";
		private static const URLNAME:String = "http://my.4399.com/jifen/activation?";
		
		private var _anti:Antiwear;
		
		public function IntegrationView()
		{
			_moduleName = V.INTEGRATION;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.ACTIVITY;
			
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
				getData();
				initText();
				initEvent();
				initURL();
			}
			
			initRender();
			
			_view.layer.setCenter(panel);
		}
		
		private function initRender() : void
		{
			resetState();
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(_loaderModuleName, GameConfig.ACTIVITY_RES, "IntegrationPosition");
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
		
		private function getUI() : void
		{
			
		}
		
		private var _gameID:int;
		private var _userID:int;
		private function getData() : void
		{
			_gameID = Data.instance.pay.gameID;
			if(DebugManager.instance.gameMode == V.DEVELOP)
			{
				_userID = 115099833;
				return;
			}
			_userID = Data.instance.pay.userID;
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
		
		private var _urlLoader:URLLoader;
		private function initURL() : void
		{
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			_urlLoader.addEventListener(flash.events.Event.COMPLETE, urlCompleteHandler);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, urlErrorHandler);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, urlErrorHandler);
		}
		
		private function urlCompleteHandler(e:flash.events.Event) : void
		{
			resetState();
			var checkList:Array = new Array();
			checkList = dataAnalysis(e.target.data);trace(checkList[0], checkList[1]);
			switch(checkList[0])
			{
				//未知错误
				case "99":
					//_view.prompEffect.play("未知错误！");
					_view.prompEffect.play("激活失败！");
					break;
				//激活成功
				case "100":
					getActivity(checkList[1]);
					break;
				//参数错误
				case "101":
					//_view.prompEffect.play("参数错误！");
					_view.prompEffect.play("激活失败！");
					break;
				//激活码不存在
				case "102":
					_view.prompEffect.play("激活码不存在！");
					break;
				//激活码还没被兑换
				case "103":
					_view.prompEffect.play("激活码还没被兑换！");
					break;
				//激活码被使用过了哦
				case "104":
					_view.prompEffect.play("激活码被使用过了哦！");
					break;
				//激活码只能被领取者使用
				case "105":
					_view.prompEffect.play("激活码只能被领取者使用！");
					break;
				//您的账号已经使用此礼包的激活码，不能再使用咯~
				case "106":
					_view.prompEffect.play("您的账号已经使用此礼包的激活码，不能再使用咯！");
					break;
				//token无效
				case "107":
					//_view.prompEffect.play("token无效！");
					_view.prompEffect.play("激活失败！");
					break;
				//激活码失效了
				case "108":
					_view.prompEffect.play("激活码失效了！");
					break;
				//激活失败
				case "109":
					_view.prompEffect.play("激活失败！");
					break;
				//您的账号已经今天使用过激活码，不能再使用咯~
				case "110":
					_view.prompEffect.play("您的账号已经今天使用过激活码，不能再使用咯~！");
					break;
				default:
					_view.prompEffect.play("激活失败！");
					break;
			}
			if(DebugManager.instance.gameMode == V.DEVELOP)
			{
				Data.instance.pack.addNoneProp(21, 1);
				Data.instance.pack.addNoneProp(22, 1);
			}
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
				case "141":
					_view.prompEffect.play("领取新手礼包成功，请到道具栏打开礼包哦！");
					Data.instance.pack.addNoneProp(21, 1);
					Data.instance.player.player.activityInfo.addActivity(21);
					break;
				case "142":
					_view.prompEffect.play("领取皇家礼包成功，请到道具栏打开礼包哦！");
					Data.instance.pack.addNoneProp(22, 1);
					Data.instance.player.player.activityInfo.addActivity(22);
					break;
			}
			
			Log.Trace("新手礼包，皇家礼包领取保存");
			_view.controller.save.onCommonSave(false, 1, false);
		}
		
		/**
		 * 分析从网页返回的数据
		 * @param str
		 * @return 
		 * 
		 */		
		private function dataAnalysis(str:String) : Array
		{
			var lastList:Array = new Array();
			var newStr:String = str.slice(1, str.length - 1);
			var arrList:Array = newStr.split(","); 
			for(var i:int = 0; i < arrList.length; i++)
			{
				var newList:Array = arrList[i].split(":");
				lastList[i] = newList[1];
			}
			lastList[1] = String(lastList[1]).slice(1, String(lastList[1]).length - 1);
			return lastList;
		}
		
		/**
		 * 加载异常
		 * @param e
		 * 
		 */		
		private function urlErrorHandler(e:IOErrorEvent) : void
		{
			_view.prompEffect.play("网络异常，请重新输入激活码！");
			resetState();
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
					getIntegration();
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
		private function getIntegration() : void
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
			
			urlData();
		}
		
		/**
		 * url数据发送
		 * 
		 */		
		private function urlData() : void
		{
			var activityStr:String = _input.text;
			
			var urlVariables:URLVariables = new URLVariables();
			urlVariables.uniqueId = _gameID;
			urlVariables.activation = activityStr;
			urlVariables.uid = _userID;
			var token:String = MD5.hash(urlVariables.activation + "-" + urlVariables.uid + "-" + urlVariables.uniqueId + "-" + KEYS);
			urlVariables.token = token;
			
			var urlRequest:URLRequest = new URLRequest(URLNAME + Math.random());
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = urlVariables;
			
			_urlLoader.load(urlRequest);
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
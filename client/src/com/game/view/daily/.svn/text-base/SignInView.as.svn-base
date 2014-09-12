package com.game.view.daily
{
	import com.game.Data;
	import com.game.data.db.protocal.Daily_attendance;
	import com.game.data.player.structure.RoleModel;
	import com.game.data.player.structure.SignInInfo;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import starling.text.TextField;
	import starling.textures.Texture;

	public class SignInView extends BaseView implements IView
	{
		/**
		 *　每天模板数据 
		 */		
		private var _dailyTemplateData:Object;
		/**
		 * UI位置文件 
		 */		
		private var _positionXML:XML;
		/**
		 * 签到信息 
		 */		
		private var _signInInfo:SignInInfo;
		private var _diceNum:TextField;
		
		public function SignInView()
		{
			_moduleName = V.SIGN_IN;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.PUBLIC;
			
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
			}
		}
		
		override protected function init() : void
		{
			if (!isInit)
			{
				super.init();
				isInit = true;
				
				initData();
				initUI();
				getUI();
				initEvent();
			}
			
			getData();
		}
		
		protected function getData() : void
		{
			_signInInfo = Data.instance.daily.getSignInInfo();
			
			// 请求服务器时间
			if (!Data.instance.time.isGetTime)
			{
				_view.loadData.loadDataPlay();
				Data.instance.time.reqTime(callback);
			}
			else
			{
				callback();
			}
			
			/// 回调
			function callback() : void
			{
				var signDay:int = Data.instance.time.checkDailyDay(_signInInfo);
				
				render(signDay);
			}
			
			//显示当前骰子数
			_diceNum.text = player.dice.toString();
		}
		
		protected function render(signDay:int) : void
		{
			var component:DayNumComponent;
			var dailyData:Daily_attendance;
			
			for (var i:int = 1; i <= 5; i++)
			{
				dailyData = _dailyTemplateData[i - 1];
				component = searchOf(i + "Day");
				component.initData(dailyData, signDay);
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "CloseBt":
					this.hide();
					break;
			}
		}
		
		protected function initData() : void
		{
			if (!_dailyTemplateData)
			{
				_dailyTemplateData = Data.instance.db.interfaces(InterfaceTypes.GET_DAILY_DATA);
			}
			
			if (!_positionXML)
			{
				_positionXML = getXMLData(V.DAILY, GameConfig.DAILY_RES, "SignPosition");
			}
		}
		
		protected function initUI() : void
		{
			initComponent();
			initLayout();
			
			display();
			_view.layer.setCenter(panel);
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
						case "DayNum":
							cp = new DayNumComponent(items, _view.daily.titleTxAtlas);
							_components.push(cp);
							break;
					}
				}
			}
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
		
		private function getUI() : void
		{
			_diceNum = this.searchOf("DiceNum");
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
				textures = _view.daily.titleTxAtlas.getTextures(name);
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
				texture = _view.daily.titleTxAtlas.getTexture(name);
			}
			
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
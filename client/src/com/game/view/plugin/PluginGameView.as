package com.game.view.plugin
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.equip.PropTip;
	import com.game.view.ui.UIConfig;
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.filters.GrayscaleFilter;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	
	public class PluginGameView extends BaseView implements IView
	{
		
		/**
		 * UI位置文件 
		 */		
		private var _positionXML:XML;
		/**
		 * 纹理 
		 */		
		private var _titleTxAtlas:TextureAtlas;
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		
		/**
		 * 酒 
		 */		
		private var _wineBtn:Button;
		/**
		 * 酒已挑战 
		 */		
		private var _winePlayed:Image;
		/**
		 * 色 
		 */		
		private var _lecheryBtn:Button;
		/**
		 * 色已挑战
		 */		
		private var _lecheryPlayed:Image;
		/**
		 * 财 
		 */		
		private var _moneyBtn:Button;
		/**
		 * 财已挑战
		 */		
		private var _moneyPlayed:Image;
		/**
		 * 气 
		 */		
		private var _breathBtn:Button;
		/**
		 * 气已挑战
		 */		
		private var _breathPlayed:Image;
		
		public function PluginGameView()
		{
			_moduleName = V.PLUGIN_GAME;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.PLUGIN_GAME;
			
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
				case InterfaceTypes.GetTexture:
					return getTexture(args[0], "");
					break;
				case InterfaceTypes.GetTextures:
					return getTextures(args[0], "");
					break;
			}
		}
		
		override protected function init():void
		{
			if (!isInit)
			{
				super.init();
				isInit = true;
				
				initData();
				initTextures();
				initUI();
				getUI();
				initEvent();
			}
			
			renderPlayer();
			checkReqTime();
		}
		
		private var roleLv:int;
		private function renderPlayer() : void
		{
			var _mainRole:RoleModel = player.getRoleModel(V.MAIN_ROLE_NAME);
			roleLv = _mainRole.model.lv;
		}
		
		/**
		 * 检测是否请求得到服务器时间 
		 * 
		 */		
		protected function checkReqTime() : void
		{
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
				Log.Trace("PluginGame:请求得到服务器时间");
				renderWine();
				renderLechery();
				renderMoney();
				renderBreath();
			}
		}
		
		protected function renderWine() : void
		{
			var lastWineTime:String = Data.instance.plugin.getPluginInfo().wine;
			
			// 判断今日是否已经玩过每日插件游戏了
			var isLoginPluginGame:Boolean = Data.instance.time.checkEveryDayPlay(lastWineTime);
			
			if (isLoginPluginGame || (!isLoginPluginGame && player.vipInfo.checkLevelTwo() && player.pluginGameInfo.pluginTime[0] < 2))
			{
				_winePlayed.visible = false;
				_wineBtn.touchable = true;
			}
			else
			{
				_winePlayed.visible = true;
				_wineBtn.touchable = false;
			}
		}
		
		protected function renderLechery() : void
		{
			var lastLechery:String = Data.instance.plugin.getPluginInfo().lechery;
			var isLoginPluginGame:Boolean = Data.instance.time.checkEveryDayPlay(lastLechery);
			if(isLoginPluginGame || (!isLoginPluginGame && player.vipInfo.checkLevelTwo() && player.pluginGameInfo.pluginTime[1] < 2))
			{
				_lecheryBtn.touchable = true;
				_lecheryPlayed.visible = false;
			}
			else
			{
				_lecheryBtn.touchable = false;
				_lecheryPlayed.visible = true;
			}
		}
		
		protected function renderMoney() : void
		{
			var lastMoney:String = Data.instance.plugin.getPluginInfo().money;
			var isLoginPluginGame:Boolean = Data.instance.time.checkEveryDayPlay(lastMoney);
			if(isLoginPluginGame || (!isLoginPluginGame && player.vipInfo.checkLevelTwo() && player.pluginGameInfo.pluginTime[2] < 2))
			{
				_moneyBtn.touchable = true;
				_moneyPlayed.visible = false;
			}
			else
			{
				_moneyBtn.touchable = false;
				_moneyPlayed.visible = true;
			}
		}
		
		protected function renderBreath() : void
		{
			var lastBreath:String = Data.instance.plugin.getPluginInfo().breath;
			var isLoginPluginGame:Boolean = Data.instance.time.checkEveryDayPlay(lastBreath);
			//5级开启
			if(roleLv >= 5)
			{
				_breathBtn.touchable = true;
				_breathBtn.filter = null;
			}
			else
			{
				_breathBtn.touchable = false;
				_breathBtn.filter = new GrayscaleFilter();
				return;
			}
			if(isLoginPluginGame || (!isLoginPluginGame && player.vipInfo.checkLevelTwo() && player.pluginGameInfo.pluginTime[3] < 2))
			{
				_breathBtn.touchable = true;
				_breathPlayed.visible = false;
			}
			else
			{
				_breathBtn.touchable = false;
				_breathPlayed.visible = true;
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					break;
				case "WineDescribe":
					onWineDescribe();
					break;
				case "LecheryDescribe":
					onLecheryDescribe();
					break;
				case "BreathDescribe":
					onBreathDescribe();
					break;
				case "MoneyDescribe":
					onMoneyDescribe();
					break;

				// 酒国英雄
				case "WineBt":
					onWine();
					break;
				//色艺双绝
				case "Lechery":
					onLechery();
					break;
				//气吞山河
				case "Breath":
					onBreath();
					break;
				case "MoneyBt":
					onMoney();
					break;
			}
		}
		
		/**
		 * 酒——副本说明
		 * 
		 */		
		protected function onWineDescribe() : void
		{
			_view.introducePluginGame.interfaces("", "wine");
		}
		/**
		 * 色——副本说明
		 * 
		 */		
		protected function onLecheryDescribe() : void
		{
			_view.introducePluginGame.interfaces("", "lechery");
		}
		/**
		 * 财——副本说明
		 * 
		 */		
		protected function onMoneyDescribe() : void
		{
			_view.introducePluginGame.interfaces("", "money");
		}
		/**
		 * 气——副本说明
		 * 
		 */		
		protected function onBreathDescribe() : void
		{
			_view.introducePluginGame.interfaces("", "breath");
		}
		
		/**
		 * 酒 
		 * 
		 */		
		protected function onWine() : void
		{
			this.hide();
			_view.move_game.interfaces();
		}
		/**
		 * 色
		 * 
		 */		
		protected function onLechery() : void
		{
			this.hide();
			_view.flip_Game.interfaces();
		}
		/**
		 * 财
		 * 
		 */		
		protected function onMoney() : void
		{
			this.hide();
			_view.run_game.interfaces();
		}
		/**
		 * 气
		 * 
		 */		
		protected function onBreath() : void
		{
			this.hide();
			_view.link_game.interfaces();
		}
		
		
		/**
		 * 获取模板数据 
		 * 
		 */		
		private function initData() : void
		{
			if (!_positionXML)
			{
				_positionXML = getXMLData(_loadBaseName, GameConfig.PLUGIN_GAME_RES, "PluginGamePosition");
			}
		}
		
		/**
		 * 纹理 
		 * 
		 */		
		private function initTextures() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				
				var textureXML:XML = getXMLData(_loadBaseName, GameConfig.PLUGIN_GAME_RES, "PluginGame");			
				obj = getAssetsObject(_loadBaseName, GameConfig.PLUGIN_GAME_RES, "Textures");
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
			
			display();
			_view.layer.setCenter(panel);
		}
		
		private var _propTip:PropTip;
		private function getUI() : void
		{
			_wineBtn = this.searchOf("WineBt");
			_lecheryBtn = this.searchOf("Lechery");
			_moneyBtn = this.searchOf("MoneyBt");
			_breathBtn = this.searchOf("Breath");
			_winePlayed = this.searchOf("WinePassed");
			_lecheryPlayed = this.searchOf("LecheryPassed");
			_breathPlayed = this.searchOf("BreathPassed");
			_moneyPlayed = this.searchOf("MoneyPassed");
			
			_winePlayed.visible = false;
			_lecheryPlayed.visible = false;
			_breathPlayed.visible = false;
			_moneyPlayed.visible = false;
			
			_propTip = _view.ui.interfaces(UIConfig.PROP_TIP);
			_propTip.add({o:searchOf("WineDescribe"),m:{name:"", 
				message:"完美过关额外获得两个技能符文。完美条件：获得20个普通骰子，4个如意骰子，4个满汉全席，4个雪山人参。"}}); 
			_propTip.add({o:searchOf("LecheryDescribe"),m:{name:"", 
				message:"完美过关额外获得两个技能符文。完美条件：连翻数达到8次及8次以上。"}}); 
			_propTip.add({o:searchOf("MoneyDescribe"),m:{name:"", 
				message:"完美过关额外获得两个技能符文。完美条件：财源广进通关并且获得金钱数达到6000以上。"}}); 
			_propTip.add({o:searchOf("BreathDescribe"),m:{name:"", 
				message:"完美过关额外获得两个技能符文。完美条件：击破数达到50个以上。"}}); 
			
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
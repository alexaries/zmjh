package com.game.view.PublicRes
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.Base;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.save.SaveConfig;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.Font;
	import flash.utils.getTimer;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class PublicResView extends BaseView implements IView
	{
		public function PublicResView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.PRELOAD;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			var result:*;
			
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
				case InterfaceTypes.GetTextures:
					result = getTextures(args[0], '');
					break;
				case InterfaceTypes.GetTexture:
					result = getTexture(args[0], '');
					break;
			}
			
			return result;
		}
		
		override protected function show():void
		{
			_loadResources = GameConfig.instance.ASSETS[_moduleName]["module"];
			
			if (_view.load.isInit){
				loadBar = _view.load.loadProgressBar;
				
				_view.load.startLoadGame();
			}
			
			super.show();
		}
		
		override protected function init() : void
		{
			super.init();
			initTexture();
			beginInitEnvironment();
		}
		
		/**
		 * 初始化环境 
		 * 
		 */		
		public function beginInitEnvironment() : void
		{
			_view.roleRes.interfaces();
			_view.role_big.interfaces();
			_view.roleLVUp.interfaces();
			_view.roleGain.interfaces();
			_view.passLV.interfaces();
			_view.weather.interfaces();
			_view.weather_pass.interfaces();
			_view.weather_prop.interfaces();
			_view.moon_cake.interfaces();
			_view.activity_national_pass.interfaces();
			_view.guide.interfaces();
			_view.ui.interfaces();
			_view.icon.interfaces();
			_view.freeDice.interfaces();
			_view.dice.interfaces();
			_view.other_effect.interfaces();
			_view.double_level.interfaces(InterfaceTypes.HIDE);
			_view.dialog.interfaces(InterfaceTypes.INIT);
			_view.cartoon.interfaces(InterfaceTypes.INIT);
			_view.daily.interfaces();
			
			_view.freeDice.hide();
			_view.dice.hide();
			
			_view.controller.db.init();
			_view.controller.player.reqPlayerData(onLoadPlayerComplete);
			
			// 初次加载完后，检测是否播放新玩家
			checkNewPlayer();
		}
		
		private function checkNewPlayer() : void
		{
			if(!player.checkFirstGuide())
				_view.first_guide.interfaces();
			if(!player.checkRoleGetGuide())
				_view.get_role_guide.interfaces();
			
			if (_view.save.saveType == SaveConfig.NEW_PLAYER_SAVE)
			{
				_view.dialog.interfaces(
					InterfaceTypes.Show,
					"new_player",
					"",
					"start",
					firstGuide
				);	
			}
			else
			{
				Data.instance.guide.guideInfo.addGuideInfo("first", "first");
			}
		}
		
		private function firstGuide() : void
		{
			_view.first_guide.firstGuide();
		}
		
		/**
		 * 加载玩家数据完成后 ,打开世界地图
		 * 
		 */		
		protected function onLoadPlayerComplete() : void
		{
			// 每日任务检测
			Data.instance.misson.checkData();
			// 在线奖励检测
			Data.instance.onlineTime.checkOnlineTime();
			// 双倍副本检测
			Data.instance.double_level.checkDoubleTime();
			// 世界BOSS检测
			Data.instance.world_boss.checkWorldBoss();
			// 玩家PK
			Data.instance.player_fight.checkData();
			// 天地会
			Data.instance.union.checkData();
			// vip每日礼包
			Data.instance.vip.checkData();
			// 每日必做
			Data.instance.daily_thing.checkData();
			// 扫荡
			Data.instance.auto_fight.checkData();
			
			_view.world.interfaces();
			
			//六一儿童节活动
			//checkActivity();
		}
		
		/**
		 * 六一儿童节活动
		 * 
		 */		
		private function checkActivity() : void
		{
			//if(Data.instance.player.player.activity == 1)  return;
			
			var strList:Array = (Data.instance.time.curTimeStr.slice(0, 10)).split("-");
			if(strList[0] == "2013" && strList[1] == "06" && (strList[2] == "01" || strList[2] == "02" || strList[2] == "03"))
			{
				_view.newActivity.interfaces();
			}
		}
		
		private var _textureXML:XML;
		private var _textureTitle:Texture;
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
				
				_textureXML = getXMLData(V.PUBLIC, GameConfig.PUBLIC_RES, "public");
				
				obj = getAssetsObject(V.PUBLIC, GameConfig.PUBLIC_RES, "Textures");
				_textureTitle = Texture.fromBitmap(obj as Bitmap);
				_titleTxAtlas = new TextureAtlas(_textureTitle, _textureXML);
				
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var vec:Vector.<Texture>;
			
			vec = _titleTxAtlas.getTextures(name);
			
			return vec;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			
			texture = _titleTxAtlas.getTexture(name);
			
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
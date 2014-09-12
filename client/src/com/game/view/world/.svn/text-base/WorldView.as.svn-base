package com.game.view.world
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.manager.DebugManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.Base;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TouchEvent;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class WorldView extends BaseView implements IView
	{
		private static const FIGHT_SPEED_INIT:Number = 1;
		private static const FIGHT_SPEED_1:Number = 1.5;
		private static const FIGHT_SPEED_2:Number = 2;
		private static const FIGHT_SPEED_3:Number = 2.5;
		private static const FIGHT_SPEED_4:Number = 3;
		
		private var _anti:Antiwear;
		
		/**
		 * 当前最高关卡 
		 */		
		private var _curHighLV:int;
		/**
		 * 位置配置信息 
		 */		
		private var _positionXML:XML;
		/**
		 * 纹理 
		 */		
		private var _titleTxAtlas:TextureAtlas;
		
		/**********************UI***********************/
		/**
		 * 丽春院 
		 */		
		private var _buildLCY:BuildingNameComponent;
		/**
		 *  扬州城
		 */		
		private var _buildYZC:BuildingNameComponent;
		/**
		 *  京城
		 */		
		private var _buildJC:BuildingNameComponent;
		/**
		 * 皇宫 
		 */		
		private var _buildHG:BuildingNameComponent;
		/**
		 * 慈宁宫
		 */		
		private var _buildCNG:BuildingNameComponent;
		/**
		 * 神龙岛
		 */		
		private var _buildSLD:BuildingNameComponent;
		/**
		 * 每日鯨喜 
		 */		
		private var _dialy:BuildingNameComponent;
		/**
		 * 酒色财气 
		 */		
		private var _plugin:BuildingNameComponent;
		/**
		 * 练功房
		 */		
		private var _lianGong:BuildingNameComponent;
		/**
		 * 天地会
		 */		
		private var _tianDiHui:BuildingNameComponent;
		/**
		 * 图标 
		 */		
		private var _icons:Array;
		
		/**
		 * 是否允许跳过战斗
		 * @return 
		 * 
		 */		
		public function get allowSkip() : Boolean
		{
			return _anti["allowSkip"];
		}
		
		public function set allowSkip(value:Boolean) : void
		{
			_anti["allowSkip"] = value;
		}
		
		public function get allowChange() : Number
		{
			return _anti["allowChange"];
		}
		
		public function set allowChange(value:Number) : void
		{
			_anti["allowChange"] = value;
		}
		
		public function get speedChange() : Number
		{
			return _anti["speedChange"];
		}
		
		public function set speedChange(value:Number) : void
		{
			_anti["speedChange"] = value;
		}
		
		private var _callback:Function;
		
		public function WorldView()
		{
			_layer = LayerTypes.WORLD;
			_moduleName = V.WORLD;
			_loaderModuleName = V.PUBLIC;
			
			_anti = new Antiwear(new binaryEncrypt());
			
			allowSkip = false;
			allowChange = 1;
			speedChange = 1;
			
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
				case InterfaceTypes.HIDE:
					this.hide();
					break;
				case InterfaceTypes.REFRESH:
					refresh();
					break;
			}
		}
		
		override protected function init() : void
		{
			if (!isInit)
			{
				super.init();
				
				_positionXML = getXMLData(_loadBaseName, GameConfig.WORLD_RES, "WorldPosition");
				initUI();
				getUI();
				initEvent();
			}
			
			_view.toolbar.interfaces(InterfaceTypes.Show, V.WORLD);
			refresh();
			isInit = true;
		}
		
		private function refresh() : void
		{
			display();
			_curHighLV = _view.controller.LVSelect.getHighLV();
			playSound();
			setAllRoleState();
			setSpeedInfo();
			render();
		}
		
		/**
		 * 播放声音 
		 * 
		 */		
		private function playSound() : void
		{
			var sound:Object = getAssetsData(V.START, GameConfig.START_RES);
			_view.sound.playSound(sound, "start", true);
		}
		
		/**
		 * 恢复所有角色，状态（debuff）去除 
		 * 
		 */		
		public function setAllRoleState() : void
		{
			player.recoverAllRole();
		}
		
		/**
		 * 获得用户累积充值的游戏币，判断可以加速的等级
		 * 
		 */		
		public function setSpeedInfo() : void
		{
			if(DebugManager.instance.gameMode == V.DEVELOP)
			{
				speedChange = FIGHT_SPEED_4;
				return;
			}
			//加速等级判断
			if(player.mainRoleModel.info.lv >= 15 && player.mainRoleModel.info.lv < 40) speedChange = FIGHT_SPEED_1;
			else if(player.mainRoleModel.info.lv >= 40) speedChange = FIGHT_SPEED_2;
			else speedChange = FIGHT_SPEED_INIT;
			//VIP等级加速
			/*Data.instance.pay.getTotalRecharged(
				function (str:String) : void
				{
					var rechargeMoney:int = int(str);
					if(rechargeMoney > 1000 && rechargeMoney < 2000)
					{
						if(speedChange < FIGHT_SPEED_2) speedChange = FIGHT_SPEED_2;
					}
					else if(rechargeMoney >= 2000 && rechargeMoney < 10000)
					{
						if(speedChange < FIGHT_SPEED_3) speedChange = FIGHT_SPEED_3;
					}
					else if(rechargeMoney >= 10000)
					{
						if(speedChange < FIGHT_SPEED_4) speedChange = FIGHT_SPEED_4;
					}
				},
				setSpeedInfo);*/
		}
		
		private function render() : void
		{
			if (!isInit)
			{
				_icons=[];
				_icons.push(
					new WorldIcon(searchOf("Courtyard") as Image,searchOf("CourtyardLight"),handClick),
					new WorldIcon(searchOf("YangZhou") as Image,searchOf("YangZhouLight"),handClick),
					new WorldIcon(searchOf("Capital") as Image,searchOf("CapitalLight"),handClick),
					new WorldIcon(searchOf("Palace") as Image,searchOf("PalaceLight"),handClick),
					new WorldIcon(searchOf("CiNing") as Image,searchOf("CiNingLight"),handClick),
					new WorldIcon(searchOf("Island") as Image,searchOf("IslandLight"),handClick),
					new WorldIcon(searchOf("Whale") as Image,searchOf("WhaleLight"),handClick),
					new WorldIcon(searchOf("Plugin") as Image,searchOf("PluginLight"),handClick),
					new WorldIcon(searchOf("LianGongFang") as Image,searchOf("LianGongFangLight"),handClick),
					new WorldIcon(searchOf("Union") as Image,searchOf("UnionLight"),handClick)
				);
			}
			
			(searchOf("Courtyard") as Image).useHandCursor = (searchOf("Courtyard") as Image).touchable = _icons[0].animationed=(_curHighLV >= 1);
			(searchOf("YangZhou") as Image).useHandCursor = (searchOf("YangZhou") as Image).touchable = _icons[1].animationed= (_curHighLV >= 2);
			(searchOf("Capital") as Image).useHandCursor = (searchOf("Capital") as Image).touchable = _icons[2].animationed= (_curHighLV >= 3);
			(searchOf("Palace") as Image).useHandCursor = (searchOf("Palace") as Image).touchable = _icons[3].animationed= (_curHighLV >= 4);
			(searchOf("CiNing") as Image).useHandCursor = (searchOf("CiNing") as Image).touchable = _icons[4].animationed= (_curHighLV >= 5);
			(searchOf("Island") as Image).useHandCursor = (searchOf("Island") as Image).touchable = _icons[5].animationed= (_curHighLV >= 6);
			(searchOf("Whale") as Image).useHandCursor = (searchOf("Whale") as Image).touchable = _icons[6].animationed = true;
			(searchOf("Plugin") as Image).useHandCursor = (searchOf("Plugin") as Image).touchable = _icons[7].animationed = true;
			(searchOf("LianGongFang") as Image).useHandCursor = (searchOf("LianGongFang") as Image).touchable = _icons[8].animationed = true;
			(searchOf("Union") as Image).useHandCursor = (searchOf("Union") as Image).touchable = _icons[9].animationed = true;
			
			_buildLCY.setCityName((searchOf("Courtyard") as Image).touchable ? "丽春院" : "");
			_buildYZC.setCityName((searchOf("YangZhou") as Image).touchable ? "扬州城" : "");
			_buildJC.setCityName((searchOf("Capital") as Image).touchable ? "京城" : "");
			_buildHG.setCityName((searchOf("Palace") as Image).touchable ? "皇宫" : "");
			_buildCNG.setCityName((searchOf("CiNing") as Image).touchable ? "慈宁宫" : "");
			_buildSLD.setCityName((searchOf("Island") as Image).touchable ? "神龙岛" : "");
			_dialy.setCityName((searchOf("Whale") as Image).touchable ? "每日鲸喜" : "");
			_plugin.setCityName((searchOf("Plugin") as Image).touchable ? "酒色财气" : "");
			_lianGong.setCityName((searchOf("LianGongFang") as Image).touchable ? "练功房" : "");
			_tianDiHui.setCityName((searchOf("Union") as Image).touchable ? "天地会" : "");
		}
		
		private function initUI() : void
		{
			initTeture();
			initComponent();
			initRender();
		}
		
		private function initTeture() : void
		{
			var obj:*;
			
			var textureXML:XML = getXMLData(_loadBaseName, GameConfig.WORLD_RES, "World");	
			obj = getAssetsObject(_loadBaseName, GameConfig.WORLD_RES, "WorldTitle");
			var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
			
			_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
			(obj as Bitmap).bitmapData.dispose();
			obj = null;
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
						case "BuildingName":
							cp = new BuildingNameComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
					}
				}
			}
		}
		
		/**
		 * 渲染 
		 * 
		 */		
		private function initRender() : void
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
			if (!_buildLCY) _buildLCY = this.searchOf("LiChunYuan");			
			if (!_buildYZC) _buildYZC = this.searchOf("YangZhouCheng");			
			if (!_buildJC) _buildJC = this.searchOf("JingCheng");			
			if (!_buildHG) _buildHG = this.searchOf("HuangGong");
			if (!_buildCNG) _buildCNG = this.searchOf("CiNingGong");
			if (!_buildSLD) _buildSLD = this.searchOf("ShenLongDao");
			if (!_dialy) _dialy = this.searchOf("MeiRiJingXi");
			if (!_plugin) _plugin = this.searchOf("JiuSeCaiQi");
			if (!_lianGong) _lianGong = this.searchOf("LianGong");
			if (!_tianDiHui) _tianDiHui = this.searchOf("TianDiHui");
		}
		
		/**
		 * 事件监听 
		 * @param e
		 * 
		 */		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			var sceneID:int;
	 		handClick(sceneID,name);
		}
		
		private function handClick(sceneID:int,name:String):void
		{
			switch (name)
			{
				//神龙岛
				case "Island":
					sceneID = 6;
					onLvSelect(sceneID);
					removeIconDeform(sceneID);
					break;
				//慈宁宫
				case "CiNing":
					sceneID = 5;
					onLvSelect(sceneID);
					removeIconDeform(sceneID);
					break;
				// 皇宫
				case "Palace":
					sceneID = 4;
					onLvSelect(sceneID);
					removeIconDeform(sceneID);
					break;
				// 京城
				case "Capital":
					sceneID = 3;
					onLvSelect(sceneID);
					removeIconDeform(sceneID);
					break;
				// 扬州城
				case "YangZhou":
					sceneID = 2;
					onLvSelect(sceneID);
					removeIconDeform(sceneID);
					break;
				// 丽春院
				case "Courtyard":
					sceneID = 1;
					onLvSelect(sceneID);
					removeIconDeform(sceneID);
					//1级向导
					if(_view.first_guide.isGuide)
						_view.first_guide.setFunc();
					break;
				// 每日鲸喜
				case "Whale":
					_view.daily.interfaces();
					break;
				// 酒色财气
				case "Plugin":
					_view.pluginGame.interfaces();
					break;
				//练功房
				case "LianGongFang":
					_view.roleSelect.interfaces(InterfaceTypes.SET_EFFECT);
					break;
				//天地会
				case "Union":
					_view.union.interfaces();
					break;
				default:
					Log.Trace(name);
			}
		}
		
		/**
		 * 添加抖动效果
		 * @param id
		 * 
		 */		
		public function addIconDeform(id:int) : void
		{
			if(_icons != null)
				_icons[id - 1].isShake = true;
		}
		
		/**
		 * 删除抖动效果
		 * @param id
		 * 
		 */		
		public function removeIconDeform(id:int) : void
		{
			if(_icons != null)
				_icons[id - 1].isShake = false;
		}
		
		public function showIcon() : void
		{
			if(_tianDiHui != null)
			{
				_tianDiHui.panel.visible = true;
				(searchOf("Union") as Image).visible = true;
				(searchOf("UnionLight") as Image).visible = true;
			}
		}
		
		public function hideIcon() : void
		{
			if(_tianDiHui != null)
			{
				_tianDiHui.panel.visible = false;
				(searchOf("Union") as Image).visible = false;
				(searchOf("UnionLight") as Image).visible = false;
			}
		}
		
		/**
		 * 关卡选择 
		 * @param sceneID
		 * 
		 */		
		private function onLvSelect(sceneID:int) : void
		{
			_view.levelSelect.interfaces(InterfaceTypes.Show, sceneID);
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture> = _titleTxAtlas.getTextures(name);
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			
			if (type == "pack")
			{
				texture = this.getTextureFromSwf2(GameConfig.WORLD_RES, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			
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
		
		override public function close() : void
		{
			if (!active) return;
			
			var icon:WorldIcon;
			while (_icons.length)
			{
				icon = _icons.pop();
				icon.clear();
				icon = null;
			}
			
			_buildLCY = null;
			_buildYZC = null;
			_buildJC = null;
			_buildHG = null;
			_buildCNG = null;
			_buildSLD = null;
			
			_titleTxAtlas.dispose();
			_titleTxAtlas = null;
			
			this.destroy();
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
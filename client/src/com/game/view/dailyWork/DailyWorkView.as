package com.game.view.dailyWork
{
	import com.engine.ui.controls.ComponentGrid;
	import com.engine.ui.controls.Grid;
	import com.game.Data;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.Role.ChangePageComponent;
	import com.game.view.ViewEventBind;
	
	import flash.display.Bitmap;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class DailyWorkView extends BaseView implements IView
	{
		private var _positionXML:XML;
		private var _dailyWorkPageComponent:ChangePageComponent;
		private var _dailyWorkGrid:ComponentGrid;
		private var _dailyWorkData:Vector.<Object>;
		public function DailyWorkView()
		{
			_moduleName = V.DAILY_WORK;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.DAILY_WORK;
			
			super();
		}
		
		public function interfaces(type:String="", ...args):*
		{
			if (type == "") type = InterfaceTypes.Show;
			switch (type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
				case InterfaceTypes.REFRESH:
					renderDailyWorkGrid();
					break;
			}
		}
		
		/**
		 * 纹理 
		 */		
		private var _titleTxAtlas:TextureAtlas;
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
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
				initComponent();
				initUI();
				getUI();
				initEvent();
			}
			renderDailyWorkGrid();
			_view.layer.setCenter(panel);
		}
		
		
		/**
		 * 获取模板数据 
		 * 
		 */		
		private function initData() : void
		{
			if (!_positionXML)
			{
				_positionXML = getXMLData(_loadBaseName, GameConfig.DAILY_WORK_RES, "DailyWorkPosition");
			}
			
			if(_dailyWorkData == null)
			{
				_dailyWorkData = new Vector.<Object>();
				_dailyWorkData = Data.instance.db.interfaces(InterfaceTypes.GET_DAILY_WORK_DATA);
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
				
				var textureXML:XML = getXMLData(_loadBaseName, GameConfig.DAILY_WORK_RES, "DailyWork");			
				obj = getAssetsObject(_loadBaseName, GameConfig.DAILY_WORK_RES, "Textures");
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
					switch (name)
					{
						case "ChangePage":
							cp = new ChangePageComponent(items, titleTxAtlas);
							_components.push(cp);
							break;
						case "DailyWorkComponent":
							cp = new DailyWorkComponent(items, titleTxAtlas);
							_components.push(cp);
							break;
					}
				}
			}
		}
		
		private var _componentData:Vector.<Object>;
		private var _componentList:Vector.<Component>;
		private var _componentShow:Vector.<int>;
		/**
		 * 任务条组合
		 * 
		 */		
		private function renderDailyWorkGrid() : void
		{
			_componentData = new Vector.<Object>();
			_componentList = new Vector.<Component>();
			_componentShow = new Vector.<int>();
			
			analysisData();
			
			if(!_dailyWorkGrid)
			{
				_dailyWorkGrid = new ComponentGrid(_componentList, 4, 2, 250, 98, 0, 4);
				_dailyWorkGrid["layerName"] = "DailyWorkGrid";
				_dailyWorkGrid.x = 70;
				_dailyWorkGrid.y = 90;
				panel.addChild(_dailyWorkGrid);
				_uiLibrary.push(_dailyWorkGrid);
			}
			
			_dailyWorkGrid.setData(_componentData, _taskPageComponent, _componentList);
		}
		
		
		private function analysisData() : void
		{
			for(var i:int = 0; i < _dailyWorkData.length; i++)
			{
				//每日闯关
				if(i == 6 && player.mainRoleModel.model.lv < 15){}
				else if(i == 7 && !player.checkLevelShow("4_1")){}
				else if(i == 8 && !player.checkLevelShow("1_3")){}
				else if(i == 9 && !player.checkLevelShow("3_3")){}
				else
				{
					_componentData.push(_dailyWorkData[i]);
					_componentList.push(createComponentItem("DailyWorkComponent", ("DailyWorkItem" + i).toString()));
					_componentShow.push(player.dailyThingInfo.getRewardStatus[i]);
				}
			}
			
			for(var j:int = _componentShow.length - 1; j >= 0; j--)
			{
				if(_componentShow[j] == 1)
				{
					var component:Component = _componentList[j];
					_componentList.splice(j, 1);
					_componentList.push(component);
					
					var obj:Object = _componentData[j];
					_componentData.splice(j, 1);
					_componentData.push(obj);
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
		
		private var _taskPageComponent:ChangePageComponent;
		private function getUI() : void
		{
			_taskPageComponent = this.searchOf("dailyWorkChangePageList");
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
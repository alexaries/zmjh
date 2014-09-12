package com.game.view.daily
{
	import com.game.Data;
	import com.game.data.db.protocal.Item_disposition;
	import com.game.data.db.protocal.Mission;
	import com.game.data.player.structure.PropModel;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.LevelEvent.ItemBoxUititlies;
	import com.game.view.LevelEvent.ItemComponent;
	import com.game.view.ViewEventBind;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.filters.GrayscaleFilter;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class TaskItemBoxView extends BaseView implements IView
	{
		private var _mission:*;
		private var _imageList:Vector.<RewardComponent>; 
		private var _data:Data = Data.instance;
		
		public function TaskItemBoxView()
		{
			_moduleName = V.TASK_ITEM_BOX;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			_view.icon.interfaces();
			
			if (type == "") type = InterfaceTypes.Show;
			switch (type)
			{
				case InterfaceTypes.Show:
					_imageList = new Vector.<RewardComponent>();
					_mission = args[0];
					_imageList.push(args[1]);
					_imageList.push(args[2]);
					_imageList.push(args[3]);
					if(args[4].rewardImage.visible == true) _imageList.push(args[4]);
					this.show();
					break;
				case InterfaceTypes.ITEM_SELECTED:
					onItemSelected(args[0], args[1]);
					break;
			}
		}
		
		/**
		 * 已选择卡牌 
		 * @param selectedName
		 * 
		 */
		private var _info:String;
		protected function onItemSelected(selectedName:String, thisComponent:TaskItemComponent) : void
		{
			_getItemBtn.x = thisComponent.panel.x - 18;
			_getItemBtn.visible = true;
			
			initRender("FrontSence");
			_view.task.submitTask(selectedName);
		}
		
		override protected function init() : void
		{
			if (!isInit)
			{
				isInit = true;
				super.init();
				
				initXML();
				initTexture();
				initComponent();
				initUI();
				initEvent();
			}
			
			getUI();
			getRandomData();
			initRender("BackSence");
			
			_view.toolbar.panel.touchable = false;
			_view.task.panel.touchable = false;
			
			_view.layer.setCenter(panel);
		}
		
		private var _items:*;
		private function getRandomData() : void
		{
			for(var i:int = 0; i < 4; i++)
			{
				_imageList.push(_imageList.splice(Math.floor(_imageList.length * Math.random()), 1)[0]);
			}	
		}
		
		private var itemList:Vector.<TaskItemComponent>;
		// 开始选择
		protected function initRender(layer:String) : void
		{
			itemList = new Vector.<TaskItemComponent>();
			var count:int = 0;
			for(var i:int = 0; i <　_uiLibrary.length; i++)
			{
				if (_uiLibrary[i] is TaskItemComponent)
				{
					if(_imageList.length > count)
					{
						(_uiLibrary[i] as TaskItemComponent).setReward(_imageList[count].rewardImage);
						(_uiLibrary[i] as TaskItemComponent).setStatus(layer);
						itemList.push(_uiLibrary[i]);
						count++;
					}
				}
			}
			if(_imageList.length < 4)
			{
				(this.searchOf("Card4") as TaskItemComponent).panel.touchable = false;
				(this.searchOf("Card4") as TaskItemComponent).panel.useHandCursor = false;
				(this.searchOf("Card4") as TaskItemComponent).panel.filter = new GrayscaleFilter();
				(this.searchOf("Card4") as TaskItemComponent).setStatus("BackSence");
			}
			else
			{
				(this.searchOf("Card4") as TaskItemComponent).panel.touchable = true;
				(this.searchOf("Card4") as TaskItemComponent).panel.useHandCursor = true;
				(this.searchOf("Card4") as TaskItemComponent).panel.filter = null;
			}
			this.display();
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.LEVEL_EVENT, GameConfig.LE_RES, "TaskItemBoxPosition");
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.LEVEL_EVENT, GameConfig.LE_RES, "LevelEvent");			
				obj = getAssetsObject(V.LEVEL_EVENT, GameConfig.LE_RES, "Textures");
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
						case "Card":
							cp = new TaskItemComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
					}
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
			
			_view.layer.setCenter(panel);
		}
		
		private var _getItemBtn:Button;
		private var _world:Image;
		private var _boxType:Image;
		private function getUI() : void
		{
			if (!_getItemBtn) _getItemBtn = this.searchOf("GetItemButton");
			_getItemBtn.visible = false;
			
			if (!_world) _world = this.searchOf("WordType");
			if (!_boxType) _boxType = this.searchOf("ImageType");
		}	
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "GetItemButton":
					_view.toolbar.panel.touchable = true;
					_view.task.panel.touchable = true;
					this.hide();
					break;
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			textures = _titleTxAtlas.getTextures(name);
			return textures;
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
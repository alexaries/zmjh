package com.game.view.worldBoss
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
	
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class RankListView extends BaseView implements IView
	{
		public function RankListView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.RANK_LIST;
			_loaderModuleName = V.WORLD_BOSS;
			
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
		
		override protected function init():void
		{
			if (!isInit)
			{
				super.init();
				
				initXML();
				initTexture();
				initComponent();
				initUI();
				getUI();
				initEvent();
				
				isInit = true;
			}
			
			render();
			_view.layer.setCenter(panel);
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			if(!_positionXML) _positionXML = getXMLData(V.WORLD_BOSS, GameConfig.WORLD_BOSS_RES, "FightHurtPosition");
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.WORLD_BOSS, GameConfig.WORLD_BOSS_RES, "WorldBoss");			
				obj = getAssetsObject(V.WORLD_BOSS, GameConfig.WORLD_BOSS_RES, "Textures");
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
						case "FightHurt":
							cp = new RankAreaComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "ChangePage":
							cp = new ChangePageComponent(items, _titleTxAtlas);
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
		}
		
		private var _packPageComponent:ChangePageComponent;
		private var _myRank:TextField;
		private function getUI() : void
		{
			_packPageComponent = this.searchOf("ChangePageList");
			_myRank = this.searchOf("MyRank");	
		}
		
		private var _rankList:Vector.<Component>
		private var _rankGrid:ComponentGrid;
		private function renderRank(data:Array) : void
		{
			_rankList = new Vector.<Component>();
			for(var j:uint = 0; j < data.length; j++)
			{
				data[j].fightTime = data[j].extra.split("|")[1];
			}
			data = resetSortList(data);
			for(var i:int = 0; i < data.length; i++)
			{
				data[i].realRank = (i + 1);
				_rankList.push(createComponentItem("FightHurt", ("FightHurt" + i).toString()));
			}
			
			if(!_rankGrid)
			{
				_rankGrid = new ComponentGrid(_rankList, 7, 1, 455, 26, 1, 3);
				_rankGrid["layerName"] = "rankList";
				_rankGrid.x = 78;
				_rankGrid.y = 102;
				panel.addChild(_rankGrid);
				_uiLibrary.push(_rankGrid);
			}
			
			_rankGrid.setData(data, _packPageComponent, _rankList);
		}
		
		private function resetSortList(data:Array) : Array
		{
			var switchObj:Object;
			for(var i:uint = 0; i < data.length; i++)
			{
				for(var j:uint = i; j < data.length; j++)
				{
					if(int(data[i].rank) == int(data[j].rank))
					{
						if(int(data[i].fightTime) > int(data[j].fightTime))
						{
							switchObj = data[i];
							data[i] = data[j];
							data[j] = switchObj;
						}
					}
				}
			}
			return data;
		}
		
		private function render() : void
		{
			_myRank.text = _view.world_boss.myRank;
			_view.loadData.loadDataPlay();
			Data.instance.rank.callback = setRankList;
			//Data.instance.rank.getRankListsData(Data.instance.rank.testWorldBossID, 50, 1);
			Data.instance.rank.getRankListsData(Data.instance.rank.worldBossID, 50, 1);
		}
		
		private function setRankList(data:Array) : void
		{
			_view.loadData.hide();
			renderRank(data);
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "Close":
					hide();
					break;
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
		
		override public function hide():void
		{
			super.hide();
		}
	}
}
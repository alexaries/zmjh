package com.game.view.playerFight
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
	import com.game.view.worldBoss.PlayerFightRankAreaComponent;
	import com.game.view.worldBoss.RankAreaComponent;
	
	import flash.display.Bitmap;
	
	import starling.core.Starling;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class PlayerFightRankView extends BaseView implements IView
	{
		public function PlayerFightRankView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.PLAYER_RANK_LIST;
			_loaderModuleName = V.PLAYER_FIGHT;
			
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
			_view.layer.setTopMaskShow();
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			if(!_positionXML) _positionXML = getXMLData(V.PLAYER_FIGHT, GameConfig.PLAYER_FIGHT_RES, "PlayerFightRankPosition");
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.PLAYER_FIGHT, GameConfig.PLAYER_FIGHT_RES, "PlayerFight");			
				obj = getAssetsObject(V.PLAYER_FIGHT, GameConfig.PLAYER_FIGHT_RES, "Textures");
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
							cp = new PlayerFightRankAreaComponent(items, _titleTxAtlas);
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
		
		private function render() : void
		{
			if(_view.player_fight.nowRankLv == 10001)
				_myRank.text = "无";
			else
				_myRank.text = _view.player_fight.nowRankLv.toString();
			//_view.loadData.loadDataPlay();
			Data.instance.rank.callback = setRankList;
			//Data.instance.rank.getRankListsData(Data.instance.rank.testWorldBossID, 50, 1);
			Data.instance.rank.getRankListsData(Data.instance.rank.playerFightID, 100, 1);
		}
		
		private function setRankList(data:Array) : void
		{
			//_view.loadData.hide();
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
package com.game.view.achievement
{
	import com.engine.ui.controls.Grid;
	import com.game.Data;
	import com.game.data.db.protocal.Characters;
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

	public class AchievementView extends BaseView implements IView
	{
		public function AchievementView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.ACHIEVEMENT;
			_loaderModuleName = V.ACHIEVEMENT;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if(type == "") type = InterfaceTypes.Show;
			
			switch(type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
			}
		}
		
		override protected function init() : void
		{
			if(!isInit)
			{
				super.init();
				
				initXML();
				initTexture();
				initComponent();
				initUI();
				getUI();
				initEvent();
				renderRoles();
				
				isInit = true;
			}
			
			_view.layer.setCenter(this.panel);
		}
		
		private var _positionXML:XML;
		private var _infoData:Vector.<Object>;
		private function initXML() : void
		{
			if(!_positionXML) _positionXML = getXMLData(V.ACHIEVEMENT, GameConfig.ACHIEVEMENT_RES, "AchievementPosition");
			if(!_infoData)
			{
				_infoData = Data.instance.db.interfaces(InterfaceTypes.GET_CHARACTER_DATA);
				//_infoData.sort(sortByType);
				_infoData.sort(sortByGrade);
			}
		}
		
		private function sortByType(x:Object, y:Object) : Number
		{
			var result:Number = 0;
			
			var xName:String = x.name.split("（")[1];
			var yName:String = y.name.split("（")[1];
			
			switch(xName)
			{
				case "夜）":
					if(yName != "夜")
						result = -1;
					else
						result = 1;
					break;
				case "雨）":
					if(yName != "夜")
						result = -1;
					else
						result = 1;
					break;
				case "风）":
					if(yName != "夜" &&　yName != "雨" &&　yName != "风")
						result = -1;
					else
						result = 1;
					break;
				case "雷）":
					if(yName == "雷")
						result = 0;
					else
						result = 1;
					break;
				default:
					break;
			}
			if(xName == yName)
				result = 0;
			
			return result;
		}
		
		private function sortByGrade(x:Object, y:Object) : Number
		{
			var result:Number = 0;
			
			switch(x.grade)
			{
				case "极":
					if(y.grade == "极")
						result = 0;
					else
						result = 1;
					break;
				case "甲+":
					if(y.grade != "丁" && y.grade != "丙" && y.grade != "乙" && y.grade != "甲" && y.grade != "甲+")
						result = -1;
					else if(y.grade == "甲+")
						result = 0;
					else
						result = 1;
					break;
				case "甲":
					if(y.grade != "丁" && y.grade != "丙" && y.grade != "乙" && y.grade != "甲")
						result = -1;
					else if(y.grade == "甲")
						result = 0;
					else
						result = 1;
					break;
				case "乙":
					if(y.grade != "丁" && y.grade != "丙" && y.grade != "乙")
						result = -1;
					else if(y.grade == "乙")
						result = 0;
					else
						result = 1;
					break;
				case "丙":
					if((y.grade != "丁" && y.grade != "丙"))
						result = -1;
					else if(y.grade == "丙")
						result = 0;
					else
						result = 1;
					break;
				case "丁":
					if(y.grade != "丁")
						result = -1;
					else
						result = 0;
					break;
			}
			
			return result;
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.ACHIEVEMENT, GameConfig.ACHIEVEMENT_RES, "Achievement");			
				obj = getAssetsObject(V.ACHIEVEMENT, GameConfig.ACHIEVEMENT_RES, "Textures");
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
		
		private var _changePage:ChangePageComponent;
		private function getUI() : void
		{
			_changePage = this.searchOf("ChangePageList");
		}
		
		private var _rolesGrid:Grid;
		private var _infoList:Vector.<String>;
		public function renderRoles() : void
		{			
			if (!_rolesGrid)
			{
				_rolesGrid = new Grid(AchievementRoleItemRender, 3, 9, 72, 72, 8.5, 6);
				_rolesGrid["layerName"] = "BackGround";
				_rolesGrid.x = 120;
				_rolesGrid.y = 210;
				panel.addChild(_rolesGrid);
				_uiLibrary.push(_rolesGrid);
				getAllName();
			}
			
			_rolesGrid.setData(_infoList, _changePage);
		}
		
		private function getAllName() : void
		{
			_infoList = new Vector.<String>();
			for each(var item:Object in _infoData)
			{
				_infoList.push((item as Characters).name);
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "DiceOkBt":
					this.hide();
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
	}
}
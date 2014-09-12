package com.game.view.union
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.equip.PropTip;
	import com.game.view.ui.UIConfig;
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class UnionView extends BaseView implements IView
	{
		public function UnionView()
		{
			_moduleName = V.UNION;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.UNION;
			
			super();
		}
		
		public function interfaces(type:String="", ...args):*
		{
			if (type == "") type = InterfaceTypes.Show;
			Log.Trace("UnionView" + type + "-----" + args);
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_curPosition = 0;
					this.show();
					break;
				case InterfaceTypes.REFRESH:
					_curPosition = 1;
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
				isInit = true;
			}
			
			_view.layer.setCenter(panel);
			
			checkStatus();
			render();
		}
		
		private var _curPosition:int;	
		private function checkStatus() : void
		{
			var targetXML:XML = new XML();
			targetXML = _positionXML.layer[_curPosition];
			
			resetPosition(targetXML);
			
			for each(var item:* in _uiLibrary)
			{
				if (item is DisplayObject) item.visible = false;
				else if (item is Component) (item as Component).panel.visible = false;
			}
			
			seStatusOfXML(targetXML, true);
		}
		
		private function render():void
		{
			renderTF();
			renderButton();
		}
		
		private function renderTF():void
		{
			_strengthExp.text = player.strength_exp.toString();
		}		
		
		private var _positionXML:XML;
		private var _roleData:Vector.<Object>;
		private var _instructionXML:XML;
		private function initXML():void
		{
			_positionXML = getXMLData(_moduleName, GameConfig.UNION_RES, "UnionPosition");
			_instructionXML = getXMLData(_moduleName, GameConfig.UNION_RES, "UnionInstructionPosition");
			if(_roleData == null)
			{
				_roleData = new Vector.<Object>();
				_roleData = Data.instance.db.interfaces(InterfaceTypes.GET_SKY_EARTH_DATA);
			}
		}
		
		private var _titleTxAtlas:TextureAtlas;
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		private function initTexture():void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(_moduleName, GameConfig.UNION_RES, "Union");			
				obj = getAssetsObject(_moduleName, GameConfig.UNION_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
			}
		}
		
		private function initComponent():void
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
					}
				}
			}
		}
		
		private function initUI():void
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
		
		private var _strengthExp:TextField;
		private var _role_1:Image;
		private var _role_2:Image;
		private var _role_3:Image;
		private var _selectBtn_1:Button;
		private var _selectBtn_2:Button;
		private var _selectBtn_3:Button;
		private var _type_1:Image;
		private var _type_2:Image;
		private var _type_3:Image;
		private var _glass_1:Image;
		private var _glass_2:Image;
		private var _glass_3:Image;
		private var _pass_1:Image;
		private var _pass_2:Image;
		private var _pass_3:Image;
		private var _propTip:PropTip;
		private function getUI():void
		{
			_strengthExp = this.searchOf("StrengthExpDetail");
			_role_1 = this.searchOf("RoleImage_1");
			_role_2 = this.searchOf("RoleImage_2");
			_role_3 = this.searchOf("RoleImage_3");
			_role_1.scaleX = V.FIGHT_SCALE;
			_role_1.scaleY = V.FIGHT_SCALE;
			_role_1.touchable = false;
			_role_2.scaleX = V.FIGHT_SCALE;
			_role_2.scaleY = V.FIGHT_SCALE;
			_role_2.touchable = false;
			_role_3.scaleX = V.FIGHT_SCALE;
			_role_3.scaleY = V.FIGHT_SCALE;
			_role_3.touchable = false;
			
			_selectBtn_1 = this.searchOf("TypeBtnOne");
			_selectBtn_2 = this.searchOf("TypeBtnTwo");
			_selectBtn_3 = this.searchOf("TypeBtnThird");
			
			_type_1 = this.searchOf("Type_1");
			_type_2 = this.searchOf("Type_2");
			_type_3 = this.searchOf("Type_3");
			_type_1.touchable = false;
			_type_2.touchable = false;
			_type_3.touchable = false;
			
			_glass_1 = this.searchOf("Glass_1");
			_glass_2 = this.searchOf("Glass_2");
			_glass_3 = this.searchOf("Glass_3");
			_glass_1.touchable = false;
			_glass_2.touchable = false;
			_glass_3.touchable = false;
			
			_pass_1 = this.searchOf("Passed_1");
			_pass_2 = this.searchOf("Passed_2");
			_pass_3 = this.searchOf("Passed_3");
			_pass_1.touchable = false;
			_pass_2.touchable = false;
			_pass_3.touchable = false;
			
			_propTip = _view.ui.interfaces(UIConfig.PROP_TIP);
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "Close":
					this.hide();
					break;
				case "StartStrengthBtn":
					showStrength();
					break;
				case "TypeBtnOne":
					showNextUI(1);
					break;
				case "TypeBtnTwo":
					showNextUI(2);
					break;
				case "TypeBtnThird":
					showNextUI(3);
					break;
				case "Describe":
					_view.instruction_union.interfaces(InterfaceTypes.Show, _instructionXML);
					break;
			}
		}
		
		private var _resultList:Vector.<Object>;
		private var _unionType:int;
		private var _bossType:int;
		private function showNextUI(count:int) : void
		{
			if(_curPosition == 0)
			{
				if(count == 1)
				{
					_unionType = count;
					monsterType(count);
					interfaces(InterfaceTypes.REFRESH);
				}
			}
			else
			{
				_bossType = count;
				if(player.unionInfo.canFight() == (_unionType - 1) * 3 + (_bossType - 1))
				{
					this.hide();
					_view.tdhPrepare.interfaces(""
						,_resultList[count - 1]
						,function (bol:Boolean) : void
						{
							if(bol)
							{
								player.unionInfo.setComplete(_unionType, _bossType);
								player.strength_exp += _roleData[(_unionType - 1) * 3 + (_bossType - 1)].i_force;
							}
							else
							{
								
							}
							interfaces(InterfaceTypes.REFRESH);
						});
				}
			}
		}
		
		
		private function monsterType(count:int) : void
		{
			_resultList =  new Vector.<Object>();
			for(var i:int = 0; i < _roleData.length; i++)
			{
				if(_roleData[i].type == count)
					_resultList.push(_roleData[i]);
			}
			for(var j:int = 0; j < _resultList.length; j++)
			{
				var name:String = "RoleImage_Big_" + _resultList[j].name.split("|")[0];
				(this["_role_" + (j + 1)] as Image).texture = _view.role_big.interfaces(InterfaceTypes.GetTexture, name);
				(this["_role_" + (j + 1)] as Image).readjustSize();
			}
		}
		
		private function renderButton() : void
		{
			if(_curPosition == 0)
			{
				addTouchable(_selectBtn_1)
				removeOnlyTouchable(_selectBtn_2);
				removeOnlyTouchable(_selectBtn_3);
				_type_1.filter = null;
				_type_2.filter = new GrayscaleFilter();
				_type_3.filter = new GrayscaleFilter();
				_propTip.removePropByName(_selectBtn_1);
				_propTip.removePropByName(_selectBtn_2);
				_propTip.removePropByName(_selectBtn_3);
				_propTip.add({o:_selectBtn_3,m:{name:"",message:"未开放"}});
				_propTip.add({o:_selectBtn_2,m:{name:"",message:"未开放"}});
				_propTip.add({o:_selectBtn_1,m:{name:"",message:"第一关：打手\n第二关：天地会高手\n第三关：玄真道长"}});
			}
			else
			{
				_propTip.removePropByName(_selectBtn_1);
				_propTip.removePropByName(_selectBtn_2);
				_propTip.removePropByName(_selectBtn_3);
				_propTip.add({o:_selectBtn_3,m:{name:"",message:"通关获得" + _roleData[(_unionType - 1) * 3 + 2].i_force + "内功修为"}});
				_propTip.add({o:_selectBtn_2,m:{name:"",message:"通关获得" + _roleData[(_unionType - 1) * 3 + 1].i_force + "内功修为"}});
				_propTip.add({o:_selectBtn_1,m:{name:"",message:"通关获得" + _roleData[(_unionType - 1) * 3 + 0].i_force + "内功修为"}});
				addTouchable(_selectBtn_1);
				addTouchable(_selectBtn_2);
				addTouchable(_selectBtn_3);
				_type_1.filter = null;
				_type_2.filter = null;
				_type_3.filter = null;
				panel.setChildIndex(_glass_1, panel.numChildren - 1);
				panel.setChildIndex(_glass_2, panel.numChildren - 1);
				panel.setChildIndex(_glass_3, panel.numChildren - 1);
				resetButton();
			}
		}
		
		private function resetButton() : void
		{
			for(var i:int = 0; i < 3; i++)
			{
				if(player.unionInfo.completeList[(_unionType - 1) * 3 + i] == 0)
				{
					addTouchable(this["_selectBtn_" + (i + 1)]);
					break;
				}
				else
					removeOnlyTouchable(this["_selectBtn_" + (i + 1)]);
			}
			for(var j:int = (i + 1); j < 3; j++)
			{
				removeOnlyTouchable(this["_selectBtn_" + (j + 1)]);
			}
			
			for(var k:int = 0; k < 3; k++)
			{
				this["_pass_" + (k + 1)].visible = false;
				if(player.unionInfo.completeList[(_unionType - 1) * 3 + k] == 1)
					this["_pass_" + (k + 1)].visible = true;
			}
		}
		
		private function showStrength():void
		{
			this.hide();
			_view.strength.interfaces();
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
			else if(type == "role")
			{
				texture = _view.roleRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			
			return texture;
		}
	}
}
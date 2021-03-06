package com.game.view.union
{
	import com.game.Data;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.effect.GlowAnimationEffect;
	
	import flash.display.Bitmap;
	
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class StrengthView extends BaseView implements IView
	{
		// 初始化纹理
		private var _titleTxAtlas:TextureAtlas;
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		
		public function StrengthView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.STRENGTH;
			_loaderModuleName = V.STRENGTH;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:					
					//initPosition(args);
					this.show();
					break;
				case InterfaceTypes.REFRESH:
					//render();			
					display();
					break;
			}
		}
		
		override protected function init():void
		{
			if (!isInit)
			{
				super.init();
				isInit = true;
				
				initXML();
				initTexture();
				initComponent();
				initUI();
				getUI();
				initEvent();
			}
			
			render();			
			display();
		}
		
		private function render():void
		{
			renderFormation();
			renderTF();
			renderPosition();
		}
		
		public function renderTF():void
		{
			_strengthExp.text = player.strength_exp.toString();
			_atsComponent.render();
			_adfComponent.render();
		}
		
		private var _positionXML:XML;
		private var _strengthData:Vector.<Object>;
		public function get strengthData() : Vector.<Object>
		{
			return _strengthData;
		}
		private var _instructionXML:XML; 
		private function initXML() : void
		{
			_positionXML = this.getXMLData(_moduleName, GameConfig.STRENGTH_RES, "StrengthPosition");
			
			_instructionXML = getXMLData(_moduleName, GameConfig.STRENGTH_RES, "StrengthInstructionPosition");
			if(_strengthData == null)
			{
				_strengthData = new Vector.<Object>();
				_strengthData = Data.instance.db.interfaces(InterfaceTypes.GET_STRENGTH_DATA);
			}
		}
		
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(_moduleName, GameConfig.STRENGTH_RES, "Strength");			
				obj = getAssetsObject(_moduleName, GameConfig.STRENGTH_RES, "Textures");
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
						case "OneFormation":
							cp = new StrengthFormationComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "StrengthAtsComponent":
							cp = new StrengthAtsComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "StrengthAdfComponent":
							cp = new StrengthAdfComponent(items, _titleTxAtlas);
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
		
		private var _atsComponent:StrengthAtsComponent;
		private var _adfComponent:StrengthAdfComponent;
		private var _strengthExp:TextField;
		private function getUI() : void
		{
			_atsComponent = this.searchOf("StrengthAts");
			_adfComponent = this.searchOf("StrengthAdf");
			_strengthExp = this.searchOf("StrengthDetail");
		}
		
		private var _formationFront:StrengthFormationComponent;
		private var _formationMiddle:StrengthFormationComponent;
		private var _formationBack:StrengthFormationComponent;
		private var _gl_1:GlowAnimationEffect;
		private var _gl_2:GlowAnimationEffect;
		private var _gl_3:GlowAnimationEffect;
		private function renderFormation() : void
		{
			if (!_formationFront) _formationFront = searchOf("FormationFront") as StrengthFormationComponent;
			if (!_formationMiddle) _formationMiddle = searchOf("FormationMiddle") as StrengthFormationComponent;
			if (!_formationBack) _formationBack = searchOf("FormationBack") as StrengthFormationComponent;
			
			_formationFront.setFormation(player.formation.front);
			_formationMiddle.setFormation(player.formation.middle);
			_formationBack.setFormation(player.formation.back);
			
			_gl_1 = new GlowAnimationEffect(_formationFront.panel);
			_gl_2 = new GlowAnimationEffect(_formationMiddle.panel);
			_gl_3 = new GlowAnimationEffect(_formationBack.panel);
		}
		
		private function renderPosition() : void
		{
			var position:String = "";
			if(player.formation.front != "")
				position = "front";
			else if(player.formation.middle != "")
				position = "middle";
			else 
				position = "back";
			
			switch(position)
			{
				case "front":
					_gl_1.play();
					_gl_2.stop();
					_gl_3.stop();
					break;
				case "middle":
					_gl_1.stop();
					_gl_2.play();
					_gl_3.stop();
					break;
				case "back":
					_gl_1.stop();
					_gl_2.stop();
					_gl_3.play();
					break;
			}
			
			_atsComponent.setStrengthData(position, player.strengthInfo[position]);
			_adfComponent.setStrengthData(position, player.strengthInfo[position]);
		}
		
		public function setComponent(str:String) : void
		{
			var position:String = "";
			switch(str)
			{
				case "FormationFront":
					position = "front";
					_gl_1.play();
					_gl_2.stop();
					_gl_3.stop();
					break;
				case "FormationMiddle":
					position = "middle";
					_gl_1.stop();
					_gl_2.play();
					_gl_3.stop();
					break;
				case "FormationBack":
					position = "back";
					_gl_1.stop();
					_gl_2.stop();
					_gl_3.play();
					break;
			}
			
			_atsComponent.setStrengthData(position, player.strengthInfo[position]);
			_adfComponent.setStrengthData(position, player.strengthInfo[position]);
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					_view.union.interfaces();
					break;
				case "Describe":
					_view.instruction_strength.interfaces(InterfaceTypes.Show, _instructionXML);
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
			else if(type == "role")
			{
				textures = _view.roleRes.interfaces(InterfaceTypes.GetTextures, name);
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
		
		override public function close():void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
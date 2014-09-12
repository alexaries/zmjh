package com.game.view.Role
{
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class RoleGainSkillView extends BaseView implements IView
	{
		public function RoleGainSkillView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.ROLE_GAIN_SKILL;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		private var _skillId:int;
		private var _roleName:String;
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_skillId = args[0];
					_roleName = args[1];
					this.show();
					break;
			}
		}
		
		override protected function init() : void
		{
			if (!this.isInit)
			{
				super.init();
				isInit = true;
				
				initXML();
				initTexture();
				initUI();
				getUI();
				initEvent();
			}
			
			onRender();
			_view.layer.setCenter(panel);
		}
		
		private function onRender() : void
		{
			_lvRemindTF.text = "恭喜您的角色" + _roleName + "获得新技能";
			
			var skillIMGName:String = "skill_" + _skillId;
			var texture:Texture = _view.skill.interfaces(InterfaceTypes.GetTexture, skillIMGName);
			_itemIMG.texture = texture;
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "OkBt":
					this.hide();
					break;
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
		
		private var _lvRemindTF:TextField;
		private var _itemIMG:Image;
		private var _itemTip:TextField;
		private function getUI() : void
		{
			_lvRemindTF = this.searchOf("Tx_Tip");
			_itemIMG = this.searchOf("ItemBg");
			_itemTip = this.searchOf("Tx_ItemTip");
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "GainSkillPosition");
		}
		
		// 初始化纹理
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				_titleTxAtlas = _view.roleRes.titleTxAtlas;
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
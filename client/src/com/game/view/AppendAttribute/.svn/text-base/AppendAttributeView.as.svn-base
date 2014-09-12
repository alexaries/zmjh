package com.game.view.AppendAttribute
{
	import com.game.Data;
	import com.game.data.db.protocal.Fight_soul;
	import com.game.data.player.structure.FightAttachInfo;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class AppendAttributeView extends BaseView implements IView
	{
		// 初始化纹理
		private var _titleTxAtlas:TextureAtlas;
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		
		// 当前位置
		private var _curPosition:String;
		// 战附配置数据
		private var _fightAttackInfo:Fight_soul;
		// 当前位置的角色
		private var _curRoleModel:RoleModel;
		public function get curRoleModel() : RoleModel
		{
			return _curRoleModel;
		}
		
		public function AppendAttributeView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.APPEND_ATTRIBUTE;
			_loaderModuleName = V.APPEND_ATTRIBUTE;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:					
					initPosition(args);
					this.show();
					break;
				case InterfaceTypes.REFRESH:
					render();
					display();
					break;
			}
		}
		
		private function initPosition(args:Array) : void
		{
			player = _view.controller.player.getPlayerData();

			_curPosition = args[0];
			
			Data.instance.db.interfaces(InterfaceTypes.GET_FIGHT_SOUL_LV, _curPosition, callback);
			
			function callback(data:Fight_soul) : void
			{
				_fightAttackInfo = data;
			}
			
			var positionRoleName:String = player.formation[_curPosition];
			if (!positionRoleName || positionRoleName == '')
			{
				_curRoleModel = null;
			}
			else
			{
				_curRoleModel = player.getRoleModel(positionRoleName);
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
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = this.getXMLData(V.APPEND_ATTRIBUTE, GameConfig.APPATR_RES, "AppendAttributePosition");
		}
		
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.APPEND_ATTRIBUTE, GameConfig.APPATR_RES, "AppendAttribute");			
				obj = getAssetsObject(V.APPEND_ATTRIBUTE, GameConfig.APPATR_RES, "Textures");
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
						case "AttributeDetail":
							cp = new AttributeDetailComponent(items, _titleTxAtlas);
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
		
		// 标签
		private var _title:MovieClip;
		// hp
		private var _hpDetail:AttributeDetailComponent;
		// mp
		private var _mpDetail:AttributeDetailComponent;
		// 攻击
		private var _atkDetail:AttributeDetailComponent;
		// 防御
		private var _defDetail:AttributeDetailComponent;
		// 闪避
		private var _evasionDetail:AttributeDetailComponent;
		// 暴击
		private var _critDetail:AttributeDetailComponent;
		private function getUI() : void
		{
			_title = this.searchOf("WindTitle");
			_hpDetail = this.searchOf("HPDetail");
			_mpDetail = this.searchOf("MPDetail");
			_atkDetail = this.searchOf("ATKDetail");
			_defDetail = this.searchOf("DEFDetail");
			_evasionDetail = this.searchOf("EvasionDetail");
			_critDetail = this.searchOf("CRITDetail");
		}
		
		private function render() : void
		{
			var curFight:FightAttachInfo;
			
			switch (_curPosition)
			{
				// 先锋
				case "front":
					_title.currentFrame = 0;
					curFight = player.fightAttach.front;
					break;
				// 中坚
				case "middle":
					_title.currentFrame = 1;
					curFight = player.fightAttach.middle;
					break;
				// 大将
				case "back":
					_title.currentFrame = 2;
					curFight = player.fightAttach.back;
					break;
			}
			
			_hpDetail.setData("hp", curFight.hp, _curPosition, _fightAttackInfo, curFight);
			_mpDetail.setData("mp", curFight.mp, _curPosition, _fightAttackInfo, curFight);
			_atkDetail.setData("atk", curFight.atk, _curPosition, _fightAttackInfo, curFight);
			_defDetail.setData("def", curFight.def, _curPosition, _fightAttackInfo, curFight);
			_evasionDetail.setData("evasion", curFight.evasion, _curPosition, _fightAttackInfo, curFight);
			_critDetail.setData("crit", curFight.crit, _curPosition, _fightAttackInfo, curFight);
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
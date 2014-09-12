package com.game.view.Role
{
	import com.game.Data;
	import com.game.data.db.protocal.Level_up_exp;
	import com.game.data.db.protocal.Prop;
	import com.game.data.player.PlayerEvent;
	import com.game.data.player.structure.LevelInfo;
	import com.game.data.player.structure.PropModel;
	import com.game.data.player.structure.RoleModel;
	import com.game.manager.LayerManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import flash.display.BitmapData;
	import flash.ui.Keyboard;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class RoleLVUpView extends BaseView implements IView
	{
		public function RoleLVUpView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.ROLE_LEVLE_UP;
			_loaderModuleName = V.PUBLIC;
			
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
		
		override protected function init() : void
		{
			if (!this.isInit)
			{
				super.init();
				isInit = true;
				
				this.hide();
				getData();
				initXML();
				initTexture();
				initUI();
				getUI();
				initEvent();
				initBeginEvent();
			}
			
			_view.layer.setCenter(panel);
		}
		
		override protected function initEvent():void
		{
			super.initEvent();
		}
		
		private var _curLvUpInfo:Level_up_exp;
		private var _callback:Function;
		private function onRoleUpgrade(e:Event) : void
		{
			_callback = e.data as Function;
			
			this.display();
			
			var lv:int = _mainRoleModel.model.lv;
			
			var info:Level_up_exp;
			for (var i:int = 0;i < _lvUpData.length; i++)
			{
				info = _lvUpData[i] as Level_up_exp;
				
				if (info.lv == lv)
				{
					_curLvUpInfo = info;
					break;
				}
			}
			
			if (!info) throw new Error("error");
			
			onRender();
			onTitle();
		}
		
		/**
		 * 30级获得初出江湖的称号
		 * 
		 */		
		private function onTitle():void
		{
			if(_mainRoleModel.model.lv == 30)
			{
				_view.prompEffect.play("恭喜您获得“初出江湖”的称号！");
				player.roleTitleInfo.addNewTitle(V.ROLE_NAME[2]);
			}
		}
		
		private function onRender() : void
		{
			_lvRemindTF.text = "恭喜您升到" + _mainRoleModel.model.lv + "级，这是您的奖励";
			LayerManager.instance.addKeyDowns(this.panel, comfireFun);
			if (_curLvUpInfo.skill_id != 0)
			{
				onGetSkill();
			}
			else if (_curLvUpInfo.prop != "")
			{
				onGetProp();
			}
			else
			{
				throw new Error("error");
			}
		}
		
		private function onGetSkill() : void
		{
			_itemTip.text = "习得技能：";
			var skillId:int = _curLvUpInfo.skill_id;
			
			var skillIMGName:String = "skill_" + skillId;
			var texture:Texture = _view.skill.interfaces(InterfaceTypes.GetTexture, skillIMGName);
			_itemIMG.texture = texture;
			_itemNum.text = "";
			
			Data.instance.skill.learnSkill(skillId, _mainRoleModel.info.skill);
			//是否自动扫荡
			/*if(_view.map.autoLevel)
			{
				this.hide();
				if (_callback != null) _callback();
			}*/
		}
		
		private function onGetProp() : void
		{
			var propInfo:Array = _curLvUpInfo.prop.split("|");
			var id:int = propInfo[0];
			var num:int = propInfo[1];
			_itemTip.text = "获得道具：";
			
			var propIMGName:String = "prop_" + id;
			var texture:Texture = _view.icon.interfaces(InterfaceTypes.GetTexture, propIMGName);
			_itemIMG.texture = texture;
			_itemNum.text = "X" + num.toString();
			
			var propsDB:* = Data.instance.db.interfaces(InterfaceTypes.GET_PROP_DATA);
			var prop:Prop;
			for (var i:int = 0; i < propsDB.length; i++)
			{
				if (propsDB[i].id == id)
				{
					prop = propsDB[i];
					break;
				}
			}
			
			var model:PropModel = new PropModel();
			model.id = id;
			model.num = num;
			model.config = prop;
			
			Data.instance.pack.addProp(model);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			//是否自动扫荡
			/*if(_view.map.autoLevel)
			{
				this.hide();
				if (_callback != null) _callback();
			}*/
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "OkBt":
					comfireFun();
					break;
			}
		}
		
		private function comfireFun() : void
		{
			LayerManager.instance.removeKeyDowns();
			this.hide();
			if (_callback != null) _callback();
			this.panel.touchable = true;
		}
		
		
		override protected function onClickBeginHandle(e:ViewEventBind) : void
		{
			this.panel.touchable = false;
		}
		
		private var _lvUpData:Vector.<Object>;
		private var _mainRoleModel:RoleModel;
		private function getData() : void
		{
			_lvUpData = Data.instance.db.interfaces(InterfaceTypes.GET_LEVEL_UP_EXP);
			V.MAIN_ROLE_NAME = player.roles[0].roleName;
			_mainRoleModel = player.getRoleModel(V.MAIN_ROLE_NAME);
			_mainRoleModel.addEventListener(PlayerEvent.ROLE_UPGRADE, onRoleUpgrade);
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
		private var _itemNum:TextField;
		private function getUI() : void
		{
			_lvRemindTF = this.searchOf("Tx_Tip");
			_itemIMG = this.searchOf("ItemBg");
			_itemTip = this.searchOf("Tx_ItemTip");
			_itemNum = this.searchOf("Tx_ItemNum");
		}
		
		// xml
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "LevelUpPosition");
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
		
		override public function display():void
		{
			super.display();
			var type:String = "add" + _layer + "Child";
			_view.layer[type](panel, sign);
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
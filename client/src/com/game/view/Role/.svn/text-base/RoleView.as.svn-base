package com.game.view.Role
{
	import com.engine.ui.controls.Grid;
	import com.engine.ui.controls.TabBar;
	import com.game.data.db.protocal.Battle_we;
	import com.game.data.db.protocal.Characters;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.db.protocal.Skill;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.structure.WeCharacterUtitiles;
	import com.game.data.player.PlayerFightDataUtitlies;
	import com.game.data.player.SkillUtitiles;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.RoleInfo;
	import com.game.data.player.structure.RoleModel;
	import com.game.data.player.structure.SkillModel;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.equip.EquipItemRender;
	import com.game.view.skill.SkillItemRender;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class RoleView extends BaseView implements IView
	{
		public static const TABS:Array = ["Pack", "Skill", "Formation"];
		public static const PACK_TAB:String = "Pack";		
		public static const SKILL_TAB:String = "Skill";		
		public static const FORMATION_TAB:String = "Formation";
		
		// 当前标签
		private var _curTab:String;
		
		// 当前选中的角色
		private var _curRoleName:String = "韦小宝";
		
		public function RoleView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.ROLE;
			_loaderModuleName = V.PUBLIC;
			_curTab = PACK_TAB;
			
			super();
		}
		
		override protected function show():void
		{
			_loadResources = GameConfig.instance.ASSETS[_moduleName]["module"];
			
			super.show();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					preInit();
					_curRoleName = args[0];
					this.show();
					break;
			}
		}
		
		protected function preInit() : void
		{
			_view.roleImage.interfaces();
			_view.skill.interfaces();
			_view.equip.interfaces();
		}
		
		override protected function init() : void
		{
			if (!this.isInit)
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
			
			initRender();
			checkTab();
			_view.layer.setCenter(panel);
		}
		
		// xml
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = new XML(_view.res.getAssetsData(V.ROLE_DETAIL, "RoleDetailPosition.xml"));
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
						case "RoleLabel":
							cp = new RoleLabelComponent(items, _titleTxAtlas);
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
			getObject();
		}
		
		// 初始化纹理
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = new XML(_view.res.getAssetsData(V.ROLE_DETAIL, "RoleDetail.xml"));			
				obj = _view.res.getAssetsObject(V.ROLE_DETAIL, "RoleDetail.swf", "Textures");
				var textureTitle:Texture = Texture.fromBitmapData(obj as BitmapData);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
			}
		}
		
		// 元件
		private function getObject() : void
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
		
		//// 获取UI
		private var _tabBar:TabBar;		
		private var _roleTabBar:TabBar;
		private var _expWidth:int;
		private function getUI() : void
		{
			var arr:Array = [searchOf("Pack"), searchOf("Skill"), searchOf("Formation")];
			_tabBar = new TabBar(arr);
			_tabBar.addEventListener(TabBar.TYPE_SELECT_CHANGE, onTabChange);
			_tabBar.selectIndex = TABS.indexOf(_curTab);
			
			arr = [searchOf("RoleLabeFrist"), searchOf("RoleLabeSecond"), searchOf("RoleLabeThird")];
			_roleTabBar = new TabBar(arr);
			_roleTabBar.addEventListener(TabBar.TYPE_SELECT_CHANGE, onRoleTabChange);
			_roleTabBar.selectIndex = 0;
			
			_expWidth = (searchOf("RoleExpBar") as Image).width; 
		}
		
		private function onTabChange(e:Event) : void
		{
			_curTab = TABS[e.data as int];
			checkTab();
		}
		
		private function onRoleTabChange(e:Event) : void
		{
			if (!isInit) return;
			
			this._curRoleName = player.team[e.data as int];
			initRender();
		}
		
		// 开始渲染
		protected function initRender() : void
		{
			renderRoleBaseInfo();
			renderRoleTab();
			renderSkill();
			renderEquip();
			renderFormation();
		}
		
		/// 角色基本信息
		private var _curRoleModel:RoleModel;
		private function renderRoleBaseInfo() : void
		{
			_curRoleModel = player.getRoleModel(_curRoleName);
			
			(searchOf("RoleName") as TextField).text = _curRoleModel.model.name.toString();
			(searchOf("HP") as TextField).text = _curRoleModel.model.hp.toString();
			(searchOf("MP") as TextField).text = _curRoleModel.model.mp.toString();
			(searchOf("ATK") as TextField).text = _curRoleModel.model.atk.toString();
			(searchOf("Evasion") as TextField).text = _curRoleModel.model.evasion.toString();
			(searchOf("SPD") as TextField).text = _curRoleModel.model.spd.toString();
			(searchOf("DEF") as TextField).text = _curRoleModel.model.def.toString();
			(searchOf("CRIT") as TextField).text = _curRoleModel.model.crit.toString();
			(searchOf("Level") as TextField).text = _curRoleModel.model.lv.toString();
			(searchOf("EXP") as TextField).text = _curRoleModel.info.exp + "/" +　_curRoleModel.nextExp;
			(searchOf("RoleExpBar") as Image).width = (_curRoleModel.info.exp / _curRoleModel.nextExp) * _expWidth;
			
			var imageName:String = "RoleImage_Big_" + _curRoleName;
			(searchOf("RoleImage") as Image).texture = _view.role_big.interfaces(InterfaceTypes.GetTexture, imageName);
		}
		
		/// 角色标签
		private var _teams:Array;
		private function renderRoleTab() : void
		{
			_teams = player.team;
			
			(searchOf("RoleLabeFrist") as RoleLabelComponent).panel.visible = false;
			(searchOf("RoleLabeSecond") as RoleLabelComponent).panel.visible = false;
			(searchOf("RoleLabeThird") as RoleLabelComponent).panel.visible = false;
			
			var roleName:String;
			for(var i:int = 0, len:int = _teams.length; i < len; i++)
			{
				roleName = _teams[i];
				
				switch (i)
				{
					case 0:
						(searchOf("RoleLabeFrist") as RoleLabelComponent).setRoleName(roleName);
						break;
					case 1:
						(searchOf("RoleLabeSecond") as RoleLabelComponent).setRoleName(roleName);
						break;
					case 2:
						(searchOf("RoleLabeThird") as RoleLabelComponent).setRoleName(roleName);
						break;
				}
			}
		}
		
		/**
		 * 技能 
		 * 
		 */
		private var _skillGrid:Grid;
		private var _equippedSkillGrid:Grid;
		private var _skills:Vector.<SkillModel>;
		private var _equippedSkills:Vector.<SkillModel>;
		private function renderSkill() : void
		{			
			_view.controller.db.getSkillAllData(
				_curRoleModel.info,
				function (data:*) : void
				{
					_skills = data;
				});
			
			_equippedSkills = _curRoleModel.info.skill.getSkills();
			
			if (!_skillGrid)
			{
				_skillGrid = new Grid(SkillItemRender, 6, 5, 36, 36, 9, 10);
				_skillGrid["layerName"] = SKILL_TAB;
				_skillGrid.x = 384;
				_skillGrid.y = 110;
				panel.addChild(_skillGrid);
				_uiLibrary.push(_skillGrid);
			}
			
			if (!_equippedSkillGrid)
			{
				_equippedSkillGrid = new Grid(SkillItemRender, 3, 1, 36, 36, 0, 14);
				_equippedSkillGrid["layerName"] = "BackGround";
				_equippedSkillGrid.x = 75;
				_equippedSkillGrid.y = 106;
				panel.addChild(_equippedSkillGrid);
				_uiLibrary.push(_equippedSkillGrid);
			}
			
			_skillGrid.setData(_skills as Vector.<*>, searchOf("SkillChangePageList"));
			_equippedSkillGrid.setData(_equippedSkills as Vector.<*>);
		}
		
		
		//// 技能
		private var _equipmentGrid:Grid;
		private var _equippedEquipGrid:Grid;
		private var _equipPack:Vector.<EquipModel>;
		private var _equippedEquips:Vector.<EquipModel>;
		private function renderEquip() : void
		{
			if (!_equipmentGrid)
			{
				_equipmentGrid = new Grid(EquipItemRender, 6, 5, 36, 36, 9, 10);
				_equipmentGrid["layerName"] = PACK_TAB;
				_equipmentGrid.x = 384;
				_equipmentGrid.y = 110;
				panel.addChild(_equipmentGrid);
				_uiLibrary.push(_equipmentGrid);
			}
			_equipPack = player.pack.getUnEquip();
			_equipmentGrid.setData(_equipPack as Vector.<*>);	
			
			if (!_equippedEquipGrid)
			{
				_equippedEquipGrid = new Grid(EquipItemRender, 3, 1, 36, 36, 0, 14);
				_equippedEquipGrid["layerName"] = "BackGround";
				_equippedEquipGrid.x = 271;
				_equippedEquipGrid.y = 106;
				panel.addChild(_equippedEquipGrid);
				_uiLibrary.push(_equippedEquipGrid);
			}
			
			_equippedEquips = _curRoleModel.info.equip.getEquipModels();
			_equippedEquipGrid.setData(_equippedEquips as Vector.<*>);
		}
		
		/**
		 *　阵型 
		 * 
		 */		
		private function renderFormation() : void
		{
			
		}
		
		// 当前标签页
		private function checkTab() : void
		{
			for each(var item:* in _uiLibrary)
			{
				if (item is RoleLabelComponent) continue;
				
				
				if (item["layerName"] == "BackGround" || item["layerName"] == _curTab)
				{
					if (item is DisplayObject) item.visible = true;
					if (item is Component) item["panel"].visible = true;
					
				}
				else
				{
					if (item is DisplayObject) item.visible = false;
					if (item is Component) item["panel"].visible = false;
				}
			}
			
			if (_teams) _roleTabBar.selectIndex = _teams.indexOf(this._curRoleName);
		}
		
		//// 装备
		public function equipEquipment(equip:EquipModel) : void
		{
			_view.controller.equip.setEquip(this._curRoleModel, equip);
			
			// 刷新
			this._curRoleModel.beginCount();
			renderRoleBaseInfo();
			renderEquip();
		}
		
		public function downEquipment(equip:EquipModel) : void
		{
			_view.controller.equip.downEquipment(_curRoleModel, equip); 
			
			// 刷新
			_curRoleModel.beginCount();
			renderRoleBaseInfo();
			renderEquip();
		}
		
		/// 技能
		public function equipSkill(skill:SkillModel) : void
		{
			_view.controller.skill.setEquip(_curRoleModel, skill);
			
			_curRoleModel.beginCount();
			renderSkill();
		}
		
		public function downSkill(skill:SkillModel) : void
		{
			_view.controller.skill.downEquip(_curRoleModel, skill);
			
			_curRoleModel.beginCount();
			renderSkill();
		}
		
		// 点击
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
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
				textures = _view.preload.interfaces(InterfaceTypes.GetTextures, name);
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
			if (type == "pack")
			{
				texture = getTextureFromSwf("RoleDetail.swf", name, V.ROLE_DETAIL);
			}
			else if (type == "public")
			{
				texture = _view.preload.interfaces(InterfaceTypes.GetTexture, name);
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
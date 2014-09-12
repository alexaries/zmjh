package com.game.view.Role
{
	import com.engine.ui.controls.DragTransposition;
	import com.engine.ui.controls.Grid;
	import com.engine.ui.controls.ShortCutMenu;
	import com.engine.ui.controls.TabBar;
	import com.game.Data;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.PropModel;
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
	import com.game.view.equip.PropTip;
	import com.game.view.prop.PropsItemRender;
	import com.game.view.skill.SkillItemRender;
	import com.game.view.ui.UIConfig;
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class RoleDetailView extends BaseView implements IView
	{
		public static const TABS:Array = ["Pack", "Skill", "Formation", "Prop"];
		public static const PACK_TAB:String = "Pack";		
		public static const SKILL_TAB:String = "Skill";		
		public static const FORMATION_TAB:String = "Formation";
		public static const PROP_TAB:String = "Prop";
		
		// 当前标签
		private var _curTab:String;
		
		// 当前选中的角色
		private var _curRoleName:String = "";
		
		/**
		 * 一键卖出白色装备所能获得的金币数
		 */		
		private var sellMoneyTotal:int;
		
		public function RoleDetailView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.ROLE_DETAIL;
			_curTab = PACK_TAB;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		override protected function show():void
		{
			_loadResources = GameConfig.instance.ASSETS["role"]["module"];
			
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
				case InterfaceTypes.REFRESH:
					refreshView();
					break;
				case InterfaceTypes.HIDE:
					this.hide();
					break;
			}
		}
		
		protected function preInit() : void
		{
			_view.roleImage.interfaces();
			_view.icon.interfaces();
		}
		
		
		/**
		 * 刷新界面 
		 * 
		 */		
		protected function refreshView() : void
		{
			initRender();
			checkTab();
		}
		
		override protected function init() : void
		{
			if (!this.isInit)
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
			
			display();
			initRender();
			checkTab();
			_view.layer.setCenter(panel);
		}
		
		// xml
		private var _positionXML:XML;
		private var _infomationXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "RoleDetailPosition");
			_infomationXML = getXMLData(V.PUBLIC, GameConfig.PUBLIC_RES, "instruction");
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
						case "OneFormation":
							cp = new OneFormationComponent(items, _titleTxAtlas);
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
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "Role");			
				obj = getAssetsObject(V.ROLE, GameConfig.ROLE_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
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
		private var _packPageComponent:ChangePageComponent;
		private var _skillPageComponent:ChangePageComponent;
		private var _propsPageComponent:ChangePageComponent;
		private var _roleImage:Image;
		private var _roleImageW:int;
		private var _roleImageH:int;
		private var _shortCutMenu:ShortCutMenu;
		private var _sellBtn:Button;
		private function getUI() : void
		{
			_sellBtn = searchOf("Sell") as Button;
			
			var arr:Array = [searchOf("Pack"), searchOf("Skill"), searchOf("Formation"), searchOf("Prop")];
			_tabBar = new TabBar(arr);
			_tabBar.addEventListener(TabBar.TYPE_SELECT_CHANGE, onTabChange);
			_tabBar.selectIndex = TABS.indexOf(_curTab);
			
			arr = [searchOf("RoleLabeFrist"), searchOf("RoleLabeSecond"), searchOf("RoleLabeThird")];
			_roleTabBar = new TabBar(arr);
			_roleTabBar.addEventListener(TabBar.TYPE_SELECT_CHANGE, onRoleTabChange);
			_roleTabBar.selectIndex = 0;
			
			_expWidth = (searchOf("RoleExpBar") as Image).width;
			
			_packPageComponent = searchOf("PackChangePageList") as ChangePageComponent;
			_skillPageComponent = searchOf("SkillChangePageList") as ChangePageComponent;
			_propsPageComponent = searchOf("PropChangePageList") as ChangePageComponent;
			
			_roleImage = (searchOf("RoleImage") as Image);
			_roleImageW = _roleImage.x;
			_roleImageH = _roleImage.y;
			
			_shortCutMenu = _view.ui.interfaces(UIConfig.GET_SHORT_CUT_MENU);
			
			//体力，元气，外功，根骨，灵活，暴击，步法的信息显示
			_infomationTip = new Vector.<TextField>();
			_infomationTip.push(searchOf("HP_Title") as TextField);
			_infomationTip.push(searchOf("MP_Title") as TextField);
			_infomationTip.push(searchOf("ATK_Title") as TextField);
			_infomationTip.push(searchOf("DEF_Title") as TextField);
			_infomationTip.push(searchOf("Evasion_Title") as TextField);
			_infomationTip.push(searchOf("CRIT_Title") as TextField);
			_infomationTip.push(searchOf("SPD_Title") as TextField);
			
			//添加信息到显示
			_propTip = _view.ui.interfaces(UIConfig.PROP_TIP);
			for(var i:int = 0; i < _infomationTip.length; i++)
			{
				//_propTip.removeProp(_infomationXML.item[i].@name);
				_propTip.add({o:_infomationTip[i], m:{name:_infomationXML.item[i].@name, message:_infomationXML.item[i]}});
			}
		}
		
		private function onTabChange(e:Event) : void
		{
			_curTab = TABS[e.data as int];
			checkTab();
			if(_curTab == "Pack") _sellBtn.visible = true;
			else _sellBtn.visible = false;
			
			if(_curTab == "Skill")
			{
				//1级向导
				if(_view.first_guide.isGuide)
					_view.first_guide.setFunc();
			}
		}
		
		private function onRoleTabChange(e:Event) : void
		{
			if (!isInit) return;
			
			_curRoleName = _teams[e.data as int];
			initRender();
			
			if(_shortCutMenu) _shortCutMenu.hide();
		}
		
		// 开始渲染
		protected function initRender() : void
		{
			renderRoleBaseInfo();
			renderRoleTab();
			renderSkill();
			renderEquip();
			renderFormation();
			renderProps();
		}
		
		/// 角色基本信息
		private var _curRoleModel:RoleModel;
		private var _propTip:PropTip;
		private var _infomationTip:Vector.<TextField>;
		private function renderRoleBaseInfo() : void
		{
			_curRoleModel = player.getRoleModel(_curRoleName);
			
			(searchOf("RoleName") as TextField).text = _curRoleModel.model.name.toString();
			(searchOf("HP") as TextField).text = _curRoleModel.hp.toString();// + "/" + _curRoleModel.model.hp;
			(searchOf("MP") as TextField).text = _curRoleModel.mp.toString();// + "/" + _curRoleModel.model.mp;
			(searchOf("ATK") as TextField).text = _curRoleModel.model.atk.toString();
			(searchOf("Evasion") as TextField).text = _curRoleModel.model.evasion.toString();
			(searchOf("SPD") as TextField).text = _curRoleModel.model.spd.toString();
			(searchOf("DEF") as TextField).text = _curRoleModel.model.def.toString();
			(searchOf("CRIT") as TextField).text = _curRoleModel.model.crit.toString();
			(searchOf("Level") as TextField).text = _curRoleModel.model.lv.toString();
			(searchOf("EXP") as TextField).text = _curRoleModel.info.exp + "/" +　_curRoleModel.nextExp;
			(searchOf("RoleExpBar") as Image).width = (_curRoleModel.info.exp / _curRoleModel.nextExp) * _expWidth;
			//trace(_curRoleModel.model.ats, _curRoleModel.model.adf);
			var roleName:String = _curRoleName;
			if(_curRoleName.indexOf("（") != -1) roleName =	 _curRoleName.substring(0, _curRoleName.indexOf("（"));
			
			var imageName:String;
			if(_curRoleModel.nowUseFashion == "")
			 	imageName = "RoleImage_Big_" + roleName;
			else
				imageName = "RoleImage_Big_" + roleName + "_" + _curRoleModel.nowUseFashion;
			var texture:Texture = _view.role_big.interfaces(InterfaceTypes.GetTexture, imageName);
			_roleImage.texture = texture;
			_roleImage.width = texture.width * V.ROLE_SCALE;
			_roleImage.height = texture.height * V.ROLE_SCALE;
		}
		
		/// 角色标签
		private var _teams:Array;
		private function renderRoleTab() : void
		{
			var team:Array = player.formation.getAllRoleName();
			var isSame:Boolean = true;
			if (_teams)
			{
				if (team.length == _teams.length)
				{
					for(var j:int = 0; j <　_teams.length; j++)
					{
						if (team.indexOf(_teams[j]) == -1)
						{
							isSame = false;
							break;
						}
					}
				}
				else
				{
					isSame = false;
				}
			}
			else
			{
				isSame = false;
			}
			
			if (!isSame) _teams = team;
			
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
			
			_equippedSkills = Data.instance.skill.getSkills(_curRoleModel.info.skill);
			
			if (!_skillGrid)
			{
				_skillGrid = new Grid(SkillItemRender, 6, 5, 42, 42, 3, 5);
				_skillGrid["layerName"] = SKILL_TAB;
				_skillGrid.x = 381;
				_skillGrid.y = 102;
				panel.addChild(_skillGrid);
				_uiLibrary.push(_skillGrid);
			}
			
			if (!_equippedSkillGrid)
			{
				_equippedSkillGrid = new Grid(SkillItemRender, 3, 1, 42, 42, 0, 7);
				_equippedSkillGrid["layerName"] = "BackGround";
				_equippedSkillGrid.x = 72;
				_equippedSkillGrid.y = 102;
				panel.addChild(_equippedSkillGrid);
				_uiLibrary.push(_equippedSkillGrid);
			}
			
			_skillGrid.setData(_skills, _skillPageComponent);
			_equippedSkillGrid.setData(_equippedSkills);
		}
		
		
		//// 装备
		private var _equipmentGrid:Grid;
		private var _equippedEquipGrid:Grid;
		private var _equipPack:Vector.<EquipModel>;
		private var _equippedEquips:Vector.<EquipModel>;
		private function renderEquip() : void
		{
			if (!_equipmentGrid)
			{
				_equipmentGrid = new Grid(EquipItemRender, 6, 5, 42, 42, 3, 5);
				_equipmentGrid["layerName"] = PACK_TAB;
				_equipmentGrid.x = 381;
				_equipmentGrid.y = 102;
				panel.addChild(_equipmentGrid);
				_uiLibrary.push(_equipmentGrid);
			}
			_equipPack = player.pack.getUnEquip();
			_equipmentGrid.setData(_equipPack, _packPageComponent);	
			
			if (!_equippedEquipGrid)
			{
				_equippedEquipGrid = new Grid(EquipItemRender, 3, 1, 42, 42, 0, 7);
				_equippedEquipGrid["layerName"] = "BackGround";
				_equippedEquipGrid.x = 266;
				_equippedEquipGrid.y = 102;
				panel.addChild(_equippedEquipGrid);
				_uiLibrary.push(_equippedEquipGrid);
			}
			
			_equippedEquips = Data.instance.equip.getEquipModels(_curRoleModel.info.equip);
			_equippedEquipGrid.setData(_equippedEquips);
		}
		
		/**
		 *　阵型 
		 * 
		 */
		private var _formationFront:OneFormationComponent;
		private var _formationMiddle:OneFormationComponent;
		private var _formationBack:OneFormationComponent;
		private var _dragFormation:DragTransposition;
		private function renderFormation() : void
		{
			if (!_formationFront) _formationFront = searchOf("FormationFront") as OneFormationComponent;
			if (!_formationMiddle) _formationMiddle = searchOf("FormationMiddle") as OneFormationComponent;
			if (!_formationBack) _formationBack = searchOf("FormationBack") as OneFormationComponent;
			
			_formationFront.setFormation(player.formation.front);
			_formationMiddle.setFormation(player.formation.middle);
			_formationBack.setFormation(player.formation.back);
			
			if (!_dragFormation) 
			{
				_dragFormation = new DragTransposition([_formationFront.panelContain, _formationMiddle.panelContain, _formationBack.panelContain]);
				_dragFormation.addEventListener(DragTransposition.TRANSPOSITION, onDragTrans);
			}
		}
		
		private var _propsGrid:Grid;
		private var _propsPack:Vector.<PropModel>;
		private function renderProps() : void
		{
			if (!_propsGrid)
			{
				_propsGrid = new Grid(PropsItemRender, 6, 5, 42, 42, 3, 5);
				_propsGrid["layerName"] = PROP_TAB;
				_propsGrid.x = 381;
				_propsGrid.y = 102;
				panel.addChild(_propsGrid);
				_uiLibrary.push(_propsGrid);
			}
			_propsPack = player.pack.getCountProp();
			_propsGrid.setData(_propsPack, _propsPageComponent);	
		}
		
		/**
		 *  换位
		 * @param e
		 * 
		 */		
		private function onDragTrans(e:Event) : void
		{
			var sIndex:int = e.data["sIndex"];
			var tIndex:int = e.data["tIndex"];
			
			_view.controller.formation.setTransposition(sIndex, tIndex);
			renderFormation();
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
			
			if(_curTab == "Pack") _sellBtn.visible = true;
			else _sellBtn.visible = false;
		}
		
		//// 装备
		// 穿上装备
		public function equipEquipment(equip:EquipModel) : void
		{
			if (equip.config.grade_limit > _curRoleModel.model.lv)
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"装备不上去了吧，还不去多练几级!!!",
					null, null, false, true, false);
				return;
			}
			_view.controller.equip.setEquip(this._curRoleModel, equip);
			
			//1级向导
			if(_view.first_guide.isGuide)
				_view.first_guide.setFunc();
			
			// 刷新
			this._curRoleModel.beginCount(false);
			renderRoleBaseInfo();
			renderEquip();
			
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
		
		// 卸下装备
		public function downEquipment(equip:EquipModel) : void
		{
			_view.controller.equip.downEquipment(_curRoleModel, equip); 
			
			// 刷新
			_curRoleModel.beginCount(false);
			renderRoleBaseInfo();
			renderEquip();
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
		
		// 卖出装备
		public function sellEquipment(equip:EquipModel) : void
		{
			_view.controller.equip.sellEquipment(_curRoleModel, equip);
			
			// 刷新
			_curRoleModel.beginCount(false);
			renderRoleBaseInfo();
			renderEquip();
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
		
		/**
		 * 卖出所有白色装备
		 * 
		 */		
		private function sellAllEquipment() : void
		{
			sellMoneyTotal = 0;
			for(var i:int = _equipPack.length - 1; i >= 0; i--)
			{
				//判断为白色装备则卖出
				if(_equipPack[i].config.color == "白")
				{
					_view.controller.equip.sellEquipment(_curRoleModel, _equipPack[i]);
					sellMoneyTotal += _equipPack[i].config.sale_money;
				}
			}
			
			if(sellMoneyTotal == 0) return;
			_view.prompEffect.play("获得金币 " + sellMoneyTotal);
			
			_curRoleModel.beginCount(false);
			renderRoleBaseInfo();
			renderEquip();
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
		
		/// 技能
		public function equipSkill(skill:SkillModel) : void
		{
			//1级向导
			if(_view.first_guide.isGuide)
				_view.first_guide.setFunc();
			
			_view.controller.skill.setEquip(_curRoleModel, skill);
			
			_curRoleModel.beginCount(false);
			renderSkill();
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
		
		public function downSkill(skill:SkillModel) : void
		{
			if (_curRoleModel.configData.fixedskill_name == skill.skill.skill_name)
			{
				_view.tip.interfaces(
					InterfaceTypes.Show,
					"该技能属于专属技能，不能卸下！！！",
					null, null, false, true, false);
				return;
			}
			
			_view.controller.skill.downEquip(_curRoleModel, skill);
			
			_curRoleModel.beginCount(false);
			renderSkill();
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
		
		/**
		 * 使用道具
		 * @param props
		 * 
		 */		
		public function useProps(props:PropModel) : void
		{
			_view.props.useProps(props, propCallback);
		}
		
		private function propCallback() : void
		{
			renderProps();
			renderEquip();
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
		
		// 点击
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "Close":
					//1级向导
					if(_view.first_guide.isGuide)
						_view.first_guide.setFunc();
					this.hide();
					_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
					break;
				case "Sell":
					this.sellAllEquipment();
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
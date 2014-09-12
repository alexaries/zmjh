package com.game.view.upgrade
{
	import com.engine.ui.controls.ComponentGrid;
	import com.engine.ui.controls.Grid;
	import com.engine.ui.controls.TabBar;
	import com.game.Data;
	import com.game.data.db.protocal.Characters;
	import com.game.data.db.protocal.Skill;
	import com.game.data.db.protocal.Title;
	import com.game.data.player.structure.RoleInfo;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.Role.ChangePageComponent;
	import com.game.view.ViewEventBind;
	import com.game.view.achievement.AchievementRoleItemRender;
	import com.game.view.effect.EffectShow;
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class UpgradeView extends BaseView implements IView
	{
		public static const TABS:Array = ["upgrade", "breakthrough"];
		public static const ROLETABS:Array = ["SkillBar", "RoleBar", "TitleBar"];
		public static const TABS_1:Array = ["Describe", "Compose"];
		public static const CHANGETAB:Array = ["AllRole", "TypeRole", "DefRole", "AtkRole", "ControllRole", "OtherRole"];
		public function UpgradeView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.UPGRADE_SKILL;
			_loaderModuleName = V.UPGRADE_SKILL;
			
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
				isInit = true;
			}
			
			render();
			
			_view.layer.setCenter(panel);
		}
		
		private var _pageComponent:ChangePageComponent;
		private var _rolePageComponent:ChangePageComponent;
		private var _upgradeSkillComponent:UpgradeSkillComponent;
		private var _tabBar:TabBar;
		private var _roleTabBar:TabBar;
		private var _tabBar_1:TabBar;
		private var _curTab:String;
		private var _curRoleTab:String;
		private var _curTab_1:String;
		private var _startUpgradeBtn:Button;
		private var _effectShow:EffectShow;
		private var _gatherEffect:MovieClip;
		private var _spreadEffect:MovieClip;
		private var _successEffect:MovieClip;
		
		private var _changeTypeBar:TabBar;
		private var _curChangeTab:String;
		
		private var _roleDetail:RoleDetailComponent;
		
		private var _completeTF:TextField;
		
		private var _titlePageComponent:ChangePageComponent;
		private var _titleDetailComponent:TitleDetailComponent;
		private var _equipTitleBtn:Button;
		private var _unEquipTitleBtn:Button;
		private var _alreadyTitleImage:Image;
		private var _alreadyGetTF:TextField;
		private function getUI():void
		{
			var arr:Array = [this.searchOf("UpgradeBtn"), this.searchOf("BreakThroughBtn")];
			_tabBar = new TabBar(arr);
			_tabBar.addEventListener(TabBar.TYPE_SELECT_CHANGE, onTabChange);
			_tabBar.selectIndex = 0;
			
			arr = [searchOf("SkillBar"), searchOf("RoleBar"), searchOf("TitleBar")];
			_roleTabBar = new TabBar(arr);
			_roleTabBar.addEventListener(TabBar.TYPE_SELECT_CHANGE, onRoleTabChange);
			_roleTabBar.selectIndex = 0;
			
			arr = [this.searchOf("DescribeBtn"), this.searchOf("ComposeBtn")];
			_tabBar_1 = new TabBar(arr);
			_tabBar_1.addEventListener(TabBar.TYPE_SELECT_CHANGE, onTabChange_1);
			_tabBar_1.selectIndex = 0;
			
			arr = [this.searchOf("AllRole"), this.searchOf("TypeRole"), this.searchOf("DefRole"), this.searchOf("AtkRole"), this.searchOf("ControllRole"), this.searchOf("OtherRole")];
			_changeTypeBar = new TabBar(arr);
			_changeTypeBar.addEventListener(TabBar.TYPE_SELECT_CHANGE, onTabChangeRoleType);
			_changeTypeBar.selectIndex = 0;
			
			_pageComponent = this.searchOf("PropChangePageList") as ChangePageComponent;
			_pageComponent._callbackFunc = resetSkillList;
			
			_rolePageComponent = this.searchOf("RoleChangePageList") as ChangePageComponent;
			
			_roleDetail = this.searchOf("RoleDetail") as RoleDetailComponent;
			_roleDetail.setNull();
			
			_upgradeSkillComponent = this.searchOf("UpgradeSkill") as UpgradeSkillComponent;
			_upgradeSkillComponent.setData(null);
			_startUpgradeBtn = this.searchOf("StartUpgradeBtn");
			
			_effectShow = new EffectShow(panel);
			
			_gatherEffect = this.searchOf("GatherEffect");
			_spreadEffect = this.searchOf("SpreadEffect");
			_successEffect = this.searchOf("lightEffect");
			
			_completeTF = this.searchOf("CompleteDetail");
			
			_titlePageComponent = this.searchOf("TitleChangePageList");
			_titlePageComponent._callbackFunc = resetTitleBar;
			_titleDetailComponent = this.searchOf("TitleDetail");
			
			_equipTitleBtn = this.searchOf("EquipTitleBtn");
			_unEquipTitleBtn = this.searchOf("UnEquipTitleBtn");
			_alreadyTitleImage = this.searchOf("AlreadyTitleImage");
			_alreadyTitleImage.rotation = -.3;
			_alreadyGetTF = this.searchOf("AlreadyGetTF");
		}
		
		private function onTabChangeRoleType(e:Event):void
		{
			_curChangeTab = CHANGETAB[e.data as int];
			switch(_curChangeTab)
			{
				case "AllRole":
					getAllName();
					renderRoles();
					break;
				case "TypeRole":
					getTypeName();
					renderRoles();
					break;
				case "DefRole":
					getTypeRole("肉盾");
					renderRoles();
					break;
				case "AtkRole":
					getTypeRole("输出");
					renderRoles();
					break;
				case "ControllRole":
					getTypeRole("控制");
					renderRoles();
					break;
				case "OtherRole":
					getTypeRole("辅助");
					renderRoles();
					break;
			}
		}
		
		private function onTabChange_1(e:Event):void
		{
			_curTab_1 = TABS_1[e.data as int];
			if(_curTab_1 == TABS_1[1])
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"功能未开放！",
					null, null, false, true, false);
				_tabBar_1.selectIndex = 0;
			}
		}
		
		private function onRoleTabChange(e:Event) : void
		{
			_curRoleTab = ROLETABS[e.data as int];
			checkStatus();
			checkItem();
		}
		
		private function checkItem() : void
		{
			if(_curRoleTab == ROLETABS[0])
			{
				if(_skillGrid != null)
				{
					_skillGrid.visible = true;
					setUpgradeSkill();
				}
				if(_rolesGrid != null) _rolesGrid.visible = false;
				if(_titleGrid != null) _titleGrid.visible = false;
				if(_gatherEffect && _gatherEffect.parent != null) _gatherEffect.parent.removeChild(_gatherEffect);
				if(_spreadEffect && _spreadEffect.parent != null) _spreadEffect.parent.removeChild(_spreadEffect);
				if(_successEffect && _successEffect.parent != null) _successEffect.parent.removeChild(_successEffect);
			}
			else if(_curRoleTab == ROLETABS[1])
			{
				if(_skillGrid != null) _skillGrid.visible = false;
				if(_rolesGrid != null)
				{
					_rolesGrid.visible = true;
					_roleDetail.setNull();
				}
				if(_titleGrid != null) _titleGrid.visible = false;
			}
			else if(_curRoleTab == ROLETABS[2])
			{
				if(_skillGrid != null) _skillGrid.visible = false;
				if(_rolesGrid != null) _rolesGrid.visible = false;
				if(_titleGrid != null) _titleGrid.visible = true;
				renderButton();
			}
		}
		
		private function checkStatus() : void
		{
			var targetXML:XML = new XML();
			
			if(_curRoleTab == ROLETABS[0])
				targetXML = _positionXML.layer[0];
			else if(_curRoleTab == ROLETABS[1])
				targetXML = _positionXML.layer[1];
			else if(_curRoleTab == ROLETABS[2])
				targetXML = _positionXML.layer[2];
			
			resetPosition(targetXML);
			
			for each(var item:* in _uiLibrary)
			{
				if (item is starling.display.DisplayObject) item.visible = false;
				else if (item is Component) (item as Component).panel.visible = false;
			}
			
			seStatusOfXML(targetXML, true);
		}
		
		private function onTabChange(e:Event) : void
		{
			_curTab = TABS[e.data as int];
			if(_curTab == TABS[1])
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"功能未开放！",
					null, null, false, true, false);
				_tabBar.selectIndex = 0;
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
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture():void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(_moduleName, GameConfig.UPGRADE_SKILL_RES, "Upgrade");			
				obj = getAssetsObject(_moduleName, GameConfig.UPGRADE_SKILL_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
			}
		}
		
		private var _positionXML:XML;
		private var _instructionXML:XML;
		private var _skillData:Vector.<Object>;
		private var _skillUpData:Vector.<Object>;
		private var _infoData:Vector.<Object>;
		public function get infoData() : Vector.<Object>
		{
			return _infoData;
		}
		private var _lastData:Vector.<Object>;
		public function get skillUpData() : Vector.<Object>
		{
			return _skillUpData;
		}
		private var _titleData:Vector.<Object>;
		private function initXML():void
		{
			_positionXML = getXMLData(_moduleName, GameConfig.UPGRADE_SKILL_RES, "UpgradePosition");
			_instructionXML = getXMLData(_moduleName, GameConfig.UPGRADE_SKILL_RES, "UpgradeSkillInstructionPosition");
			_skillData = Data.instance.db.interfaces(InterfaceTypes.GET_ALL_SKILL_DATA);
			_skillUpData = new Vector.<Object>();
			_skillUpData = Data.instance.db.interfaces(InterfaceTypes.GET_SKILL_UP_DATA);
			initSkill();
			
			if(!_infoData)
			{
				_lastData = new Vector.<Object>();
				_infoData = new Vector.<Object>();
				_infoData = Data.instance.db.interfaces(InterfaceTypes.GET_CHARACTER_DATA);
			}
			if(!_titleData)
			{
				_titleData = new Vector.<Object>();
				_titleData = Data.instance.db.interfaces(InterfaceTypes.GET_TITLE_ADD_DATA);
			}
		}	
		
		private var _skillList:Vector.<Object>;
		private function initSkill() : void
		{
			_skillList = new Vector.<Object>();
			for each(var item:Object in _skillData)
			{
				if(item.type == 0 || item.type == 1)
					_skillList.push(item);
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
						case "ChangePage":
							cp = new ChangePageComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "UpgradeSkillComponent":
							cp = new UpgradeSkillComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "RoleDetailComponent":
							cp = new RoleDetailComponent(items, _titleTxAtlas);
							_components.push(cp);
							break
						case "TitleComponent":
							cp = new TitleDetailComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "TitleSelectComponent":
							cp = new TitleSelectComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
							
					}
				}
			}
		}	
		
		private function render():void
		{
			renderButton();
			renderSkill();
			renderRoles();
			renderTitle();
			checkItem();
		}
		
		private var _rolesGrid:Grid;
		private var _infoList:Vector.<String>;
		public function renderRoles() : void
		{			
			if (!_rolesGrid)
			{
				_rolesGrid = new Grid(AchievementRoleItemRender, 4, 3, 72, 72, 8.5, 6);
				_rolesGrid["layerName"] = "BackGround";
				_rolesGrid.x = 78;
				_rolesGrid.y = 85;
				panel.addChild(_rolesGrid);
				_uiLibrary.push(_rolesGrid);
				getAllName();
			}
			_rolesGrid.setData(_infoList, _rolePageComponent);
			
			if(_completeTF != null) _completeTF.text = (player.upgradeRole.getRoleList.length / (_infoData.length - 5) * 100).toFixed(2) + "%";
		}
		
		
		/**
		 * 获得所有角色
		 * 
		 */		
		private function getAllName() : void
		{
			_infoList = new Vector.<String>();
			for each(var item:Object in _infoData)
			{
				if((item as Characters).name == "韦小宝" ||　(item as Characters).name.split("（").length > 1) continue;
				_infoList.push((item as Characters).name);
			}
		}
		
		/**
		 * 根据类型获得角色
		 * @param type
		 * 
		 */		
		private function getTypeRole(type:String) : void
		{
			_lastData = _infoData.slice(0);
			
			_infoList = new Vector.<String>();
			for each(var item:Object in _lastData)
			{
				if((item as Characters).name == "韦小宝" ||　(item as Characters).name.split("（").length > 1) continue;
				if(!compareType(type, item as Characters)) continue;
				_infoList.push((item as Characters).name);
			}
		}
		
		/**
		 * 根据品质获得角色
		 * 
		 */		
		private function getTypeName() : void
		{
			_lastData = _infoData.slice(0);
			_lastData.sort(Data.instance.role_select.sortByGrade);
			_lastData = _lastData.reverse();
			
			_infoList = new Vector.<String>();
			for each(var item:Object in _lastData)
			{
				if((item as Characters).name == "韦小宝" ||　(item as Characters).name.split("（").length > 1) continue;
				_infoList.push((item as Characters).name);
			}
		}
		
		private function compareType(str:String, item:Characters) : Boolean
		{
			var result:Boolean = false;
			var arr:Array = item.location.split("，");
			if(arr.length == 1 && arr[0] == str)
				result = true;
			if(arr.length == 2 && (arr[0] == str || arr[1] == str))
				result = true;
			
			return result;
		}
		
		
		private var _skillGrid:Grid;
		private function renderSkill() : void
		{
			if (!_skillGrid)
			{
				_skillGrid = new Grid(UpgradeSkillItemRender, 6, 5, 42, 42, 3, 5);
				_skillGrid.x = 82;
				_skillGrid.y = 74;
				panel.addChild(_skillGrid);
				_uiLibrary.push(_skillGrid);
			}
			_skillGrid.setData(_skillList, _pageComponent);
			resetSkillList();
		}
		
		private var _nowSkill:Skill;
		public function setUpgradeSkill(skill:Skill = null) : void
		{
			_nowSkill = skill;
			_upgradeSkillComponent.setData(skill);
			resetSkillList();
			renderButton();
		}
		
		private function resetSkillList(params:uint = 0) : void
		{
			var item:UpgradeSkillItemRender;
			var isHave:Boolean;
			for(var i:uint = 0; i < _skillGrid.numChildren; i++)
			{
				item = _skillGrid.getChildAt(i) as UpgradeSkillItemRender;
				if(_nowSkill != null && item.skillData.id == _nowSkill.id)
				{
					removeTouchable(item);
				}
				else
				{
					item.canClick = true;
					addTouchable(item);
				}
				
				isHave = false;
				for each(var skill:String in player.upgradeSkill.learnSkillList)
				{
					if(item.skillData.skill_name == skill)
					{
						isHave = true;
						break;
					}
				}
				if(!isHave)
				{
					item.canClick = false;
					removeOnlyTouchable(item);
				}
			}
		}
		
		public function setRoleDetail(roleName:String) : void
		{
			_roleDetail.setRole(roleName);
		}
		
		private var _nowTitleData:Object;
		private var _titleGrid:ComponentGrid;
		private var _componentList:Vector.<Component>;
		private function renderTitle() : void
		{
			if(!_titleGrid)
			{
				_componentList = new Vector.<Component>();
				
				for(var i:int = 0; i < _titleData.length; i++)
				{
					_componentList.push(createComponentItem("TitleSelectComponent", ("TitleItem" + i).toString()));
				}
				_titleGrid = new ComponentGrid(_componentList, 5, 1, 0, 10, 0, 50);
				_titleGrid["layerName"] = "TitleSelect";
				_titleGrid.x = 116;
				_titleGrid.y = 72;
				panel.addChild(_titleGrid);
				_uiLibrary.push(_titleGrid);
				_titleGrid.setData(_titleData, _titlePageComponent);
			}
			(_componentList[0] as TitleSelectComponent).onClick();
		}
		
		public function clickTitle(select:TitleSelectComponent) : void
		{
			for each(var item:TitleSelectComponent in _componentList)
			{
				if(item != select)
				{
					item.isSelect = false;
					item.leaveBtn();
				}
			}
			_nowTitleData = _titleData[_componentList.indexOf(select)];
			_titleDetailComponent.setData(_nowTitleData);
			resetEquipBtn();
			renderButton();
		}
		
		private function resetEquipBtn() : void
		{
			if(_curRoleTab == ROLETABS[2])
			{
				_alreadyTitleImage.visible = false;
				_alreadyGetTF.visible = false;
				if(!player.roleTitleInfo.checkTitle((_nowTitleData as Title).name))
				{
					_alreadyTitleImage.visible = false;
					_alreadyGetTF.visible = true;
					removeTouchable(_equipTitleBtn);
				}
				else
				{
					_alreadyTitleImage.visible = true;
					_alreadyGetTF.visible = false;
					addTouchable(_equipTitleBtn);
				}
			}
		}
		
		private function resetTitleBar(pageNum:int) : void
		{
			_nowTitleData = _titleData[5 * (pageNum - 1)];
			(_componentList[5 * (pageNum - 1)] as TitleSelectComponent).onClick();
		}
		
		private function renderButton() : void
		{
			if(_curRoleTab == ROLETABS[0])
			{
				if(_startUpgradeBtn == null) return;
				if(_nowSkill != null)
				{
					if(_nowSkill.hp_up == 0)
					{
						if(player.upgradeSkill.isUpgradeSkill(_nowSkill) < V.MAX_COMMON_SKILL_LEVEL)
							addTouchable(_startUpgradeBtn);
						else
							removeTouchable(_startUpgradeBtn);
					}
					else
					{
						if(player.upgradeSkill.isUpgradeSkill(_nowSkill) < V.MAX_CURE_SKILL_LEVEL)
							addTouchable(_startUpgradeBtn);
						else
							removeTouchable(_startUpgradeBtn);
					}
				}
				
			}
			else if(_curRoleTab == ROLETABS[2])
			{
				if(player.roleTitleInfo.nowTitle == (_nowTitleData as Title).name)
				{
					_equipTitleBtn.visible = false;
					_unEquipTitleBtn.visible = true;
				}
				else
				{
					_equipTitleBtn.visible = true;
					_unEquipTitleBtn.visible = false;
				}
				resetEquipBtn();
			}
			
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "Close":
					this.hide();
					break;
				case "StartUpgradeBtn":
					startUpgrade(); 
					break;
				case "UpgradeSkillInstructionBtn":
					_view.instruction_upgrade_skill.interfaces(InterfaceTypes.Show, _instructionXML);
					break;
				case "EquipTitleBtn":
					equipTitle();
					break;
				case "UnEquipTitleBtn":
					unEquipTitle();
					break;
			}
		}
		
		private function unEquipTitle():void
		{
			player.roleTitleInfo.nowTitle = "";
			player.mainRoleModel.beginCount();
			renderButton();
		}
		
		private function equipTitle():void
		{
			//player.roleTitleInfo.addNewTitle((_nowTitleData as Title).name);
			if(!player.roleTitleInfo.checkTitle((_nowTitleData as Title).name))
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"还未获得该称号，请继续努力！",
					null, null, false, true, false);
			}
			else
			{
				player.roleTitleInfo.nowTitle = (_nowTitleData as Title).name;
				player.mainRoleModel.beginCount();
				renderButton();
			}
		}
		
		private function startUpgrade() : void
		{
			if(_nowSkill != null)
			{
				_upgradeSkillComponent.checkConsume(addEffect);
			}
			else
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"请选择一个技能升级",
					null, null, false, true, false);
			}
		}
		
		/**
		 * 添加技能升级特效
		 * 
		 */		
		private function addEffect() : void
		{
			this.panel.touchable = false;
			_effectShow.addShowObj(_gatherEffect);
			_effectShow.addShowObj(_spreadEffect);
			_effectShow.addShowObj(_successEffect, 0, upgradeSkillComplete);
			_effectShow.start();
		}
		
		private function upgradeSkillComplete() : void
		{
			_upgradeSkillComponent.startUpgrade();
			player.upgradeSkill.addUpgradeSkill(_nowSkill.id);
			setUpgradeSkill(_nowSkill);
			renderButton();
			this.panel.touchable = true;
		}
		
		override public function hide():void
		{
			setUpgradeSkill();
			super.hide();
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
			else if(type == "effect")
			{
				textures = _view.other_effect.interfaces(InterfaceTypes.GetTextures, name);
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
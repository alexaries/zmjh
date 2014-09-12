package com.game.view.Role
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.engine.ui.controls.DragOut;
	import com.engine.ui.controls.DragTransposition;
	import com.engine.ui.controls.Grid;
	import com.engine.ui.controls.TabBar;
	import com.game.Data;
	import com.game.data.DataList;
	import com.game.data.db.protocal.Level_up_exp;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.structure.WeCharacterUtitiles;
	import com.game.data.player.structure.RoleInfo;
	import com.game.data.player.structure.RoleModel;
	import com.game.data.player.structure.SkillInfo;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.effect.EffectShow;
	import com.game.view.effect.GlowAnimationEffect;
	import com.game.view.effect.TextColorEffect;
	import com.game.view.equip.PropTip;
	import com.game.view.ui.UIConfig;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.Color;

	public class RoleSelectView extends BaseView implements IView
	{
		private var _anti:Antiwear;
		
		public static const TABS:Array = ["team", "transfer", "martial", "glowing"];
		public static const TEAM:String = "team";
		public static const TRANSFER:String = "transfer";
		public static const MARTIAL:String = "martial";
		public static const GLOWING:String = "glowing";
		public static const LUCKYRATE:Number = DataList.littleList[5];
		// 当前标签
		private var _curTab:String;
		
		/**
		 * 可以获得的经验总值
		 * @return 
		 * 
		 */		
		//private var allExp:int;
		public function get allExp() : int
		{
			return _anti["allExp"];
		}
		public function set allExp(value:int) : void
		{
			_anti["allExp"] = value;
		}
		
		/**
		 * 技能获得概率
		 * @return 
		 * 
		 */		
		//private var skillRate:Number;
		public function get skillRate() : Number
		{
			return _anti["skillRate"];
		}
		public function set skillRate(value:Number) : void
		{
			_anti["skillRate"] = value;
		}
		
		
		//private var _useLuckCount:int;
		public function get useLuckCount() : int
		{
			return _anti["useLuckCount"];
		}
		public function set useLuckCount(value:int) : void
		{
			_anti["useLuckCount"] = value;
		}
		
		//private var _luckCount:int;
		public function get luckCount() : int
		{
			return _anti["luckCount"];
		}
		public function set luckCount(value:int) : void
		{
			_anti["luckCount"] = value;
		}
		//private var _drugCount:int;
		public function get drugCount() : int
		{
			return _anti["drugCount"];
		}
		public function set drugCount(value:int) : void
		{
			_anti["drugCount"] = value;
		}
		
		//private var _useDrug:Boolean;
		public function get useDrug() : Boolean
		{
			return _anti["useDrug"];
		}
		public function set useDrug(value:Boolean) : void
		{
			_anti["useDrug"] = value;
		}
		
		public function RoleSelectView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.ROLE_SELECT;
			_loaderModuleName = V.PUBLIC;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["allExp"] = 0;
			_anti["skillRate"] = 0;
			_anti["useLuckCount"] = 0;
			_anti["luckCount"] = 0;
			_anti["drugCount"] = 0;
			_anti["useDrug"] = false;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_curTab = TEAM;
					this.show();
					break;
				case InterfaceTypes.SET_EFFECT:
					_curTab = MARTIAL;
					this.show();
					break;
				case InterfaceTypes.REFRESH:
					resetGlowingBtn();
					renderRoles();
					renderTeam();
					transferRoleBtnState();
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
				initPlayer();
				initComponent();
				initUI();
				initEvent();
				initMartial();
			}
			
			display();
			initRender();
			resetState();
			resetMartialState();
			
			_tabBar.selectIndex = TABS.indexOf(_curTab);
			
			_view.layer.setCenter(panel);
		}
		
		// xml
		private var _positionXML:XML;
		private var _levelInfo:Vector.<Object>;
		private var _propInformation:Object;
		private var _martialXML:XML;
		private var _transferXML:XML;
		private var _glowingXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "RoleSelectPosition");
			_levelInfo = new Vector.<Object>();
			_levelInfo = Data.instance.db.interfaces(InterfaceTypes.GET_LEVEL_UP_EXP);
			
			_propInformation = Data.instance.db.interfaces(InterfaceTypes.GET_PROP_DATA);
			
			_martialXML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "InstructionMartial");
			_transferXML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "InstructionTransfer");
			_glowingXML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "InstructionGlowing");
			
			Data.instance.pack.addNoneProp(12);
			Data.instance.pack.addNoneProp(34);
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
						case "TeamRole":
							cp = new TeamRoleComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "ChangePage":
							cp = new ChangePageComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "TransferComponent":
							cp = new TransferComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "ChangeCount":
							cp = new TransferChangeCount(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "Martial":
							cp = new MartialComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "GlowingComponent":
							cp = new GlowingComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
						case "TransferRoleType":
							cp = new TransferRoleComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
					}
				}	
			}
		}
		
		private function initMartial() : void
		{
			for(var i:int = 0; i < player.martialInfo.martialRoles.length; i++)
			{
				for(var j:int = 0; j < _martialList.length; j++)
				{
					if(_martialList[j].hasRole == false && _martialList[j].alreadyRole == false)
					{
						_martialList[j].setData(player.martialInfo.martialRoles[i], resetMartialRole);
						break;
					}
				}
			}
		}
		
		private function resetMartialRole() : void
		{
			renderRoles();
			setRoles();
		}
		
		private function initUI() : void
		{
			getObject();
			getUI();
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
		
		private var _tabBar:TabBar;
		private var _changePage:ChangePageComponent;
		private var _mainRoleCharacter:TransferComponent;
		private var _secondaryRoleCharacter:TransferComponent;
		private var _transferBtn:Button;
		
		private var _luckTF:TextField;
		private var _luckImg:Image;
		private var _luckComponent:TransferChangeCount;
		private var _luckSelect:MovieClip;
		
		private var _drugButton:MovieClip;
		private var _drugTF:TextField;
		private var _drugImg:Image;
		private var _drugSelect:MovieClip;
		
		private var _startLv:TextField;
		private var _middleLv:TextField;
		private var _endLv:TextField;
		private var _expChange:Image;
		private var _expColorChange:Image;
		private var _luckChange:TextField;
		private var _expTFChange:TextField;
		private var _soulChange:TextField;
		
		private var _colorTween:Tween;
		private var _lvColorEffect:TextColorEffect;
		
		private var _martialItem_1:MartialComponent;
		private var _martialItem_2:MartialComponent;
		private var _martialItem_3:MartialComponent;
		private var _martialList:Vector.<MartialComponent>;
		
		private var _success:MovieClip;
		private var _effectShow:EffectShow;
		
		
		private var _glowingStartRole:GlowingComponent;
		private var _glowingEndRole:GlowingComponent;
		private var _glowingBtn:Button;
		private var _nightSelect:MovieClip;
		private var _rainSelect:MovieClip;
		private var _windSelect:MovieClip;
		private var _thunderSelect:MovieClip;
		private var _glowingRoleList:Vector.<GlowingComponent>;
		private var _glowingProp:MovieClip;
		private var _usePropCount:TextField;
		private var _propNothing:TextField;
		private var _totalPropCount:TextField;
		private var _glowingTxt:TextColorEffect;
		private var _transferRole:TransferRoleComponent;
		private var _transferRoleBtn:Button;
		private function getUI() : void
		{
			var arr:Array = [searchOf("Team"), searchOf("Transfer"), searchOf("Martial"), searchOf("Glowing")];
			_tabBar = new TabBar(arr);
			_tabBar.addEventListener(TabBar.TYPE_SELECT_CHANGE, onTabChange);
			_tabBar.selectIndex = TABS.indexOf(_curTab);
		
			_changePage = this.searchOf("RoleChangePageList");
			_changePage._callbackFunc = setRoles;
			
			_mainRoleCharacter = this.searchOf("Transfer1");
			_mainRoleCharacter.callbackFun =setState;
			_secondaryRoleCharacter = this.searchOf("Transfer2");
			_secondaryRoleCharacter.callbackFun =setState;
			_transferBtn = this.searchOf("TransferBtn");
			removeTouchable(_transferBtn);
			
			_luckTF = this.searchOf("LuckCount");
			_luckImg = this.searchOf("LuckProp");
			_luckImg.useHandCursor = true;
			_luckImg.data = new Object();
			_luckImg.data[0] = "幸运符";
			_luckComponent = this.searchOf("CountChange");
			_luckSelect = this.searchOf("Select_2");
			removeMovieClip(_luckSelect);
			
			useDrug = false;
			_drugButton = this.searchOf("Used");
			_drugImg = this.searchOf("DrugProp");
			_drugImg.data = new Object();
			_drugImg.data[0] = "传功胶囊";
			_drugImg.useHandCursor = true
			_drugTF = this.searchOf("DrugCount");
			_drugSelect = this.searchOf("Select_1");
			removeMovieClip(_drugSelect);
			_drugButton.addEventListener(TouchEvent.TOUCH, onUseDrug);
			
			var luck:PropItemRender = new PropItemRender();
			luck.setData(12, _luckImg);
			panel.addChild(luck);
			
			var drug:PropItemRender = new PropItemRender();
			drug.setData(34, _drugImg);
			panel.addChild(drug);
			
			_startLv = this.searchOf("StartLv");
			_middleLv = this.searchOf("IntervalTF");
			_endLv = this.searchOf("EndLv");
			_expChange = this.searchOf("TransferExpBar");
			_expColorChange = this.searchOf("TransferExpChange");
			_luckChange = this.searchOf("TransferSkillDetail");
			_expTFChange = this.searchOf("TransferExpDetail");
			_soulChange = this.searchOf("TransferSoulDetail");
			
			_colorTween = new Tween(_expColorChange, .5);
			_colorTween.reverse = true;
			_colorTween.repeatCount = 0;
			_colorTween.animate("color", 0xFF0000);
			
			_lvColorEffect = new TextColorEffect(_endLv, 0xFFFF00, 0xFF0000, 0xFF0000, .6);
			
			_martialItem_1 = this.searchOf("Martial_1");
			_martialItem_2 = this.searchOf("Martial_2");
			_martialItem_3 = this.searchOf("Martial_3");
			_martialList = new Vector.<MartialComponent>();
			_martialList.push(_martialItem_1, _martialItem_2, _martialItem_3);
			
			_effectShow = new EffectShow(panel);
			var textures:Vector.<Texture> = _view.other_effect.interfaces(InterfaceTypes.GetTextures, "light");
			_success = new MovieClip(textures);
			_success.x = 260;
			_success.y = 10;
			
			_glowingBtn = this.searchOf("GlowingBtn");
			_glowingStartRole = this.searchOf("GlowingStart");
			_glowingEndRole = this.searchOf("GlowingEnd");
			_nightSelect = this.searchOf("NightSelect");
			_nightSelect.useHandCursor = true;
			_rainSelect = this.searchOf("RainSelect");
			_rainSelect.useHandCursor = true;
			_windSelect = this.searchOf("WindSelect");
			_windSelect.useHandCursor = true;
			_thunderSelect = this.searchOf("ThunderSelect");
			_thunderSelect.useHandCursor = true;
			_glowingProp = this.searchOf("GlowingProp");
			_glowingProp.visible = false;
			
			_glowingRoleList = new Vector.<GlowingComponent>();
			_glowingRoleList.push(
				this.searchOf("GlowingUse_1") as GlowingComponent, 
				this.searchOf("GlowingUse_2") as GlowingComponent, 
				this.searchOf("GlowingUse_3") as GlowingComponent, 
				this.searchOf("GlowingUse_4") as GlowingComponent, 
				this.searchOf("GlowingUse_5") as GlowingComponent, 
				this.searchOf("GlowingUse_6") as GlowingComponent);
			
			for each(var item:GlowingComponent in _glowingRoleList)
			{
				item.unDoubleClick = false;
			}
			
			_glowingStartRole.callbackFun = doubleClickGlowingState;
			_glowingEndRole.unDoubleClick = false;
			
			_nightSelect.addEventListener(TouchEvent.TOUCH, selectNight);
			_rainSelect.addEventListener(TouchEvent.TOUCH, selectRain);
			
			_usePropCount = this.searchOf("NowProp");
			_propNothing = this.searchOf("Nothing");
			_totalPropCount = this.searchOf("AllProp");
			
			_glowingTxt = new TextColorEffect(_usePropCount, 0xFFFF00, 0xFF0000, 0xFF0000, .6);
			
			_transferRole = this.searchOf("TransferRole");
			_transferRoleBtn = this.searchOf("TransferRoleBtn");
		}
		
		private function selectNight(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_nightSelect);
			if(!touch)	return;
			if(touch.phase == TouchPhase.ENDED)
			{
				_nightSelect.currentFrame = 0;
				_rainSelect.currentFrame = 1;
				_glowingType = "夜";
				setGlowingEndRole();
			}
		}
		
		private function selectRain(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_rainSelect);
			if(!touch)	return;
			if(touch.phase == TouchPhase.ENDED)
			{
				_nightSelect.currentFrame = 1;
				_rainSelect.currentFrame = 0;
				_glowingType = "雨";
				setGlowingEndRole();
			}
		}
		
		private function onTabChange(e:Event) : void
		{
			_curTab = TABS[e.data as int];
			checkStatus();
		}
		
		private function initPlayer() : void
		{
			
		}
		
		public function initRender() : void
		{
			renderRoles();
			renderTeam();
			player.calculateFighting();
		}
		
		private var _rolesGrid:Grid;
		private var _roles:Vector.<RoleModel>;
		private var _idleRoles:Vector.<RoleModel>;
		public function renderRoles() : void
		{			
			if (!_rolesGrid)
			{
				_rolesGrid = new Grid(RoleItemRender, 4, 3, 72, 72, 8.5, 6);
				_rolesGrid["layerName"] = "BackGround";
				_rolesGrid.x = 82;
				_rolesGrid.y = 58;
				panel.addChild(_rolesGrid);
				_uiLibrary.push(_rolesGrid);
			}
			
			_roles = player.roleModels;
			if(_curTab == GLOWING)
				_idleRoles = player.getGlowingRoles();
			else
				_idleRoles = player.getIdleRoles();
			_rolesGrid.setData(_idleRoles, _changePage);
		}
		
		private var _teamRole1:TeamRoleComponent;
		private var _teamRole2:TeamRoleComponent;
		private var _teamRole3:TeamRoleComponent;
		private var _teamModel:Vector.<RoleModel>;
		private var _formationModel:Object;
		private var _dragOut:DragOut;
		private function renderTeam() : void
		{
			if (!_teamRole1) _teamRole1 = searchOf("TeamRole2");
			if (!_teamRole2) _teamRole2 = searchOf("TeamRole1");
			if (!_teamRole3) _teamRole3 = searchOf("TeamRole3");
			
			_teamModel = player.roleModels;
			_formationModel = _view.controller.formation.getFormationData();
			
			if(_view.get_role_guide.isGuide)
			{
				if(player.formation.front == "小强" && player.formation.middle.split("（")[0] == "韦小宝")
					_view.get_role_guide.setFunc();
			}
			
			var model:RoleModel;
			var isLock:Boolean;
			
			/// 1
			isLock = false;
			_teamRole1.setData(_formationModel["front"], isLock, FightConfig.FRONT_POS);
			
			/// 2
			isLock = false;
			_teamRole2.setData(_formationModel["middle"], isLock, FightConfig.MIDDLE_POS);
			
			/// 3
			isLock = false;
			_teamRole3.setData(_formationModel["back"], isLock, FightConfig.BACK_POS);
			
			if (!_dragOut)
			{
				_dragOut = new DragOut([_teamRole1.panelContain, _teamRole2.panelContain, _teamRole3.panelContain]);
				_dragOut.addEventListener(DragOut.DRAG_OUT, onDragOut);
				_dragOut.addEventListener(DragTransposition.TRANSPOSITION, onTransPosition);
			}
			
			_rolesGrid.visible = true;
		}
		
		private function onDragOut(e:Event) : void
		{
			_view.controller.formation.removeTransposition(e.data[0], e.data[1]);			
			initRender();
		}
		
		private function onTransPosition(e:Event) : void
		{
			var sIndex:int = e.data["sIndex"];
			var tIndex:int = e.data["tIndex"];
			
			_view.controller.formation.setTransposition(sIndex, tIndex, false);
			initRender();
		}
		
		public function onDoubleClick(roleModel:RoleModel) : void
		{
			if(_curTab == TEAM)
			{
				_view.controller.formation.setDefaultPosition(roleModel.info.roleName);
				initRender();
			}
			else if(_curTab == TRANSFER)
			{
				setCharacter(roleModel);
				setState();
			}
			else if(_curTab == MARTIAL)
			{
				setMartialRole(roleModel);
				setRoles();
			}
			else if(_curTab == GLOWING)
			{
				setGlowing(roleModel);
				setRoles();
			}
		}
		
		private function setMartialRole(roleModel:RoleModel) : void
		{
			for(var i:int = 0; i < _martialList.length; i++)
			{
				if(_martialList[i].alreadyRole == false && _martialList[i].hasRole == false)
				{
					_martialList[i].changeData(roleModel, resetMartialRole);
					break;
				}
			}
			if(i == 3)
			{
				for(var j:int = 0; j < _martialList.length; j++)
				{
					if(_martialList[j].alreadyRole == false && _martialList[j].hasRole == true)
					{
						_martialList[j].changeData(roleModel, resetMartialRole);
						break;
					}
				}
			}
		}
		
		/**
		 * 设置主框、副框状态
		 * 
		 */		
		private function setCharacter(roleModel:RoleModel) : void
		{
			if(!_mainRoleCharacter.hasRole)
				_mainRoleCharacter.setImage(roleModel);
			else
			{
				if(roleModel.info.lv < 30) 
				{
					_view.prompEffect.play(roleModel.info.roleName + "等级不足30级，无法传功！");
					return;
				}
				_secondaryRoleCharacter.setImage(roleModel);
			}
		}
		
		private function resetState() : void
		{
			if(!_mainRoleCharacter) return;
			resetCharacter();
			resetDrug();
			setState();
			_expColorChange.visible = false;
		}
		
		/**
		 * 清空主框、副框状态
		 * 
		 */		
		private function resetCharacter() : void
		{
			_mainRoleCharacter.setImage();
			_secondaryRoleCharacter.setImage();
		}
		
		/**
		 * 设置传功界面的状态
		 * 
		 */		
		private function setState() : void
		{
			setRoles();
			setTransferBtn();
			setDrug();
			setLuck();
			setDetailState();
		}
		
		private function resetDrug() : void
		{
			_drugButton.currentFrame = 0;
			removeMovieClip(_drugSelect);
			useDrug = false;
		}
		
		private function setDrug() : void
		{
			drugCount = player.pack.getPropNumById(34);
			_drugTF.text = drugCount.toString();
			if(drugCount <= 0)
			{
				removeTouchable(_drugButton);
				_drugImg.filter = new GrayscaleFilter();
				_drugImg.useHandCursor = true;
				_drugImg.addEventListener(TouchEvent.TOUCH, gotoShop);
			}
			else
			{
				addTouchable(_drugButton);
				_drugImg.filter = null;
				_drugImg.useHandCursor = false;
				_drugImg.removeEventListener(TouchEvent.TOUCH, gotoShop);
			}
			if(!_mainRoleCharacter.hasRole || !_secondaryRoleCharacter.hasRole)
			{
				removeTouchable(_drugButton);
				resetDrug();
			}
		}
		
		private function onUseDrug(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_drugButton);
			if(touch && touch.phase == TouchPhase.ENDED)
			{
				if(useDrug)
				{
					_drugButton.currentFrame = 0;
					removeMovieClip(_drugSelect);
				}
				else 
				{
					_drugButton.currentFrame = 1;
					addMovieClip(this.panel, _drugSelect);
				}
				useDrug = !useDrug;
				setDetailState();
			}
		}
		
		private function setLuck() : void
		{
			luckCount = player.pack.getPropNumById(12);
			_luckTF.text = luckCount.toString();
			if(luckCount <= 0)
			{
				_luckImg.filter = new GrayscaleFilter();
				_luckImg.useHandCursor = true;
				_luckImg.addEventListener(TouchEvent.TOUCH, gotoShop);
			}
			else
			{
				_luckImg.filter = null;
				_luckImg.useHandCursor = false;
				_luckImg.removeEventListener(TouchEvent.TOUCH, gotoShop);
			}
			_luckComponent.setData(luckCount, setLuckSelect);
			if(!_mainRoleCharacter.hasRole || !_secondaryRoleCharacter.hasRole)
			{
				_luckComponent.resetButton();
				removeMovieClip(_luckSelect);
			}
		}
		
		/**
		 * 转向商城链接
		 * @param e
		 * 
		 */		
		private function gotoShop(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(panel);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				var item:Image = touch.target as Image;
				_view.shop.interfaces(InterfaceTypes.GET_MALL, item.data[0], checkStatus);
			}
		}
		
		
		private function resetLuck() : void
		{
			_luckComponent.resetButton();
			removeMovieClip(_luckSelect);
		}
		
		private function setLuckSelect() : void
		{
			useLuckCount = _luckComponent.useLuck;
			if(useLuckCount <= 0)
			{
				removeMovieClip(_luckSelect);
			}
			else
			{
				if(_luckSelect.parent == null)
				{
					addMovieClip(this.panel, _luckSelect);
				}
			}
			if(_mainRoleCharacter.hasRole && _secondaryRoleCharacter.hasRole)
			{
				useLuckCount = _luckComponent.useLuck;
				setSkillRate();	
			}
		}
		
		private function setDetailState() : void
		{
			if(_mainRoleCharacter.hasRole && _secondaryRoleCharacter.hasRole)
			{
				allExp = getAllExp();
				allExp = (useDrug?allExp * .5:allExp * .25);
				var lastLv:int = _mainRoleCharacter.roleModel.getAllLv(allExp, _mainRoleCharacter.roleModel.info.lv)[0];
				useLuckCount = _luckComponent.useLuck;
				_startLv.text = _mainRoleCharacter.roleModel.info.lv.toString();
				_middleLv.text = "—>"; 
				_endLv.text = lastLv.toString();
				_soulChange.text = (_levelInfo[_secondaryRoleCharacter.roleModel.info.lv - 1] as Level_up_exp).soul.toString();
				setExpState();
				setSkillRate();
			}
			else
			{
				_startLv.text = "";
				_middleLv.text = "";
				_endLv.text = "";
				_soulChange.text = "";
				_luckChange.text = "";
				_expTFChange.text = "0/0";
				_expChange.width = 0;
				skillRate = 0;
			}
		}
		
		private function setExpState() : void
		{
			if(allExp + _mainRoleCharacter.roleModel.info.exp >= _mainRoleCharacter.roleModel.nextExp)
			{
				_expTFChange.text = _mainRoleCharacter.roleModel.nextExp + " / " + _mainRoleCharacter.roleModel.nextExp;
				_expColorChange.width = 154;
			}
			else 
			{
				_expTFChange.text =	(allExp + _mainRoleCharacter.roleModel.info.exp) + " / " + _mainRoleCharacter.roleModel.nextExp;
				_expChange.width = _mainRoleCharacter.roleModel.info.exp / _mainRoleCharacter.roleModel.nextExp * 154;
				_expColorChange.width = (allExp + _mainRoleCharacter.roleModel.info.exp)/_mainRoleCharacter.roleModel.nextExp * 154;
			}
		}
		
		private function setSkillRate() : void
		{
			if(_secondaryRoleCharacter.roleModel.info.lv < 30)
			{
				_startLv.text = "";
				_middleLv.text = ""; 
				_endLv.text = "";
				_luckChange.text = "";
				_soulChange.text = "";
				//_view.prompEffect.play("传功角色等级不足30级，请重新选择！");
				return;
			}
			if( _secondaryRoleCharacter.roleModel.configData.fixedskill_name == "无")
			{
				_luckChange.text = "";
				return;
			}
			skillRate = .05;
			skillRate += (int((_secondaryRoleCharacter.roleModel.info.lv - 30) / 5) * 2 + useLuckCount * LUCKYRATE * 100) * .01;
			_luckChange.text = Math.floor(skillRate * 100) + "%";
		}
		
		/**
		 * 设置人物栏状态
		 * 
		 */		
		private function setRoles(count:int = 0) : void
		{
			var item:RoleItemRender
			for(var i:int = 0; i < _rolesGrid.numChildren; i++)
			{
				item = (_rolesGrid.getChildAt(i) as RoleItemRender)
				if(item.roleName == _mainRoleCharacter.roleName || item.roleName == _secondaryRoleCharacter.roleName)
					removeTouchable(item);
				else
					addTouchable(item);
				for(var j:int = 0; j < _martialList.length; j++)
				{
					if(_martialList[j].hasRole && _martialList[j].roleModel.info.roleName == item.roleName)
					{
						removeTouchable(item);
					}
				}
				if(item.roleName == _glowingStartRole.roleName)
					removeTouchable(item);
			}
		}
		
		/**
		 * 设置附体按钮状态
		 * 
		 */		
		private function setTransferBtn() : void
		{
			if(_mainRoleCharacter.hasRole && _secondaryRoleCharacter.hasRole && _secondaryRoleCharacter.roleModel.info.lv >= 30)
			{
				addTouchable(_transferBtn);
				addColorChange();
			}
			else 
			{
				removeTouchable(_transferBtn);
				removeColorChange();
			}
		}
		
		private function addColorChange() : void
		{
			_lvColorEffect.play();
			
			_expColorChange.visible = true;
			_expChange.color = 0xFFFF00;
			Starling.juggler.add(_colorTween);
		}
		
		private function removeColorChange() : void
		{
			_lvColorEffect.stop();
			
			if(_colorTween != null) Starling.juggler.remove(_colorTween);
			_expChange.color = 0xFFFF00;
			_expColorChange.visible = false;
		}
		
		/**
		 * 传功
		 * 
		 */	
		private function transferStart() : void
		{
			if(player.fight_soul < (_levelInfo[_secondaryRoleCharacter.roleModel.info.lv - 1] as Level_up_exp).soul)
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"战魂不足，无法传功！",
					null, null, false, true, false);
				return;
			}
			if(_mainRoleCharacter.roleModel.getAllLv(allExp, _mainRoleCharacter.roleModel.info.lv)[1])
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"角色等级无法超过小宝，多余经验将会消失，是否确认继续练功？",
					continueTransfer, null, false);
			}
			else
				continueTransfer();
		}
		
		private function continueTransfer() : void
		{
			_view.controller.save.onlineStatus(continueSave, function () : void{panel.touchable = true;});
			panel.touchable = false;
			
			function continueSave() : void
			{
				player.fight_soul -= (_levelInfo[_secondaryRoleCharacter.roleModel.info.lv - 1] as Level_up_exp).soul
				removeColorChange();
				if(useDrug) Data.instance.pack.changePropNum(34, -1);
				if(useLuckCount > 0) Data.instance.pack.changePropNum(12, -useLuckCount);
				
				_secondaryRoleCharacter.roleModel.info.lv = 1;
				_secondaryRoleCharacter.roleModel.info.exp = 0;
				_secondaryRoleCharacter.roleModel.beginCount();
				
				startAddExp();
			}
		}
		
		private function startAddExp() : void
		{
			if(_mainRoleCharacter.roleModel.info.lv >= player.mainRoleModel.info.lv && _mainRoleCharacter.roleModel.info.exp == (_mainRoleCharacter.roleModel.nextExp - 1))
			{
				_expTFChange.text =	_mainRoleCharacter.roleModel.info.exp + " / " + _mainRoleCharacter.roleModel.nextExp;
				_soulChange.text = "";
				endTransfer();
			}
			else if(_mainRoleCharacter.roleModel.info.exp + allExp >= _mainRoleCharacter.roleModel.nextExp)
			{
				_startLv.text = _mainRoleCharacter.roleModel.info.lv.toString();
				_middleLv.text = "—>";
				_endLv.text = (_mainRoleCharacter.roleModel.info.lv + 1).toString();
				_expTFChange.text = _mainRoleCharacter.roleModel.nextExp + " / " + _mainRoleCharacter.roleModel.nextExp;
				allExp -= (_mainRoleCharacter.roleModel.nextExp - _mainRoleCharacter.roleModel.info.exp);
				_mainRoleCharacter.roleModel.addExp(_mainRoleCharacter.roleModel.nextExp - _mainRoleCharacter.roleModel.info.exp);
				startTween(startAddExp);
			}
			else
			{
				_expTFChange.text =	(allExp + _mainRoleCharacter.roleModel.info.exp) + " / " + _mainRoleCharacter.roleModel.nextExp;
				_soulChange.text = "";
				_mainRoleCharacter.roleModel.addExp(allExp);
				_mainRoleCharacter.roleModel.beginCount();
				startTween(null, ((_mainRoleCharacter.roleModel.info.exp)/_mainRoleCharacter.roleModel.nextExp * 154));
				endTransfer();
			}
		}
		
		private function endTransfer() : void
		{
			learnSkill();
			resetDrug();
			resetLuck();
			setState();
			unEquip();
			
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.prompEffect.play("传功结束！");
			_effectShow.addShowObj(_success, 0, showSuccessEffect);
			_effectShow.start();
			Log.Trace("传功结束保存");
			_view.controller.save.onCommonSave(false, 1, false);
			this.panel.touchable = true;
		}
		
		/**
		 * 传功者装备卸下
		 * 
		 */		
		private function unEquip() : void
		{
			player.pack.unLoadRoleEquip(_secondaryRoleCharacter.roleModel);
		}
		
		private function showSuccessEffect() : void
		{
			this.panel.touchable = true;
		}
		
		private var _expTween:Tween;
		private function startTween(callback:Function, wid:int = 154) : void
		{
			_expChange.width = 0;
			_expTween = new Tween(_expChange, .1);
			_expTween.animate("width", wid);
			_expTween.onComplete = callback;
			Starling.juggler.add(_expTween);
		}
		
		/**
		 * 获得角色的所有经验值
		 * @return 
		 * 
		 */		
		private function getAllExp() : int
		{
			var allExp:int = 0;
			var roleName:String = _secondaryRoleCharacter.roleModel.info.roleName;
			for(var i:int = 1; i < _secondaryRoleCharacter.roleModel.info.lv; i++)
			{
				allExp += WeCharacterUtitiles.getNextExpData(i, roleName);
			}
			allExp += _secondaryRoleCharacter.roleModel.info.exp;
			return allExp;
		}
		
		/**
		 * 学习技能
		 * 
		 */		
		private function learnSkill() : void
		{
			if(_secondaryRoleCharacter.roleModel.configData.fixedskill_name == "无") return;
			if(Math.random() < skillRate)
				_view.controller.role.learnRoleSkill(_mainRoleCharacter.roleModel, _secondaryRoleCharacter.roleModel);
		}
		
		private function checkStatus() : void
		{
			var targetXML:XML = new XML();
			
			if(_curTab == TEAM)
				targetXML = _positionXML.layer[0];
			else if(_curTab == TRANSFER)
				targetXML = _positionXML.layer[1];
			else if(_curTab == MARTIAL)
				targetXML = _positionXML.layer[2];
			else if(_curTab == GLOWING)
				targetXML = _positionXML.layer[3];
			
			resetPosition(targetXML);
			
			for each(var item:* in _uiLibrary)
			{
				if (item is starling.display.DisplayObject) item.visible = false;
				else if (item is Component) (item as Component).panel.visible = false;
			}
			
			seStatusOfXML(targetXML, true);
			
			if(_rolesGrid) 	_rolesGrid.visible = true;
			
			resetState();
			
			resetMartialState();
			
			resetGlowingState();
			
			if(_transferRole != null) _transferRole.panel.visible = false;
		}
		
		private function resetMartialState() : void
		{
			if(_martialItem_1 == null) return;
			for each(var item:MartialComponent in _martialList)
			{
				if(item.alreadyRole) continue;
				item.changeData();
			}
		}
		
		private function resetGlowingState() : void
		{
			if(_glowingStartRole == null) return;
			
			resetGlowingBtn();
			
			renderRoles();
		}
		
		/**
		 * 设置所有按钮和组件状态
		 * 
		 */		
		private function resetGlowingBtn() : void
		{
			transferRoleBtnState();
			removeTouchable(_glowingBtn);
			removeAllGlowingBtn();
			
			_glowingStartRole.setImage();
			_glowingEndRole.setImage();
			
			_glowingType = "";
			_glowingProp.visible = false;
			
			_usePropCount.visible = false;
			_propNothing.visible = false;
			_totalPropCount.visible = false;
			
			for each(var item:GlowingComponent in _glowingRoleList)
			{
				item.setImage();
				addTouchable(item.panel);
			}
		}
		
		private function transferRoleBtnState() : void	
		{
			if(_glowingStartRole.roleModel == null)
				removeTouchable(_transferRoleBtn);
			else if(_glowingStartRole.roleModel != null && _glowingStartRole.roleModel.info.roleName.split("（").length < 2)
				removeTouchable(_transferRoleBtn);
			else
				addTouchable(_transferRoleBtn);
		}
		
		private var _glowingType:String = "";
		/**
		 * 确定选择要觉醒的角色
		 * @param roleModel
		 * 
		 */		
		private function setGlowing(roleModel:RoleModel) : void
		{
			if(roleModel.configData.quality == 1 && roleModel.info.lv < 50)
			{
				_view.prompEffect.play(roleModel.info.roleName + "等级不够，无法进行觉醒！");
				return;
			}
			else if((roleModel.configData.quality == 2 || roleModel.configData.quality == 3) && roleModel.info.lv < 100)
			{
				_view.prompEffect.play(roleModel.info.roleName + "等级不够，无法进行觉醒！");
				return;
			}
			else
			{
				resetGlowingBtn();
				_glowingStartRole.setImage(roleModel);
				setGlowingBtnState(roleModel);
				transferRoleBtnState();
			}
		}
		
		/**
		 * 双击卸下已选择的角色
		 * 
		 */		
		private function doubleClickGlowingState() : void
		{
			resetGlowingBtn();
			setRoles();
		}
		
		/**
		 * 设置四种按钮的状态
		 * @param name
		 * 
		 */		
		private function setGlowingBtnState(roleModel:RoleModel) : void
		{
			removeAllGlowingBtn();
			
			if(roleModel.configData.quality == 1)
			{
				_nightSelect.touchable = true;
				_nightSelect.currentFrame = 1;
				_rainSelect.touchable = true;
				_rainSelect.currentFrame = 1;
			}
			else if(roleModel.configData.quality == 2)
			{
				_windSelect.touchable = false;
				_windSelect.currentFrame = 0;
				_glowingType = "风";
				setGlowingEndRole();
			}
			else if(roleModel.configData.quality == 3)
			{
				_thunderSelect.touchable = false;
				_thunderSelect.currentFrame = 0;
				_glowingType = "雷";
				setGlowingEndRole();
			}
		}
		
		/**
		 * 清除四种按钮的状态
		 * 
		 */		
		private function removeAllGlowingBtn() : void
		{
			_nightSelect.touchable = false;
			_nightSelect.currentFrame = 2;
			_rainSelect.touchable = false;
			_rainSelect.currentFrame = 2;
			_windSelect.touchable = false;
			_windSelect.currentFrame = 2;
			_thunderSelect.touchable = false;
			_thunderSelect.currentFrame = 2;
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
				case "TransferBtn":
					transferStart();
					break;
				case "MartialInstrutionBtn":
					martialInstrution();
					break;
				case "TransferInstructionBtn":
					transferInstruction();
					break;
				case "GlowingInstructionBtn":
					glowingInstruction();
					break;
				case "GlowingBtn":
					glowingRole();
					break;
				case "TransferRoleBtn":
					showTransferRole();
					break;
			}
		}
		
		private function showTransferRole() : void
		{
			_view.transfer_role_type.interfaces(InterfaceTypes.Show, _glowingStartRole);
		}
		
		/**
		 * 设置觉醒后角色的详细信息
		 * 
		 */		
		private function setGlowingEndRole() : void
		{
			var newRole:RoleModel = _view.controller.role.createEndRole(_glowingStartRole.roleModel, _glowingType);
			
			_glowingEndRole.setImage(newRole);
			setGlowingProp();
			checkGlowingProp();
			checkGlowingRequest();
		}
		
		/**
		 * 检查道具需求
		 * 
		 */		
		private function checkGlowingProp() : void
		{
			if(_glowingPropNum < _glowingEndRole.roleModel.configData.token)
				removeTouchable(_glowingBtn);
			else
				addTouchable(_glowingBtn);
		}
		
		/**
		 * 检查角色需求
		 * 
		 */		
		private function checkGlowingRequest() : void
		{
			var requestRoles:Array = new Array();
			requestRoles = _glowingEndRole.roleModel.configData.synthetic.split("|");
			for(var i:int = 0; i < requestRoles.length; i++)
			{
				var newName:String = requestRoles[i];
				_glowingRoleList[i].setShowImage(newName);
				removeOnlyTouchable(_glowingRoleList[i].panel);
				if(player.hasRole(newName))
					addTouchable(_glowingRoleList[i].panel);
				else
					removeTouchable(_glowingBtn);
			}
		}
		
		private var _glowingPropNum:int;
		private var _glowingTip:PropItemRender;
		/**
		 * 设置要使用的令牌
		 * 
		 */		
		private function setGlowingProp() : void
		{
			_glowingProp.visible = true;
			var propType:int;
			switch(_glowingType)
			{
				case "夜":
					propType = 35;
					break;
				case "雨":
					propType = 36;
					break;
				case "风":
					propType = 37;
					break;
				case "雷":
					propType = 38;
					break;
			}
			_glowingProp.currentFrame = propType - 35;
			_glowingPropNum = player.pack.getPropNumById(propType);
			
			if(_glowingTip == null)
			{
				_glowingTip = new PropItemRender();
				panel.addChild(_glowingTip);
			}
			_glowingTip.setData(propType, _glowingProp);
			
			_usePropCount.visible = true;
			_propNothing.visible = true;
			_totalPropCount.visible = true;
			
			var useProp:int;
			if(_glowingPropNum >= _glowingEndRole.roleModel.configData.token)
			{
				useProp = _glowingEndRole.roleModel.configData.token;
				_glowingTxt.stop();
			}
			else
			{
				useProp = _glowingPropNum;
				_glowingTxt.play();
			}
			_usePropCount.text = useProp.toString();
			_totalPropCount.text = _glowingEndRole.roleModel.configData.token.toString();
		}
		
		private function checkMartial() : Array
		{
			var result:Boolean = false;
			var resultStr:String = "";
			var requestRoles:Array = new Array();
			requestRoles = _glowingEndRole.roleModel.configData.synthetic.split("|");
			for(var i:int = 0; i < requestRoles.length; i++)
			{
				for(var j:int = 0; j < player.martialInfo.martialRoles.length; j++)
				{
					if(requestRoles[i] == player.martialInfo.martialRoles[j].name)
					{
						result = true;
						resultStr += " " + requestRoles[i];
					}
				}
			}
			return [result, resultStr];
		}
		
		/**
		 * 觉醒角色
		 * 
		 */		
		private function glowingRole() : void
		{
			if(_glowingStartRole.roleModel == null) return;
				
			var resultArr:Array = checkMartial();
			if(resultArr[0] == true)
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					resultArr[1] + "还在练功房中，" + _glowingStartRole.roleModel.info.roleName + "无法觉醒",
					null, null, false, false, true);
			}
			else
			{
				_view.controller.role.glowingRole(_glowingStartRole.roleModel, _glowingEndRole.roleModel, _glowingType);
				_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
				_view.prompEffect.play(_glowingStartRole.roleModel.info.roleName + "觉醒成功！");
				reduceProp();
				resetGlowingBtn();
				renderRoles();
				renderTeam();
				_effectShow.addShowObj(_success, 0, showSuccessEffect);
				_effectShow.start();
				Log.Trace("觉醒保存");
				_view.controller.save.onCommonSave(false, 1, false);
				
				transferRoleBtnState();
			}
		}
		
		private function reduceProp() : void
		{
			switch(_glowingType)
			{
				case "夜":
					Data.instance.pack.changePropNum(35, -(_glowingEndRole.roleModel.configData.token));
					break;
				case "雨":
					Data.instance.pack.changePropNum(36, -(_glowingEndRole.roleModel.configData.token));
					break;
				case "风":
					Data.instance.pack.changePropNum(37, -(_glowingEndRole.roleModel.configData.token));
					break;
				case "雷":
					Data.instance.pack.changePropNum(38, -(_glowingEndRole.roleModel.configData.token));
					break;
			}
		}

		private function martialInstrution() : void
		{
			_view.instruction_martial.interfaces(InterfaceTypes.Show, _martialXML);
		}
		
		private function transferInstruction() : void
		{
			_view.instruction_transfer.interfaces(InterfaceTypes.Show, _transferXML);
		}
		
		private function glowingInstruction() : void
		{
			_view.instruction_glowing.interfaces(InterfaceTypes.Show, _glowingXML);
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
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
			if (type == "pack")
			{
				texture = getTextureFromSwf("RoleDetail.swf", name, V.ROLE_DETAIL);
			}
			else if (type == "public")
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else if(type == "icon")
			{
				texture = _view.icon.interfaces(InterfaceTypes.GetTexture, name);
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
		
		
		override public function resetView() : void
		{
			for each(var item:MartialComponent in _martialList)
			{
				item.resetView();
			}
			_martialList = new Vector.<MartialComponent>();
		}
	}
}
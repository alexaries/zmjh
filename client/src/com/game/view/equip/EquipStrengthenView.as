package com.game.view.equip
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.engine.ui.controls.Grid;
	import com.engine.ui.controls.TabBar;
	import com.game.Data;
	import com.game.data.DataList;
	import com.game.data.db.protocal.Equipment_strengthen;
	import com.game.data.equip.EquipConfig;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.PropModel;
	import com.game.data.player.structure.RoleModel;
	import com.game.data.prop.PropUtilies;
	import com.game.manager.LayerManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.Role.ChangePageComponent;
	import com.game.view.Role.PropItemRender;
	import com.game.view.ViewEventBind;
	import com.game.view.effect.EffectShow;
	import com.game.view.effect.TextColorEffect;
	import com.game.view.prop.PropsItemRender;
	import com.game.view.prop.StrengthPropItemRender;
	import com.game.view.ui.UIConfig;
	
	import flash.display.Bitmap;
	import flash.utils.getTimer;
	
	import starling.animation.DelayedCall;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class EquipStrengthenView extends BaseView implements IView
	{
		private static const TABS:Array = ["StrengthLabel", "DecomposeLabel", "ComposeLabel"];
		private static const STRENGTH:String = "StrengthLabel";
		private static const DECOMPOSE:String = "DecomposeLabel";
		private static const COMPOSE:String = "ComposeLabel";
		private static const STONENUM:int = 11;
		private static const LUCKYNUM:int = 12;
		private static const ENDNUM:int = 13;
		private static const LUCKYRATE:Number = DataList.littleList[5];
		
		private var _anti:Antiwear;
		
		private var _positionXML:XML;
		/**
		 * 强化信息
		 */		
		private var _equipStrengthenData:Object;
		/**
		 * 纹理 
		 */		
		private var _titleTxAtlas:TextureAtlas;
		
		/**
		 * 当前选择强化的装备
		 */		
		private var _equipNow:EquipModel;
		
		/**
		 * 强化石个数
		 * @return 
		 * 
		 */		
		private function get stoneCount() : int
		{
			return _anti["stoneCount"];
		}
		private function set stoneCount(value:int) : void
		{
			_anti["stoneCount"] = value;
		}
		
		/**
		 * 幸运符个数
		 * @return 
		 * 
		 */		
		private function get luckyTalismanCount() : int
		{
			return _anti["luckyTalismanCount"];
		}
		private function set luckyTalismanCount(value:int) : void
		{
			_anti["luckyTalismanCount"] = value;
		}
		/**
		 * 保底符个数
		 * @return 
		 * 
		 */		
		private function get endTalismanCount() : int
		{
			return _anti["endTalismanCount"];
		}
		private function set endTalismanCount(value:int) : void
		{
			_anti["endTalismanCount"] = value;
		}
		/**
		 * 使用幸运符个数
		 * @return 
		 * 
		 */		
		private function get useLuckyCount() : int
		{
			return _anti["useLuckyCount"];
		}
		private function set useLuckyCount(value:int) :void
		{
			_anti["useLuckyCount"] = value;
		}
		/**
		 * 是否使用保底符
		 * @return 
		 * 
		 */		
		private function get useEndTalisman() : Boolean
		{
			return _anti["useEndCount"];
		}
		private function set useEndTalisman(value:Boolean) : void
		{
			_anti["useEndCount"] = value;
		}
		
		/**
		 * 强化结果参数—— 0-强化成功， 1-强化失败但装备未消失， 2-强化失败但装备会消失， 3-强化成功，并且强化已达到最高等级
		 */		
		private function get strengthenResult() : int
		{
			return _anti["strengthenResult"]
		}
		private function set strengthenResult(value:int) : void
		{
			_anti["strengthenResult"] = value;
		}
		
		/**
		 * 动画特效
		 */		
		private var effectShow:EffectShow;
		
		private var _status:String;
		
		public function EquipStrengthenView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.EQUIP_STRENGTHEN;
			_loaderModuleName = V.EQUIP_STRENGTHEN;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["stoneCount"] = 0;
			_anti["luckyTalismanCount"] = 0;
			_anti["endTalismanCount"] = 0;
			_anti["useLuckyCount"] = 0;
			_anti["useEndTalisman"] = false;
			_anti["strengthenResult"] = 0;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_status = STRENGTH;
					this.show();
					break;
				case InterfaceTypes.REFRESH_PART:
					_status = args[0];
					this.show();
					break;
			}
		}
		
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		
		override protected function init() : void
		{
			if(!this.isInit)
			{
				super.init();
				this.isInit = true;
				initXML();
				initTextures();
				initRole();
				initComponent();
				initUI();
				getUI();
				initEvent();
				initEquip();
				initEffect();
			}
			
			initData();
			resetTalisman();
			initRender();
			checkStatus();
			tabInit();
			
			_view.layer.setCenter(panel);
		}
		
		/**
		 * 初始化渲染
		 * 
		 */		
		private function initRender() : void
		{
			renderEquip();
			renderDecomposeProps();
			resetRender();
		}
		
		private function initRole() : void
		{
			
		}
		
		private function initEffect() : void
		{
			effectShow = new EffectShow(panel);
		}
		
		private var _equipmentGrid:Grid;
		private var _equipPack:Vector.<EquipModel>;
		/**
		 * 初始化装备列表
		 * 
		 */		
		private function renderEquip() : void
		{
			if (!_equipmentGrid)
			{
				_equipmentGrid = new Grid(StrengthenItemRender, 6, 5, 42, 42, 3, 5);
				_equipmentGrid.x = 86;
				_equipmentGrid.y = 99;
				panel.addChild(_equipmentGrid);
				_uiLibrary.push(_equipmentGrid);
			}
			_equipPack = player.pack.getUnEquip();
			_equipmentGrid.setData(_equipPack, _packPageComponent);
		}
		
		private var _propsGrid:Grid;
		private var _propsPack:Vector.<PropModel>;
		/**
		 * 初始化道具包裹
		 * 
		 */		
		private function renderProps() : void
		{
			if (!_propsGrid)
			{
				_propsGrid = new Grid(StrengthPropItemRender, 6, 5, 42, 42, 3, 5);
				_propsGrid.x = 86;
				_propsGrid.y = 99;
				panel.addChild(_propsGrid);
				_uiLibrary.push(_propsGrid);
			}
			_propsPack = player.pack.getCountProp();
			_propsGrid.setData(_propsPack, _propsPageComponent);	
			
			for(var i:int = 0; i < _propsGrid.numChildren; i++)
			{
				(_propsGrid.getChildAt(i) as StrengthPropItemRender).isProp = true;
			}
		}
		
		private var _decomposePropsGrid:Grid;
		private var _decomposePropsPack:Vector.<PropModel>;
		/**
		 * 初始化分解碎片的显示
		 * 
		 */		
		private function renderDecomposeProps() : void
		{
			if (!_decomposePropsGrid)
			{
				_decomposePropsGrid = new Grid(PropsItemRender, 2, 3, 42, 42, 30, 14);
				_decomposePropsGrid.x = 404;
				_decomposePropsGrid.y = 242;
				panel.addChild(_decomposePropsGrid);
				_uiLibrary.push(_decomposePropsGrid);
			}
		}
		
		
		private function resetRender() : void
		{
			renderProps();
			if(_curTab == STRENGTH)
			{
				renderText();
				renderButton();
				renderDetail();
				renderImage();
			}
			else if(_curTab == DECOMPOSE)
			{
				renderButtonDecompose();
				renderTextDecompose();
			}
			else if(_curTab == COMPOSE)
			{
				resetComposeEffect();
				renderButtonCompose();
				composeDetailChange();
				resetComposeComponent();
				renderComposeComponent();
			}
		}
		
		/**
		 * 三个界面的切换
		 * 
		 */		
		private function checkStatus() : void
		{
			var targetXML:XML = new XML();
			
			if(_status == STRENGTH)		targetXML = _positionXML.layer[0];
			else if(_status == DECOMPOSE) 	targetXML = _positionXML.layer[1];
			else if(_status == COMPOSE)		targetXML = _positionXML.layer[2];
			
			resetPosition(targetXML);
			
			for each(var item:* in _uiLibrary)
			{
				if (item is DisplayObject) item.visible = false;
				else if (item is Component) (item as Component).panel.visible = false;
			}
			
			panel.setChildIndex((this.searchOf("DecomposeBg") as Image), panel.getChildIndex(this.searchOf("BackGround") as Image) + 1);
			seStatusOfXML(targetXML, true);
			
			onPropTabChange();
			
			(this.searchOf("ClearComposeBtn") as Button).visible = false;
		}
		
		private var _curPropTab:int;
		private function tabInit() : void
		{
			_tabBar.addEventListener(TabBar.TYPE_SELECT_CHANGE, onTabChange);
			switch(_status)
			{
				case STRENGTH:
					_tabBar.selectIndex = 0;
					_curTab = TABS[0];
					break;
				case DECOMPOSE:
					_tabBar.selectIndex = 1;
					_curTab = TABS[1];
					break;
				case COMPOSE:
					_tabBar.selectIndex = 2;
					_curTab = TABS[2];
					break;
			}
			
			_propBar.addEventListener(TabBar.TYPE_SELECT_CHANGE, onPropTabChange);
			_propBar.selectIndex = 0;
			_curPropTab = 0;
			
			_equipmentGrid.visible = true;
			_propsGrid.visible = false;
		}
		
		
		private var _curTab:String;
		/**
		 * 切换强化、分解和充灵功能
		 * @param e
		 * 
		 */		
		private function onTabChange(e:Event) : void
		{
			_curTab = TABS[e.data as int];
			_equipNow = null;
			_selectEquip.setNull();
			resetTalisman()
			initRender();
			if(_curTab == STRENGTH)
			{
				_selectEquip.y = 150;
				_status = STRENGTH;
			}
			else if(_curTab == DECOMPOSE)
			{
				_selectEquip.y = 119;
				_status = DECOMPOSE;
			}
			else if(_curTab == COMPOSE)
			{
				_selectEquip.y = 174;
				_status = COMPOSE;
			}
			checkStatus();
		}
		
		/**
		 * 装备和道具切换
		 * @param e
		 * 
		 */		
		private function onPropTabChange(e:Event = null) : void
		{
			//_decomposePropsGrid.visible = false;
			if(e != null)	_curPropTab = (e.data as int);
			if(_curPropTab == 0)
			{
				_equipmentGrid.visible = true;
				_propsGrid.visible = false;
				_packPageComponent.panel.visible = true;
				_propsPageComponent.panel.visible = false;
			}
			else
			{
				_equipmentGrid.visible = false;
				_propsGrid.visible = true;
				_packPageComponent.panel.visible = false;
				_propsPageComponent.panel.visible = true;
			}
		}
		
		
		/**
		 * 重新设置保底符和幸运符
		 * 
		 */		
		private function resetTalisman() : void
		{
			resetEndTalisman();
			resetLuckyTalisman();
		}
		
		/**
		 * 重新设置保底符配置
		 * 
		 */		
		private function resetEndTalisman() : void
		{
			useEndTalisman = false;
			_useEndMC.currentFrame = 0;
			removeMovieClip(_select_1);
		}
		
		/**
		 * 重新设置幸运符配置
		 * 
		 */		
		private function resetLuckyTalisman() : void
		{
			useLuckyCount = 0;
			removeMovieClip(_select_2);
			_luckyNum.text = useLuckyCount.toString();
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				//关闭
				case "Close":
					_selectEquip.setNull();
					this.hide();
					break;
				//装备强化
				case "equip_Strengthen":
					strengthenEquipment();
					break;
				//强化介绍
				case "InstructionBtn":
					instruction_Strengthen();
					break;
				case "DecomposeInstructionBtn":
					decomposeInstruction();
					break;
				case "ComposeInstructionBtn":
					composeInstruction();
					break;
				//装备分解
				case "equip_Decompose":
					decomposeEquipment();
					break;
				//装备充灵
				case "ComposeBtn":
					onComposeEquip();
					break;
				//洗灵
				case "ClearComposeBtn":
					startClearUp();
					break;
			}
		}
		
		/**
		 * 强化介绍页面
		 * 
		 */		
		private function instruction_Strengthen() : void
		{
			_view.instruction_strengthen.interfaces(InterfaceTypes.Show, _instructionXML);
		}
		
		private function decomposeInstruction() : void
		{
			_view.instruction_decompose.interfaces(InterfaceTypes.Show, _decomposeXML);
		}
		
		private function composeInstruction() : void
		{
			_view.instruction_compose.interfaces(InterfaceTypes.Show, _composeXML);
		}
		
		private var _instructionXML:XML;
		private var _composeXML:XML;
		private var _decomposeXML:XML;
		private var _composeData:Object;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.EQUIP_STRENGTHEN, GameConfig.EQUIP_STRENGTHEN, "EquipStrengthenPosition");
			_equipStrengthenData = Data.instance.db.interfaces(InterfaceTypes.GET_STRENGTHEN);
			_composeData = Data.instance.db.interfaces(InterfaceTypes.GET_FRAGMENT);
			
			_instructionXML = getXMLData(V.EQUIP_STRENGTHEN, GameConfig.EQUIP_STRENGTHEN, "InstructionPosition");
			_composeXML = getXMLData(V.EQUIP_STRENGTHEN, GameConfig.EQUIP_STRENGTHEN, "ComposeInstructionPosition");
			_decomposeXML = getXMLData(V.EQUIP_STRENGTHEN, GameConfig.EQUIP_STRENGTHEN, "DecomposeInstructionPosition");
			for(var i:int = 11; i < 21; i++)
			{
				Data.instance.pack.addNoneProp(i);
			}
		}
		
		private function initTextures() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				
				var textureXML:XML = getXMLData(V.EQUIP_STRENGTHEN, GameConfig.EQUIP_STRENGTHEN, "EquipStrengthen");			
				obj = getAssetsObject(V.EQUIP_STRENGTHEN, GameConfig.EQUIP_STRENGTHEN, "Textures");
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
							cp = new ChangePageComponent(items, _view.daily.titleTxAtlas);
							_components.push(cp);
							break;
						case "ChangeCount":
							cp = new ChangeCountComponent(items, titleTxAtlas);
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
		
		private var _packPageComponent:ChangePageComponent;
		private var _propsPageComponent:ChangePageComponent;
		private var _strengthenEquipmentBtn:Button;
		private var _useEndMC:MovieClip;
		private var _stone:TextField;
		private var _luckyTalisman:TextField;
		private var _endTalisman:TextField;
		private var _detail_1:TextField;
		private var _detail_2:TextField;
		private var _detail_3:TextField;
		private var _detail_4:TextField;
		private var _detail_5:TextField;
		private var _detail_6:TextField;
		private var _stoneImage:Image;
		private var _luckyImage:Image;
		private var _endImage:Image;
		private var _luckyNum:TextField;
		private var _luckyLeftBtn:Button;
		private var _luckyRightBtn:Button;
		private var _select_1:MovieClip;
		private var _select_2:MovieClip;
		private var _bomb:MovieClip;
		private var _gather:MovieClip;
		private var _spread:MovieClip;
		private var _success:MovieClip;
		private var _successImage:Image;
		private var _failureImage:Image;
		private var _propTip:PropTip;
		private var _textEffect_1:TextColorEffect;
		private var _textEffect_2:TextColorEffect;
		private var _tabBar:TabBar;
		private var _propBar:TabBar;
		private var _decomposeEquipmentBtn:Button;
		private function getUI() : void
		{
			getStrengthUI();
			getDecomposeUI();
			getComposeUI();

			_select_1 = this.searchOf("Select_1");
			removeMovieClip(_select_1);
			_select_2 = this.searchOf("Select_2");
			removeMovieClip(_select_2);
			_bomb = this.searchOf("Bomb");
			removeMovieClip(_bomb);
			_gather = this.searchOf("Gather");
			removeMovieClip(_gather);
			_spread = this.searchOf("Spread");
			removeMovieClip(_spread);
			_success = this.searchOf("Success");
			removeMovieClip(_success);
			
			_successImage = this.searchOf("SuccessWord");
			if(_successImage.parent) _successImage.parent.removeChild(_successImage);
			_failureImage = this.searchOf("FailureWord");
			if(_failureImage.parent) _failureImage.parent.removeChild(_failureImage);
			
			var arr:Array = [searchOf("StrengthLabel"), searchOf("DecomposeLabel"), searchOf("ComposeLabel")];
			_tabBar = new TabBar(arr);
			
			var tarArr:Array = [searchOf("RoleButton_Pack"), searchOf("RoleButton_Prop")];
			_propBar = new TabBar(tarArr);
			
		}
		
		private function getStrengthUI() : void
		{
			_packPageComponent = searchOf("PackChangePageList") as ChangePageComponent;
			_propsPageComponent = searchOf("PropChangePageList") as ChangePageComponent;
			
			_strengthenEquipmentBtn = searchOf("equip_Strengthen") as Button;
			_stone = searchOf("Stone") as TextField;
			_luckyTalisman = searchOf("LuckyTalisman") as TextField;
			_endTalisman = searchOf("EndTalisman") as TextField;
			_detail_1 = searchOf("Detail_1") as TextField;
			_detail_2 = searchOf("Detail_2") as TextField;
			_detail_3 = searchOf("Detail_3") as TextField;
			_detail_4 = searchOf("Detail_4") as TextField;
			_detail_5 = searchOf("Detail_5") as TextField;
			_detail_6 = searchOf("Detail_6") as TextField;
			
			_textEffect_1 = new TextColorEffect(_detail_2, 0xFFFF00, 0xFF0000, 0x3333ff, .6);
			_textEffect_2 = new TextColorEffect(_detail_3, 0xFFFF00, 0xFF0000, 0x3333ff, .6);
			
			setTextColor();
			
			_useEndMC = searchOf("Used") as MovieClip;
			_useEndMC.useHandCursor = true;
			_useEndMC.addEventListener(TouchEvent.TOUCH, onAddEndTalisman);
			_useEndMC.stop();
			Starling.juggler.add(_useEndMC);
			
			_stoneImage = searchOf("StoneImage") as Image;
			_stoneImage.data = new Object();
			_stoneImage.data[0] = "强化石";
			_luckyImage = searchOf("LuckyImage") as Image;
			_luckyImage.data = new Object();
			_luckyImage.data[0] = "幸运符";
			_endImage = searchOf("EndImage") as Image;
			_endImage.data = new Object();
			_endImage.data[0] = "保底符";
			(searchOf("StoneWord") as Image).touchable = false;
			(searchOf("LuckyWord") as Image).touchable = false;
			(searchOf("EndWord") as Image).touchable = false;
			
			_luckyNum = searchOf("LuckyNum") as TextField;
			_luckyNum.text = useLuckyCount.toString();
			_luckyLeftBtn = searchOf("LuckyLeft") as Button;
			_luckyRightBtn = searchOf("LuckyRight") as Button;
			_luckyLeftBtn.addEventListener(TouchEvent.TOUCH, onReduceLuckyNum);
			_luckyRightBtn.addEventListener(TouchEvent.TOUCH, onAddLuckyNum);
			
			addTip();
			_propTip = _view.ui.interfaces(UIConfig.PROP_TIP);
		}
		
		private function addTip() : void
		{
			var stone:PropItemRender = new PropItemRender();
			stone.setData(11, _stoneImage);
			panel.addChild(stone);
			
			var luck:PropItemRender = new PropItemRender();
			luck.setData(12, _luckyImage);
			panel.addChild(luck);
			
			var end:PropItemRender = new PropItemRender();
			end.setData(13, _endImage);
			panel.addChild(end);
		}
		
		private var _warValue:TextField;
		private var _warEffect:TextColorEffect;
		private function getDecomposeUI() : void
		{
			_decomposeEquipmentBtn = this.searchOf("equip_Decompose");
			_warValue = this.searchOf("WarValue");
			_warEffect = new TextColorEffect(_warValue, 0xFFFF00, 0xFF0000, 0xFF0000, .6);
		}
		
		/**
		 * 分解按钮状态
		 * 
		 */		
		private function renderButtonDecompose() : void
		{
			if(_equipNow == null)	removeTouchable(_decomposeEquipmentBtn);
			else	addTouchable(_decomposeEquipmentBtn);
			//luckyChange();
		}
		
		/**
		 * 装备分解数据
		 * 
		 */		
		private var _nowComposeData:Equipment_strengthen;
		public function get nowComposeData() : Equipment_strengthen
		{
			return _nowComposeData;
		}
		/**
		 * 分解
		 * 
		 */		
		private function decomposeEquipment() : void
		{
			if(Data.instance.player.player.fight_soul < _nowComposeData.basic_soul)
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"战魂不足，无法分解！",
					null, null, false, true, false);
				return;
			}
			panel.touchable = false;
			
			effectShow.addShowObj(_gather);
			effectShow.addShowObj(_spread, 0, addDecomposeResult);
			effectShow.start();
		}
		
		/**
		 * 开始分解
		 * 
		 */		
		private function addDecomposeResult() : void
		{
			_decomposePropsPack = _view.controller.equip.decomposeEquip(_nowComposeData, _equipNow);
			_decomposePropsGrid.setData(_decomposePropsPack, null);
			_decomposePropsGrid.visible = true;
			_equipNow = null;
			_selectEquip.setNull();
			initRender();
			player.dailyThingInfo.setThingComplete(4);
			Log.Trace("装备分解保存");
			_view.controller.save.onCommonSave(false, 1, false);
			_view.prompEffect.play("分解完成！");
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			panel.touchable = true;
		}
		
		/**
		 * 设置战魂消耗文本框的显示
		 * 
		 */
		private function renderTextDecompose() : void
		{
			if(_equipNow == null) 
			{
				_warValue.text = "";
				_warEffect.stop();
				return;
			}
			if(_nowComposeData == null)  _warValue.text = "";
			else _warValue.text = _nowComposeData.basic_soul.toString();
			
			if(Data.instance.player.player.fight_soul < _nowComposeData.basic_soul)	_warEffect.play();
			else 	_warEffect.stop();
		}
		
		private var _composePropList:Vector.<Image>;
		private var _composeChangeList:Vector.<ChangeCountComponent>;
		private var _composeNumList:Array;
		private var _composeEffect_2:TextColorEffect;
		private var _composeEffect_3:TextColorEffect;
		private var _composeEffect_4:TextColorEffect;
		private var _composeEffect_5:TextColorEffect;
		private var _composeEffect_6:TextColorEffect;
		private var _composeEffect_7:TextColorEffect;
		private var _composeEffect_8:TextColorEffect;
		private var _composeEffect_9:TextColorEffect;
		private function getComposeUI() : void
		{
			_composePropList = new Vector.<Image>();
			_composePropList.push(
				this.searchOf("HpImage") as Image, 
				this.searchOf("MpImage") as Image,
				this.searchOf("AtkImage") as Image, 
				this.searchOf("DefImage") as Image,
				this.searchOf("EvasionImage") as Image,
				this.searchOf("CritImage") as Image,
				this.searchOf("SpdImage") as Image);
			
			_composeChangeList = new Vector.<ChangeCountComponent>();
			_composeChangeList.push(
				this.searchOf("HpChange") as ChangeCountComponent,
				this.searchOf("MpChange") as ChangeCountComponent,
				this.searchOf("AtkChange") as ChangeCountComponent,
				this.searchOf("DefChange") as ChangeCountComponent,
				this.searchOf("EvasionChange") as ChangeCountComponent,
				this.searchOf("CritChange") as ChangeCountComponent,
				this.searchOf("SpdChange") as ChangeCountComponent);
			
			var propData:Vector.<Object> = Data.instance.db.interfaces(InterfaceTypes.GET_PROP_DATA);
			for(var j:int = 0; j < _composePropList.length; j++)
			{
				var newTip:PropItemRender = new PropItemRender();
				newTip.setData(14 + j, _composePropList[j]);
				panel.addChild(newTip);
				//_propTip.add({o:_composePropList[j],m:propData[j + 13]});
			}
			
			_composeEffect_2 = new TextColorEffect(this.searchOf("DetailCompose_2"), 0xFFFF00, 0xFF0000, 0xFF0000, .6);
			
			for(var k:int = 3; k < 10; k++)
			{
				this["_composeEffect_" + k] = new TextColorEffect(this.searchOf("DetailCompose_" + k), 0xFFFF00, 0xFFFFFF, 0xFF0000, .6);
				this["_composeEffect_" + k].stop();
			}
		}
		
		/**
		 * 开始洗灵判断
		 * 
		 */		
		private function startClearUp() : void
		{
			if(_equipNow == null)
			{
				_view.tip.interfaces(InterfaceTypes.Show, "请选择一件装备", null, null, false, true, false);
				return;
			}
			if(!_view.controller.equip.checkEquip(_equipNow))
			{
				_view.tip.interfaces(InterfaceTypes.Show, "该装备不需要洗灵", null, null, false, true, false);
			}
			else
			{
				var info:String = "洗灵会洗掉当前装备的所有器灵并获得少量金钱，请问是否进行洗灵？（消耗战魂" + _nowComposeData.basic_soul + ")";
				_view.tip.interfaces(InterfaceTypes.Show, info, 
					function() : void{Starling.juggler.delayCall(countClearUp, .1);}, null, false);
			}
		}
		
		/**
		 * 洗灵完成
		 * 
		 */		
		private function countClearUp() : void
		{
			if(player.fight_soul < _nowComposeData.basic_soul)
			{
				_view.tip.interfaces(InterfaceTypes.Show, "战魂不足，无法洗灵", null, null, false, true, false);
			}
			else
			{
				_view.controller.equip.clearUpEquip(_equipNow, _nowComposeData);
				_view.prompEffect.play("洗灵完成！");
				initEquipCompose();
				renderProps();
			}
		}
		
		/**
		 * 充灵
		 * @param e
		 * 
		 */		
		private function onComposeEquip() : void
		{
			if(Math.floor((getLittleValue() * _nowComposeData.money_add + 1) * _nowComposeData.basic_money) > player.money)
				_view.tip.interfaces(InterfaceTypes.Show,
					"金币不足！",
					null, null, false, true, false);
			else
			{
				panel.touchable = false;
				effectShow.addShowObj(_gather);
				effectShow.addShowObj(_spread, 0, countComposeResult);
				effectShow.start();
			}
		}
		
		/**
		 * 充灵数据计算
		 * 
		 */		
		private function countComposeResult() : void
		{
			_view.controller.equip.composeEquip(_equipNow, _composeChangeList, _composeData);
			player.money -= Math.floor((getLittleValue() * _nowComposeData.money_add + 1) * _nowComposeData.basic_money);
			player.dailyThingInfo.setThingComplete(5);
			_view.prompEffect.play("充灵完成！");
			initEquipCompose();
			renderProps();
			panel.touchable = true;
		}
		
		/**
		 * 初始化碎片按钮组件
		 * 
		 */		
		private function initEquipCompose() : void
		{
			for(var i:int = 0; i < _composeChangeList.length; i++)
			{
				_composeChangeList[i].setData(player.pack.getPropNumById(14 + i), _composeData[i],  getAlreadyValue(), composeRender);
			}
		}
		
		/**
		 * 详细资料颜色渐变重置
		 * 
		 */		
		private function resetComposeEffect() : void
		{
			for(var i:int = 3; i < 10; i++)
			{
				this["_composeEffect_" + i].stop();
			}
		}
		
		/**
		 * 充灵界面界面显示
		 * 
		 */		
		private function composeRender() : void
		{
			composeDetailChange();
			changeTextEffect();
			renderButtonCompose();
		}
		
		/**
		 * 冲灵界面详细资料显示
		 * 
		 */		
		private function composeDetailChange() : void
		{
			//没有装备，显示清空
			if(_equipNow == null)
			{
				for(var k:int = 1; k < 	10; k++)
				{
					(searchOf("DetailCompose_" + k) as TextField).text = "";
				}
				_composeEffect_2.stop();
				resetComposeEffect();
				return;
			}
			//显示详细信息
			(searchOf("DetailCompose_1") as TextField).text = (getTotalValue() + getAlreadyValue()).toString() + "/" + _nowComposeData.total_value;
			(searchOf("DetailCompose_2") as TextField).text = Math.floor((getLittleValue() * _nowComposeData.money_add + 1) * _nowComposeData.basic_money).toString();
			for(var i:int = 0; i < 7; i++)
			{
				(searchOf("DetailCompose_" + (i + 3)) as TextField).text = "+" + (_composeChangeList[i].nowCount * _composeData[i].add_value).toString()
			}
			//达到最大可充灵值，数量增加按钮不能点击
			if((getTotalValue() + getAlreadyValue()) >= _nowComposeData.total_value)	setRightUntouch();
			else	renderComposeComponent();
		}
		
		/**
		 * 详细资料颜色效果改变
		 * 
		 */		
		private function changeTextEffect() : void
		{
			//金币不足的效果
			if(Math.floor((getLittleValue() * _nowComposeData.money_add + 1) * _nowComposeData.basic_money) > player.money)	_composeEffect_2.play();
			else _composeEffect_2.stop();
			
			for(var i:int = 0; i < _composeChangeList.length; i++)
			{
				if(_composeChangeList[i].nowCount > 0)  (this["_composeEffect_" + (i + 3)] as TextColorEffect).play();
				else	(this["_composeEffect_" + (i + 3)] as TextColorEffect).stop();
			}
		}
		
		/**
		 * 按钮右键不可按
		 * 
		 */		
		private function setRightUntouch() : void
		{
			for(var i:int = 0; i < _composeChangeList.length; i++)
			{
				_composeChangeList[i].setRightUnTouch();
			}
		}
		
		/**
		 * 按钮状态初始化——不可按
		 * 
		 */		
		private function resetComposeComponent() : void
		{
			for(var i:int = 0; i < _composeChangeList.length; i++)
			{
				_composeChangeList[i].resetButton();
			}
		}
		
		/**
		 * 设置按钮状态
		 * 
		 */		
		private function renderComposeComponent() : void
		{
			for(var i:int = 0; i < _composeChangeList.length; i++)
			{
				_composeChangeList[i].renderButton();
			}
		}
		
		/**
		 * 获得碎片添加的冲灵值
		 * @return 
		 * 
		 */		
		private function getTotalValue() : int
		{
			var resultCount:int = 0;
			for(var i:int = 0; i < _composeChangeList.length; i++)
			{
				resultCount += _composeChangeList[i].nowCount * _composeData[i].use_value;
			}
			return resultCount;
		}
		
		/**
		 * 获得已附加的冲灵值
		 * @return 
		 * 
		 */		
		private function getAlreadyValue() : int
		{
			var resultCount:int = 0;
			var equipArr:Array = [_equipNow.hp_compose, _equipNow.mp_compose, _equipNow.atk_compose, _equipNow.def_compose, _equipNow.evasion_compose, _equipNow.crit_compose, _equipNow.spd_compose];
			for(var i:int = 0; i < equipArr.length; i++)
			{
				resultCount += Math.floor(equipArr[i] /_composeData[i].add_value) * _composeData[i].use_value;
			}
			return resultCount;
		}
		
		private function getLittleValue() : int
		{
			var resultCount:int = 0;
			for(var i:int = 0; i < _composeChangeList.length; i++)
			{
				resultCount += _composeChangeList[i].nowCount;
			}
			return resultCount;
		}
		
		/**
		 * 冲灵界面按钮状态
		 * 
		 */		
		private function renderButtonCompose() : void
		{
			if(_equipNow != null && checkComposeState())	addTouchable(this.searchOf("ComposeBtn") as Button);
			else	removeTouchable(this.searchOf("ComposeBtn") as Button);
		}
		
		/**
		 * 检测是否可以点击充灵按钮——是否有碎片
		 * @return 
		 * 
		 */		
		private function checkComposeState() : Boolean
		{
			var returnResult:Boolean = false;
			for(var i:int = 0; i < _composeChangeList.length; i++)
			{
				if(_composeChangeList[i].nowCount > 0)
				{
					returnResult = true;
					break;
				}
			}
			return returnResult;
		}
		
		/**
		 * 设置强化装备详细资料的文本框的颜色
		 * 
		 */		
		private function setTextColor() : void
		{
			for(var i:int = 1; i < 7; i++)
			{
				this["_detail_" + i].color = 0x3333ff;
			}
		}
		
		/**
		 * 减少使用幸运符
		 * @param e
		 * 
		 */		
		private function onReduceLuckyNum(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_luckyLeftBtn);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				if(_curTab == STRENGTH)
				{
					if(useLuckyCount > 0)	useLuckyCount--;
					if(useLuckyCount <= 0)	removeMovieClip(_select_2);
					renderButton();
					renderText();
					renderDetail();
				}
				else
				{
					if(useLuckyCount > 0)	useLuckyCount--;
					renderButtonDecompose();
					renderText();
				}
			}
		}
		
		/**
		 * 增加使用幸运符
		 * @param e
		 * 
		 */		
		private function onAddLuckyNum(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_luckyRightBtn);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED && useLuckyCount < luckyTalismanCount)
			{
				if(_curTab == STRENGTH)
				{
					var rate:Number = (_equipStrengthenData[_equipNow.lv].strengthen_rate + useLuckyCount * LUCKYRATE) * 100;
					if(rate >= 100)
					{
						_view.tip.interfaces(InterfaceTypes.Show, 
							"成功率已超过100%，是否继续使用幸运符！",
							addLuckyNum, null, false);
					}
					else
					{
						addLuckyNum();
					}
				}
				else
				{
					if(useLuckyCount < luckyTalismanCount)	useLuckyCount++;
					renderButtonDecompose();
					renderText();
				}
			}
		}
		
		private function addLuckyNum() : void
		{
			if(useLuckyCount < 10 && useLuckyCount < luckyTalismanCount)
			{
				useLuckyCount++;
				if(_select_2.parent == null)	addMovieClip(panel, _select_2);
			}
			renderButton();
			renderText();
			renderDetail();
		}
		
		/**
		 * 是否使用保底符
		 * @param e
		 * 
		 */		
		private function onAddEndTalisman(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_useEndMC);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				useEndTalisman = !useEndTalisman;
				if(useEndTalisman)
				{
					_view.tip.interfaces(InterfaceTypes.Show, 
						"使用保底符?",
						function () : void
						{
							_useEndMC.currentFrame = 1;
							addMovieClip(panel, _select_1);
						},
						function () : void
						{
							useEndTalisman = !useEndTalisman;
						},
						false);
				}
				else
				{
					_view.tip.interfaces(InterfaceTypes.Show, 
						"不使用保底符？",
						function () : void
						{
							_useEndMC.currentFrame = 0;
							removeMovieClip(_select_1);
						},
						function () : void
						{
							useEndTalisman = !useEndTalisman;
						},
						false);
				}
			}
		}
		
		private var _selectEquip:StrengthenItemRender;
		/**
		 * 初始化强化框
		 * 
		 */		
		private function initEquip() : void
		{
			_selectEquip = new StrengthenItemRender();
			_selectEquip.x = 475;
			_selectEquip.y = 150;
			_selectEquip._isStrengthen = true;
			_selectEquip.addEventListener(TouchEvent.TOUCH, unStrengthen);
			panel.addChild(_selectEquip);
		}
		
		/**
		 * 卸下强化的装备
		 * @param e
		 * 
		 */		
		public function unStrengthen(e:TouchEvent = null) : void
		{
			if(e!= null) var touch:Touch = e.getTouch(_selectEquip);
			if((touch && touch.tapCount == 2 && touch.phase == TouchPhase.ENDED) || e == null)
			{
				_selectEquip.setNull();
				_equipNow = null;
				resetTalisman();
				if(_curTab ==  COMPOSE)
				{
					resetComposeComponent();
					composeDetailChange();
				}
				initRender();
			}
		}
		
		/**
		 * 初始化当前选择的需要强化的装备
		 * 
		 */		
		private function initData() : void
		{
			_equipNow = new EquipModel();
			_equipNow = null;
		}
		
		
		/**
		 * 选择要强化的装备
		 * @param equip
		 * 
		 */		
		public function onSelectEquip(equip:StrengthenItemRender) : void
		{
			//装备强化等级不超过20级
			if(equip._equip.lv >= 20 && _curTab == STRENGTH)
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"该装备已达到最高强化等级！", 
					null, null, false, true, false);
				return;
			}
			//装备显示还原
			for(var i:int = 0; i < _equipmentGrid.numChildren; i++)
			{
				if(_equipmentGrid.getChildAt(i).filter != null)	_equipmentGrid.getChildAt(i).filter = null;
				if(!_equipmentGrid.getChildAt(i).hasEventListener(TouchEvent.TOUCH))	(_equipmentGrid.getChildAt(i) as StrengthenItemRender).addTouchEvent();
			}
			resetTalisman();
			equip.addColorChange();
			_equipNow = equip._equip;
			_equipNow.isNew = false;
			_selectEquip.setData(_equipNow);
			_luckyNum.text = useLuckyCount.toString();
			_equipmentGrid.parent.setChildIndex(_equipmentGrid, _equipmentGrid.parent.numChildren - 1);
			
			_nowComposeData = (Data.instance.db.interfaces(InterfaceTypes.GET_STRENGTHEN_DATA, _equipNow.id) as Equipment_strengthen);
			
			if(_curTab == STRENGTH)
			{
				renderButton();
				renderDetail();
			}
			else if(_curTab == DECOMPOSE)
			{
				_decomposePropsGrid.visible = false;
				renderTextDecompose();
				renderButtonDecompose();
			}
			else 
			{
				initEquipCompose();
			}
		}
		
		private var _equipmentStrengthen:Equipment_strengthen;
		/**
		 * 强化按钮是否可以点击
		 * 
		 */
		private function renderButton() : void
		{
			_textEffect_1.stop();
			_textEffect_2.stop();
			setTextColor();
			strengthBtnChange();
			endChange();
			luckyChange();
		}
		
		private function strengthBtnChange() : void
		{
			//没有选择装备、强化石不足、金币不足
			if(_equipNow == null)
			{
				removeTouchable(_strengthenEquipmentBtn);
			}
			else
			{
				_equipmentStrengthen = Data.instance.db.interfaces(InterfaceTypes.GET_STRENGTHEN_DATA, _equipNow.id)
				if(stoneCount < _equipStrengthenData[_equipNow.lv].strengthen_stone || player.money < _equipmentStrengthen.basic_money * _equipStrengthenData[_equipNow.lv].money_add)
				{
					if(stoneCount < _equipStrengthenData[_equipNow.lv].strengthen_stone)
					{
						removeTouchable(_strengthenEquipmentBtn);
						_textEffect_2.play();
						
					}
					if(player.money < _equipmentStrengthen.basic_money * _equipStrengthenData[_equipNow.lv].money_add)
					{
						removeTouchable(_strengthenEquipmentBtn);
						_textEffect_1.play();
					}
				}
				else
				{
					addTouchable(_strengthenEquipmentBtn);
				}
			}
		}
		
		private function endChange() : void
		{
			//保底符
			if(endTalismanCount <= 0 || _equipNow == null)
			{
				removeTouchable(_useEndMC);
				_useEndMC.currentFrame = 0;
				resetEndTalisman();
			}
			else
			{
				addTouchable(_useEndMC);
			}
		}
		
		private function luckyChange() : void
		{
			//幸运符
			if(luckyTalismanCount <= 0 || _equipNow == null)
			{
				removeTouchable(_luckyLeftBtn);
				removeTouchable(_luckyRightBtn);
				resetLuckyTalisman();
			}
			else
			{
				addTouchable(_luckyLeftBtn);
				addTouchable(_luckyRightBtn);
			}
			//幸运符减少按钮
			if(useLuckyCount == 0)
			{
				removeTouchable(_luckyLeftBtn);
			}
			//幸运符增加按钮
			if((_curTab == STRENGTH && (useLuckyCount == luckyTalismanCount || useLuckyCount == 10)) || (_curTab == DECOMPOSE && useLuckyCount == luckyTalismanCount))
			{
				removeTouchable(_luckyRightBtn);
			}
		}
		
		/**
		 * 强化石、幸运符、保底符显示，幸运符使用个数显示
		 * 
		 */		
		private function renderText() : void
		{
			for(var i:int = 0; i < player.pack.props.length; i++)
			{
				if(player.pack.props[i].id == STONENUM)
				{
					stoneCount = player.pack.props[i].num;
					_stone.text = stoneCount.toString();
				}
				if(player.pack.props[i].id == LUCKYNUM)
				{
					luckyTalismanCount = player.pack.props[i].num;
					_luckyTalisman.text = luckyTalismanCount.toString();
				}
				if(player.pack.props[i].id == ENDNUM)
				{
					endTalismanCount = player.pack.props[i].num;
					_endTalisman.text = endTalismanCount.toString();
				}
			}
			
			_luckyNum.text = useLuckyCount.toString();
		}
		
		/**
		 * 装备详细信息显示
		 * 
		 */		
		private function renderDetail() : void
		{
			if(_equipNow == null)	_detail_1.text = _detail_2.text = _detail_3.text = _detail_4.text = _detail_5.text = _detail_6.text = "";
			else
			{
				//强化等级
				_detail_1.text = _equipNow.lv + " —> " + (_equipNow.lv + 1);
				//强化金钱
				_detail_2.text = Math.floor(_equipmentStrengthen.basic_money * _equipStrengthenData[_equipNow.lv].money_add).toString();
				//强化消耗石头
				_detail_3.text = (_equipStrengthenData[_equipNow.lv].strengthen_stone).toString();
				//强化成功率
				_detail_4.text = (_equipStrengthenData[_equipNow.lv].strengthen_rate * 100).toFixed(2) + "%" + (useLuckyCount > 0?( " + " + int(useLuckyCount * LUCKYRATE * 100) + "%"):"");
				//强化信息显示
				var lvData:Array = _view.controller.equip.getEquipmentLv(_equipNow);
				_equipNow.lv++;
				var newLvData:Array = _view.controller.equip.getEquipmentLv(_equipNow);
				switch(_equipNow.config.type)
				{
					case EquipConfig.WEAPON:
						_detail_5.text = (_equipNow.atk + " + " + newLvData[0]).toString();
						break;
					case EquipConfig.CLOTHES:
						_detail_5.text = (_equipNow.def + " + " + newLvData[1]).toString();
						break;
					case EquipConfig.THING:
						_detail_5.text = (_equipNow.spd + " + " + newLvData[2]).toString();
						break;
				}
				_equipNow.lv--;
				if(!player.vipInfo.checkLevelThree())
				{
					switch(_equipStrengthenData[_equipNow.lv].failure)
					{
						case "无":
							_detail_6.text = "无";
							break;
						case "-1":
							_detail_6.text = "强化等级降一级";
							break;
						case "-5":
							_detail_6.text = "强化等级降五级";
							break;
						case "0":
							_detail_6.text = "强化等级归零";
							break;
						case "爆":
							_detail_6.text = "装备消失";
							break;
					}
				}
				else
					_detail_6.text = "VIP3等级以上玩家，不受惩罚";
			}
		}
		
		/**
		 * 强化石、幸运符、保底符图片显示，道具不足时添加商城链接
		 * 
		 */		
		private function renderImage() : void
		{
			//强化石
			if(stoneCount <= 0)
			{
				_stoneImage.filter = new GrayscaleFilter();
				_stoneImage.useHandCursor = true;
				_stoneImage.addEventListener(TouchEvent.TOUCH, gotoShop);
			}
			else
			{
				_stoneImage.filter = null;
				_stoneImage.useHandCursor = false;
				_stoneImage.removeEventListener(TouchEvent.TOUCH, gotoShop);
			}
			//幸运符
			if(luckyTalismanCount <= 0)	 
			{
				_luckyImage.filter = new GrayscaleFilter();
				_luckyImage.useHandCursor = true;
				_luckyImage.addEventListener(TouchEvent.TOUCH, gotoShop);
			}
			else
			{
				_luckyImage.filter = null;
				_luckyImage.useHandCursor = false;
				_luckyImage.removeEventListener(TouchEvent.TOUCH, gotoShop);
			}
			//保底符
			if(endTalismanCount <= 0)	
			{
				_endImage.filter = new GrayscaleFilter();
				_endImage.useHandCursor = true;
				_endImage.addEventListener(TouchEvent.TOUCH, gotoShop);
			}
			else 
			{
				_endImage.filter = null;
				_endImage.useHandCursor = false;
				_endImage.removeEventListener(TouchEvent.TOUCH, gotoShop);
			}
		}
		
		private var _shopName:String;
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
				_view.shop.interfaces(InterfaceTypes.GET_MALL, item.data[0], resetRender);
			}
		}
		
		
		private var saveDelay:DelayedCall;
		/**
		 * 强化装备
		 * 
		 */		
		private function strengthenEquipment() : void
		{
			_view.controller.save.onlineStatus(continueSave, function () : void{panel.touchable = true});
			panel.touchable = false;
			
			function continueSave() : void
			{
				strengthenResult = 0;
				strengthenResult = _view.controller.equip.strengthenEquip(_equipNow, useLuckyCount, useEndTalisman, _equipmentStrengthen);
				
				saveDelay = Starling.juggler.delayCall(unStableSave, 3);
				
				//保存
				Starling.juggler.delayCall(function () : void{
					player.dailyThingInfo.setThingComplete(3);
					Log.Trace("装备强化保存");
					_view.controller.save.onCommonSave(false, 1, false, addStrengthEffect);}, .5);
			}
		}
		
		private function unStableSave() : void
		{
			_view.tip.interfaces(InterfaceTypes.Show,
				"当前网络不稳定，请检查您的网络状况！",
				null, null, true);
		}
		
		public function removeDelayFun() : void
		{
			Starling.juggler.remove(saveDelay);
			_view.tip.hide();
		}
		
		/**
		 * 添加强化过程效果
		 * 
		 */		
		private function addStrengthEffect() : void
		{
			removeDelayFun();
			//_view.removeFromFrameProcessList("equipStrengthSave");
			if(strengthenResult == 3 || strengthenResult == 2)	_equipNow = null;
			effectShow.addShowObj(_gather, .7);
			effectShow.addShowObj(_spread);
			if(strengthenResult == 0 || strengthenResult == 3)
			{
				effectShow.addShowObj(_success);
				effectShow.addShowObj(_successImage, 1, strengthSuccess);
			}
			else if(strengthenResult == 1)
			{
				effectShow.addShowObj(_failureImage, 1, strengthFailure);
			}
			else if(strengthenResult == 2)
			{
				effectShow.addShowObj(_bomb);
				effectShow.addShowObj(_failureImage, 1, strengthDispose);
			}
			effectShow.start();
		}
		
		/**
		 * 强化成功
		 * 
		 */		
		private function strengthSuccess() : void
		{
			resetLuckyTalisman();
			if(_equipNow == null) 
			{
				_selectEquip.setNull();
				initRender();
				resetEndTalisman();
			}
			else resetRender();
			panel.touchable = true;
		}
		
		/**
		 * 强化失败，装备不消失
		 * 
		 */		
		private function strengthFailure() : void
		{
			resetLuckyTalisman();
			resetRender();
			panel.touchable = true;
		}
		
		/**
		 * 强化失败，装备消失
		 * 
		 */		
		private function strengthDispose() : void
		{
			resetLuckyTalisman();
			_selectEquip.setNull();
			initRender();
			resetEndTalisman();
			panel.touchable = true;
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else if(type == "icon")
			{
				textures = _view.equip.interfaces(InterfaceTypes.GetTextures, name);
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
			else if(type == "icon")
			{
				texture = _view.equip.interfaces(InterfaceTypes.GetTexture, name);
			}
			else if(type == "effect")
			{
				texture = _view.other_effect.interfaces(InterfaceTypes.GetTexture, name);
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
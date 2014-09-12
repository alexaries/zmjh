package com.game.view.endless
{
	import com.engine.core.Log;
	import com.engine.ui.controls.DragOut;
	import com.engine.ui.controls.DragTransposition;
	import com.engine.utils.Utilities;
	import com.game.Data;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.FightModelStructure;
	import com.game.data.shop.PaymentData;
	import com.game.data.shop.ShopSubmitData;
	import com.game.manager.DebugManager;
	import com.game.manager.LayerManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.Role.OneFormationComponent;
	import com.game.view.ViewEventBind;
	
	import flash.display.Bitmap;
	import flash.utils.getTimer;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class EndlessBattlesView extends BaseView implements IView
	{
		private var _useProp:Boolean;
		public function get useProp() : Boolean
		{
			return _useProp;
		}
		
		public function EndlessBattlesView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.ENDLESS_BATTLE;
			_loaderModuleName = V.ENDLESS_BATTLE;
			
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
				
				initXML();
				initTexture();
				initComponent();
				initUI();
				getUI();
				initEvent();
			}
			
			_view.layer.setCenter(panel);
			
			renderFormation();
			checkTime();
		}
		
		
		// xml
		private var _positionXML:XML;
		private var _instructionXML:XML;
		private var _endlessData:Vector.<Object>;
		private var _endlessBossData:Vector.<Object>;
		private function initXML() : void
		{
			if(!_positionXML) _positionXML = getXMLData(V.ENDLESS_BATTLE, GameConfig.ENDLESS_BATTLE_RES, "EndlessBattlePosition");
			if(!_instructionXML) _instructionXML = getXMLData(V.ENDLESS_BATTLE, GameConfig.ENDLESS_BATTLE_RES, "EndlessInstructionPosition");
			if(!_endlessData)
			{
				_endlessData = new Vector.<Object>();
				_endlessData = Data.instance.db.interfaces(InterfaceTypes.GET_ENDLESS_DATA);
			}
			if(!_endlessBossData)
			{
				_endlessBossData = new Vector.<Object>();
				_endlessBossData = Data.instance.db.interfaces(InterfaceTypes.GET_SPECIAL_BOSS_DATA);
			}
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
				var textureXML:XML = getXMLData(V.ENDLESS_BATTLE, GameConfig.ENDLESS_BATTLE_RES, "EndlessBattle");			
				obj = getAssetsObject(V.ENDLESS_BATTLE, GameConfig.ENDLESS_BATTLE_RES, "Textures");
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
							cp = new OneFormationComponent(items, _titleTxAtlas);
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
		
		private var _formationFront:OneFormationComponent;
		private var _formationMiddle:OneFormationComponent;
		private var _formationBack:OneFormationComponent;
		private var _dragFormation:DragTransposition;
		private var _timeDetail:TextField;
		private var _goldDetail:TextField;
		private var _expDetail:TextField;
		private var _soulDetail:TextField;
		private var _maxLevelDetail:TextField;
		private var _contain:Sprite;
		private var _nowLevel:Image;
		private function getUI() : void
		{
			_timeDetail = this.searchOf("TimeDetail") as TextField;
			_goldDetail = this.searchOf("GoldDetail") as TextField;
			_expDetail = this.searchOf("ExpDetail") as TextField;
			_soulDetail = this.searchOf("SoulDetail") as TextField;
			_maxLevelDetail = this.searchOf("MaxLevelDetail") as TextField;
			_nowLevel = this.searchOf("NowLevelTitle") as Image;
		}
		
		private function checkTime() : void
		{
			var result:Boolean = Data.instance.time.checkEveryDayPlay(Data.instance.player.player.endlessInfo.time);
			if(result)
			{
				_timeDetail.text = "";
				_goldDetail.text = "";
				_expDetail.text = "";
				_soulDetail.text = "";
				createNowLevel(0);
			}
			else
			{
				createNowLevel(player.endlessInfo.endlessLevel);
				_timeDetail.text = Data.instance.time.formatTime(player.endlessInfo.endlessTime);
				if(player.endlessInfo.endlessLevel == 0)
				{
					_goldDetail.text = "0";
					_expDetail.text = "0";
					_soulDetail.text = "0";
				}
				else
				{
					_goldDetail.text = _endlessData[player.endlessInfo.endlessLevel - 1].gold.toString();
					_expDetail.text = _endlessData[player.endlessInfo.endlessLevel - 1].exp.toString();
					_soulDetail.text = _endlessData[player.endlessInfo.endlessLevel - 1].soul.toString();
				}
			}
			_maxLevelDetail.text = player.endlessInfo.maxLevel.toString();
		}
		
		private function createNowLevel(count:int) : void
		{
			_contain = new Sprite();
			this.panel.addChild(_contain);
			_contain.y = 130;
			_contain.alpha = 1;
			
			var arrs:Array = Utilities.seperate(count);
			if(arrs.length == 3)
				_contain.x = 310;
			else if(arrs.length == 2)
				_contain.x  = 340;
			else 
				_contain.x  = 370;
			while (arrs.length > 0)
			{
				createNumber(arrs.shift());
			}
			_nowLevel.x = _contain.x + _contain.width;
		}
		
		private function createNumber(value:int) : void
		{
			var name:String;
			var texture:Texture;
			name = "Lv_" + (value + 1);
			texture = _titleTxAtlas.getTexture(name);
			var num:Image = new Image(texture);
			num.x = _contain.width;
			_contain.addChild(num);
		}
		
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
				_dragFormation.addEventListener(DragOut.DRAG_OUT, onDragOut);
				_dragFormation.addEventListener(DragTransposition.TRANSPOSITION, onDragTrans);
			}
		}
		
		private function onDragOut(e:Event) : void
		{
			_view.controller.formation.removeTransposition(e.data[0], e.data[1]);			
			renderFormation();
			resetImagePosition();
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
			
			_view.controller.formation.setTransposition(sIndex, tIndex, false);
			renderFormation();
			
			resetImagePosition();
		}
		
		private function resetImagePosition() : void
		{
			this.panel.setChildIndex(this.searchOf("Middle"), panel.numChildren - 1);
			this.panel.setChildIndex(this.searchOf("Front"), panel.numChildren - 1);
			this.panel.setChildIndex(this.searchOf("Major"), panel.numChildren - 1);
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "Close":
					this.hide();
					break;
				case "StartEndlessBtn":
					isCanStart();
					break;
				case "EndlessInstructionBtn":
					endlessInstruction();
					break;
			}
		}
		
		private function endlessInstruction() : void
		{
			_view.instruction_endless.interfaces(InterfaceTypes.Show, _instructionXML);
		}
		
		override public function hide() : void
		{
			if(!isNaN(_nowAllowChange))
			{
				_view.world.allowChange = _nowAllowChange;
				_nowAllowChange = NaN;
			}
			if (_contain)
			{
				if(_contain.parent != null) _contain.parent.removeChild(_contain);
				_contain.dispose();
				_contain = null;
			}
			super.hide();
		}
		
		private function isCanStart() : void
		{
			if(DebugManager.instance.gameMode == V.DEVELOP)
			{
				startEndlessBattle();
				return;
			}
			var result:Boolean = Data.instance.time.checkEveryDayPlay(Data.instance.player.player.endlessInfo.time);
			if(result) player.endlessInfo.isComplete = 0;
			if(result || (player.vipInfo.checkLevelFour() && player.endlessInfo.isComplete == 1))
			{
				startEndlessBattle();
			}
			else
			{
				var obj:ShopSubmitData = new ShopSubmitData("758", 1, 200);
				PaymentData.startPay(200, obj,
					startEndlessBattle, 
					"是否花费200点卷再次进入无尽闯关？");
			}
		}
		
		private var _curLevel:int;
		private var _curBoss:Object;
		public function get curBoss() : Object
		{
			return _curBoss;
		}
		private var _isSkip:Boolean;
		public function get isSkip() : Boolean
		{
			return _isSkip;
		}
		private var _isSpecial:Boolean;
		public function get isSpecial() : Boolean
		{
			return _isSpecial;
		}
		private var _startTime:int;
		private var _endTime:int;
		private var _useTime:int;
		private var _nowAllowChange:Number;
		private function startEndlessBattle() : void
		{
			this.hide();
			_curLevel = 1;
			_isSkip = false;
			_isSpecial = false;
			_useProp = false;
			_nowAllowChange = _view.world.allowChange;
			_view.endless_fight.interfaces(InterfaceTypes.Show, _curLevel, 1, nextFight);
			
			player.endlessInfo.time = Data.instance.time.curTimeStr;
			player.endlessInfo.endlessTime = 1;
			player.endlessInfo.endlessLevel = 1;
			player.endlessInfo.isComplete++;
			player.endlessInfo.checkMaxLevel(1);
			
			Log.Trace("开始无尽闯关保存");
			_view.controller.save.onCommonSave(false, 1, false);
			
			_useTime = 0;
			_startTime = getTimer();
			_view.addToFrameProcessList(V.ENDLESS_BATTLE, countTime);
		}
		
		private function countTime() : void
		{
			_endTime = getTimer();
			_useTime += (_endTime - _startTime);
			_startTime = getTimer();
		}
		
		public function stopTime() : int
		{
			_view.removeFromFrameProcessList(V.ENDLESS_BATTLE);
			return (_useTime * .001);
		}
		
		public function skipCommonBattle() : void
		{
			_curLevel += 5;
			_isSkip = true;
		}
		
		public function gotoNextBattle() : void
		{
			_curLevel++;
			_isSkip = false;
		}
		
		public function returnLastBattle() : void
		{
			_curLevel--;
		}
		
		public function nextFight() : void
		{
			_curBoss = _endlessBossData[Math.floor(Math.random() * _endlessBossData.length)];
			if(Math.random() < Number(_curBoss.boss_rate))
			{
				_isSpecial = true;
				_view.endless_fight.interfaces(InterfaceTypes.Show, _curLevel, 2, nextFight);
			}
			else
			{
				_isSpecial = false;
				_view.endless_fight.interfaces(InterfaceTypes.Show, _curLevel, 1, nextFight);
			}
		}
		
		public function checkOver() : Boolean
		{
			var result:Boolean = false;
			if(_curLevel > _endlessData.length)
			{
				result = true;
			}
			return result
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
				textures = _view.roleImage.interfaces(InterfaceTypes.GetTextures, name);
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
				texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			
			return texture;
		}
	}
}
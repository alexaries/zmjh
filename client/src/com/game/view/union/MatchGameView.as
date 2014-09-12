package com.game.view.union
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.ui.controls.Grid;
	import com.game.Data;
	import com.game.data.db.protocal.Enemy;
	import com.game.data.db.protocal.Level_up_enemy;
	import com.game.data.db.protocal.SkyEarth;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.RoleModel;
	import com.game.data.player.structure.SkillModel;
	import com.game.manager.FontManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.effect.FightEffectConfig;
	import com.game.view.effect.TweenEffect;
	import com.game.view.effect.protocol.FightEffectConfigData;
	import com.game.view.effect.protocol.FightEffectPlayer;
	import com.game.view.skill.SkillItemRender;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import org.osmf.events.TimeEvent;
	
	import starling.animation.DelayedCall;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.ColorArgb;
	import starling.extensions.PDParticleSystem;
	import starling.filters.BlurFilter;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import starling.utils.deg2rad;
	
	public class MatchGameView extends BaseView implements IView
	{
		[Embed(source='../resources/Union/MatchFight/particle.pex', mimeType='application/octet-stream')]
		private static const BlizzardPexClass:Class;            
		[Embed(source='../resources/Union/MatchFight/texture.png')]
		private static const BlizzardBmpClass:Class;

		private var _tweenEffect:TweenEffect;
		private var _tweenDeadEffect:TweenEffect;
		private static const ENEMY_ATK_TURN:int = 3;//boss攻击频率
		private static const TICK_TIME:int = 4;//拖动时间
		private static const COMBO_BONUS:Number = 0.5;
		private static const X_MAX:int = 6;
		private static const Y_MAX:int = 5;
		private static const X_START:int = 350;//左上角方块坐标
		private static const Y_START:int = 342;
		private static const X_END:int = 590;//右下角方块坐标
		private static const Y_END:int = 534;
		private static const PIECE_DROP_SPEED:int = 8;
		private static const ICON_WIDTH:int = 48;
		private static const ICON_HEIGHT:int = 48;
		private static const ENEMY_LIFE_WIDTH:int = 357;
		private static const ME_LIFE_WIDTH:int = 232;
		private static const ENEMY_X_POSITION:int = 466;
		private static const ENEMY_Y_POSITION:int = 150;
		public var playDelayTime:int = 10;//动画播放时间
		// 攻击数目
		private var _hitPlayNum:int = 0;
		
		private var _anti:Antiwear;
		private var _data:Object;
		private var _positionXML:XML;
		private var _titleTxAtlas:TextureAtlas;

		
		private var _quitBtn:Button;
		
		private var _enemyData:SkyEarth;
		private var _enemyCallBack:Function;
		
		private var EnemyCurHp:int;
		private var EnemyHpMax:int;
		
		private var MeCurHp:int;
		private var MeHpMax:int;
		
		

		
		private var _timer:Timer;
		private var timeOver:Boolean;
		private var startX:int;
		private var startY:int;
		
		//主角基础伤害
		private var MeBaseDamage:int;
		//敌人基础伤害
		private var EnemyBaseDamage:int;
		//单个技能伤害(包括治疗)
		private var SkillDamage:int;
		//回合总治疗
		private var TotalHeal:int;
		//回合总伤害
		private var TotalDamage:int;
		//一次消除的方块数
		private var singleMatchNum:int;
		
		//敌人攻击回合数
		private var turnNum:int;
		
		//方块是否正在下落
		private var isDroping:Boolean;
		
		//是否有方块发生过交换
		private var isSwitched:Boolean;
		
		//方块是否正在交换中
		private var isSwitching:Boolean;
		
		//游戏是否结束
		private var isOver:Boolean;
		
		private var enemyDamageInfo:String = "";
		private var meDamageInfo:String = "";
		private var meHealInfo:String = "";
		private var comboNum:int;

		
		private var pieceArr:Vector.<Vector.<MatchPiece>>;
		private var _skillTypeList:Array;
		
		private var usedSkillArr:Array;
		//闪屏图片
		private var _blinkImage:Image;
		//敌人血条
		private var _enemyLifeBar:Image;
		private var _enemyHpTF:TextField;
		
		private var _tickImage:Image;
		private var _pieceTickTxt:TextField;
		private var tickNum:int;
		private var _tickImageWidthMax:int;
		
		//小宝血条
		private var _meLifeBar:Image;
		private var _meHpTF:TextField;
		
		//已装备的技能格子
		private var _equippedSkillGrid:Grid;
		
		//已装备的技能数据
		private var _equippedSkills:Vector.<SkillModel>;
		

		
		
		private var _turnTextField:TextField;
		
		private var _mainRoleModel:RoleModel;
		
		// 敌人最终数值
		private var _enemyModel:Enemy;
		
		// 敌人基础属性值
		private var _enemyConfig:Enemy;
		
		private var _enemyImage:Image;

		private var turnInfoDelay:DelayedCall;
		
		private var _matchResultPanel:MatchGameResultComponent;
		

		
		
		public function MatchGameView()
		{
			_moduleName = V.MATCH_GAME;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.MATCH_GAME;
			
			_anti = new Antiwear(new binaryEncrypt());
			
		

		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch(type)
			{
				case InterfaceTypes.Show:
					_view.fightEffect.interfaces();
					_enemyData=args[0];
					_enemyCallBack=args[1];
					this.show();
					break;
			}
		}
		
		
		/**
		 * 基础 
		 * 
		 */		
		private function getEnemyBaseData() : void
		{
			var roleName:String = _enemyData.name;
			Data.instance.db.interfaces(InterfaceTypes.GET_ROLE_BASE_DATA, V.ENEMY, roleName, callback);
			
			function callback(data:Enemy) : void
			{
				_enemyConfig = data;
				
			}
		}
		

		
		override protected function init() : void
		{
			if(!this.isInit)
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
			

			initGame();
			

			var component:Component = this.searchOfCompoent("matchFightResult");
			_matchResultPanel = component.copy() as MatchGameResultComponent;
			panel.addChild(_matchResultPanel.panel);
			_view.layer.setCenter(_matchResultPanel.panel);
			_matchResultPanel.hide();
			
			
			_view.layer.setCenter(panel);
		}


		
		private function initXML() : void
		{
			_positionXML = getXMLData(V.MATCH_GAME, GameConfig.MATCH_GAME_RES, "MatchGamePosition");
			//_data = Data.instance.db.interfaces(InterfaceTypes.GET_SMALLGAME_MATCH);

		}
		
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.MATCH_GAME, GameConfig.MATCH_GAME_RES, "MatchGame");
				obj = getAssetsObject(V.MATCH_GAME, GameConfig.MATCH_GAME_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
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
						case "matchFightResult":
							cp = new MatchGameResultComponent(items, _titleTxAtlas);
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
		
		
		private function getUI() : void
		{
			_enemyLifeBar = this.searchOf("BossLifeBar");
			_enemyHpTF=this.searchOf("bossHp");
			
			_meLifeBar = this.searchOf("MeLifeBar");
			_meHpTF=this.searchOf("meHp");
			
			_quitBtn=this.searchOf("Return_Button");
			_tweenEffect = new TweenEffect();
			_tweenDeadEffect = new TweenEffect();
			
		}
		
		private function initEffectLayer() : void
		{
			if(_effectLayer == null)
			{
				_effectLayer = new Sprite();
				_effectLayer.x = ENEMY_X_POSITION - 78;
				_effectLayer.y = ENEMY_Y_POSITION - 81;
				this.panel.addChild(_effectLayer);
			}
			isJuggler = true;
			this.panel.setChildIndex(_effectLayer, this.panel.numChildren - 1);
		}
		
		/**
		 * 初始化渲染
		 * 
		 */		
		private function initGame() : void
		{
			usedSkillArr = new Array;
			_mainRoleModel = player.getRoleModel(V.MAIN_ROLE_NAME);
			initEnemy();
			initEffectLayer();
			initSkillGrid();
			initPiecesData();
			addTurnInfo();
			initGameData();
			turnNum=ENEMY_ATK_TURN;
			_quitBtn.touchable=true;
			isDroping=false;
			isSwitching=false;
			isOver=false;
			_view.addToFrameProcessList("matchGame",onPiecesMove);
			_view.guide.showMatchGameGuide();
		}
		
		/**
		 * 根据敌人初始和等级初始化敌人属性
		 * 
		 */		
		private function getEnemyLVData() : void
		{
			var lv:int = int(_enemyData.lv);
			
			if (lv < 0) lv = 0;
			
			_enemyModel = new Enemy();
			
			Data.instance.db.interfaces(
				InterfaceTypes.GET_ROLE_LV__DATA,
				V.ENEMY,
				_enemyData.name,
				callback);
			
			function callback(data:Level_up_enemy) : void
			{
				_enemyModel.hp = lv * data.hp * _enemyConfig.hp;
				_enemyModel.atk = lv * data.atk * _enemyConfig.atk;
				_enemyModel.def = lv * data.def * _enemyConfig.def;
				
			}
		}
		
		/**
		 *添加敌人到舞台 
		 * 
		 */
		private function initEnemy():void{
			getEnemyBaseData();
			getEnemyLVData();
			var enemyTexture:Texture = _view.role_big.interfaces(InterfaceTypes.GetTexture, "RoleImage_Big_" + _enemyData.name);
			_enemyImage = new Image(enemyTexture);
			_enemyImage.x=ENEMY_X_POSITION;
			_enemyImage.y=ENEMY_Y_POSITION;
			_enemyImage.pivotX = .5 * _enemyImage.width;
			_enemyImage.pivotY = .5 * _enemyImage.height;
			_enemyImage.scaleX = V.FIGHT_SCALE;
			_enemyImage.scaleY = V.FIGHT_SCALE;
			this.panel.addChild(_enemyImage);
		}

		
		private function initSkillGrid():void{
			_equippedSkills = _view.tdhPrepare.equippedSkills;
			if (!_equippedSkillGrid)
			{
				_equippedSkillGrid = new Grid(MatchItemRender, 1, 5, 42, 42, 3, 0);
				_equippedSkillGrid["layerName"] = "BackGround";
				_equippedSkillGrid.x = 359;
				_equippedSkillGrid.y = 242;
				panel.addChild(_equippedSkillGrid);
			}
			_equippedSkillGrid.setData(_equippedSkills);
		}

		
		private function initGameData():void
		{
			EnemyCurHp=EnemyHpMax=_enemyModel.hp*_enemyData.hp_up;
			MeCurHp=MeHpMax=_mainRoleModel.hp;
			_enemyLifeBar.width = ENEMY_LIFE_WIDTH;
			_meLifeBar.width = ME_LIFE_WIDTH;
			_enemyHpTF.text=EnemyCurHp.toString()+"/"+EnemyHpMax.toString();
			_meHpTF.text=MeCurHp.toString()+"/ "+MeHpMax.toString();
			MeBaseDamage=Math.max(_mainRoleModel.model.atk-_enemyModel.def,1);
			EnemyBaseDamage=Math.max(_enemyModel.atk-_mainRoleModel.model.def,1);
		}
		
		/**
		 * 添加图标点击事件
		 * 
		 */		
		private function addPieceEvent() : void
		{
			for(var i:int = 0; i < pieceArr.length; i++)
			{
				for(var j:int = 0; j < pieceArr[i].length; j++)
				{
					pieceArr[i][j].useHandCursor = true;
					pieceArr[i][j].addEventListener(TouchEvent.TOUCH, onPieceTouch);
				}
			}
		}
		
		/**
		 * 删除图标点击事件
		 * 
		 */		
		private function removePieceEvent() : void
		{
			for(var i:int = 0; i < pieceArr.length; i++)
			{
				for(var j:int = 0; j < pieceArr[i].length; j++)
				{
					pieceArr[i][j].useHandCursor = false;
					pieceArr[i][j].removeEventListener(TouchEvent.TOUCH, onPieceTouch);
				}
			}
		}

		

		
		/**
		 * 初始化地图数据
		 * 
		 */		
		private function initPiecesData() : void
		{
			while(true){
				
				pieceArr = new Vector.<Vector.<MatchPiece>>();
				
				for(var i:int = 0; i < X_MAX; i++)
				{
					pieceArr[i] = new Vector.<MatchPiece>();
					for(var j:int = 0; j < Y_MAX; j++)
					{
						pieceArr[i].push(creatPiece(i,j));
					}
				}
				
				if(lookForMatches().length !=0) continue;
				
				//if(lookForPossibles() == false) continue;
				
				break;
			}
			
			addPieces();

		}
		
		private function creatPiece(xPos:int,yPos:int):MatchPiece{
			
			var randomImageName:String="props_" + Math.floor(Math.random()*6+44);
			if(randomImageName == "props_49"){
				randomImageName = "props_53"
			}
			var texture:Texture = _view.icon.interfaces(InterfaceTypes.GetTexture, randomImageName);
			var newPiece:MatchPiece = new MatchPiece(texture);
			newPiece.xPos=xPos;
			newPiece.yPos=yPos;
			newPiece.type=creatType(randomImageName);
			return newPiece;
		}
		
		private function creatType(imageName:String):String{
			var type:String;
			switch(imageName){
				case "props_44":
					type="common";
					break;
				case "props_45":
					type="fire";
					break;
				case "props_46":
					type="water";
					break;
				case "props_47":
					type="poison";
					break;
				case "props_48":
					type="chaos";
					break;
				case "props_53":
					type="hp_up";
					break;
			}
			return type;
		}
		
		/**
		 * 创建图标
		 * 
		 */		
		private function addPieces() : void
		{
			
			for(var i:int = 0; i < X_MAX; i++)
			{
				for(var j:int = 0; j < Y_MAX; j++)
				{
					pieceArr[i][j].pivotX=pieceArr[i][j].width/2;
					pieceArr[i][j].pivotY=pieceArr[i][j].height/2;
					pieceArr[i][j].x = i * ICON_WIDTH + X_START;
					pieceArr[i][j].y = j * ICON_HEIGHT + Y_START;
					pieceArr[i][j].xPos=i;
					pieceArr[i][j].yPos=j;
					panel.addChild(pieceArr[i][j]);
				}
			}
			
			addPieceEvent();
		}
		

		/**
		 * 添加回合数
		 * 
		 */	
		private function addTurnInfo():void{
			_turnTextField = new TextField(300, 50,"");	
			_turnTextField.fontName ="HKHB";
			_turnTextField.text=ENEMY_ATK_TURN.toString()+"回合后发动攻击";
			_turnTextField.hAlign = HAlign.CENTER;
			_turnTextField.vAlign = VAlign.CENTER;
			_turnTextField.fontSize=20 
			_turnTextField.color=0Xffffff;
			_turnTextField.x = 315;
			_turnTextField.y = 35;
			panel.addChild(_turnTextField);
			


		}
		

		
		
		/**
		 * 图标点击事件
		 * @param e
		 * 
		 */		

		private function onPieceTouch(e:TouchEvent) : void
		{
			var firstPiece:MatchPiece = e.target as MatchPiece;
			var touch:Touch = e.getTouch(firstPiece);
			var xOffSet:int;
			var yOffSet:int;
			var xDis:int;
			var yDis:int;
			

			
			if(!touch) return;
			
			
			if(touch.phase == TouchPhase.BEGAN){
				isSwitched=false;
				startX=firstPiece.x;
				startY=firstPiece.y;
				
				
				tickNum=TICK_TIME;
				initTickDisplay(startX,startY);
				
				_timer= new Timer(1000,4)
				_timer.addEventListener(TimerEvent.TIMER, tickNumUpdate);
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE, putPiece);
				_timer.start();
				timeOver=false;
				
			}else if(touch.phase == TouchPhase.MOVED)
			{
				if(!timeOver){
					isSwitching=true;
					//var yDis:int=touch.globalY-card.y;
					if(touch.globalX > X_START && touch.globalX < 590){
						firstPiece.x = touch.globalX;
					}else if(touch.globalX>=590){
						firstPiece.x = 590;
					}else if(touch.globalX <= X_START){
						firstPiece.x = X_START;
					}
					
					if(touch.globalY > Y_START && touch.globalY < 534){
						firstPiece.y = touch.globalY;
					}else if(touch.globalY >= 534){
						firstPiece.y = 534;
					}else if(touch.globalY <= Y_START){
						firstPiece.y = Y_START;
					}
					
					_pieceTickTxt.x=firstPiece.x;
					_pieceTickTxt.y=firstPiece.y;
					_tickImage.x=firstPiece.x-19;
					_tickImage.y=firstPiece.y-19;
					
					
					for(var i:int=0;i<X_MAX;i++){
						for(var j:int=0;j<Y_MAX;j++){
							startX=firstPiece.xPos*ICON_WIDTH+X_START;
							startY=firstPiece.yPos*ICON_HEIGHT+Y_START;
							xOffSet=Math.floor((firstPiece.x+ICON_WIDTH/2-startX)/ICON_WIDTH);
							yOffSet=Math.floor((firstPiece.y+ICON_HEIGHT/2-startY)/ICON_WIDTH);
							xDis=touch.globalX-startX;
							yDis=touch.globalY-startY;
							if(pieceArr[i][j].xPos==firstPiece.xPos+xOffSet 
								&& pieceArr[i][j].yPos==firstPiece.yPos+yOffSet
								&& pieceArr[i][j]!=firstPiece){
								TweenMax.to(pieceArr[i][j],0.5,{x:firstPiece.xPos*ICON_WIDTH+X_START,y:firstPiece.yPos*ICON_HEIGHT+Y_START});
								
								var secondPiece:MatchPiece=pieceArr[i][j];
								var firstXpos:int = firstPiece.xPos;
								var firstYpos:int = firstPiece.yPos;
								
								firstPiece.xPos = secondPiece.xPos;
								firstPiece.yPos = secondPiece.yPos;
								
								secondPiece.xPos = firstXpos;
								secondPiece.yPos = firstYpos;
								
								pieceArr[firstPiece.xPos][firstPiece.yPos]=firstPiece;
								pieceArr[secondPiece.xPos][secondPiece.yPos]=secondPiece;
								isSwitched=true;
								
								break;
							}
						}
					}
				}


			}else if(touch.phase == TouchPhase.ENDED){
				if(!timeOver){
					xDis=touch.globalX-startX;
					yDis=touch.globalY-startY;
					if(isSwitched){
						putPiece(null);	
					}else{
						putPieceWithouCheck();	
					}
				}

				
			}
			
			 function tickNumUpdate(e:TimerEvent):void{
				 tickNum--;
				 _pieceTickTxt.text=tickNum.toString();
				 
			 }
			
			 function putPiece(e:TimerEvent):void{
				 removeTickDisplay();
				panel.touchable=false;
				_skillTypeList = new Array();
				_quitBtn.touchable=false;
				xDis=touch.globalX-startX;
				yDis=touch.globalY-startY;
				if(xDis>0){
					firstPiece.x=Math.min(startX+ICON_WIDTH*int((Math.abs(xDis)/ICON_WIDTH)),X_END);
				}else if(xDis<0){
					firstPiece.x=Math.max(startX-ICON_WIDTH*int((Math.abs(xDis)/ICON_WIDTH)),X_START);
				}
				
				if(yDis>0){
					firstPiece.y=Math.min(startY+ICON_HEIGHT*int((Math.abs(yDis)/ICON_HEIGHT)),Y_END);
				}else if(yDis<0){
					firstPiece.y=Math.max(startY-ICON_HEIGHT*int((Math.abs(yDis)/ICON_HEIGHT)),Y_START);
				}
				if(_timer){
					_timer.stop();
					_timer.removeEventListener(TimerEvent.TIMER, tickNumUpdate);
					_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, putPiece);
					_timer=null;
				}
				isSwitching=false;
				findAndRemoveMatches();
				timeOver=true;
			}
			 
			 
			 function putPieceWithouCheck():void{
				 removeTickDisplay();
				 xDis=touch.globalX-startX;
				 yDis=touch.globalY-startY;
				 if(xDis>0){
					 firstPiece.x=Math.min(startX+ICON_WIDTH*int((Math.abs(xDis)/ICON_WIDTH)),X_END);
				 }else if(xDis<0){
					 firstPiece.x=Math.max(startX-ICON_WIDTH*int((Math.abs(xDis)/ICON_WIDTH)),X_START);
				 }
				 
				 if(yDis>0){
					 firstPiece.y=Math.min(startY+ICON_HEIGHT*int((Math.abs(yDis)/ICON_HEIGHT)),Y_END);
				 }else if(yDis<0){
					 firstPiece.y=Math.max(startY-ICON_HEIGHT*int((Math.abs(yDis)/ICON_HEIGHT)),Y_START);
				 }
				 if(_timer){
					 _timer.stop();
					 _timer.removeEventListener(TimerEvent.TIMER, putPiece);
					 _timer=null;
				 }
			 }
		}


		private function initTickDisplay(x:int,y:int):void{
			
			var _tickShape:Shape = new Shape;
			_tickShape.graphics.clear();  
			_tickShape.graphics.beginFill(0x000000);
			_tickShape.graphics.drawRect(0,0,40,38);
			_tickShape.graphics.endFill();
			_tickShape.cacheAsBitmap = true;
			var _bmpData:BitmapData = new BitmapData(40, 38,true,0);
			_bmpData.draw(_tickShape);
			var _Texture:Texture = Texture.fromBitmapData(_bmpData);
			_tickImage = new Image(_Texture);
			_tickImage.x=x-19;
			_tickImage.y=y-19;
			_tickImage.alpha=0.7;
			panel.addChild(_tickImage);
			_tickImageWidthMax=_tickImage.width;
			
			_pieceTickTxt = new TextField(30, 30,"");	
			_pieceTickTxt.fontName ="HKHB";
			_pieceTickTxt.hAlign = HAlign.CENTER;
			_pieceTickTxt.vAlign = VAlign.CENTER;
			_pieceTickTxt.fontSize=25;
			_pieceTickTxt.color=0Xff0000;
			_pieceTickTxt.pivotX=15;
			_pieceTickTxt.pivotY=15;
			_pieceTickTxt.touchable=false;
			_pieceTickTxt.x=x;
			_pieceTickTxt.y=y;
			_pieceTickTxt.text=tickNum.toString();
			panel.addChild(_pieceTickTxt);
			

		}
		
		
		private function removeTickDisplay():void{
			_pieceTickTxt.text="";
			panel.removeChild(_pieceTickTxt);
			_pieceTickTxt.dispose();
			_pieceTickTxt=null;
			
			panel.removeChild(_tickImage);
			_tickImage.texture.dispose();
			_tickImage.dispose();
			_tickImage=null;
		}
		
		private function countEnemyAttack():void{
			turnNum--;
			if(turnNum==0){
				Starling.juggler.delayCall(enemyAtackEffectBegin,0.8);
				_turnTextField.text="敌人发动攻击！";
			}else{
				_turnTextField.text=turnNum.toString()+"回合后发动攻击";
				panel.touchable=true;
			}
			
		}
		
		private function enemyAtackEffectBegin():void{
			_enemyImage.scaleX=1;
			_enemyImage.scaleY=1;
			Starling.juggler.delayCall(enemyAtackEnd,0.15);
		}
		
		private function enemyAtackEnd():void{
			_enemyImage.scaleX = V.FIGHT_SCALE;
			_enemyImage.scaleY = V.FIGHT_SCALE;
			Starling.juggler.delayCall(addBlinkEffect,0.1);
		}
		
		
		
		/**
		 *添加闪屏效果 
		 * 
		 */
		private function addBlinkEffect():void{
			
			var whiteShape:Shape = new Shape();
			whiteShape.graphics.beginFill(0xFFFFFF, 1);
			whiteShape.graphics.drawRect(0, 0, GameConfig.CAMERA_WIDTH, GameConfig.CAMERA_HEIGHT);
			whiteShape.graphics.endFill();
			
			var bitmapWhite:BitmapData = new BitmapData(GameConfig.CAMERA_WIDTH, GameConfig.CAMERA_HEIGHT, true, 0);
			bitmapWhite.draw(whiteShape);
			
			var lightWhite:Texture = Texture.fromBitmapData(bitmapWhite);
			_blinkImage = new Image(lightWhite);
			_blinkImage.x = 0;
			_blinkImage.y = 0;
			_blinkImage.alpha = 1;
			_blinkImage.data=[0];//记录闪屏次数
			addBlink(_blinkImage)	
		}
		
		
		private function removeblink(...args):void{
			panel.removeChild(args[0]);
			args[0].data[0]++;
			if(args[0].data[0]<2){//闪屏2次
				Starling.juggler.delayCall(addBlink,0.1,args[0]);
			}else{
				MeGetDamage(EnemyBaseDamage);
				disposeImage(args[0]);
			}
			
		}
		
		private function addBlink(...args):void{
			this.panel.addChild(args[0]);
			Starling.juggler.delayCall(removeblink,0.1,args[0])
		}
		
		/**
		 * 清空指定图片
		 */	
		private function disposeImage(...args):void{
			
			panel.removeChild(args[0]);
			args[0].texture.dispose();
			args[0].dispose();
			args[0]=null;	
		}
		
		/**
		 * 查找所有匹配并消除
		 * 
		 */	
		private function findAndRemoveMatches():void{
			var matchArr:Array = lookForMatches();
			if(matchArr.length==0){//一次拖动后查找完所有匹配
				TotalDamage=TotalDamage*(1+(comboNum-1)*COMBO_BONUS);
				creatInfoString();
				enemyDamageNumEffect();
				addPieceEvent();
				_quitBtn.touchable=true;
				EnemyGetDamage(TotalDamage);
				MeGetHeal(TotalHeal);
				showSkillEffect();
				comboNum=0;
				usedSkillArr=[];
				return;
			}else{
				removePieceEvent();
				comboNum+=matchArr.length;
				for( var i:int = 0; i < matchArr.length ; i++ ){
					for( var j:int = 0; j < matchArr[i].length ; j++ ){
						var tempPiece:MatchPiece=matchArr[i][j];
						var crossMatchCheck:Boolean=true;//当出现交叉匹配时检查是否有重复方块
						for( var m:int = 0; m < matchArr.length ; m++ ){
							for( var n:int = 0; n< matchArr[m].length ; n++ ){
								if(!(i==m && j==n) && tempPiece==matchArr[m][n]){
									crossMatchCheck=false;
								}
							}
						}
						if(crossMatchCheck){
							singleMatchNum=matchArr[i].length;
							countMatches(matchArr[i][0].type);
							if(SkillDamage>0){
								initParticle(matchArr[i][j].x,matchArr[i][j].y,matchArr[i][j].type);	
							}
							SkillDamage=0;
							panel.removeChild(matchArr[i][j]);
							matchArr[i][j].texture.dispose();
							matchArr[i][j].dispose();
							pieceArr[matchArr[i][j].xPos][matchArr[i][j].yPos]=null;
							dropPieceAbove(matchArr[i][j]);
						}
					}
					
				}
				Starling.juggler.delayCall(addNewTopPiece,0.2);
				//addNewTopPiece();

			}
		}
		
		
		

		
		
		/**
		 * 生成粒子效果
		 * @param startX
		 * @param startY
		 * @param type
		 * 
		 */
		private function initParticle(startX:int,startY:int,type:String):void{

			var usedSkillNum:int;
			var targetArr:Array= [];
			var targetX:int;
			var targetY:int;
			
			for each (var skillItemRender:MatchItemRender in usedSkillArr){
				for(var typeIndex:int=0;typeIndex<skillItemRender.skillTypeArray.length;typeIndex++){
					if(skillItemRender.skillTypeArray[typeIndex]==type){
						var target:Array=new Array(skillItemRender.x+skillItemRender.width/2+_equippedSkillGrid.x
							,skillItemRender.y+skillItemRender.height/2+_equippedSkillGrid.y);
						targetArr.push(target);
						usedSkillNum++;
						target=null;
					}
				}
			}
/*			if(type=="hp_up"){
				targetX=470;
				targetY=294;
			}*/
			
			for(var i:int=0;i<targetArr.length;i++){
				var particle:PDParticleSystem = new PDParticleSystem(XML(new BlizzardPexClass()),Texture.fromBitmap(new BlizzardBmpClass()));
				particle.x=startX;
				particle.y=startY;
				particle.speed=80;
				switch(type){
					case "common":
						setParticleStartColor(0.3,0.3,0.3);
						break;
					case "fire":
						setParticleStartColor(0.6,0.3,0);
						break;
					case "water":
						setParticleStartColor(0,0.3,0.6);
						break;
					case "poison":
						setParticleStartColor(0.3,0.6,0);
						break;
					case "chaos":
						setParticleStartColor(0.3,0,0.6);
						break;
					case "hp_up":
						setParticleStartColor(0.1,0.3,0.3);
						break;
				}
				
				
				this.panel.addChild(particle);
				Starling.juggler.add(particle);
				//particleArr.push(particle);
				particle.start();
				var dx:int = targetArr[i][0] - particle.x;
				var dy:int = targetArr[i][1] - particle.y;
				particle.emitAngle = deg2rad(Math.atan2(dy, dx) * 180 / Math.PI);
				TweenMax.to(particle,0.5,{x:targetArr[i][0],y:targetArr[i][1],onComplete:particleExplode,onCompleteParams:[particle]});
				
			}

			/**
			 * 设置粒子颜色
			 * 
			 */
			function setParticleStartColor(red:Number,green:Number,blue:Number):void{
				particle.startColor.red=particle.endColor.red=red;
				particle.startColor.green=particle.endColor.green=green;
				particle.startColor.blue=particle.endColor.blue=blue;
				
			}
			targetArr=null;
		}
		
		

		
		
		/**
		 *粒子爆炸效果 
		 * @param particle
		 * 
		 */		
		private function particleExplode(particle:PDParticleSystem):void{
			particle.speed=0;
			particle.speedVariance=80;
			particle.emitAngleVariance=240;
			Starling.juggler.delayCall(destroyParticle,1,particle);
		}
		
		/**
		 *移除粒子 
		 * @param particle
		 * 
		 */		
		private function destroyParticle(particle:PDParticleSystem):void{
			this.panel.removeChild(particle);
			particle.stop();
			//particleArr.splice(particleArr.indexOf(particle),1);
			particle.texture.dispose();
			particle.dispose();
		}
		

		
		
		
		/**
		 * 计算匹配类型
		 * 
		 */	
		private function countMatches(type:String):void{
			var isHeal:Boolean;
			for (var i:int=0; i<_equippedSkillGrid.numChildren;i++){
				var skillItemRender:MatchItemRender = _equippedSkillGrid.getChildAt(i) as MatchItemRender;
				if(type!="hp_up"){
					var typeRepeat:Boolean;
					for(var j:int=0;j<_skillTypeList.length;j++){
						if(_skillTypeList[j]==type){
							typeRepeat=true;
							break;
						}
					}
					if(!typeRepeat){
						_skillTypeList.push(type);		
					}
					isHeal=false;
				}else{
					isHeal=true;
				}
				
				for(var typeIndex:int=0;typeIndex<skillItemRender.skillTypeArray.length;typeIndex++){
					if(skillItemRender.skillTypeArray[typeIndex]==type){
						countDamage(isHeal);
					}
				}

			}
			
			function countDamage(isHeal:Boolean):void{
				usedSkillArr.push(skillItemRender);
				if(isHeal){
					SkillDamage=Math.max(1,(skillItemRender.skillModel.skill.hp_up+player.upgradeSkill.isUpgradeSkill(skillItemRender.skillModel.skill) * 0.01)*_mainRoleModel.hp/singleMatchNum);
					TotalHeal+=SkillDamage;
				}else{
					SkillDamage=Math.max(1,(skillItemRender.skillModel.skill.damage_ratio+player.upgradeSkill.isUpgradeSkill(skillItemRender.skillModel.skill) * 0.01)*MeBaseDamage/singleMatchNum);
					TotalDamage+=SkillDamage;
				}
				
			}
		}
		

	
		
	
		private function showSkillEffect():void
		{
			var len:int = _skillTypeList.length;
			for(var i:int = 0; i < len; i++)
			{
				returnSkill(_skillTypeList[i])
			}
		}		
		
		private function returnSkill(property:String) : void
		{
			var len:int = _equippedSkills.length;
			for(var i:int = 0; i < len; i++)
			{
				if(_equippedSkills[i].skill[property] == 1 && property!="hp_up")
				{
					onSkill(_equippedSkills[i]);
					return;
				}
			}
		}
		
		/// 技能伤害
		private function onSkill(skillModel:SkillModel) : void
		{
			var effect:String = skillModel.skill.effect;
			
			if (effect == "无")
			{
				return;
			}
			
			var arr:Array = effect.split("|");
			// effect
			for (var i:int = 0; i < arr.length; i++)
			{
				play(arr[i]);
			}
			
			// 水属性
			if (skillModel.skill.water == 1)
			{
				play(FightEffectConfig.WATER);
			}
			
			// 火属性
			if (skillModel.skill.fire == 1)
			{
				play(FightEffectConfig.FIRE);
			}
			
			// 混沌属性
			if (skillModel.skill.chaos == 1)
			{
				play(FightEffectConfig.CHAOS);
			}
			
			// 毒属性
			if (skillModel.skill.poison == 1)
			{
				play(FightEffectConfig.POSION_HURT);
			}
		}
		
		private var _effectLayer:Sprite;
		private function play(type:String) : void
		{
			var texture_index:int = FightEffectConfig.TEXTURE_INDEX[type] || 1;
			var atlas:TextureAtlas = (texture_index == 2 ? _view.fightEffect.titleTxAtlas2 : _view.fightEffect.titleTxAtlas1);
			
			var itemData:FightEffectConfigData = _view.fightEffect.getFightEffectData(type);
			var posion:MatchEffectPlayer = new MatchEffectPlayer();
			posion.initData(itemData, atlas, playDelayTime);
			posion.addEventListener(Event.COMPLETE, onPlayComplete);
			_effectLayer.addChild(posion);
			
			posion.x = itemData.X;
			posion.y = itemData.Y;
		}
		
		private function onPlayComplete(e:Event) : void
		{
			var target:MatchEffectPlayer = e.target as MatchEffectPlayer;
			target.parent.removeChild(target);
			target.removeEventListeners();
			target.dispose();
			target = null;
		}
		
		/**
		 * 敌人受伤
		 * @param damage
		 * 
		 */
		private function EnemyGetDamage(damage:int):void{
			if(damage==0){
				countEnemyAttack();
				return;
			}
			EnemyCurHp-=damage;
			TotalDamage=0;
			if(EnemyCurHp>0){
				_enemyHpTF.text=EnemyCurHp.toString()+"/"+EnemyHpMax.toString();
				TweenMax.to(_enemyLifeBar, 0.5, {width:EnemyCurHp / EnemyHpMax * ENEMY_LIFE_WIDTH, onComplete:countEnemyAttack});
			}else{
				_enemyHpTF.text="0/"+EnemyHpMax.toString();
				_tweenDeadEffect.setStart(_enemyLifeBar, "width", 0 , .5, win);
				
			}
			
		}
		
		private function enemyTurnInfoRefresh():void{
			turnNum=ENEMY_ATK_TURN;
			_turnTextField.text=turnNum.toString()+"回合后发动攻击";
			panel.touchable=true;
		}
		
		
		
		/**
		 *主角受伤 
		 * @param damage
		 * 
		 */
		private function MeGetDamage(damage:int):void{
			if(damage==0){
				return;
			}
			MeCurHp-=damage;
			if(MeCurHp>0){
				_meHpTF.text=MeCurHp.toString()+"/"+MeHpMax.toString();
				TweenMax.to(_meLifeBar,0.5,{width: MeCurHp / MeHpMax * ME_LIFE_WIDTH
					,onComplete: enemyTurnInfoRefresh});
			}else{
				_meHpTF.text="0/"+MeHpMax.toString();
				TweenMax.to(_meLifeBar,0.5,{width: 0
					,onComplete: lose});
			}
			meHurtNumEffect(damage);

		}
		
		/**
		 * 主角受伤数字效果
		 * @param damage
		 * 
		 */
		private function meHurtNumEffect(damage:int):void{
			var _damageTextField:TextField = new TextField(250, 50,"");	
			_damageTextField.fontName ="HKHB";
			_damageTextField.text="-"+damage.toString();
			_damageTextField.hAlign = HAlign.CENTER;
			_damageTextField.vAlign = VAlign.CENTER;
			_damageTextField.fontSize=20 
			_damageTextField.color=0Xff0000;
			_damageTextField.x = 370;
			_damageTextField.y = 266;
			panel.addChild(_damageTextField);
			TweenMax.to(_damageTextField,0.7,{x:510,onComplete: removeTF,onCompleteParams:[_damageTextField]});
			
		}
		
		private function MeGetHeal(heal:int):void{
			if(heal==0){
				return;
			}
			MeCurHp+=heal*(1+comboNum/2);
			MeCurHp=Math.min(MeCurHp,_mainRoleModel.hp);
			TotalHeal=0;
			_meHpTF.text=MeCurHp.toString()+"/"+MeHpMax.toString();
			_tweenEffect.setStart(_meLifeBar, "width", MeCurHp / MeHpMax * ME_LIFE_WIDTH , .5,null);
			meHealNumEffect(heal);
		}

		
		private function meHealNumEffect(heal:int):void{
			var _healTextField:TextField = new TextField(250, 50,"");	
			_healTextField.fontName ="HKHB";
			_healTextField.text="+"+heal.toString();
			_healTextField.hAlign = HAlign.CENTER;
			_healTextField.vAlign = VAlign.CENTER;
			_healTextField.fontSize=20 
			_healTextField.color=0Xfd840b;
			_healTextField.x = 370;
			_healTextField.y = 266;
			panel.addChild(_healTextField);
			TweenMax.to(_healTextField,0.7,{x:510,onComplete: removeTF,onCompleteParams:[_healTextField]});
			
		}
		
		
		private function creatInfoString():void{
			enemyDamageInfo="-"+TotalDamage.toString();
			
		}
		
		
		
		/**
		 * 添加敌人受伤数字效果
		 * 
		 */	
		private function enemyDamageNumEffect():void{
			var enemyDamageTxt:TextField = new TextField(250, 50,"");	
			enemyDamageTxt.fontName ="HKHB";
			enemyDamageTxt.text=enemyDamageInfo;
			enemyDamageTxt.hAlign = HAlign.CENTER;
			enemyDamageTxt.vAlign = VAlign.CENTER;
			enemyDamageTxt.fontSize=34 
			enemyDamageTxt.color=0Xff0000;
			enemyDamageTxt.x = 320;
			enemyDamageTxt.y = 140;
			panel.addChild(enemyDamageTxt);
			TweenMax.to(enemyDamageTxt,0.7,{x:500,onComplete: removeTF,onCompleteParams:[enemyDamageTxt]});
			enemyDamageInfo="";
			
			var _comboTextField:TextField = new TextField(250, 50,"");	
			_comboTextField.fontName ="HKHB";
			_comboTextField.text="连击："+comboNum.toString();
			_comboTextField.hAlign = HAlign.CENTER;
			_comboTextField.vAlign = VAlign.CENTER;
			_comboTextField.fontSize=32 
			_comboTextField.color=0Xffffff;
			_comboTextField.x = 320;
			_comboTextField.y = 100;
			panel.addChild(_comboTextField);
			TweenMax.to(_comboTextField,0.7,{x:500,onComplete: removeTF,onCompleteParams:[_comboTextField]});
			
		}

		
		/**
		 * 文本删除自身
		 * @param tf
		 * 
		 */	
		private function removeTF(tf:TextField):void{
			
			panel.removeChild(tf);
			tf.dispose();
			tf=null;
		}
		
		

		
		
		/**
		 * 下落被消去方块上方已有的方块
		 * 
		 */	
		private function dropPieceAbove(missPiece:MatchPiece):void{
			for(var yPos:int = missPiece.yPos-1;yPos>=0;yPos--){
				if(pieceArr[missPiece.xPos][yPos]!= null){
					pieceArr[missPiece.xPos][yPos].yPos++;
					//TweenMax.to(pieceData[missPiece.xPos][yPos],PIECE_DROP_SPEED,{y:pieceData[missPiece.xPos][yPos].yPos* ICON_HEIGHT + Y_START});
					pieceArr[missPiece.xPos][yPos+1]=pieceArr[missPiece.xPos][yPos];
					pieceArr[missPiece.xPos][yPos] = null;
				}
			}
		}
		
		
		
		/**
		 * 在顶部添加新方块并下落
		 * 
		 */	
		private function addNewTopPiece():void{
			for(var xPos:int = 0; xPos<X_MAX ; xPos++){
				var missPieces:int = 0;
				for( var yPos:int = Y_MAX-1 ; yPos>=0 ; yPos--){
					if(pieceArr[xPos][yPos]==null){ 
						var newPiece:MatchPiece = creatPiece(xPos,yPos);
						newPiece.pivotX=newPiece.width/2;
						newPiece.pivotY=newPiece.height/2;
						newPiece.x= xPos * ICON_WIDTH + X_START;
						newPiece.y= Y_START - ICON_HEIGHT - ICON_HEIGHT*missPieces++;
						newPiece.useHandCursor = true;
						newPiece.addEventListener(TouchEvent.TOUCH, onPieceTouch);
						pieceArr[xPos][yPos]=newPiece;
						panel.addChild(newPiece);
						isDroping=true;
						//TweenMax.to(newPiece,PIECE_DROP_SPEED,{y:yPos* ICON_HEIGHT + Y_START,onComplete: findAndRemoveMatches});
					}
				}
			}
		}
		
		
		/**
		 *查找并生成匹配队列 
		 * @return 
		 * 
		 */
		private function lookForMatches():Array{
			var matchList:Array = [];
			//搜索水平方向的匹配
			for(var horizYpos:int=0 ; horizYpos < Y_MAX ; horizYpos++){
				for(var horizXpos:int=0 ; horizXpos < X_MAX-2 ; horizXpos++){
					var horizmatch:Array = getHorizMatch(horizXpos,horizYpos);
					if(horizmatch.length>2){
						matchList.push(horizmatch);
						horizXpos+= horizmatch.length-1;
					}
				}
			}
			
			//搜索垂直方向的匹配
			for(var vertXpos:int=0 ; vertXpos < X_MAX; vertXpos++){
				for(var vertYpos:int=0 ; vertYpos < Y_MAX-2 ; vertYpos++){
					var vertmatch:Array = getVertMatch(vertXpos,vertYpos);
					if(vertmatch.length>2){
						matchList.push(vertmatch);
						vertYpos+= vertmatch.length-1;
					}
				}
			}
			
			return matchList;
		}
		
		
		/**
		 * 寻找横向匹配
		 * 
		 */	
		private function getHorizMatch(col:int,row:int):Array{
			var match:Array = [pieceArr[col][row]];
			for(var i:int=1;i+col<X_MAX;i++){
				if(pieceArr[col][row].type == pieceArr[col+i][row].type){
					match.push(pieceArr[col+i][row]);
				}else{
					return match;
				}
			}
			return match;
		}
		
		
		/**
		 * 寻找纵向匹配
		 * 
		 */	
		private function getVertMatch(col:int,row:int):Array{
			var match:Array = [pieceArr[col][row]];
			for(var i:int=1;i+row<Y_MAX;i++){
				if(pieceArr[col][row].type == pieceArr[col][row+i].type){
					match.push(pieceArr[col][row+i]);
				}else{
					return match;
				}
			}
			return match;
		}
		
		
		/**
		 * 方块下落循环函数
		 * 
		 */
		private function onPiecesMove():void{
			var pieceMove:Boolean=false;
			if(!isSwitching){
				for(var xPos:int=0;xPos<6;xPos++){
					for(var yPos:int=0;yPos<5;yPos++){
						if(pieceArr[xPos][yPos]!=null 
							&& pieceArr[xPos][yPos].y<pieceArr[xPos][yPos].yPos*ICON_WIDTH+Y_START){
							pieceArr[xPos][yPos].y+=PIECE_DROP_SPEED;
							pieceMove=true;
						}
					}
				}
			}

			
			if(isDroping && !pieceMove && !isOver){
				isDroping=false;
				findAndRemoveMatches();
			}
			
			if(_tickImage){
				_tickImage.width-=0.4;
			}
		}		
		
	
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			switch (e.target.name)
			{
				//提示
				case "Return_Button":
					quitMatchGame();
					break;
			}
		}
		

		private function quitMatchGame() : void
		{
			isJuggler = false;
			_view.tip.interfaces(InterfaceTypes.Show,
				"退出视为自动失败，是否确定退出？",
				lose, cancelQuit, false);
		}
		
		private function cancelQuit() : void
		{
			isJuggler = true;
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
			if (type == "public")
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else if(type == "effect")
			{
				texture = _view.other_effect.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			return texture;
		}
		
		
		
		private function win():void{
			gameOver(true);
		}
		
		private function lose():void{
			gameOver(false);
		}
		
		/**
		 * 游戏结束调用函数，显示信息
		 * 
		 */		
		private function gameOver(isWined:Boolean) : void
		{
			panel.touchable=true;
			isOver=true;
			if(isWined){
				_enemyImage.filter = new GrayscaleFilter();
			}else{
				_enemyImage.filter = null;
			}
			
			removePieceEvent();
			
			for(var i:int = 0; i < pieceArr.length; i++)
			{
				for(var j:int = 0; j < pieceArr[j].length; j++)
				{
					this.panel.removeChild(pieceArr[i][j]);
					pieceArr[i][j].texture.dispose()
					pieceArr[i][j].dispose();
					pieceArr[i][j] = null;
				}
			}
			
			Starling.juggler.remove(turnInfoDelay);
			
			//this.hide();
			_matchResultPanel.showResult(_enemyCallBack,isWined,_enemyData.i_force);
			_quitBtn.touchable=false;
			//_enemyCallBack(isWined);
			//_view.world.interfaces();
		}
		
		override public function close() : void
		{			
			super.close();
		}
		
		override public function hide() : void
		{	

			this.panel.removeChild(_enemyImage);
			_enemyImage.texture.dispose();
			_enemyImage.dispose();
			_enemyImage=null;
			
			
			this.panel.removeChild(_turnTextField);
			_turnTextField.dispose();
			_turnTextField=null;
			
			super.hide();
		}
		
		
		
		
	}
}
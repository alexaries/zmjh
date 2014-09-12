package com.game.view.plugin
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.data.player.structure.RoleModel;
	import com.game.manager.FontManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class LinkGameView extends BaseView implements IView
	{
		private static const X_MAX:int = 17;
		private static const Y_MAX:int = 10;
		private static const X_START:int = 75;
		private static const Y_START:int = 80;
		private static const ICON_WIDTH:int = 47;
		private static const ICON_HEIGHT:int = 47;
		private static const DIGIT:String = "go_00";
		private static const MAX_TIME:int = 120;
		private static const LIGHTNING:String = "Line_000";
		private static const CORNER:String = "Corner_000";
		private static const BOMB:String = "Bomb_000";
		private static const SELECT:String = "Select_000";
		private static const CORNEROFFSET:int = 0;
		private static const BOMEOFFSET:int = 15;
		private static const SELECTOFFSET:int = 4;
		private static const SOULEXP:int = 40;
		
		private var _anti:Antiwear;
		
		private var _positionXML:XML;
		private var _titleTxAtlas:TextureAtlas;
		/**
		 * 第一个拐点
		 */		
		private var _firstPoint:Point;
		/**
		 * 第二个拐点
		 */		
		private var _secondPoint:Point;
		/**
		 * 第一张图标
		 */		
		private var firstImage:Image;
		/**
		 * 第二张图标
		 */		
		private var secondImage:Image;
		private var randomData:Vector.<String>;
		private var iconData:Vector.<LinkCard>;
		private var cardData:Vector.<Vector.<Image>>;
		private var _coldDownDigit:MovieClip;
		private var _selectMC:MovieClip;
		/**
		 * 倒计时3秒
		 */	
		private var _countDownCount:int;
		/**
		 * 倒计时显示框
		 */		
		private var _coldTime:TextField;
		
		private var _tipTime:TextField;
		private var _resetTime:TextField;
		
		private var _linkGameOverComponent:LinkGameOverComponent;
		
		private var _progressBar:Image;
		private var _progressBg:Image;
		
		private var _data:Object;
		
		private var startTime:int;
		
		private var endTime:Number;
		
		private function get tipCount() : int
		{
			return _anti["tipCount"];
		}
		private function set tipCount(value:int) : void
		{
			_anti["tipCount"] = value;
		}
		
		private function get resetCount() : int
		{
			return _anti["resetCount"];
		}
		private function set resetCount(value:int) : void
		{
			_anti["resetCount"] = value;
		}
		
		//private var roleLv:int;
		private function get roleLv() : int
		{
			return _anti["roleLv"];
		}
		private function set roleLv(value:int) : void
		{
			_anti["roleLv"] = value;
		}
		//private var oneSoulExp:int;
		private function get oneSoulExp() : int
		{
			return _anti["oneSoulExp"];
		}
		private function set oneSoulExp(value:int) : void
		{
			_anti["oneSoulExp"] = value;
		}
		//private var totalSoulExp:int;
		private function get totalSoulExp() : int
		{
			return _anti["totalSoulExp"];
		}
		private function set totalSoulExp(value:int) : void
		{
			_anti["totalSoulExp"] = value;
		}
		private var soulExp:Vector.<Object>;
		
		private var _select_1:MovieClip;
		private var _select_2:MovieClip;
		
		private var _selectCount:Vector.<Image> = new Vector.<Image>();
		
		public function LinkGameView()
		{
			_moduleName = V.LINK_GAME;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.LINK_GAME;
			
			_anti = new Antiwear(new binaryEncrypt());
			
			_anti["tipCount"] = 0;
			_anti["resetCount"] = 0;
			_anti["roleLv"] = 0;
			_anti["oneSoulExp"] = 0;
			_anti["totalSoulExp"] = 0;
			
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch(type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
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
				initTime();
				initEvent();
			}
			
			initData();
			initRender();
			
			_view.layer.setCenter(panel);
		}
		
		private function initData() : void
		{
			oneSoulExp = 0;
			totalSoulExp = 0;
			soulExp = Data.instance.db.interfaces(InterfaceTypes.GET_LEVEL_UP_EXP);
			var _mainRole:RoleModel = player.getRoleModel(V.MAIN_ROLE_NAME);
			roleLv = _mainRole.model.lv;
			oneSoulExp = Math.floor(soulExp[roleLv - 1].soul / SOULEXP);
		}
		
		private function initXML() : void
		{
			_positionXML = getXMLData(V.LINK_GAME, GameConfig.LINK_GAME_RES, "LinkGamePosition");
			_data = Data.instance.db.interfaces(InterfaceTypes.GET_SMALLGAME_LINK);
			tipCount = _data[0].number;
			resetCount = _data[1].number;
		}
		
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(V.LINK_GAME, GameConfig.LINK_GAME_RES, "LinkGame");
				obj = getAssetsObject(V.LINK_GAME, GameConfig.LINK_GAME_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
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
		
		private function initTime() : void
		{
			var digitFrames:Vector.<Texture> = this.getTextures(DIGIT, V.PUBLIC);
			_coldDownDigit = new MovieClip(digitFrames);
			_coldDownDigit.touchable = false;
			_coldDownDigit.stop();
		}
		
		private function getUI() : void
		{
			_coldTime = this.searchOf("coldTime");
			_progressBar = this.searchOf("ProgressBar");
			_progressBg = this.searchOf("BarBg");
			_tipTime = this.searchOf("TipTime");
			_resetTime = this.searchOf("ResetTime");
			
			_tipTime.text = tipCount.toString();
			_resetTime.text = resetCount.toString();
			_coldTime.text = MAX_TIME.toString();
			_linkGameOverComponent = this.searchOf("passGame") as LinkGameOverComponent;
			_linkGameOverComponent.hide();
			
			var frames:Vector.<Texture> = this.getTextures(SELECT, "effect");
			_selectMC = new MovieClip(frames);
			_selectMC.touchable = false;
			_selectMC.stop();
			Starling.juggler.add(_selectMC);
			
			_select_1 = new MovieClip(frames);
			_select_1.touchable = false;
			_select_1.stop();
			Starling.juggler.add(_select_1);
			
			_select_2 = new MovieClip(frames);
			_select_2.touchable = false;
			_select_2.stop();
			Starling.juggler.add(_select_2);
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
					if(name == "PassGame")
					{
						cp = new LinkGameOverComponent(items, _titleTxAtlas);
						_components.push(cp);
					}
				}
			}
		}
		
		/**
		 * 初始化渲染
		 * 
		 */		
		private function initRender() : void
		{
			initMapData();
			createIcon();
			renderStart();
		}
		
		/**
		 * 开始小游戏
		 * 
		 */		
		private function renderStart() : void
		{
			panel.touchable = false;
			_countDownCount = 3;
			panel.addChildAt(_coldDownDigit, panel.numChildren - 1);
			_coldDownDigit.x = panel.width * .5 - _coldDownDigit.width * .5;
			_coldDownDigit.y = panel.height * .5 - _coldDownDigit.height * .5;
			_coldDownDigit.currentFrame = _countDownCount;
			juggle.delayCall(changeText, 1);
		}
		
		/**
		 * 延迟3秒的文本框提示
		 * 
		 */		
		private function changeText() : void
		{
			_countDownCount--;
			_coldDownDigit.currentFrame = _countDownCount;
			if(_countDownCount == 0)
			{
				var tween:Tween = new Tween(_coldDownDigit, .5);
				tween.animate("alpha", 0);
				tween.onComplete = removeColdDown;
				Starling.juggler.add(tween);
				juggle.delayCall(removeColdDown, .5);
				panel.touchable = true;
				endTime = MAX_TIME;
				_coldTime.text = endTime.toString();
				addIconEvent();
				juggle.delayCall(delayedStart, 1);
			}
			else
			{
				juggle.delayCall(changeText, 1);
			}
		}
		
		private function removeColdDown() : void
		{
			if(_coldDownDigit.parent != null)
			{
				_coldDownDigit.parent.removeChild(_coldDownDigit);
			}
		}
		
		/**
		 * 延迟3秒开始游戏
		 * 
		 */		
		private function delayedStart() : void
		{
			startTime = getTimer();
			panel.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			
		}
		
		/**
		 * 添加图标点击事件
		 * 
		 */		
		private function addIconEvent() : void
		{
			for(var i:int = 0; i < cardData.length; i++)
			{
				for(var j:int = 0; j < cardData[i].length; j++)
				{
					cardData[i][j].useHandCursor = true;
					cardData[i][j].addEventListener(TouchEvent.TOUCH, onImageTouch);
				}
			}
		}
		
		/**
		 * 删除图标点击事件
		 * 
		 */		
		private function removeIconEvent() : void
		{
			for(var i:int = 0; i < cardData.length; i++)
			{
				for(var j:int = 0; j < cardData[i].length; j++)
				{
					cardData[i][j].useHandCursor = false;
					cardData[i][j].removeEventListener(TouchEvent.TOUCH, onImageTouch);
				}
			}
		}
		
		/**
		 * 主循环函数
		 * @param e
		 * 
		 */		
		private function onEnterFrameHandler(e:Event) : void
		{
			var intervalTime:int = getTimer() - startTime;
			endTime -= intervalTime * .001;
			startTime = getTimer();
			
			setTimeShow();
		}
		
		/**
		 * 设置倒计时时间显示
		 * 
		 */		
		private function setTimeShow() : void
		{
			_coldTime.text = int(endTime).toString();
			endTime = endTime > MAX_TIME?MAX_TIME:endTime;
			_progressBar.width = (endTime<0?0:endTime) / MAX_TIME * _progressBg.width;
			
			//游戏结束
			if(endTime <= 0)	gameOver();
		}
		
		/**
		 * 游戏结束调用函数，显示信息
		 * 
		 */		
		private function gameOver() : void
		{
			panel.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			removeIconEvent();
			_linkGameOverComponent.showing(totalSoulExp, Math.floor(totalSoulExp / oneSoulExp));
		}
		
		/**
		 * 初始化地图数据
		 * 
		 */		
		private function initMapData() : void
		{
			randomData = new Vector.<String>();
			iconData = new Vector.<LinkCard>();
			for(var i:int = 1; i < X_MAX - 1; i++)
			{
				for(var j:int = 1; j < (Y_MAX - 1)/2; j++)
				{
					var random:int = Math.floor(Math.random() * 37 + 1);
					var str:String = "skill_" + random;
					randomData.push(str);
					randomData.push(str);
				}
			}
			
			for(var m:int = 1; m < X_MAX - 1; m++)
			{
				for(var n:int = 1; n < Y_MAX - 1; n++)
				{
					var pushNum:int = Math.floor(Math.random() * randomData.length);
					var linkCard:LinkCard = new LinkCard(m, n, randomData[pushNum]);
					randomData.splice(pushNum, 1);
					iconData.push(linkCard);
				}
			}
		}
		
		/**
		 * 创建图标
		 * 
		 */		
		private function createIcon() : void
		{
			cardData = new Vector.<Vector.<Image>>();
			for(var i:int = 0; i < X_MAX; i++)
			{
				cardData[i] = new Vector.<Image>();
				for(var j:int = 0; j < Y_MAX; j++)
				{
					if(j != 0 && j != Y_MAX - 1 && i != 0 && i != X_MAX - 1)
					{
						var texture:Texture = _view.icon.interfaces(InterfaceTypes.GetTexture, iconData[(i - 1) * (Y_MAX - 2) + (j - 1)].type);
						var image:Image = new Image(texture);
						image.x = iconData[(i - 1) * (Y_MAX - 2) + (j - 1)].xPos * ICON_WIDTH + X_START;
						image.y = iconData[(i - 1) * (Y_MAX - 2) + (j - 1)].yPos * ICON_HEIGHT + Y_START;
						image.data = iconData[(i - 1) * (Y_MAX - 2) + (j - 1)];
						panel.addChild(image);
						cardData[i].push(image);
					}
					else 
					{
						var linkCard:LinkCard = new LinkCard(i, j, "skill_1");
						linkCard.isShow = false;
						var texture1:Texture = _view.icon.interfaces(InterfaceTypes.GetTexture, linkCard.type);
						var image1:Image = new Image(texture1);
						image1.x = linkCard.xPos * ICON_WIDTH + X_START;
						image1.y = linkCard.yPos * ICON_HEIGHT + Y_START;
						image1.data = linkCard;
						cardData[i].push(image1);
					}
				}
			}
		}
		
		/**
		 * 图标点击事件
		 * @param e
		 * 
		 */		
		private function onImageTouch(e:TouchEvent) : void
		{
			var image:Image = e.target as Image;
			var touch:Touch = e.getTouch(image);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				//点击第一个图标
				if(firstImage == null)
				{
					firstImage = image;
					firstImage.removeEventListener(TouchEvent.TOUCH, onImageTouch);
					addSelect();
					//firstImage.filter = BlurFilter.createGlow(0x0000ff);
				}
				//点击第二个图标
				else if(secondImage == null)
				{
					secondImage = image;
					//secondImage.filter = BlurFilter.createGlow(0x0000ff);
					//判断可以消除
					if(checkLink(firstImage, secondImage))
					{
						totalSoulExp += oneSoulExp;
						secondImage.removeEventListener(TouchEvent.TOUCH, onImageTouch);
						firstImage.data.isShow = false;
						secondImage.data.isShow = false;
						panel.removeChild(firstImage);
						panel.removeChild(secondImage);
						addLineEffect();
						addCardEffect();
						checkObstacle();
						showDigit();
						checkSelect();
						checkGameOver();
						//endTime += 5;
					}
					//不能消除
					else 
					{
						firstImage.addEventListener(TouchEvent.TOUCH, onImageTouch);
						//firstImage.filter = null;
						//secondImage.filter = null;
					}
					//还原参数
					firstImage = null;
					secondImage = null;
					removeSelect();
				}
			}
		}
		
		private function showDigit() : void
		{
			var txt:TextField = createDigit(oneSoulExp.toString());
			var tween:Tween = new Tween(txt, 1);
			tween.animate("y", txt.y - 40);
			tween.onComplete = removeTxt;
			tween.onCompleteArgs = [txt];
			Starling.juggler.add(tween);
		}
		
		private function removeTxt(txt:TextField) : void
		{
			if(txt.parent != null)
			{
				txt.parent.removeChild(txt);
			}
			txt.dispose();
			txt = null;
		}
		
		private function createDigit(str:String) : TextField
		{
			var showStr:String = "+" + str + "战魂";
			var tf:TextField;
			tf = new TextField(100, 30, showStr);			
			tf.color = 0x0000FF;
			tf.hAlign = HAlign.CENTER;
			tf.vAlign = VAlign.CENTER;
			tf.fontSize = 15;
			tf.kerning = true;
			panel.addChild(tf);
			tf.x = (firstImage.x + secondImage.x) / 2 - tf.width / 2 + ICON_WIDTH / 2;
			tf.y = (firstImage.y + secondImage.y) / 2;
			tf.fontName = FontManager.instance.font.fontName; 
			return tf;
		}
		
		private function addSelect() : void
		{
			_selectMC.play();
			_selectMC.x = firstImage.x - SELECTOFFSET;
			_selectMC.y = firstImage.y - SELECTOFFSET;
			panel.addChild(_selectMC);
		}
		
		private function removeSelect() : void
		{
			if(_selectMC.parent != null)
			{
				_selectMC.parent.removeChild(_selectMC);
				_selectMC.stop();
			}
		}
		
		/**
		 * 添加点击正确特效
		 * 
		 */		
		private function addCardEffect() : void
		{
			var frames:Vector.<Texture> = this.getTextures(BOMB, "effect")
			var bomb_1:MovieClip = new MovieClip(frames, 8);
			bomb_1.touchable = false;
			bomb_1.x = firstImage.x - BOMEOFFSET;
			bomb_1.y = firstImage.y - BOMEOFFSET;
			panel.addChild(bomb_1);
			
			var bomb_2:MovieClip = new MovieClip(frames, 8);
			bomb_2.touchable = false;
			bomb_2.x = secondImage.x - BOMEOFFSET;
			bomb_2.y = secondImage.y - BOMEOFFSET;
			panel.addChild(bomb_2);
			
			Starling.juggler.add(bomb_1);
			Starling.juggler.add(bomb_2);
			Starling.juggler.delayCall(onRemoveLine, 1, bomb_1);
			Starling.juggler.delayCall(onRemoveLine, 1, bomb_2);
		}
		
		/**
		 * 连线特效判断
		 * 
		 */		
		private function addLineEffect() : void
		{
			//直接连接
			if(_secondPoint != null && _firstPoint.x == firstImage.data.xPos && _firstPoint.y == firstImage.data.yPos && _secondPoint.x == secondImage.data.xPos && _secondPoint.y == secondImage.data.yPos)
			{
				addLine(_firstPoint, _secondPoint);
			}
			//一个拐弯
			else if(_secondPoint == null)
			{
				var point_1:Point = new Point(firstImage.data.xPos, firstImage.data.yPos);
				var point_2:Point = new Point(secondImage.data.xPos, secondImage.data.yPos);
				addLine(point_1, _firstPoint);
				addLine(point_2, _firstPoint);
				addCorner(_firstPoint, point_1, point_2);
			}
			//两个拐弯
			else
			{
				var point_3:Point = new Point(firstImage.data.xPos, firstImage.data.yPos);
				var point_4:Point = new Point(secondImage.data.xPos, secondImage.data.yPos);
				if(_firstPoint.x == point_3.x)
				{
					addLine(_firstPoint, point_3);
					addLine(_secondPoint, point_4);
					addCorner(_firstPoint, _secondPoint, point_3);
					addCorner(_secondPoint, _firstPoint, point_4);
				}
				else if(_firstPoint.x == point_4.x)
				{
					addLine(_firstPoint, point_4);
					addLine(_secondPoint, point_3);
					addCorner(_firstPoint, _secondPoint, point_4);
					addCorner(_secondPoint, _firstPoint, point_3);
				}
				if(_firstPoint.y == point_3.y)
				{
					addLine(_firstPoint, point_3);
					addLine(_secondPoint, point_4);
					addCorner(_firstPoint, _secondPoint, point_3);
					addCorner(_secondPoint, _firstPoint, point_4);
				}
				else if(_firstPoint.y == point_4.y)
				{
					addLine(_firstPoint, point_4);
					addLine(_secondPoint, point_3);
					addCorner(_firstPoint, _secondPoint, point_4);
					addCorner(_secondPoint, _firstPoint, point_3);
				}
				addLine(_firstPoint, _secondPoint);
				
			}
		}
		
		/**
		 * 添加转角特效
		 * @param a
		 * 
		 */		
		private function addCorner(a:Point, b:Point, c:Point) : void
		{
			var frames:Vector.<Texture> = this.getTextures(CORNER, "effect");
			var corner:MovieClip = new MovieClip(frames);
			corner.touchable = false;
			if((a.x < c.x && a.y < b.y) || (a.x < b.x && a.y < c.y))
			{
				corner.scaleX = -1;
				corner.x = (a.x + 1) * ICON_WIDTH + X_START + CORNEROFFSET;
				corner.y = a.y * ICON_HEIGHT + Y_START + CORNEROFFSET;
			}
			else if((a.x > b.x && a.y < c.y) || (a.x > c.x && a.y < b.y))
			{
				corner.x = a.x * ICON_WIDTH + X_START - CORNEROFFSET;
				corner.y = a.y * ICON_HEIGHT + Y_START + CORNEROFFSET;
			}
			else if((a.x > b.x && a.y > c.y) || (a.x > c.x && a.y > b.y))
			{
				corner.scaleY = -1
				corner.x = a.x * ICON_WIDTH + X_START - CORNEROFFSET;
				corner.y = (a.y + 1)* ICON_HEIGHT + Y_START - CORNEROFFSET;
			}
			//else if((a.x > c.x && a.y > b.y) || (a.x > b.x && a.y > c.y))
			else
			{
				corner.scaleX = -1;
				corner.scaleY = -1;
				corner.x = (a.x + 1) * ICON_WIDTH + X_START + CORNEROFFSET;
				corner.y = (a.y + 1) * ICON_HEIGHT + Y_START - CORNEROFFSET;
			}
			panel.addChild(corner);
			Starling.juggler.add(corner);
			Starling.juggler.delayCall(onRemoveLine, 1, corner);
		}
		
		/**
		 * 添加连接特效
		 * @param startPoint
		 * @param endPoint
		 * 
		 */		
		private function addLine(startPoint:Point, endPoint:Point) : void
		{
			var frames:Vector.<Texture> = this.getTextures(LIGHTNING, "effect")
			
			//添加水平特效
			if(startPoint.y == endPoint.y)
			{
				var x_start:int = startPoint.x < endPoint.x ? startPoint.x:endPoint.x;
				var x_end:int = startPoint.x < endPoint.x ? endPoint.x:startPoint.x;
				for(var i:int = x_start + 1; i < x_end; i++)
				{
					var _lightning:MovieClip = new MovieClip(frames);
					_lightning.touchable = false;
					_lightning.x = (i + 1) * ICON_WIDTH + X_START;
					if(firstImage.data.yPos > startPoint.y || secondImage.data.yPos > startPoint.y)
					{
						_lightning.scaleX = -1;
						_lightning.y = (startPoint.y + 1) * ICON_HEIGHT + Y_START;
					}
					else
					{
						_lightning.y = startPoint.y * ICON_HEIGHT + Y_START;
					}
					_lightning.rotation = Math.PI * .5;
					panel.addChild(_lightning);
					Starling.juggler.add(_lightning);
					Starling.juggler.delayCall(onRemoveLine, 1, _lightning);
				}
			}
			//添加垂直特效
			else if(startPoint.x == endPoint.x)
			{
				var y_start:int = startPoint.y < endPoint.y ? startPoint.y:endPoint.y;
				var y_end:int = startPoint.y < endPoint.y ? endPoint.y:startPoint.y;
				for(var j:int = y_start + 1; j < y_end; j++)
				{
					var _lightning1:MovieClip = new MovieClip(frames);
					_lightning1.touchable = false;
					_lightning1.y = j * ICON_HEIGHT + Y_START;
					if(firstImage.data.xPos > startPoint.x || secondImage.data.xPos > startPoint.x) 
					{
						_lightning1.scaleX = -1;
						_lightning1.x = (startPoint.x + 1)* ICON_WIDTH + X_START;
						
					}
					else
					{
						_lightning1.x = startPoint.x * ICON_WIDTH + X_START;
					}
					panel.addChild(_lightning1);
					Starling.juggler.add(_lightning1);
					Starling.juggler.delayCall(onRemoveLine, 1, _lightning1);
				}
			}
		}
		
		/**
		 * 特效播放结束删除自身
		 * @param ima
		 * 
		 */		
		private function onRemoveLine(ima:MovieClip) : void
		{
			ima.stop();
			if(ima.parent != null) ima.parent.removeChild(ima);
			ima.texture.dispose();
			ima.dispose();
			ima = null;
		}
		
		/**
		 * 判断是否可以消除
		 * @param getImage_1
		 * @param getImage_2
		 * @return 
		 * 
		 */		
		private function checkLink(getImage_1:Image, getImage_2:Image) : Boolean
		{
			if(getImage_1.data.type != getImage_2.data.type) return false;
			if(horizon(getImage_1, getImage_2))	return true;
			if(vertical(getImage_1, getImage_2)) return true;
			if(oneCorner(getImage_1, getImage_2)) return true;
			if(twoCorner(getImage_1, getImage_2)) return true;
			return false;
		}
		
		/**
		 * 水平
		 * @param a
		 * @param b
		 * @return 
		 * 
		 */		
		private function horizon(a:Image, b:Image) : Boolean
		{
			if(a.data.xPos == b.data.xPos || a.data.yPos != b.data.yPos) return false;
			var x_start:int = a.data.xPos < b.data.xPos ? a.data.xPos:b.data.xPos;
			var x_end:int = a.data.xPos < b.data.xPos ? b.data.xPos:a.data.xPos;
			for(var i:int = x_start + 1; i < x_end; i++)
			{
				if(cardData[i][a.data.yPos].data.isShow == true)	return false;
			}
			_firstPoint = new Point(a.data.xPos, a.data.yPos);
			_secondPoint = new Point(b.data.xPos, b.data.yPos);
			return true;
		}
		
		/**
		 * 垂直
		 * @param a
		 * @param b
		 * @return 
		 * 
		 */		
		private function vertical(a:Image, b:Image) : Boolean
		{
			if(a.data.yPos == b.data.yPos || a.data.xPos != b.data.xPos) return false;
			var y_start:int = a.data.yPos < b.data.yPos ? a.data.yPos:b.data.yPos;
			var y_end:int = a.data.yPos < b.data.yPos ? b.data.yPos:a.data.yPos;
			for(var i:int = y_start + 1; i < y_end; i++)
			{
				if(cardData[a.data.xPos][i].data.isShow == true)	return false;
			}
			_firstPoint = new Point(a.data.xPos, a.data.yPos);
			_secondPoint = new Point(b.data.xPos, b.data.yPos);
			return true;
		}
		
		/**
		 * 一个拐角
		 * @param a
		 * @param b
		 * @return 
		 * 
		 */		
		private function oneCorner(a:Image, b:Image) : Boolean
		{
			var c:Point = new Point(a.data.xPos, b.data.yPos);
			var d:Point = new Point(b.data.xPos, a.data.yPos);
			if(cardData[c.x][c.y].data.isShow == false)
			{
				var path1:Boolean = horizon(b, cardData[c.x][c.y]) && vertical(a, cardData[c.x][c.y]);
				_firstPoint = new Point(c.x, c.y);
				_secondPoint = null;
				return path1;
			}
			else if(cardData[d.x][d.y].data.isShow == false)
			{
				var path2:Boolean = horizon(a, cardData[d.x][d.y]) && vertical(b, cardData[d.x][d.y]);
				_firstPoint = new Point(d.x, d.y);
				_secondPoint = null;
				return path2;
			}
			else
			{
				return false;
			}
			
		}
		
		/**
		 * 两个拐角
		 * @param a
		 * @param b
		 * @return 
		 * 
		 */		
		private function twoCorner(a:Image, b:Image) : Boolean
		{
			var a_xPos:Vector.<Image> = new Vector.<Image>();
			a_xPos = getXPos(a);
			var b_xPos:Vector.<Image> = new Vector.<Image>();
			b_xPos = getXPos(b);
			for(var i:int = 0; i < a_xPos.length; i++)
			{
				for(var j:int = 0; j < b_xPos.length; j++)
				{
					if(a_xPos[i].data.yPos == b_xPos[j].data.yPos)
					{
						if(horizon(a_xPos[i], b_xPos[j]))	
						{
							_firstPoint = new Point(a_xPos[i].data.xPos, a_xPos[i].data.yPos);
							_secondPoint = new Point(b_xPos[j].data.xPos, b_xPos[j].data.yPos);
							return true;
						}
					}
				}
			}
			
			var a_yPos:Vector.<Image> = new Vector.<Image>();
			a_yPos = getYPos(a);
			var b_yPos:Vector.<Image> = new Vector.<Image>();
			b_yPos = getYPos(b);
			for(var m:int = 0; m < a_yPos.length; m++)
			{
				for(var n:int = 0; n < b_yPos.length; n++)
				{
					if(a_yPos[m].data.xPos == b_yPos[n].data.xPos)
					{
						if(vertical(a_yPos[m], b_yPos[n])) 
						{
							_firstPoint = new Point(a_yPos[m].data.xPos, a_yPos[m].data.yPos);
							_secondPoint = new Point(b_yPos[n].data.xPos, b_yPos[n].data.yPos);
							return true;
						}
					}
				}
			}
			return false;
		}
		
		/**
		 * 获得纵向的点
		 * @param a
		 * @return 
		 * 
		 */		
		private function getXPos(a:Image) : Vector.<Image>
		{
			var xPos:Vector.<Image> = new Vector.<Image>();
			for(var i:int = a.data.yPos + 1; i < Y_MAX; i++)
			{
				if(!cardData[a.data.xPos][i].data.isShow) xPos.push(cardData[a.data.xPos][i]);
				else break;
			}
			for(var j:int = a.data.yPos - 1; j >= 0; j--)
			{
				if(!cardData[a.data.xPos][j].data.isShow) xPos.push(cardData[a.data.xPos][j]);
				else break;
			}
			return xPos;
		}
		
		/**
		 * 获得横向的点
		 * @param a
		 * @return 
		 * 
		 */		
		private function getYPos(a:Image) : Vector.<Image>
		{
			var yPos:Vector.<Image> = new Vector.<Image>();
			for(var i:int = a.data.xPos + 1; i < X_MAX; i++)
			{
				if(!cardData[i][a.data.yPos].data.isShow) yPos.push(cardData[i][a.data.yPos]);
				else break;
			}
			for(var j:int = a.data.xPos - 1; j >= 0; j--)
			{
				if(!cardData[j][a.data.yPos].data.isShow) yPos.push(cardData[j][a.data.yPos]);
				else break;
			}
			return yPos;
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			switch (e.target.name)
			{
				//提示
				case "TipBtn":
					onSearch();
					break;
				//重置
				case "ResetBtn":
					handResetCard();
					break;
			}
		}
		
		/**
		 * 手动重新排列图标
		 * 
		 */		
		private function handResetCard() : void
		{
			if(resetCount <= 0 || endTime <= 0) return;
			resetCount--;
			_resetTime.text = resetCount.toString();
			resetCard();
			if(_selectCount.length == 0) return;
			_select_1.stop();
			if(_select_1.parent != null) _select_1.parent.removeChild(_select_1);
			_select_2.stop();
			if(_select_2.parent != null) _select_2.parent.removeChild(_select_2);
			_selectCount = new Vector.<Image>();
			
		}
		
		/**
		 * 自动查找配对
		 * 
		 */		
		private function onSearch() : void
		{
			if(tipCount <=0 || endTime <= 0) return;
			tipCount--;
			_tipTime.text = tipCount.toString();
			var search:Vector.<Image> = new Vector.<Image>();
			var isFind:Boolean = false;
			for(var i:int = 0; i < cardData.length; i++)
			{
				for(var j:int = 0; j < cardData[j].length; j++)
				{
					search.push(cardData[i][j]);
				}
			}
			for(var m:int = 0; m < search.length; m++)
			{
				for(var n:int = m; n < search.length; n++)
				{
					if(checkLink(search[m], search[n]) && search[m].data.isShow && search[n].data.isShow)
					{
						_select_1.play();
						_select_1.x = search[m].x - SELECTOFFSET;
						_select_1.y = search[m].y - SELECTOFFSET;
						panel.addChild(_select_1);
						
						_select_2.play();
						_select_2.x = search[n].x - SELECTOFFSET;
						_select_2.y = search[n].y - SELECTOFFSET;
						panel.addChild(_select_2);
						
						search[m].alpha = .5;
						search[n].alpha = .5;
						
						_selectCount[0] = search[m];
						_selectCount[1] = search[n];
						
						isFind = true;
						break;
					}
					if(isFind) break;
				}
			}
		}
		
		/**
		 * 检测提示的图标是否消除
		 * 
		 */		
		private function checkSelect() : void
		{
			if(_selectCount.length == 0) return;
			if(firstImage == _selectCount[0] || firstImage == _selectCount[1] || secondImage == _selectCount[0] || secondImage == _selectCount[1])
			{
				_selectCount[0].alpha = 1;
				_selectCount[1].alpha = 1;
				_select_1.stop();
				if(_select_1.parent != null) _select_1.parent.removeChild(_select_1);
				_select_2.stop();
				if(_select_2.parent != null) _select_2.parent.removeChild(_select_2);
				_selectCount = new Vector.<Image>();
			}
		}
		
		/**
		 * 检测是否可以继续游戏
		 * 
		 */		
		private function checkObstacle() : void
		{
			var search:Vector.<Image> = new Vector.<Image>();
			var isFind:Boolean = false;
			for(var i:int = 0; i < cardData.length; i++)
			{
				for(var j:int = 0; j < cardData[j].length; j++)
				{
					search.push(cardData[i][j]);
				}
			}
			for(var m:int = 0; m < search.length; m++)
			{
				for(var n:int = m; n < search.length; n++)
				{
					if(checkLink(search[m], search[n]) && search[m].data.isShow && search[n].data.isShow)
					{
						isFind = true;
						break;
					}
					if(isFind) break;
				}
			}
			//没有可以配对的图标，重新排列图标
			if(!isFind)		resetCard();
		}
		
		/**
		 * 检测是否已完成所有的配对
		 * 
		 */		
		private function checkGameOver() : void
		{
			var gameOverTOF:Boolean = true;
			for(var i:int = 0; i < cardData.length; i++)
			{
				for(var j:int = 0; j < cardData[j].length; j++)
				{
					if(cardData[i][j].data.isShow) 
					{
						gameOverTOF = false;
						break;
					}
				}
				if(!gameOverTOF) break;
			}
			//已所有配对成功
			if(gameOverTOF) gameOver();
		}
		
		/**
		 * 无法继续游戏时，重新设置排列顺序
		 * 
		 */		
		private function resetCard() : void
		{
			var resetCard:Vector.<Image> = new Vector.<Image>();
			//获得还未消除的图标
			for(var i:int = 0; i < cardData.length; i++)
			{
				for(var j:int = 0; j < cardData[j].length; j++)
				{
					if(cardData[i][j].data.isShow)
					{
						resetCard.push(cardData[i][j]);
					}
				}
			}
			var resetData:Vector.<String> = new Vector.<String>();
			//重新设置图标排列顺序
			for(var k:int = 0; k < resetCard.length / 2; k++)
			{
				var random:int = Math.floor(Math.random() * 37 + 1);
				var str:String = "skill_" + random;
				resetData.push(str);
				resetData.push(str);
			}
			//修改图标显示和内容
			for(var m:int = 0; m < resetCard.length; m++)
			{
				var randomNum:int = Math.floor(Math.random() * resetData.length);
				resetCard[m].data.type = resetData[randomNum];
				resetCard[m].texture = _view.icon.interfaces(InterfaceTypes.GetTexture, resetCard[m].data.type);
				resetCard[m].alpha = 1;
				resetData.splice(randomNum, 1);
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.pluginGame.interfaces(InterfaceTypes.GetTextures, name);
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
				texture = _view.pluginGame.interfaces(InterfaceTypes.GetTexture, name);
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
		
		override public function close() : void
		{
			_titleTxAtlas.dispose();
			_titleTxAtlas = null;
			
			for(var i:int = 0; i < cardData.length; i++)
			{
				for(var j:int = 0; j < cardData[j].length; j++)
				{
					cardData[i][j].texture.dispose()
					cardData[i][j].dispose();
					cardData[i][j] = null;
				}
			}
			
			_coldDownDigit.texture.dispose();
			_coldDownDigit.dispose();
			_coldDownDigit = null;
			
			_selectMC.texture.dispose();
			_selectMC.dispose();
			_selectMC = null;
			
			_select_1.texture.dispose();
			_select_1.dispose();
			_select_1 = null;
			
			_select_2.texture.dispose();
			_select_2.dispose();
			_select_2 = null;
			
			super.close();
		}
		
		
	}
}
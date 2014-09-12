package com.game.view.playerFight
{
	import com.engine.ui.controls.IGrid;
	import com.game.Data;
	import com.game.View;
	import com.game.data.player.structure.RoleModel;
	import com.game.manager.DebugManager;
	import com.game.manager.FontManager;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.equip.RoleTip;
	import com.game.view.ui.UIConfig;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class PlayerFightItemRender extends Sprite implements IGrid
	{
		private var _image:Image;
		
		private var _view:View = View.instance;
		
		public function PlayerFightItemRender()
		{
		}
		
		private var _roleBg:Image;
		private var _roleLvBg:Image;
		private var _roleType:Image;
		private var _roleGrade:Image;
		private var _glass:Image;
		private var _roleNameTF:TextField;
		private var _roleLvTF:TextField;
		private var _roleRankNumTF:TextField;
		private var _roleFightingTF:TextField;
		private var _roleData:Object;
		private var _roleLv:int;
		public function setData(data:*) : void
		{
			_roleData = data as Object;
			var roleInfo:Array = data.extra.split("|");
			var roleName:String = (roleInfo.length >= 2?roleInfo[1]:"韦小宝");
			_roleLv = (roleInfo.length >= 1?int(roleInfo[0]):1);
			
			var lastRoleName:String = roleName;
			if(roleName.indexOf("（") != -1) lastRoleName = roleName.substring(0, roleName.indexOf("（"));
			
			var roleImageName:String = "RoleImage_Rect_" + lastRoleName;
			var texture:Texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, roleImageName);
			
			if(!_roleBg)
			{
				var textureBg:Texture = _view.player_fight.titleTxAtlas.getTexture("RoleImageBg");
				_roleBg = new Image(textureBg);
				_roleBg.x = -8;
				_roleBg.y = -8;
				addChild(_roleBg);
			}
			
			if (!_image)
			{
				_image = new Image(texture);
				_image.useHandCursor = true;
				addChild(_image);
				_image.addEventListener(TouchEvent.TOUCH, onTouch);
			}
			
			
			_image.width = _image.height = 68;
			_image.texture = texture;
			_image.readjustSize();
			
			checkType(roleName);
			checkGrade(roleName);
			
			if(!_glass)
			{
				var glassTexture:Texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "Glass");
				_glass = new Image(glassTexture);
				_glass.touchable = false;
				_glass.x = 2;
				_glass.y = 1;
				addChild(_glass);
			}
			
			if(!_roleLvBg)
			{
				var textureLv:Texture = _view.player_fight.titleTxAtlas.getTexture("RankNumBg");
				_roleLvBg = new Image(textureLv);
				_roleLvBg.x = 7;
				_roleLvBg.y = 60;
				addChild(_roleLvBg);
			}
			
			if(!_roleRankNumTF)
			{
				_roleRankNumTF = addText(7, 58, 52, 22, 0xFFFFFF);
				addChild(_roleRankNumTF);
			}
			
			if(!_roleFightingTF)
			{
				_roleFightingTF = addText(-8, -25, 80, 22, 0xFF0000);
				addChild(_roleFightingTF);
			}
			
			if(!_roleNameTF)
			{
				_roleNameTF = addText(-15, 80, 100, 22, 0x85300C);
				addChild(_roleNameTF);
			}
			
			if(!_roleLvTF)
			{
				_roleLvTF = addText(0, 100, 70, 22, 0xFF0000);
				addChild(_roleLvTF);
			}
			
			_roleNameTF.text = _roleData.userName;
			_roleRankNumTF.text = _roleData.rank.toString();
			_roleFightingTF.text = "战力：" + _roleData.extra.split("|")[2];
			_roleLvTF.text = "等级" + _roleLv;
		}
		
		public function addText(xPos:int, yPos:int, wid:int, hei:int, color:uint) : TextField
		{
			var tf:TextField = new TextField(wid, hei, "");			
			tf.color = color;
			tf.hAlign = HAlign.CENTER;
			tf.vAlign = VAlign.CENTER;
			tf.fontSize = 15;
			tf.kerning = true;
			tf.autoScale = true;
			tf.x = xPos;
			tf.y = yPos;
			tf.fontName = FontManager.instance.font.fontName; 
			
			return tf;
		}
		
		/**
		 * 检测角色类型
		 * @param name
		 * 
		 */		
		private function checkType(name:String) : void
		{
			if(_roleType) return;
			var texture:Texture;
			if(name.indexOf(V.NIGHT_TYPE) != -1)
			{
				texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "RoleImage_Rect_Night");
				_roleType = new Image(texture);
				_roleType.visible = true;
			}
			else if(name.indexOf(V.RAIN_TYPE) != -1)
			{
				texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "RoleImage_Rect_Rain");
				_roleType = new Image(texture);
				_roleType.visible = true;
			}
			else if(name.indexOf(V.THUNDER_TYPE) != -1)
			{
				texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "RoleImage_Rect_Thunder");
				_roleType = new Image(texture);
				_roleType.visible = true;
			}
			else if(name.indexOf(V.WIND_TYPE) != -1)
			{
				texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "RoleImage_Rect_Wind");
				_roleType = new Image(texture);
				_roleType.visible = true;
			}
			else 
			{
				texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "RoleImage_Rect_Night");
				_roleType = new Image(texture);
				_roleType.visible = false;
			}
			_roleType.touchable = false;
			_roleType.x = -7;
			_roleType.y = -5;
			addChild(_roleType);
		}
		
		/**
		 * 检测角色品质
		 * 
		 */		
		private function checkGrade(name:String) : void
		{
			if(_roleGrade) return;
			var grade:String = Data.instance.db.interfaces(InterfaceTypes.GET_GRADE_BY_NAME, name);
			var textureName:String = "";
			switch(grade)
			{
				case "极":
					textureName = "RoleGrade_Ji";
					break;
				case "甲+":
					textureName = "RoleGrade_JiaJia";
					break;
				case "甲":
					textureName = "RoleGrade_Jia";
					break;
				case "乙":
					textureName = "RoleGrade_Yi";
					break;
				case "丙":
					textureName = "RoleGrade_Bing";
					break;
				case "丁":
					textureName = "RoleGrade_Ding";
					break;
			}
			var texture:Texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, textureName);
			_roleGrade = new Image(texture);
			_roleGrade.touchable = false;
			_roleGrade.x = 35;
			addChild(_roleGrade);
		}
		
		private function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_image);
			
			if (touch && touch.phase == TouchPhase.ENDED)
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"是否要挑战该玩家？",
					comfireFight, null, false);
					
			}
		}
		
		private function comfireFight() : void
		{
			if(DebugManager.instance.gameMode == V.DEVELOP)
			{
				var enemyDataConfig:XML = Data.instance.res.getAssetsData(V.LOAD, V.LOAD, "PlayerData.xml") as XML;
				_view.player_fight.hide();
				Data.instance.playerKillingPlayer.parseData(enemyDataConfig, _roleData.userName, _roleData.rank, _roleData.uId);
			}
			else
			{
				_view.player_fight.rivalScore = int(_roleData.score);
				_view.loadData.loadDataPlay();
				Data.instance.rank.callback = loadOver;
				Data.instance.rank.getUserData(_roleData.uId, _roleData.index);
			}
		}
		
		private function loadOver(data:Object, isSuccess:Boolean = true) : void
		{
			_view.loadData.hide();
			if(!isSuccess) 
			{
				_view.tip.interfaces(InterfaceTypes.Show,
					"该玩家数据异常，无法挑战！",
					null, null, false, true, false);
			}
			else
			{
				_view.player_fight.hide();
				Data.instance.playerKillingPlayer.parseData(XML(data.data), _roleData.userName, _roleData.rank, _roleData.uId);
			}
		}
		
		public function clear() : void
		{
			if(_image) _image.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
	}
}
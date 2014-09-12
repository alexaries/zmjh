package com.game.view.AppendAttribute
{
	import com.engine.ui.controls.TipTextField;
	import com.engine.ui.core.BaseSprite;
	import com.engine.ui.core.Scale9Image;
	import com.engine.ui.core.Scale9Textures;
	
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import starling.utils.HAlign;

	public class AppendAttributeTip extends BaseSprite
	{
		private var _data:Object;
		
		private var _bg:Scale9Image;
		private var _line:Image;
		private var _fightSoul:Image;
		
		private static const LEFT_GAP:Number=11;
		private static const TEXT_VGAP:Number=-1;
		
		public function AppendAttributeTip()
		{
		}
		
		private var _bgTexture:Texture;
		private var _fightSoulTx:Texture;
		private var _lineTexture:Texture;
		public function init(bgTexture:Texture, fightSoulTx:Texture, line:Texture) : void
		{
			_bgTexture = bgTexture;
			_fightSoulTx = fightSoulTx;
			_lineTexture = line;
			
			initUI();
			initEvent();
		}
		
		private var _nameTxt:TipTextField;
		private var _content:TipTextField;
		private var _upgrade:TipTextField;
		//private var _upgrade_role_lv:TipTextField;
		private var _upgrade_fight_soul:TipTextField;
		private function initUI() : void
		{
			// 底图
			var textures:Scale9Textures = new Scale9Textures(_bgTexture, new Rectangle(20, 20, 50, 50));
			_bg = new Scale9Image(textures);
			_bg.alpha = 0.8;
			_bg.width = 140;
			this.addChild(_bg);
			
			// 名称
			_nameTxt = createTextField(132, 19, 0x66CC33, "", 15);
			_nameTxt.x = LEFT_GAP;
			_nameTxt.y = 10;
			this.addChild(_nameTxt);
			
			// 每级增加
			_content = createTextField(132);
			_content.x = LEFT_GAP;
			_content.y = 10;
			this.addChild(_content);
			
			// 分割线
			_line=new Image(_lineTexture);
			_line.width = 120
			addChild(_line);
			_line.x=_bg.width/2-_line.width/2;
			
			// 升级需求 主角等级
			_upgrade = createTextField(132);
			_upgrade.color = 0xFF9900;
			_upgrade.x = LEFT_GAP;
			_upgrade.y = 10;
			this.addChild(_upgrade);
			
			// 升级所需主角等级
			/*
			_upgrade_role_lv = createTextField(132);
			_upgrade_role_lv.color = 0xFF9900;
			_upgrade_role_lv.x = LEFT_GAP;
			_upgrade_role_lv.y = 10;
			this.addChild(_upgrade_role_lv);*/
			
			// 战魂图标
			_fightSoul = new Image(_fightSoulTx);
			_fightSoul.width = 22;
			_fightSoul.height = 24;
			_fightSoul.x = LEFT_GAP;
			this.addChild(_fightSoul);
			
			// 战魂值
			_upgrade_fight_soul = createTextField();
			_upgrade_fight_soul.color = 0x66CC33;
			this.addChild(_upgrade_fight_soul);
		}
		
		public function setData(data:Object) : void
		{
			_data = data;
			
			initRender();
		}
		
		private function initRender() : void
		{
			_nameTxt.text = _data["name"];
			_content.text = _data["content"];
			_upgrade.text = "升级需求:" + _data["role"];
			_upgrade_fight_soul.text = _data["fightSoul"];
			
			resetPosition();
		}
		
		private function resetPosition() : void
		{
			_nameTxt.y = 10;
			
			_content.y = _nameTxt.y + _nameTxt.height + TEXT_VGAP;
			
			_line.y = _content.y + _content.height + 4;
			
			_upgrade.y = _line.y + _line.height + TEXT_VGAP +　2;
			
			//_upgrade_role_lv.y = _upgrade.y + _upgrade.height + TEXT_VGAP;
			
			_fightSoul.y = _upgrade.y + _upgrade.height + TEXT_VGAP;
			
			_upgrade_fight_soul.y = _fightSoul.y + 4;
			_upgrade_fight_soul.x = _fightSoul.x + _fightSoul.width + 4;
			
			_bg.height = _fightSoul.y + _fightSoul.height + 4;
		}
		
		private function initEvent() : void
		{
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this);
			
			if (!touch)
			{
				hide();
			}
		}
		
		protected function createTextField(W:int=90, H:int=19, Col:Number=0Xffffff, Str:String='', Size:uint=12, HAl:String=HAlign.LEFT, Auto:Boolean=true, Wor:Boolean=true) : TipTextField
		{
			var mytext:TipTextField=new TipTextField(W,H,Str);
			mytext.color=Col;
			mytext.fontSize=Size;
			mytext.hAlign=HAl;
			return mytext;
		}
		
		public function hide():void
		{
			if (this.parent) this.parent.removeChild(this);
		}
	}
}
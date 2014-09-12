package com.game.view.equip
{
	import com.engine.ui.controls.TipTextField;
	import com.engine.ui.core.BaseSprite;
	import com.engine.ui.core.Scale9Image;
	import com.engine.ui.core.Scale9Textures;
	import com.game.View;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.GameConfig;
	import com.game.view.icon.PropIcon;
	import com.game.view.icon.PropNoramlIcon;
	
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.HAlign;

	public class PropTip extends BaseSprite
	{
		private var _bg:Scale9Image;
		private var _line:Image;
		private var _money:Image;
		private static const LEFT_GAP:Number=11;
		private static const TXT2_X:Number=45;
		private static const TEXT_VGAP:Number=-1;
		private var _view:View = View.instance;
		private static const TEXT_HGAP:Number=4;
		private var _data:Object;
		private var _bgTexture:Texture;
		private var _moneyTexture:Texture;
		private var _lineTexture:Texture;
		
		private var _nameTxt:TipTextField;
		private var _messageTxt:TipTextField;
		private var _dispArr:Array;
		private var _mssages:Array;
		
		private var _propIconList:Vector.<PropIcon>;
		
		public function get data() : Object
		{
			return _data;
		}
		
		public function PropTip()
		{
			_dispArr=[];
			_mssages=[];
			_propIconList = new Vector.<PropIcon>();
		}
		
		public function add(obj:Object):void
		{
			_propIconList.push(new  PropIcon(obj,this));
		}
		
		public function removeProp(name:String) : void
		{
			for each(var item:PropIcon in _propIconList)
			{
				if(item.mssage.name == name)
				{
					 var propIcon:PropIcon = item;
					 _propIconList.splice(_propIconList.indexOf(item), 1);
					 propIcon.removeAll();
					 propIcon = null;
				}
			}
			//trace(_propIconList.length);
		}
		
		public function removePropByName(obj:Object) : void
		{
			var len:int = _propIconList.length;
			for(var i:int = len - 1; i >= 0; i--)
			{
				if(_propIconList[i].obj == obj)
				{
					_propIconList[i].removeOnly();
					_propIconList[i] = null;
					_propIconList.splice(i, 1);
				}
			}
			//trace(_propIconList.length);
		}
		
		public function add2(obj:Object):void
		{
			new  PropNoramlIcon(obj,this);
		}
	
		
		public function init(bgTexture:Texture, moneyTx:Texture, line:Texture) : void
		{
			_bgTexture = bgTexture;
			_moneyTexture = moneyTx;
			_lineTexture = line;
			
			initUi();
			initEvent();
		}
	
 
		private function initUi() : void
		{
			// 底图
			var textures:Scale9Textures = new Scale9Textures(_bgTexture, new Rectangle(20, 20, 50, 50));
			_bg = new Scale9Image(textures);
			_bg.alpha = 0.8;
			_bg.width = 154;
			this.addChild(_bg);
			
			//名称
			_nameTxt = createTextField(150,19,0x66CC33,"",15);
			_nameTxt.x = LEFT_GAP
			_nameTxt.y = 10;
			this.addChild(_nameTxt);
			
			// 介绍
			_messageTxt = createTextField(132);
			_messageTxt.x = LEFT_GAP
			_messageTxt.y = 10;
			this.addChild(_messageTxt);
			 
			
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
		
		public function setData(data:Object) : void
		{
			//trace(data.mid, data.config.name);
			
			_data = data;
			
			initRender();
		}
		
		public function setData2(data:Object) : void
		{
			//trace(data.mid, data.config.name);
			
			_data = data;
			
			
			_nameTxt.text =""
			_messageTxt.text=String(_data);
			resetCompose();
		}
		
		private function initRender() : void
		{
			//var equipmentImageName:String = "equip_" + _data.config.id;
			//_skillImage.texture = _view.equip.interfaces(InterfaceTypes.GetTexture, equipmentImageName);
			
			_nameTxt.text = _data.name;
			 _messageTxt.text=_data.message;
			resetCompose();
		}
		
		private function resetCompose() : void
		{
			_nameTxt.y = 10;
			if(_nameTxt.text!="")
			{
				_messageTxt.y = _nameTxt.y +_nameTxt.height+TEXT_VGAP;
			}else
			{
				_messageTxt.y=10;
			}
			
			_bg.height = _messageTxt.y + _messageTxt.height +10
		}
		
 
		
		protected function createTextField(W:int=90, H:int=19, Col:Number=0Xffffff, Str:String='', Size:uint=12, HAl:String=HAlign.LEFT, Auto:Boolean=true, Wor:Boolean=true) : TipTextField
		{
			var mytext:TipTextField=new TipTextField(W,H,Str);
			mytext.color=Col;
			//mytext.fontName = FontManager.instance.font.fontName;
			mytext.fontSize=Size;
			mytext.hAlign=HAl;
			return mytext;
		}
		
		public function hide():void
		{
			if (this.parent) this.parent.removeChild(this);
		}
		
		override public function set x(value:Number):void
		{
			// TODO Auto Generated method stub
			if(value+this.width>GameConfig.CAMERA_WIDTH)
			{
				value=GameConfig.CAMERA_WIDTH-this.width-4;
			}
			super.x = value;
		}
		
		override public function set y(value:Number):void
		{
			if(value+this.height>GameConfig.CAMERA_HEIGHT)
			{
				value=GameConfig.CAMERA_HEIGHT-this.height-4;
			}
			super.y = value;
		}
		
		
		
	}
}
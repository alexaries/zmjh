package com.game.view.upgrade
{
	import com.game.Data;
	import com.game.data.db.protocal.Title;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.map.player.PlayerStatus;
	
	import flash.utils.ByteArray;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.VAlign;

	public class TitleDetailComponent extends Component
	{
		public function TitleDetailComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			init();
		}
		
		override protected function init() : void
		{
			super.init();
			getUI();
			initEvent();
		}
		
		private var _titleAddDetailTF:TextField;
		private var _conditionTF:TextField;
		private function getUI():void
		{
			_titleAddDetailTF = this.searchOf("AddProperty");
			_conditionTF = this.searchOf("GetConditionDetail");
			_conditionTF.vAlign = VAlign.TOP;
			_titleAddDetailTF.vAlign = VAlign.TOP;
			
			createTitleShow();
		}
		
		private function createTitleShow() : void
		{
			if(_titleShow != null) return ;
			var frames:Vector.<Texture> = _view.other_effect.interfaces(InterfaceTypes.GetTextures, V.ROLE_TITLE["花好月圆"]);
			_titleShow = new MovieClip(frames);
			_titleShow.x = 25;
			_titleShow.y = -17;
			_titleShow.play();
			this.panel.addChild(_titleShow);
			Starling.juggler.add(_titleShow);
		}
		
		private var _titleData:Title;
		private var _titleShow:MovieClip;
		public function setData(titleData:Object) : void
		{
			_titleData = titleData as Title;
			_conditionTF.text = _titleData.info;
			analysisData();
			analysisTitle();
			analysisRole();
		}
		
		private var mp:MovieClip;
		private function analysisRole():void
		{
			if(mp != null)
			{
				mp.stop();
				mp.removeFromParent(true);
				Starling.juggler.remove(mp);
			}
			var type:uint = 0;
			var frames:Vector.<Texture>;
			if(Data.instance.player.player.mainRoleModel.nowUseFashion == "")	
				frames = textureAtlas.getTextures(PlayerStatus.ZMDJ);
			else 
			{
				frames = newTextureAtlas.getTextures(PlayerStatus.ZMDJ);
				type = 1;
			}
			mp = new MovieClip(frames, 10);
			mp.addFrame(frames[3]);
			mp.addFrame(frames[2]);
			mp.addFrame(frames[1]);
			mp.x = 50 + mp.width * .5 - type * 15;
			mp.y = 50;
			mp.pivotX = mp.width * .5;
			mp.scaleX = .8;
			mp.scaleY = .8;
			mp.play();
			this.panel.addChild(mp);
			Starling.juggler.add(mp);
		}
		
		private function analysisTitle():void
		{
			if(_titleShow != null)
			{
				_titleShow.stop();
				_titleShow.removeFromParent(true);
				Starling.juggler.remove(_titleShow);
			}
			var frames:Vector.<Texture> = _view.other_effect.interfaces(InterfaceTypes.GetTextures, V.ROLE_TITLE[_titleData.name]);
			_titleShow = new MovieClip(frames);
			if(_titleData.name == V.ROLE_NAME[1])
			{
				_titleShow.x = 186 - _titleShow.width * .5 + 4;
				_titleShow.y = 60 - _titleShow.height * .5 + 5;
			}
			else
			{
				_titleShow.x = 186 - _titleShow.width * .5;
				_titleShow.y = 60 - _titleShow.height * .5;
			}
			_titleShow.pivotX = _titleShow.width * .5;
			_titleShow.pivotY = _titleShow.height * .5;
			_titleShow.play();
			this.panel.addChild(_titleShow);
			Starling.juggler.add(_titleShow);
		}
		
		private function analysisData():void
		{
			var str:String = "";
			if(_titleData.hp != 0)
				str += "体力	基础属性+" + int(_titleData.hp * 100) + "%\n";
			if(_titleData.mp != 0)
				str += "元气	基础属性+" + int(_titleData.mp * 100) + "%\n";
			if(_titleData.atk != 0)
				str += "外功	基础属性+" + int(_titleData.atk * 100) + "%\n";
			if(_titleData.def != 0)
				str += "根骨	基础属性+" + int(_titleData.def * 100) + "%\n";
			if(_titleData.spd != 0)
				str += "步法	基础属性+" + int(_titleData.spd * 100) + "%\n";
			
			if(_titleData.hp == _titleData.mp && _titleData.mp == _titleData.atk && _titleData.atk == _titleData.def && _titleData.def == _titleData.spd)
			{
				str = "全属性	基础属性+" + int(_titleData.hp * 100) + "%\n";
			}
			
			if(_titleData.special != "无")
				str += _titleData.special;
			
			_titleAddDetailTF.text = str;
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
		
		/**
		 * 纹理 
		 * @return 
		 * 
		 */
		private var _sTextureAtlas:TextureAtlas;
		private function get textureAtlas() : TextureAtlas
		{
			if (!_sTextureAtlas)
			{
				var ba:ByteArray = _view.res.getAssetsObject(V.PUBLIC, V.PLAYER, GameConfig.PLAYER_RES, "Textures") as ByteArray;
				var texture:Texture = Texture.fromAtfData(ba);	
				var xml:XML = getXMLDataNow(V.PLAYER, GameConfig.PLAYER_RES, "Player") as XML;			
				_sTextureAtlas = new TextureAtlas(texture, xml);
				/*ba.clear();
				ba = null;*/
			}
			
			return _sTextureAtlas;
		}
		
		private var _newTextureAtlas:TextureAtlas;
		private function get newTextureAtlas() : TextureAtlas
		{
			if (!_newTextureAtlas)
			{	
				var ba:ByteArray = _view.res.getAssetsObject(V.PUBLIC, V.PLAYER_NEW, GameConfig.PLAYER_NEW_RES, "Textures") as ByteArray;
				var texture:Texture = Texture.fromAtfData(ba);
				var xml:XML = getXMLDataNow(V.PLAYER_NEW, GameConfig.PLAYER_NEW_RES, "PlayerNew") as XML;			
				_newTextureAtlas = new TextureAtlas(texture, xml);
				/*ba.clear();
				ba = null;*/
			}
			
			return _newTextureAtlas;
		}
		
		protected function getXMLDataNow(ModelName:String, SWFName:String, fileName:String) : XML
		{
			var xmlData:XML;
			var bytes:ByteArray = _view.res.getAssetsObject(V.PUBLIC, ModelName, SWFName, fileName) as ByteArray;
			xmlData = XML(bytes.toString());
			
			return xmlData;
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new TitleDetailComponent(_configXML, _titleTxAtlas);
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			super.destroy();
		}
	}
}
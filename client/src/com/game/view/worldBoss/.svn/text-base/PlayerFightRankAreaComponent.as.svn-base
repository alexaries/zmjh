package com.game.view.worldBoss
{
	import com.game.template.InterfaceTypes;
	import com.game.view.Component;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class PlayerFightRankAreaComponent extends Component
	{
		public function PlayerFightRankAreaComponent(item:XML, titleTxAtlas:TextureAtlas)
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
		
		private var _playerRank:TextField;
		private var _playerName:TextField;
		private var _playerLevel:TextField;
		private var _playerHurt:TextField;
		private var _itemBg:Image;
		private function getUI() : void
		{
			_playerRank = this.searchOf("PlayerRank");
			_playerName = this.searchOf("PlayerName");
			_playerLevel = this.searchOf("PlayerLevel");
			_playerHurt = this.searchOf("PlayerHurt");
			_itemBg = this.searchOf("FightCountArea");
		}
		
		override public function setGridData(data:*) : void
		{
			_playerRank.text = data.rank;
			_playerName.text = data.userName;
			_playerLevel.text = (data.extra.toString()).split("|")[0];
			_playerHurt.text = (data.extra.toString()).split("|")[2];
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
		
		
		public function clearOwn() : void
		{
			_playerRank.dispose();
			_playerName.dispose();
			_playerLevel.dispose();
			_playerHurt.dispose();
			_itemBg.texture.dispose();
			_itemBg.dispose();
			if(panel.parent) panel.parent.removeChild(panel);
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new PlayerFightRankAreaComponent(_configXML, _titleTxAtlas);
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
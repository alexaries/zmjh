package com.game.view.talk
{
	import com.engine.core.Log;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.dialog.Word;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.VAlign;

	public class LeftTalkComponent extends Component
	{
		public function LeftTalkComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
		}
		
		private var _contentTF:TextField;
		private var _roleName:TextField;
		private var _roleImage:Image;
		private function getUI() : void
		{
			_contentTF = this.searchOf("Tx_Talk");
			_contentTF.fontSize = 17;
			_contentTF.kerning = true;
			_roleName = this.searchOf("Tx_Name");
			_roleImage = this.searchOf("RoleImage");
		}
		
		private var _curWord:Word;
		public function start(wordData:Word) : void
		{
			if (!_curWord || _curWord.name != wordData.name)
			{
				var roleFileName:String;
				if(wordData.name == V.MAIN_ROLE_NAME.split("（")[0])
					roleFileName = player.returnNowFashion("RoleImage_Big_", wordData.name);
				else
					roleFileName = "RoleImage_Big_" + wordData.name;
				
				var texture:Texture = _view.role_big.interfaces(InterfaceTypes.GetTexture, roleFileName);
				_roleImage.texture = texture;
				_roleImage.readjustSize();
				_roleImage.width = _roleImage.texture.width * V.ROLE_SCALE;
				_roleImage.height = _roleImage.texture.height * V.ROLE_SCALE;
				_roleImage.pivotX = _roleImage.pX * _roleImage.texture.width;
				_roleImage.pivotY = _roleImage.pY * _roleImage.texture.height;
			}
			
			_roleName.text = wordData.name;
			_contentTF.text = wordData.content;
			
			_curWord = wordData;
			this.display();
			Log.Trace("Left Talk!" + wordData.name);
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new LeftTalkComponent(_configXML, _titleTxAtlas);
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
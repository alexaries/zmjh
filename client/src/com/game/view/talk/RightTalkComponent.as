package com.game.view.talk
{
	import com.engine.core.Log;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.dialog.Word;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;
	import starling.utils.VAlign;

	public class RightTalkComponent extends Component
	{
		public function RightTalkComponent(item:XML, titleTxAtlas:TextureAtlas)
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
				
				roleFileName = "RoleImage_Big_" + wordData.name;
				_roleImage.texture = _view.role_big.interfaces(InterfaceTypes.GetTexture, roleFileName);
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
			Log.Trace("Right Talk!" + wordData.name);
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new RightTalkComponent(_configXML, _titleTxAtlas);
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
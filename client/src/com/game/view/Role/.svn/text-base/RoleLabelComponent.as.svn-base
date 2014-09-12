package com.game.view.Role
{
	import com.game.view.Component;
	
	import starling.display.MovieClip;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class RoleLabelComponent extends Component
	{
		public var mName:String;
		
		private var _curRoleName:String;
		public function get curRoleName() : String
		{
			return _curRoleName;
		}
		
		public function RoleLabelComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
		}
		
		private var _roleNameTF:TextField;
		private var _bg:MovieClip;
		private function getUI() : void
		{
			_roleNameTF = this.searchOf("Tx_RoleName");
			_bg = this.searchOf("RoleLabelBg");
		}
		
		/**
		 * 当前Label 
		 * @param name
		 * 
		 */	
		public function setRoleName(name:String) : void
		{
			_curRoleName = name;
			_roleNameTF.text = name;
			this.panel.visible = true;
		}
		
		public function set currentFrame(value:int) : void
		{
			_bg.currentFrame = value;
		}
		
		/**
		 * 组件拷贝 
		 * @return
		 * 
		 */		
		override public function copy() : Component
		{
			return new RoleLabelComponent(_configXML, _titleTxAtlas);
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
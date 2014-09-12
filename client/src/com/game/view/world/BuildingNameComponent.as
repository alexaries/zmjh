package com.game.view.world
{
	import com.game.view.Component;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class BuildingNameComponent extends Component
	{
		public function BuildingNameComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
		}
		
		private var _cityNameTF:TextField;
		private var _buildBg:Image;
		private function getUI() : void
		{
			_cityNameTF = this.searchOf("Tx_BuildingName");
			_buildBg = this.searchOf("BuildBg");
		}
		
		private var _cityName:String;
		public function setCityName(value:String) : void
		{
			_cityName = value;			
			_cityNameTF.text = _cityName;
			
			_buildBg.visible = (_cityName != "");
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new BuildingNameComponent(_configXML, _titleTxAtlas);
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
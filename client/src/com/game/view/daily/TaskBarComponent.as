package com.game.view.daily
{
	import com.game.view.Component;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class TaskBarComponent extends Component
	{
		private var _taskName:TextField;
		private var _taskBar:MovieClip;
		private var _alreadyGet:Image;
		public function get alreadyGet() : Image
		{
			return _alreadyGet;
		}
		public function set alreadyGet(value:Image) : void
		{
			_alreadyGet = value;
		}
		public function get taskName() : TextField
		{
			return _taskName;
		}
		public function get taskBar() : MovieClip
		{
			return _taskBar;
		}
		
		public function TaskBarComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
		}
		
		private function getUI() : void
		{
			_taskName = this.searchOf("TaskName");
			_taskBar = this.searchOf("TaskBarBg");
			_alreadyGet = (this.searchOf("AlreadyGet") as Image);
			_alreadyGet.visible = false;
			_taskName.touchable = false;
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new TaskBarComponent(_configXML, _titleTxAtlas);
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
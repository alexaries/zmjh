package com.game.view.Role
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.engine.net.File;
	import com.game.manager.LayerManager;
	import com.game.manager.ResCacheManager;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import flash.text.Font;
	import flash.utils.getDefinitionByName;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.events.Event;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class ChangePageComponent extends Component
	{
		public static const PAGE_CHANGE_EVENT:String = "page_change_event";
		public var _callbackFunc:Function;
		
		private var _totalPages:uint = 1;//总页数
		private var _curPage:uint = 1;//当前页数
		private var _pageNum:uint = 1;//每页数目
		
		public function ChangePageComponent(item:XML, titleTxAtlas:TextureAtlas)
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
		
		private var _prePageBtn:Button;//上一页
		private var _nextPageBtn:Button;//下一页
		private var _curPageTf:TextField;//当前页数
		
		private function getUI():void{
			_prePageBtn = searchOf("PageUp");
			_nextPageBtn = searchOf("PageDown");
			_curPageTf = searchOf("Tx_Page");
			
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			switch(name){
				case "PageUp":
					//上一页
					if(_curPage > 1 && _curPage <= _totalPages){
						_curPage--;
						this.refreshDisplay();
						this.dispatchEventWith(PAGE_CHANGE_EVENT,false,[_curPage]);
					}
					break;
				case "PageDown":
					//下一页
					if(_curPage < _totalPages){
						_curPage++;
						this.refreshDisplay();
						this.dispatchEventWith(PAGE_CHANGE_EVENT,false,[_curPage]);
					}
					break;
			}
			checkState();
		}
		
		private function checkState() : void
		{
			_prePageBtn.touchable = true;
			_prePageBtn.filter = undefined;
			_nextPageBtn.touchable = true;
			_nextPageBtn.filter = undefined;
			if(_curPage <= 1)
			{
				_prePageBtn.touchable = false;
				_prePageBtn.filter = new GrayscaleFilter();
			}
			if(_curPage >= _totalPages)
			{
				_nextPageBtn.touchable = false;
				_nextPageBtn.filter = new GrayscaleFilter();
			}
			if(_callbackFunc != null) _callbackFunc(_curPage);
		}
		
		private function refreshDisplay():void{
			_curPageTf.text = _curPage+"/"+_totalPages;
		}
		
		/**
		 * 设置数据 
		 * 
		 */		
		public function setData(dataLen:uint,pageNum:uint):void{
			this._pageNum = pageNum;
			_totalPages = Math.ceil(dataLen/this._pageNum);
			this._totalPages = _totalPages == 0 ? 1 : this._totalPages;//最少也有一页
			if(this._totalPages < this._curPage){
				//改变当前页
				this._curPage = this._totalPages;
			}
			this.dispatchEventWith(PAGE_CHANGE_EVENT,false,[_curPage]);
			this.refreshDisplay();
			
			checkState();
		}
		
		public function resetState(callbackFunc:Function) : void
		{
			_callbackFunc = callbackFunc;
			/*_curPage = 1;
			this.refreshDisplay();
			this.dispatchEventWith(PAGE_CHANGE_EVENT,false,[_curPage]);*/
			checkState();
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
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new ChangePageComponent(_configXML, _titleTxAtlas);
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
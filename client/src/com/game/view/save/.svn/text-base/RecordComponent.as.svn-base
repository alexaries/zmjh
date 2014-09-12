package com.game.view.save
{
	import com.engine.core.Log;
	import com.game.manager.URIManager;
	import com.game.template.InterfaceTypes;
	import com.game.view.Component;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class RecordComponent extends Component
	{
		public function RecordComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			this.panel.useHandCursor = true;
			
			getUI();
			initEvent();
		}
		
		override protected function initEvent():void
		{
			this.panel.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		override protected  function onTouch(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this.panel);
			
			// 鼠标out
			if (!touch)
			{
				_selectRecord.visible = false;
			}
			else
			{
				switch (touch.phase)
				{
					case TouchPhase.HOVER:
						_selectRecord.visible = true;
						break;
					case TouchPhase.ENDED:
						onClick();
						break;
				}
			}
		}
		
		protected function onClick() : void
		{
			Log.Trace("save Index:" + _index);
			
			var type:String = _view.save.saveType;
			
			var curIndex:int = !_data ? index : _data["index"];
			
			switch (type)
			{
				case SaveConfig.TOOLBAR_SAVE:
				case SaveConfig.SAVE:
				case SaveConfig.NEW_PLAYER_SAVE:
					_view.save.recover.onShow(curIndex);
					break;
				case SaveConfig.GET:
					if(_data)
					{
						if(int(_data["status"]) == 0)
							_view.save.tip.onShow(curIndex);
						else if(int(_data["status"]) == 1)
							_view.tip.interfaces(InterfaceTypes.Show,
								"您的该存档由于修改已被暂时封停，点击确定进行账号申诉",
								function () : void
								{
									URIManager.openDataURL();
								},
								null, false);
						else 
							_view.tip.interfaces(InterfaceTypes.Show,
								"您的该存档由于修改次数过多已经被永久封停。",
								null, null, false, false, true);
					}
					break;
			}
		}
		
		// 存储记录标题
		private var _nameTF:TextField;
		// 存储记录时间
		private var _saveTime:TextField;
		// 存储选择
		private var _selectRecord:Image;
		// 索引
		private var _index:int;
		private var _emptyTF:TextField;
		private var _unNormal:Image;
		public function get index() : int
		{
			_index = parseInt(name.replace("Record", ""));
			_index -= 1;
			return _index;
		}
		
		private function getUI() : void
		{
			if (!_nameTF) _nameTF = this.searchOf("Tx_Name");
			if (!_saveTime) _saveTime = this.searchOf("Tx_Data");
			if (!_selectRecord) _selectRecord = this.searchOf("SelectRecord");
			if (!_emptyTF) _emptyTF = this.searchOf("Tx_Empty");
			if (!_unNormal) _unNormal = this.searchOf("UnNormal");
			
			_nameTF.text = '';
			_nameTF.fontName = "宋体";
			_nameTF.width = 160;
			
			_saveTime.text = '';
			_saveTime.fontName = "宋体";
			_selectRecord.visible = false;
			
			_emptyTF.text = '';
			_emptyTF.fontName = '宋体';
			
			_unNormal.visible = false;
		}
		
		private var _data:Object;
		public function setData(obj:Object) : void
		{
			_data = obj;
			
			// 没有数据
			if (!_data)
			{
				_nameTF.text = '';
				_saveTime.text = '';
				_emptyTF.text = '空存档';
				_unNormal.visible = false;
			}
			else
			{
				_nameTF.text = _data["title"];
				_saveTime.text = _data["datetime"];
				_emptyTF.text = '';
				
				if(_data["status"] == 0)
					_unNormal.visible = false;
				else
					_unNormal.visible = true;
			}
			
			Log.Trace("Record:" + _nameTF.text);
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new RecordComponent(_configXML, _titleTxAtlas);
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
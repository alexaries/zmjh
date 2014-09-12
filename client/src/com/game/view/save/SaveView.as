package com.game.view.save
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.Base;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import starling.display.MovieClip;
	import starling.textures.Texture;

	public class SaveView extends BaseView implements IView
	{
		private var _saveList:Array;
		// 存储提示框标题
		private var _saveGetTitle:MovieClip;
		// 存储条目
		private var _records:Vector.<RecordComponent>;
		
		// 存储还是读取
		private var _saveType:String;
		public function get saveType() : String
		{
			return _saveType;
		}	
		
		// 提示
		private var _tip:TipComponent;
		public function get tip() : TipComponent
		{
			return _tip;
		}
		
		// 覆盖
		private var _recover:RecoverComponent;
		public function get recover() : RecoverComponent
		{
			return _recover;
		}
		
		public function SaveView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.SAVE;
			_loaderModuleName = V.LOAD;
			
			//_saveType = SaveConfig.NEW_PLAYER_SAVE;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			
			switch (type)
			{
				case InterfaceTypes.Show:
					_saveType = args[0];
					CheckPlayerLogged();
					break;
			}
		}
		
		/**
		 * 检测玩家是否登录 
		 * 
		 */		
		private function CheckPlayerLogged() : void
		{
			if (Data.instance.save.logged)
			{
				this.show();
			}
			else
			{
				Data.instance.save.showLogPanel();
			}
		}
		
		override protected function init() : void
		{
			if (!isInit)
			{
				super.init();
				isInit = true;
				
				initXML();
				initComponent();
				initUI();
				getUI();
				initEvent();
			}
			
			display();
			getSaveList();
			initRender();
		}
		
		/**
		 * 获取存档列表 
		 * 
		 */		
		private function getSaveList() : void
		{
			_view.loadData.loadDataPlay();			
			_view.controller.save.getSaveList(
				function (data:Array) : void
				{
					_view.loadData.hide();
					_saveList = data;
					Log.Trace("getSaveList:" + data.length);
					beginRender();
				});
		}
		
		private function initRender() : void
		{
			_saveGetTitle.currentFrame = (_saveType == SaveConfig.GET ? 1 : 0);
		}
		
		private function beginRender() : void
		{
			for (var i:int = 0; i < 6; i++)
			{
				_records[i].setData(null);
			}
			
			for each(var item:Object in _saveList)
			{
				if (item.index >= 6) continue;
				
				Log.Trace(item.index);
				_records[item.index].setData(item);
			}
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.LOAD, GameConfig.LOAD_RES, "SaveGetPosition");
		}
		
		private function initComponent() : void
		{
			var name:String;
			var cp:Component;
			var layerName:String;
			for each(var items:XML in _positionXML.component.Items)
			{
				name = items.@name;
				if (!this.checkInComponent(name))
				{
					switch (name)
					{
						case "Record":
							cp = new RecordComponent(items, _view.load.titleTxAtlas);
							_components.push(cp);
							break;
						case "Tip":
							cp = new TipComponent(items, _view.load.titleTxAtlas);
							_components.push(cp);
							break;
						case "Cover":
							cp = new RecoverComponent(items, _view.load.titleTxAtlas);
							_components.push(cp);
							break;
					}
				}
			}
		}
		
		private function initUI() : void
		{
			var name:String;
			var obj:*;
			var layerName:String;
			for each(var items:XML in _positionXML.layer)
			{
				layerName = items.@layerName;
				for each(var element:XML in items.item)
				{
					name = element.@name;
					
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						obj["layerName"] = layerName;
						_uiLibrary.push(obj);
					}
				}
			}
			
			_view.layer.setCenter(panel);
		}
		
		private function getUI() : void
		{
			_saveGetTitle = this.searchOf("SaveGetTitle");
			
			_records = new Vector.<RecordComponent>();
			var cp:Component;
			for (var i:int = 1; i <= 6; i++)
			{
				cp = this.searchOf("Record" + i);
				_records.push(cp);
			}
			
			if (!_tip)
			{
				var TP:TipComponent = this.searchOfCompoent("Tip") as TipComponent;
				_tip = TP.copy() as TipComponent;
				
				_view.layer.top.addChild(_tip.panel);
				_view.layer.setCenter(_tip.panel);
				_tip.hide();
			}
			
			if (!_recover)
			{
				var Recover:RecoverComponent = this.searchOfCompoent("Cover") as RecoverComponent;
				_recover = Recover.copy() as RecoverComponent;
				
				_view.layer.top.addChild(_recover.panel);
				_view.layer.setCenter(_recover.panel);
				_recover.hide();
			}
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					break;
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture> = _view.load.titleTxAtlas.getTextures(name);
			
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture = _view.load.titleTxAtlas.getTexture(name);
			return texture;
		}
		
		/**
		 * 每帧调用 
		 * 
		 */
		override public function update():void
		{
			super.update();
		}
		
		override public function close():void
		{
			Log.Trace("SaveView Close");
			super.close();
		}
		
		override public function hide() : void
		{
			Log.Trace("SaveView hide");
			
			super.hide();
			_view.loadData.hide();
		}
	}
}
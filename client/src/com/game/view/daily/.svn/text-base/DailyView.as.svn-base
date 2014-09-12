package com.game.view.daily
{
	import com.game.Data;
	import com.game.data.db.protocal.Daily_attendance;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class DailyView extends BaseView implements IView
	{
		/**
		 *　每天模板数据 
		 */		
		private var _dailyTemplateData:Object;
		/**
		 * UI位置文件 
		 */		
		private var _positionXML:XML;
		/**
		 * 纹理 
		 */		
		private var _titleTxAtlas:TextureAtlas;
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		
		//// UI
		/**
		 * 每日签到 
		 */		
		private var _sign:Button;
		/**
		 * 每日任务 
		 */		
		private var _task:Button;
		/**
		 * 每日地图 
		 */		
		private var _map:Button;
		
		private var _showTask:Boolean;
		private var _hideTask:Boolean;
		
		private var _firstInit:Boolean;
		
		public function DailyView()
		{
			_moduleName = V.DAILY;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.PUBLIC;
			
			_showTask = false;
			_hideTask = false;
			_firstInit = false;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch (type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
				case InterfaceTypes.GetTexture:
					getTexture(args[0], "");
					break;
				case InterfaceTypes.HIDE:
					_showTask = true;
					this.show();
					break;
				case InterfaceTypes.HIDE_ALL:
					_showTask = true;
					_hideTask = true;
					this.show();
					break;
			}
		}
		
		override protected function init():void
		{
			if (!isInit)
			{
				super.init();
				isInit = true;
				
				initData();
				initTextures();
				initUI();
				getUI();
				initEvent();
				hide();
			}
			
			if(_showTask)
			{
				this.hide();
				if(_hideTask)	_view.task.interfaces(InterfaceTypes.HIDE);
				else _view.task.interfaces(InterfaceTypes.Show);
				_hideTask = false;
				_showTask = false;
			}
			
			checkTaskState();
		}
		
		private function checkTaskState() : void
		{
			if(player.mainRoleModel.info.lv >= 15)
				addTouchable(_map);
			else
				removeTouchable(_map);
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "CloseBt":
					this.hide();
					break;
				case "SignBt":
					onSignIn();
					break;
				case "TaskBt":
					onTask();
					break;
				case "MapBt":
					onMap();
					break;
			}
		}
		
		private function onMap() : void
		{
			this.hide();
			_view.endless_battle.interfaces();
		}
		
		/**
		 * 每日签到 
		 * 
		 */		
		protected function onSignIn() : void
		{
			this.hide();
			_view.signIn.interfaces();
		}
		
		protected function onTask() : void
		{
			this.hide();
			_view.task.interfaces();
		}
		
		
		/**
		 * 获取模板数据 
		 * 
		 */		
		private function initData() : void
		{
			if (!_dailyTemplateData)
			{
				_dailyTemplateData = Data.instance.db.interfaces(InterfaceTypes.GET_DAILY_DATA);
			}
			
			if (!_positionXML)
			{
				_positionXML = getXMLData(_loadBaseName, GameConfig.DAILY_RES, "DailyPosition");
			}
		}
		
		/**
		 * 纹理 
		 * 
		 */		
		private function initTextures() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				
				var textureXML:XML = getXMLData(_loadBaseName, GameConfig.DAILY_RES, "Daily");			
				obj = getAssetsObject(_loadBaseName, GameConfig.DAILY_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
			}
		}
	
		private function initUI() : void
		{
			var name:String;
			var obj:*;			
			for each(var items:XML in _positionXML.layer)
			{
				for each(var element:XML in items.item)
				{
					name = element.@name;
					
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						_uiLibrary.push(obj);
					}
				}
			}
			
			display();
			_view.layer.setCenter(panel);
		}
		
		private function getUI() : void
		{
			_sign = this.searchOf("SignBt");
			_task = this.searchOf("TaskBt");
			_map = this.searchOf("MapBt");
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
		
		override public function update() : void
		{
			super.update();
		}
		
		override public function close() : void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
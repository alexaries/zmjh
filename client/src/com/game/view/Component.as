package com.game.view
{
	import com.game.View;
	import com.game.data.db.protocal.Prop;
	import com.game.data.fight.structure.BaseModel;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Component extends BaseView
	{
		protected var _configXML:XML;
		protected var _titleTxAtlas:TextureAtlas;
		
		public var name:String;
		public var layerName:String;
		public var type:String;
		public var mean:String;
		
		public function Component(item:XML, titleTxAtlas:TextureAtlas)
		{
			_view = View.instance;
			_configXML = item;
			_titleTxAtlas = titleTxAtlas;

			init();
		}
		
		public function copy() : Component
		{
			throw new Error("需重写");
		}
		
		override protected function init() : void
		{
			type = _configXML.@name;
			mean = _configXML.@mean;
			
			initUI();
		}
		
		private function initUI() : void
		{
			var name:String;
			var obj:DisplayObject;
			var layerName:String;
			for each(var items:XML in _configXML.layer)
			{
				layerName = items.@layerName;
				for each(var element:XML in items.item)
				{
					name = element.@name;
					
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						obj["layerName"] = layerName;
						uiLibrary.push(obj);
					}
				}
			}
		}
		
		public function setGridData(args:*) : void
		{
			
		}
		
		/**
		 * 重新设置图片大小
		 * 
		 */		
		protected function resetImage(img:Image) : void
		{
			var _width:Number = img.width / 42;
			img.width = 42;
			img.height = img.height / _width;
			
			if(img.height > 42)
			{
				var _height:Number = img.height / 42;
				img.height = 42;
				img.width = img.width / _height;
			}
		}
		
		public function initRender(data:BaseModel, stand:String, isPlayerKilling:Boolean = false) : void
		{
			throw new Error("需重写");
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;			
			textures = _titleTxAtlas.getTextures(name);
			
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			texture = _titleTxAtlas.getTexture(name);
			
			return texture;
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		public function clear() : void
		{			
			this.removeEventListeners();
			//this.panel.dispose();
		}
	}
}
package com.game.view
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.player.structure.RoleModel;
	import com.game.manager.FontManager;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	
	import feathers.controls.TextInput;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.core.ITextEditor;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.NineSliceImage;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchPhase;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class BaseView extends Base
	{
		public function BaseView()
		{
			super();
		}
		
		protected function createDisplayObject(item:XML) : *
		{
			var obj:*;
			
			var type:String = item.@type;
			
			switch (type)
			{
				case "Image":
					obj = createImage(item);
					break;
				case "Button":
					obj = createButton(item);
					break;
				case "TextField":
					obj = createTextField(item);
					break;
				case "MovieClip":
					obj = createMovieClip(item);
					break;
				case "Slice9Image":
					break;
				default:
					obj = createComponent(item);
			}
			
			return obj;
		}
		
		/**
		 * 需重写 
		 * @param item
		 * @return 
		 * 
		 */		
		protected function createComponent(item:XML) : Component
		{
			var type:String = item.@type;
			var component:Component = this.searchOfCompoent(type);
			
			component = component.copy();
			component.name = item.@name;
			
			if (!component) Log.Error("没找到相关的自定义组件");
			
			panel.addChild(component.panel);
			component.panel.x = item.@x;
			component.panel.y = item.@y;
			
			return component;
		}
		
		
		protected function createComponentItem(type:String, name:String) : Component
		{
			var component:Component = this.searchOfCompoent(type);
			
			component = component.copy();
			component.name = name;
			if (!component) Log.Error("没找到相关的自定义组件");
			
			panel.addChild(component.panel);
			
			return component;
		}
		
		protected function createImage(item:XML) : DisplayObject
		{
			var image:Image;
			var name:String = item.@name;
			var textureName:String = item.@textureName;
			var textureType:String = item.@textureType;

			var texture:Texture = (textureName == "" ? Texture.empty() : this.getTexture(textureName, textureType));

			image = new Image(texture);
			image.smoothing = TextureSmoothing.TRILINEAR;
			image.width = item.@width;
			image.height = item.@height;
			image.name = item.@name;
			panel.addChild(image);
			
			//image.touchable = false;
			
			image.x = item.@x;
			image.y = item.@y;
			image.pX = item.@pivotX;
			image.pY = item.@pivotY;
			image.pivotX = item.@pivotX * item.@width;
			image.pivotY = item.@pivotY * item.@height;
			
			return image;
		}
		
		protected function createButton(item:XML) : DisplayObject
		{
			var btn:Button;
			var name:String = item.@name;
			var textureName:String = item.@textureName + "_";
			var textureType:String = item.@textureType;
			var textures:Vector.<Texture> = this.getTextures(textureName, textureType);
			btn = new Button(textures[0], '', textures.length >= 2 ? textures[1] : null);
			btn.width = item.@width;
			btn.height = item.@height;
			btn.name = item.@name;
			panel.addChild(btn);
			btn.x = parseInt(item.@x);
			btn.y = parseInt(item.@y);
			btn.text = item.@text || '';
			if(item.@pivotX != "" && item.@pivotY != "")
			{
				btn.pivotX = item.@pivotX * item.@width;
				btn.pivotY = item.@pivotY * item.@height;
			}
			
			if (FontManager.instance.font)
			{
				btn.fontName = FontManager.instance.font.fontName;
			}
			btn.scaleX = int(item.@ScaleX) ? int(item.@ScaleX): 1;
			btn.useHandCursor = true;
			
			return btn;
		}
		
		protected function createMovieClip(item:XML) : DisplayObject
		{
			var mc:MovieClip;
			var name:String = item.@name;
			var textureName:String = item.@textureName + "_";
			var textureType:String = item.@textureType;
			var textures:Vector.<Texture> = this.getTextures(textureName, textureType);
			mc = new MovieClip(textures);
			mc.name = item.@name;
			mc.x = parseInt(item.@x);
			mc.y = parseInt(item.@y);
			mc.pivotX = Number(item.@pivotX);
			mc.pivotY = Number(item.@pivotY);
			panel.addChild(mc);
			
			return mc;
		}
		
		protected function createTextField(item:XML) : DisplayObject
		{
			var tf:TextField;			
			tf = new TextField(item.@width, item.@height, item.@text);	
			tf.name = item.@name;			
			tf.color = item.@color || 0x000000;
			tf.hAlign = item.@align || HAlign.CENTER;
			tf.vAlign = VAlign.CENTER;
			tf.fontSize = item.@size;
			tf.kerning = true;
			tf.autoScale = true;
			panel.addChild(tf);
			tf.text = item.@text;
			tf.x = item.@x;
			tf.y = item.@y;
			
			var fontType:String = item.@fontType || "";
			if (FontManager.instance.font || fontType == "DFPHaiBaoW12-GB")
			{
				tf.fontName = FontManager.instance.font.fontName; 
			}
			else
			{
				tf.fontName = "宋体";
			}
			
			return tf;
		}
		
		protected function seStatusOfXML(xml:XML, isShow:Boolean) : void
		{
			var name:String;
			var obj:*;
			for each(var element:XML in xml.item)
			{
				name = element.@name;
				
				obj = searchOf(name);
				
				if (!obj)
				{
					Log.Error(this._moduleName + ":没有索引到！");
				}
				
				if (obj is DisplayObject) obj.visible = true;
				else if (obj is Component)obj["panel"].visible = true;
			}
		}
		
		/**
		 * 数组里是否有 
		 * @param name
		 * @return 
		 * 
		 */		
		protected function checkIndexof(name:String) : Boolean
		{
			var result:Boolean = false;
			for each(var item:* in _uiLibrary)
			{
				if (item.name == name) 
				{
					result = true;
					break;
				}
			}
			
			return result;
		}
		
		/**
		 * 组件 
		 * @param type
		 * @return 
		 * 
		 */		
		protected function checkInComponent(type:String) : Boolean
		{
			var result:Boolean = false;
			for each(var item:Component in this._components)
			{
				if (item.type == type) 
				{
					result = true;
					break;
				}
			}
			
			return result;
		}
		
		
		public function getObj(name:String) : *
		{
			return this.searchOf(name);
		}
		
		/**
		 * 搜索 
		 * @param name
		 * @return 
		 * 
		 */		
		protected function searchOf(name:String) : *
		{
			var obj:*;
			
			for each(var item:* in _uiLibrary)
			{
				if (item.name == name)
				{
					obj = item;
					break;
				}
			}
			
			return obj;
		}
		
		protected function searchOfCompoent(type:String) : Component
		{
			var obj:Component;
			
			for each(var item:Component in this._components)
			{
				if (item.type == type)
				{
					obj = item;
					break;
				}
			}
			
			return obj;
		}
		
		protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			throw new Error("改函数接口需重写");
			var textures:Vector.<Texture> = new Vector.<Texture>();
			return textures;
		}
		
		protected function getTexture(name:String, type:String) : Texture
		{
			throw new Error("改函数接口需重写");
			var texture:Texture = new Texture();
			return texture;
		}
		
		protected function getTextureFromSwf(swf:String, name:String, moduleName:String = "") : Texture
		{
			var texture:Texture;
			
			if (moduleName == "") moduleName = _loadBaseName;
			var bd:BitmapData = getAssetsObject(moduleName, swf, name) as BitmapData;
			texture = Texture.fromBitmapData(bd as BitmapData);
			
			return texture;
		}
		
		protected function getTextureFromSwf2(swf:String, name:String, moduleName:String = "") : Texture
		{
			var texture:Texture;
			
			if (moduleName == "") moduleName = _loadBaseName;
			var bd:Bitmap = getAssetsObject(moduleName, swf, name) as Bitmap;
			texture = Texture.fromBitmap(bd as Bitmap);
			
			return texture;
		}
		
		override protected function initEvent() : void
		{
			super.initEvent();
			var eventBind:ViewEventBind;
			for each(var item:* in _uiLibrary)
			{
				if (item is Button)
				{
					eventBind = new ViewEventBind(item, TouchPhase.ENDED, onClickeHandle, true);
					this.addListener(eventBind);
				}
			}
		}
		
		protected function initBeginEvent() : void
		{
			var eventBind:ViewEventBind;
			for each(var item:* in _uiLibrary)
			{
				if (item is Button)
				{
					eventBind = new ViewEventBind(item, TouchPhase.BEGAN, onClickBeginHandle, true);
					this.addListener(eventBind);
				}
			}
		}
		
		protected function onClickBeginHandle(e:ViewEventBind) : void
		{
			
		}
		
		
		protected function onClickeHandle(e:ViewEventBind) : void
		{
			
		}
		
		/**
		 * 获取xml文件 
		 * @param ModelName ： 模块名
		 * @param SWFName ： swf
		 * @param fileName ： 目标文件
		 * @return 
		 * 
		 */		
		protected function getXMLData(ModelName:String, SWFName:String, fileName:String, LoaderModule:String = '') : XML
		{
			if (LoaderModule == '') LoaderModule = this._loaderModuleName;
			
			var xmlData:XML;
			var bytes:ByteArray = getAssetsObject(ModelName, SWFName, fileName, LoaderModule) as ByteArray;
			xmlData = XML(bytes.toString());
			
			return xmlData;
		}
		
		public function getAssetsObject(ModelName:String, SWFName:String, className:String, LoaderModule:String = '') : Object
		{	
			if (LoaderModule == '') LoaderModule = this._loaderModuleName;
			
			var obj:Object = _view.res.getAssetsObject(LoaderModule, ModelName, SWFName, className);
			
			return obj;
		}
		
		public function getAssetsData(ModelName:String, name:String, LoaderModule:String = '') : Object
		{
			if (LoaderModule == '') LoaderModule = this._loaderModuleName;
			
			var obj:Object = _view.res.getAssetsData(LoaderModule, ModelName, name);
			return obj;
		}
		
		/**
		 * 清理UI生成库 
		 * 
		 */
		protected function clearUILibrary() : void
		{
			var item:*;
			
			while (_uiLibrary.length > 0)
			{
				item = _uiLibrary.shift();
				
				if (item is Image)
				{
					(item as Image).removeEventListeners();
					(item as Image).dispose();
					item = null;
				}
				else if (item is Button)
				{
					(item as Button).dispose();
					item = null;
				}
				else if (item is TextField)
				{
					(item as TextField).dispose();
					item = null;
				}
			}
		}
		
		/**
		 * 清除组件 
		 * 
		 */		
		protected function clearComponent() : void
		{
			var component:Component;
			
			while (_components.length > 0)
			{
				component = _components.shift();
				component.destroy();
			}
		}
		
		override public function destroy():void
		{
			clearUILibrary();
			clearComponent();
			
			super.destroy();
		}
		
		
		public function addText(xPos:int, yPos:int, wid:int, hei:int, content:String) : TextInput
		{
			var _input:TextInput = new TextInput();
			_input.text = content;
			_input.x = xPos;
			_input.y = yPos;
			_input.width = wid;
			_input.height = hei;
			_input.textEditorFactory = setTextEditor;
			_input.addEventListener(Event.CHANGE, inputChangeHandler);
			if(!_input.parent) 	this.panel.addChild(_input);
			
			return _input;
		}
		
		public function setTextEditor() : ITextEditor
		{
			var editor:StageTextTextEditor = new StageTextTextEditor();
			editor.fontFamily = "DFPHaiBaoW12-GB";
			editor.fontSize = 12;
			editor.color = 0xFFFFFF;
			editor.textAlign  = "center";
			editor.maxChars = 2;
			editor.restrict="0-9";
			return editor;
		}
		
		public function inputChangeHandler(e:Event) : void
		{
			
		}
		
		protected function resetPosition(targetXML:XML) : void
		{
			var name:String;
			for each(var element:XML in targetXML.item)
			{
				name = element.@name;
				for each(var item:* in _uiLibrary)
				{
					if (item.name == name)
					{
						if(item is Component)
						{
							item.panel.x = element.@x;
							item.panel.y = element.@y;
						}
						else if (item is DisplayObject)
						{
							item.x = element.@x;
							item.y = element.@y;
						}
					}
				}
			}
		}
		
		/**
		 * 添加动画
		 * @param thisPanel
		 * @param mc
		 * 
		 */		
		public function addMovieClip(thisPanel:Sprite, mc:MovieClip) : void
		{
			if(thisPanel == null || mc == null) 
			{
				Log.Error("无法添加动画！");
				return;
			}
			mc.visible = true;
			mc.currentFrame = 0;
			mc.play();
			thisPanel.addChild(mc);
			Starling.juggler.add(mc);
		}
		
		/**
		 * 删除动画
		 * @param mc
		 * 
		 */		
		public function removeMovieClip(mc:MovieClip) : void
		{
			if(mc == null)
			{
				Log.Error("无法删除动画！");
			}
			if(mc != null && mc.parent) mc.parent.removeChild(mc);
			mc.visible = false;
			mc.stop();
			Starling.juggler.remove(mc);
		}
		
		public function removeTouchable(obj:*) : void
		{
			obj.useHandCursor = false;
			obj.touchable = false;
			obj.filter = new GrayscaleFilter();
		}
		
		public function removeOnlyTouchable(obj:*) : void
		{
			obj.filter = new GrayscaleFilter();
		}
		
		public function addTouchable(obj:*) : void
		{
			obj.useHandCursor = true;
			obj.touchable = true;
			obj.filter = null;
		}
		
		public function addStarlingDelay(obj:*, delayTime:Number, callback:Function) : void
		{
			Starling.juggler.delayCall(
				function () : void
				{
					removeMovieClip(obj);
					if(callback != null) callback();
				},
				.7)
		}
		
		
		/**
		 * 检测角色图片
		 * @param name
		 * @param img
		 * 
		 */		
		protected function checkImage(name:String, img:Image) : void
		{
			var lastRoleName:String = name;
			if(name.indexOf("（") != -1) lastRoleName = name.substring(0, name.indexOf("（"));
			
			
			var imageName:String;
			imageName = player.returnNowFashion("RoleImage_Rect_", lastRoleName);
			
			//var imageName:String = "RoleImage_Rect_" + lastRoleName;
			
			img.texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, imageName);
		}
		
		/**
		 * 检测角色类型
		 * @param name
		 * 
		 */		
		protected function checkType(name:String, img:Image) : void
		{
			if(name.indexOf(V.NIGHT_TYPE) != -1)
			{
				img.texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "RoleImage_Rect_Night");
			}
			else if(name.indexOf(V.RAIN_TYPE) != -1)
			{
				img.texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "RoleImage_Rect_Rain");
			}
			else if(name.indexOf(V.THUNDER_TYPE) != -1)
			{
				img.texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "RoleImage_Rect_Thunder");
			}
			else if(name.indexOf(V.WIND_TYPE) != -1)
			{
				img.texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, "RoleImage_Rect_Wind");
			}
			else 
			{
				img.visible = false;
			}
		}
		
		/**
		 * 检测角色品质
		 * 
		 */		
		protected function checkGrade(name:String, img:Image) : void
		{
			var grade:String = Data.instance.db.interfaces(InterfaceTypes.GET_GRADE_BY_NAME, name);
			var textureName:String = "";
			switch(grade)
			{
				case "极":
					textureName = "RoleGrade_Ji";
					break;
				case "甲+":
					textureName = "RoleGrade_JiaJia";
					break;
				case "甲":
					textureName = "RoleGrade_Jia";
					break;
				case "乙":
					textureName = "RoleGrade_Yi";
					break;
				case "丙":
					textureName = "RoleGrade_Bing";
					break;
				case "丁":
					textureName = "RoleGrade_Ding";
					break;
			}
			img.texture = _view.roleImage.interfaces(InterfaceTypes.GetTexture, textureName);
		}
		
		
		protected function createNewMovieClip(xPos:int, yPos:int, name:String) : MovieClip
		{
			var frames:Vector.<Texture> = _view.other_effect.interfaces(InterfaceTypes.GetTextures, "Spread_00");
			var result:MovieClip = new MovieClip(frames);
			result.x = xPos;
			result.y = yPos;
			result.stop();
			result.touchable = false;
			
			return result;
		}
	}
}
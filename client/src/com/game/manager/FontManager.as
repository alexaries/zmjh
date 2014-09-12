package com.game.manager
{
	import flash.text.Font;
	
	import starling.core.Starling;

	public class FontManager
	{
		[Embed(source="../resources/public/font/HKHB.ttf", embedAsCFF='false', fontName='HKHB')]
		public var HKHB:Class;
		
		private var _font:Font;
		public function get font() : Font
		{
			if (!_font) 
			{
				_font = new HKHB();
			}
			
			return _font;
		}
		
		public function FontManager(s : Singleton)
		{
			if (_instance != null)
			{
				throw new Error("LayerManager 是单例！");
			}
			
			_instance = this;
		}
		
		/**
		 * 嵌入字体 
		 * @param FT
		 * 
		 */		
		public function setDefaultFont(FT:Class) : void
		{
			try
			{
				Font.registerFont(FT);
				_font= new FT as Font;
			}
			catch (e:*) 
			{
				trace("font error!");
				//Font.registerFont(HKHB);
			}
		}
		
		private static var _instance : FontManager;
		public static function get instance () : FontManager
		{
			if (null == _instance)
			{
				_instance = new FontManager(new Singleton());
			}
			
			return _instance;
		}
	}
}

class Singleton {}
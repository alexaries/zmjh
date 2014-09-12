package com.engine.ui.controls
{
	import flash.geom.Rectangle;
	
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class TipTextField extends TextField
	{
		
		public function TipTextField(width:int, height:int, text:String, fontName:String = "宋体", fontSize:Number = 12, color:uint=0, bold:Boolean=false)
		{
			super(width, height, text, fontName, fontSize, color, bold);
			vAlign = VAlign.TOP;
			hAlign = HAlign.LEFT;
			
			checkTextHeight();
		}
		
		override public function set text(value:String):void {
			super.text = value;
			checkTextHeight();
		}
		
		private function checkTextHeight():void{
			this.height = this.textBounds.height+4;
		}
	}
}
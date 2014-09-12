package com.engine.core
{
	import flash.geom.*;
	import flash.text.*;
	
	public class RxTextField
	{
		protected var m_textField:TextField;
		
		public function RxTextField(multiline:Boolean, type:Boolean)
		{
			this.m_textField = new TextField();
			this.m_textField.background = true;
			this.m_textField.border = true;
			this.m_textField.mouseEnabled = true;
			this.m_textField.mouseWheelEnabled = true;
			this.m_textField.multiline = multiline;
			this.m_textField.selectable = true;
			this.m_textField.type = type ? (TextFieldType.INPUT) : (TextFieldType.DYNAMIC);
			this.m_textField.wordWrap = true;
			var format:TextFormat = new TextFormat();
			format.font = "Courier";
			this.m_textField.defaultTextFormat = format;
			this.m_textField.x = 0;
			this.m_textField.y = 0;
			this.m_textField.width = 100;
			this.m_textField.height = 100;
			this.SetColors(16777215, 0, 8421504, 1);
		}
		
		public function SetColors(red:uint, green:uint, blue:uint, alphaMultiplier:Number) : void
		{
			var ired:* = red >> 16 & 255;
			var iired:* = red >> 8 & 255;
			var iiired:* = red & 255;
			var igreen:* = green >> 16 & 255;
			var iigreen:* = green >> 8 & 255;
			var iiigreen:* = green & 255;
			var iblue:* = blue >> 16 & 255;
			var iiblue:* = blue >> 8 & 255;
			var iiiblue:* = blue & 255;
			var redOffset:* = Number(ired);
			var greenOffset:* = Number(iired);
			var blueOffset:* = Number(iiired);
			var redMultiplier:Number = Number(igreen - ired) / 255;
			var greenMultiplier:* = Number(iigreen - iired) / 255;
			var blueMultiplier:* = Number(iiigreen - iiired) / 255;
			ired = uint((ired - redOffset) / redMultiplier);
			iired = uint((iired - greenOffset) / greenMultiplier);
			iiired = uint((iiired - blueOffset) / blueMultiplier);
			igreen = uint((igreen - redOffset) / redMultiplier);
			iigreen = uint((iigreen - greenOffset) / greenMultiplier);
			iiigreen = uint((iiigreen - blueOffset) / blueMultiplier);
			iblue = uint((iblue - redOffset) / redMultiplier);
			iiblue = uint((iiblue - greenOffset) / greenMultiplier);
			iiiblue = uint((iiiblue - blueOffset) / blueMultiplier);
			this.m_textField.textColor = ired << 16 | iired << 8 | iiired;
			this.m_textField.backgroundColor = igreen << 16 | iigreen << 8 | iiigreen;
			this.m_textField.borderColor = iblue << 16 | iiblue << 8 | iiiblue;
			this.m_textField.transform.colorTransform = new ColorTransform(redMultiplier, greenMultiplier, blueMultiplier, alphaMultiplier, redOffset, greenOffset, blueOffset, 0);
		}
		
		public function GetTextColor() : uint
		{
			return this.TransformColor(this.m_textField.textColor);
		}
		
		public function GetBackgroundColor() : uint
		{
			return this.TransformColor(this.m_textField.backgroundColor);
		}
		
		public function GetBorderColor() : uint
		{
			return this.TransformColor(this.m_textField.borderColor);
		}
		
		public function GetAlpha() : Number
		{
			return this.m_textField.transform.colorTransform.alphaMultiplier;
		}
		
		public function SetVisible(visible:Boolean) : void
		{
			this.m_textField.visible = visible;
		}
		
		public function TransformColor(color:uint) : uint
		{
			var resColor:uint = 0;
			var red:* = color >> 16 & 255;
			var green:* = color >> 8 & 255;
			var blue:* = color & 255;
			var colorTransform:ColorTransform = this.m_textField.transform.colorTransform;
			red = uint(colorTransform.redMultiplier * red + colorTransform.redOffset);
			green = uint(colorTransform.greenMultiplier * green + colorTransform.greenOffset);
			blue = uint(colorTransform.blueMultiplier * blue + colorTransform.blueOffset);
			resColor = red << 16 | green << 8 | blue;
			
			return resColor;
		}
		
		public function GetVisible() : Boolean
		{
			return this.m_textField.visible;
		}
		
		public function ClearText() : void
		{
			this.m_textField.text = "";
		}
		
		public function AddText(str:String) : void
		{
			this.m_textField.appendText(str);
			if (this.m_textField.selectionBeginIndex == this.m_textField.selectionEndIndex)
			{
				this.m_textField.scrollV = this.m_textField.maxScrollV;
			}
		}
		
		public function GetText() : String
		{
			return this.m_textField.text;
		}
		
		public function GetTextField() : TextField
		{
			return this.m_textField;
		}
		
		public function SetRect(rec:Rectangle) : void
		{
			this.m_textField.x = rec.x;
			this.m_textField.y = rec.y;
			this.m_textField.width = rec.width;
			this.m_textField.height = rec.height;
		}
		
		public function Delete() : void
		{
			this.m_textField = null;
		}
	}
}
package com.engine.profile
{
	import flash.utils.*;
	
	public class RxTimingProfileData extends RxProfileData
	{
		public function RxTimingProfileData()
		{
		}
		
		override public function Start(name:String, depth:int) : void
		{
			super.Start(name, depth);
			m_valueStart = getTimer();
		}
		
		override public function End() : void
		{
			m_valueEnd = getTimer();
			super.End();
		}
		
		override public function Snapshot(name:String) : void
		{
			super.Snapshot(name);
			m_valueStart = getTimer();
		}
		
		override public function ConvertToString(bol:Boolean, average:Boolean, p:uint) : String
		{
			var disTime:Number;
			var unit:String;
			var result:String = "";
			var divide:String = "";
			
			if (m_valueCount == -1)
			{
				result = result + (m_name + ": " + m_valueStart.toFixed(p) + " ms");
				return result;
			}
			
			var i:int = 0;
			while (i < m_stackDepth)
			{
				
				divide = divide + "-";
				i++;
			}
			divide = divide + " ";
			if (bol)
			{
				disTime = m_valueEnd - m_valueStart;
				result = result + (divide + m_name + ":\n");
				result = result + (divide + "  start: " + m_valueStart.toFixed(p) + " ms\n");
				result = result + (divide + "  end: " + m_valueEnd.toFixed(p) + " ms\n");
				result = result + (divide + "  delta: " + disTime.toFixed(p) + " ms\n");
			}
			else
			{
				disTime = average ? this.m_valueAverage : (m_valueEnd - m_valueStart);
				if (disTime < 1000)
				{
					unit = "ms";
				}
				else if (disTime < 60 * 1000)
				{
					unit = "sec";
					disTime = disTime * (1 / 1000);
				}
				else
				{
					unit = "min";
					disTime = disTime * (1 / (60 * 1000));
				}
				result = result + (divide + m_name + ": " + disTime.toFixed(p) + " " + unit);
			}
			
			return result;
		}
	}
}
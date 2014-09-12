package com.engine.profile
{
	import com.engine.core.*;
	import com.engine.utils.Utilities;
	
	import flash.system.*;
	
	public class RxMemoryProfileData extends RxProfileData
	{
		private var m_freeMemoryProfileData:RxProfileData;
		
		public function RxMemoryProfileData()
		{
			m_freeMemoryProfileData = new RxProfileData();
		}
		
		override public function Start(name:String, depth:int) : void
		{
			super.Start(name, depth);
			m_valueStart = System.totalMemoryNumber;
			this.m_freeMemoryProfileData.Start(name, depth);
			this.m_freeMemoryProfileData.m_valueStart = System.freeMemory;
		}
		
		override public function End() : void
		{
			m_valueEnd = System.totalMemoryNumber;
			this.m_freeMemoryProfileData.m_valueEnd = System.freeMemory;
			super.End();
			this.m_freeMemoryProfileData.End();
		}
		
		override public function Snapshot(name:String) : void
		{
			super.Snapshot(name);
			m_valueStart = System.totalMemoryNumber;
			this.m_freeMemoryProfileData.m_valueStart = System.freeMemory;
		}
		
		override public function ConvertToString(bol:Boolean, average:Boolean, p:uint) : String
		{
			var result:String = "";
			
			var divide:String = "";
			if (m_valueCount == -1)
			{
				result = result + (m_name + ": total: " + Utilities.scvt(m_valueStart, p) + ", free: " + Utilities.scvt(this.m_freeMemoryProfileData.m_valueStart, p));
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
				result = result + divide + m_name + ":\n";
				result = result + divide + "  start: total: " + Utilities.scvt(m_valueStart, p) + ", free: " + Utilities.scvt(this.m_freeMemoryProfileData.m_valueStart, p) + "\n";
				result = result + divide + "  end: total: " + Utilities.scvt(m_valueEnd, p) + ", free: " + Utilities.scvt(this.m_freeMemoryProfileData.m_valueEnd, p) + "\n";
				result = result + divide + "  delta: total: " + Utilities.scvt(m_valueEnd - m_valueStart, p) + ", free: " + Utilities.scvt(this.m_freeMemoryProfileData.m_valueEnd - this.m_freeMemoryProfileData.m_valueStart, p) + "\n";
			}
			else
			{
				var total:Number = average ? m_valueAverage : (m_valueEnd - m_valueStart);
				var free:Number  = average ? this.m_freeMemoryProfileData.m_valueAverage : (this.m_freeMemoryProfileData.m_valueEnd - this.m_freeMemoryProfileData.m_valueStart);
				result = result + (divide + m_name + ": total: " + Utilities.scvt(total, p) + ", free: " + Utilities.scvt(free, p));
			}
			
			return result;
		}
	}
}
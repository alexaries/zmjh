package com.engine.profile
{
	public class RxProfileData
	{
		public var m_name:String;
		public var m_stackDepth:int;
		public var m_valueStart:Number;
		public var m_valueEnd:Number;
		public var m_valueTotal:Number;
		public var m_valueCount:int;
		public var m_valueAverage:Number;
		public var m_valueMin:Number;
		public var m_valueMax:Number;
		public static var s_averageSamples:uint = 15;
		
		public function RxProfileData()
		{
			this.m_name = "";
			this.m_stackDepth = 0;
			this.m_valueStart = 0;
			this.m_valueEnd = 0;
			this.ResetStats();
		}
		
		private function ResetStats() : void
		{
			this.m_valueTotal = 0;
			this.m_valueCount = 0;
			this.m_valueAverage = 0;
			this.m_valueMin = Number.MAX_VALUE;
			this.m_valueMax = -Number.MAX_VALUE;
		}
		
		public function Start(name:String, depth:int) : void
		{
			if (this.m_name != name)
			{
				this.ResetStats();
			}
			
			this.m_name = name;
			this.m_stackDepth = depth;
		}
		
		public function End() : void
		{
			this.UpdateStats();
		}
		
		public function Snapshot(name:String) : void
		{
			this.m_name = name;
			this.m_valueCount = -1;
		}
		
		public function GetName() : String
		{
			return this.m_name;
		}
		
		public function GetStackDepth() : int
		{
			return this.m_stackDepth;
		}
		
		public function GetValue() : Number
		{
			return this.m_valueEnd - this.m_valueStart;
		}
		
		public function GetAverage() : Number
		{
			return this.m_valueAverage;
		}
		
		public function GetMin() : Number
		{
			return this.m_valueMin;
		}
		
		public function GetMax() : Number
		{
			return this.m_valueMax;
		}
		
		private function UpdateStats() : void
		{
			var dis:Number = this.m_valueEnd - this.m_valueStart;
			this.m_valueTotal = this.m_valueTotal + dis;
			this.m_valueCount++;
			
			if (this.m_valueCount >= s_averageSamples)
			{
				this.m_valueAverage = this.m_valueTotal / Number(this.m_valueCount);
				this.m_valueTotal = 0;
				this.m_valueCount = 0;
			}
			
			this.m_valueMin = Math.min(this.m_valueMin, dis);
			this.m_valueMax = Math.max(this.m_valueMax, dis);
		}
		
		public function ConvertToString(param1:Boolean, param2:Boolean, param3:uint) : String
		{
			return null;
		}
	}
}
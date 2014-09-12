package com.engine.profile
{
	import flash.display.*;
	
	public class RxDualProfiler
	{
		private var m_timingProfiler:RxTimingProfiler;
		public function GetTimingProfiler() : RxTimingProfiler
		{
			return this.m_timingProfiler;
		}
		
		private var m_memoryProfiler:RxMemoryProfiler;
		public function GetMemoryProfiler() : RxMemoryProfiler
		{
			return this.m_memoryProfiler;
		}
		
		public function RxDualProfiler()
		{
			this.m_timingProfiler = new RxTimingProfiler();
			this.m_memoryProfiler = new RxMemoryProfiler();
		}
		
		public function AddToStage(stage:Stage) : void
		{
			m_timingProfiler.AddToStage(stage);
			m_memoryProfiler.AddToStage(stage);
		}
		
		public function RemoveFromStage(stage:Stage) : void
		{
			this.m_timingProfiler.RemoveFromStage(stage);
			this.m_memoryProfiler.RemoveFromStage(stage);
		}
		
		public function Start(type:String) : void
		{
			this.m_timingProfiler.Start(type);
			this.m_memoryProfiler.Start(type);
		}
		
		public function End() : void
		{
			this.m_timingProfiler.End();
			this.m_memoryProfiler.End();
		}
		
		public function Snapshot(name:String) : void
		{
			this.m_timingProfiler.Snapshot(name);
			this.m_memoryProfiler.Snapshot(name);
		}
		
		public function ClearTextField() : void
        {
            this.m_timingProfiler.ClearTextField();
            this.m_memoryProfiler.ClearTextField();
        }

        public function UpdateTextField(param1:String, param2:String, param3:Boolean, param4:Boolean, param5:uint) : void
        {
            this.m_timingProfiler.UpdateTextField(param1, param3, param4, param5);
            this.m_memoryProfiler.UpdateTextField(param2, param3, param4, param5);
        }
	}
}
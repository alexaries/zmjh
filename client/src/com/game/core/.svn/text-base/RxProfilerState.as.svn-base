package com.game.core
{
	import com.engine.core.Log;
	import com.engine.profile.*;
	import com.engine.utils.Utilities;
	
	import flash.display.*;
	import flash.geom.*;
	import flash.system.*;
	
	public class RxProfilerState
	{
		private var m_stage:Stage;
		private var m_state:uint;
		private var m_updateCount:uint;
		private var m_appMemory:Number;
		private var m_appMemoryUpdateFrames:uint;
		
		public static const PROFILE_FRAME:uint = 1;
		// 微监控器
		public static const PROFILE_FRAME_MIN:uint = 2;
		public static const PROFILE_ACCUM:uint = 3;
		public static const PROFILE_SAMPLING:uint = 4;
		
		private var m_minTimingProfileData:RxTimingProfileData;
		
		private var m_frameDualProfiler:RxDualProfiler;
		public function GetFrameDualProfiler() : RxDualProfiler
		{
			return this.m_frameDualProfiler;
		}
		
		private var m_accumDualProfiler:RxDualProfiler;
		public function GetAccumDualProfiler() : RxDualProfiler
		{
			return this.m_accumDualProfiler;
		}
		
		private var m_samplingProfiler:RxSamplingProfiler;
		public function GetSamplingProfiler() : RxSamplingProfiler
		{
			return this.m_samplingProfiler;
		}
		
		public function RxProfilerState(stage:Stage)
		{
			m_stage = stage;
			
			m_frameDualProfiler = new RxDualProfiler();
			m_accumDualProfiler = new RxDualProfiler();
			
			m_samplingProfiler = new RxSamplingProfiler();
			m_samplingProfiler.SampleInternalAllocs(false);
			m_samplingProfiler.TrackAllocs(false);

			var frameTimingProfiler:RxTimingProfiler = m_frameDualProfiler.GetTimingProfiler();
			var frameMemoryProfiler:RxMemoryProfiler = m_frameDualProfiler.GetMemoryProfiler();
			
			var accumTimingProfiler:RxTimingProfiler = m_accumDualProfiler.GetTimingProfiler();
			var accumMemoryProfiler:RxMemoryProfiler = m_accumDualProfiler.GetMemoryProfiler();
			
			frameTimingProfiler.GetTextField().SetColors(0xffffff, 0, 0x808080, 0.8);
			frameMemoryProfiler.GetTextField().SetColors(0xffffff, 0, 0x808080, 0.8);
			
			accumTimingProfiler.GetTextField().SetColors(0xffffff, 0, 0x808080, 0.8);
			accumMemoryProfiler.GetTextField().SetColors(0xffffff, 0, 0x808080, 0.8);
			
			m_frameDualProfiler.GetTimingProfiler().Enable(false);
			m_frameDualProfiler.GetMemoryProfiler().Enable(false);
			
			m_accumDualProfiler.GetTimingProfiler().Enable(true);
			m_accumDualProfiler.GetMemoryProfiler().Enable(true);
			
			this.SetState(PROFILE_SAMPLING, 60);
			
			this.m_updateCount = 0;
			this.m_appMemory = System.privateMemory;
			this.m_appMemoryUpdateFrames = 30;
			
			m_minTimingProfileData = new RxTimingProfileData();
			this.m_minTimingProfileData.Start("min", 0);
		}
		
		public function SetState(state:uint, frame:Object) : void
		{
			var curFrame:uint = 0;
			this.m_state = state;
			var frameIsChildOfStage:Boolean = this.m_frameDualProfiler.GetTimingProfiler().IsChildOfStage(this.m_stage);
			var accumIsChildOfStage:Boolean = this.m_accumDualProfiler.GetTimingProfiler().IsChildOfStage(this.m_stage);
			
			// 移除监控面板
			if (this.m_state == 0)
			{
				this.m_frameDualProfiler.GetTimingProfiler().Enable(false);
				this.m_frameDualProfiler.GetMemoryProfiler().Enable(false);
				if (frameIsChildOfStage)
				{
					this.m_frameDualProfiler.RemoveFromStage(this.m_stage);
				}
				if (accumIsChildOfStage)
				{
					this.m_accumDualProfiler.RemoveFromStage(this.m_stage);
				}
			}
			// 放大版监控
			else if (this.m_state == PROFILE_FRAME)
			{
				this.m_frameDualProfiler.GetTimingProfiler().Enable(true);
				this.m_frameDualProfiler.GetMemoryProfiler().Enable(true);
				if (!frameIsChildOfStage)
				{
					this.m_frameDualProfiler.AddToStage(this.m_stage);
				}
				if (accumIsChildOfStage)
				{
					this.m_accumDualProfiler.RemoveFromStage(this.m_stage);
				}
			}
			// 缩小版监控
			else if (this.m_state == PROFILE_FRAME_MIN)
			{
				this.m_frameDualProfiler.GetTimingProfiler().Enable(false);
				this.m_frameDualProfiler.GetMemoryProfiler().Enable(false);
				if (!frameIsChildOfStage)
				{
					this.m_frameDualProfiler.AddToStage(this.m_stage);
				}
				if (accumIsChildOfStage)
				{
					this.m_accumDualProfiler.RemoveFromStage(this.m_stage);
				}
			}
			// 统计
			else if (this.m_state == PROFILE_ACCUM)
			{
				this.m_frameDualProfiler.GetTimingProfiler().Enable(false);
				this.m_frameDualProfiler.GetMemoryProfiler().Enable(false);
				if (frameIsChildOfStage)
				{
					this.m_frameDualProfiler.RemoveFromStage(this.m_stage);
				}
				if (!accumIsChildOfStage)
				{
					this.m_accumDualProfiler.AddToStage(this.m_stage);
				}
			}
			// 抽样
			else if (this.m_state == PROFILE_SAMPLING)
			{
				this.m_frameDualProfiler.GetTimingProfiler().Enable(false);
				this.m_frameDualProfiler.GetMemoryProfiler().Enable(false);
				if (frameIsChildOfStage)
				{
					this.m_frameDualProfiler.RemoveFromStage(this.m_stage);
				}
				if (accumIsChildOfStage)
				{
					this.m_accumDualProfiler.RemoveFromStage(this.m_stage);
				}
				curFrame = uint(frame);
				if (this.m_samplingProfiler.CaptureFrames(curFrame))
				{
					this.m_samplingProfiler.ProcessSampleTypes(false, true);
					this.m_samplingProfiler.TrackAllocs(true);
				}
			}
			
			// 设置显示区域
			if (this.m_state == PROFILE_FRAME_MIN)
			{
				this.m_frameDualProfiler.GetTimingProfiler().GetTextField().SetRect(new Rectangle(0, 0, 180, 20));
				this.m_frameDualProfiler.GetMemoryProfiler().GetTextField().SetRect(new Rectangle(180, 0, 260, 20));
				this.m_accumDualProfiler.GetTimingProfiler().GetTextField().SetRect(new Rectangle(0, 0, 180, 20));
				this.m_accumDualProfiler.GetMemoryProfiler().GetTextField().SetRect(new Rectangle(180, 0, 260, 20));
			}
			else
			{
				this.m_frameDualProfiler.GetTimingProfiler().GetTextField().SetRect(new Rectangle(0, 0, 300, 280));
				this.m_frameDualProfiler.GetMemoryProfiler().GetTextField().SetRect(new Rectangle(300, 0, 420, 280));
				this.m_accumDualProfiler.GetTimingProfiler().GetTextField().SetRect(new Rectangle(0, 0, 300, 280));
				this.m_accumDualProfiler.GetMemoryProfiler().GetTextField().SetRect(new Rectangle(300, 0, 420, 280));
			}
		}
		
		public function UpdateTextFields() : void
		{
			if (m_state == 0) return;
			
			if (m_state == PROFILE_SAMPLING)
			{
				var num:int = this.m_samplingProfiler.Update();
				if (num)
				{
					Log.Info("\n********************************");
					Log.Info("**** sampler captured " + num + " frames\n");
					var stats:String = this.m_samplingProfiler.DumpTimingStats();
					Log.Info("**** timing sampling:\n" + stats);
					stats = this.m_samplingProfiler.DumpMemoryStats();
					Log.Info("**** memory sampling:\n" + stats);
					stats = this.m_samplingProfiler.DumpTrackedAllocs();
					Log.Info("**** tracked allocs:\n" + stats);
					Log.Info("********************************\n");
				}
			}
			else
			{
				var timingProfiler:RxTimingProfiler = this.m_frameDualProfiler.GetTimingProfiler();
				var memoryProfiler:RxMemoryProfiler = this.m_frameDualProfiler.GetMemoryProfiler();
				
				var avg:Number;
				var fps:Number;
				var freeMemory:Number;
				var totalMemory:Number;
				
				if (m_state == PROFILE_FRAME)
				{
					this.m_updateCount = this.m_updateCount + 1;
					
					if (m_updateCount % m_appMemoryUpdateFrames == 0)
					{
						this.m_appMemory = System.privateMemory;
					}
					
					var timingProfileData:RxTimingProfileData = timingProfiler.GetProfileData(0) as RxTimingProfileData;
					
					if (!timingProfileData) return;
					
					avg = timingProfileData.GetAverage();
					fps = 1000 / avg;
					freeMemory = System.freeMemory;
					totalMemory = System.totalMemoryNumber;
					
					this.m_frameDualProfiler.ClearTextField();
					timingProfiler.GetTextField().AddText("fps: " + fps.toFixed(1) + "\n\n");
					memoryProfiler.GetTextField().AddText("total: " + Utilities.scvt(totalMemory, 1) + ", free: " + Utilities.scvt(freeMemory, 1) + ", app: " + Utilities.scvt(this.m_appMemory, 1) + "\n\n");
					
					m_frameDualProfiler.UpdateTextField("timing:\n", "memory:\n", false, true, 1);
				}
				else if (m_state == PROFILE_FRAME_MIN)
				{
					this.m_minTimingProfileData.End();
					
					avg = m_minTimingProfileData.GetAverage();
					fps = 1000 / avg;
					freeMemory = System.freeMemory;
					totalMemory = System.totalMemoryNumber;
					this.m_frameDualProfiler.ClearTextField();
					timingProfiler.GetTextField().AddText("fps: " + fps.toFixed(1) + " (" + avg.toFixed(1) + " ms)");
					memoryProfiler.GetTextField().AddText("total: " + Utilities.scvt(totalMemory, 1) + ", free: " + Utilities.scvt(freeMemory, 1));
				}
				else if (m_state == PROFILE_ACCUM)
				{
					this.m_accumDualProfiler.UpdateTextField(null, null, true, false, 1);
				}
			}
		}
	}
}
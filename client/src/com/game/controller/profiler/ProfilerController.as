package com.game.controller.profiler
{
	import com.engine.profile.RxDualProfiler;
	import com.engine.profile.RxSamplingProfiler;
	import com.game.controller.Base;
	import com.game.core.RxProfilerState;
	import com.game.manager.LayerManager;

	public class ProfilerController extends Base
	{
		private var _profiler:RxProfilerState;
		public function get profiler() : RxProfilerState
		{
			return _profiler;
		}
		
		private var _samplingProfiler:RxSamplingProfiler;
		public function get samplingProfiler() : RxSamplingProfiler
		{
			return _samplingProfiler;
		}
		
		private var _frameDualProfiler:RxDualProfiler;
		public function get frameDualProfiler() : RxDualProfiler
		{
			return _frameDualProfiler;
		}
		
		private var _accumDualProfiler:RxDualProfiler;
		public function get accumDualProfiler() : RxDualProfiler
		{
			return _accumDualProfiler;
		}

		public function ProfilerController()
		{
		}
		
		public function init() : void
		{
			_profiler = new RxProfilerState(LayerManager.instance.cpu_stage);
			
			_samplingProfiler = _profiler.GetSamplingProfiler();
			_frameDualProfiler = _profiler.GetFrameDualProfiler();
			_accumDualProfiler = _profiler.GetAccumDualProfiler();
			
			this._controller.addToFrameProcessList(this.sign, updateProfile);
		}
		
		private function updateProfile() : void
		{
			this._frameDualProfiler.Start("mainLoop");
			_profiler.UpdateTextFields();
			
		}	
	}
}
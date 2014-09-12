package com.engine.profile
{
	import com.engine.utils.Utilities;
	
	import flash.display.Stage;
	import flash.sampler.*;
	import flash.utils.*;
	
	public class RxSamplingProfiler
	{
		private var m_framesCaptured:uint;
		private var m_framesToCapture:uint;
		private var m_timingSamples:Object;
		private var m_newSamples:Object;
		private var m_newSampleData:RxSampleData;
		private var m_delSampleData:RxSampleData;
		private var m_lastSampleTime:Number;
		private var m_processTimingSamples:Boolean;
		private var m_processMemorySamples:Boolean;
		private var m_trackAllocs:Boolean;
		private var m_allocs:Dictionary;
		private var m_numAllocs:uint;
		private var m_totalAllocSize:Number;
		
		public function RxSamplingProfiler()
		{
			this.m_framesCaptured = 0;
			this.m_framesToCapture = 0;
			this.m_timingSamples = {};
			this.m_newSamples = {};
			this.m_newSampleData = new RxSampleData("new");
			this.m_delSampleData = new RxSampleData("del");
			this.m_processTimingSamples = true;
			this.m_processMemorySamples = true;
			this.m_trackAllocs = false;
			this.m_allocs = new Dictionary();
			this.m_numAllocs = 0;
			this.m_totalAllocSize = 0;
		}
		
		/**
		 * 追踪分配 
		 * @param trackAllocs
		 * 
		 */		
		public function TrackAllocs(trackAllocs:Boolean) : void
		{
			this.m_trackAllocs = trackAllocs;
		}
		
		/**
		 * 采集帧 
		 * @param frame
		 * @return 
		 * 
		 */		
		public function CaptureFrames(frame:uint) : Boolean
		{
			if (frame == 0)
			{
				this.m_framesToCapture = this.m_framesCaptured + 1;
				return false;
			}
			if (frame == 65535)
			{
				frame = 0xffffff;
			}
			frame = Math.max(frame, 1);
			if (this.m_framesCaptured < this.m_framesToCapture)
			{
				return false;
			}
			
			this.BeginCapture();
			this.m_framesCaptured = 0;
			this.m_framesToCapture = frame;
			
			return true;
		}
		
		/**
		 * 开始采集 (初始化)
		 * @return 
		 * 
		 */		
		public function BeginCapture() : Boolean
		{
			if (this.m_framesCaptured < this.m_framesToCapture)
			{
				return false;
			}
			this.ClearTimingSamples();
			this.ClearMemorySamples();
			this.ClearTrackedAllocs();
			this.Start();
			this.m_framesCaptured = 0;
			this.m_framesToCapture = 1;
			
			return true;
		}
		
		/**
		 * 结束采集 
		 * @return 
		 * 
		 */		
		public function EndCapture() : Boolean
		{
			if (this.m_framesCaptured != this.m_framesToCapture)
			{
				return false;
			}
			
			Process();
			Stop();
			
			return true;
		}
		
		/**
		 * 更新 
		 * @return 
		 * 
		 */		
		public function Update() : uint
		{
			if (this.m_framesCaptured == this.m_framesToCapture)
			{
				return 0;
			}
			
			this.m_framesCaptured = this.m_framesCaptured + 1;
			if (this.m_framesCaptured == this.m_framesToCapture)
			{
				this.EndCapture();
				return this.m_framesCaptured;
			}
			
			return 0;
		}
		
		/**
		 * 采集数据对比 (排序)
		 * @param preData
		 * @param laData
		 * @return 
		 * 
		 */		
		private function SampleDataCompareFunction(preData:RxSampleData, laData:RxSampleData) : Number
		{
			return laData.GetSumValues() - preData.GetSumValues();
		}
		
		/**
		 * 导出时间状态信息
		 * @return 
		 * 
		 */		
		public function DumpTimingStats() : String
		{			
			var sampleDatas:Vector.<RxSampleData> = new Vector.<RxSampleData>;			
			for each (data in this.m_timingSamples)
			{
				sampleDatas.push(data);
			}			
			sampleDatas = sampleDatas.sort(this.SampleDataCompareFunction);
			
			var stats:String = '';
			var num:Number;
			for each (var data:RxSampleData in sampleDatas)
			{
				num = 0.001 * data.GetSumValues();
				stats = stats + (data.GetName() + ": " + data.GetNumSamples() + ", " + num.toFixed(1) + " ms\n");
			}
			
			Utilities.DeleteVector(sampleDatas);
			sampleDatas = null;
			
			return stats;
		}
		
		/**
		 * 导出内存状态信息 
		 * @return 
		 * 
		 */		
		public function DumpMemoryStats() : String
		{
			var sampleDatas:Vector.<RxSampleData> = new Vector.<RxSampleData>;
			for each (data in this.m_newSamples)
			{
				sampleDatas.push(data);
			}
			sampleDatas = sampleDatas.sort(this.SampleDataCompareFunction);
			
			var stats:String = '';
			for each (var data:RxSampleData in sampleDatas)
			{
				stats = stats + (data.GetName() + ": " + data.GetNumSamples() + ", " + Utilities.scvt(data.GetSumValues(), 1) + "\n");
			}
			
			Utilities.DeleteVector(sampleDatas);
			sampleDatas = null;
			
			stats = stats + ("total new: " + this.m_newSampleData.GetNumSamples() + ", " + Utilities.scvt(this.m_newSampleData.GetSumValues(), 1) + "\n");
			stats = stats + ("total delete: " + this.m_delSampleData.GetNumSamples() + ", " + Utilities.scvt(this.m_delSampleData.GetSumValues(), 1) + "\n");
			
			return stats;
		}
		
		/**
		 * 导出追踪分配信息 
		 * @return 
		 * 
		 */		
		public function DumpTrackedAllocs() : String
		{
			var frame:StackFrame;
			var info:String = "";
			for each (var sample:NewObjectSample  in this.m_allocs)
			{
				info = info + ("alloc " + sample.id + ": " + sample.type + " " + Utilities.scvt(sample.size, 1));
				if (sample.stack != null && sample.stack.length > 0)
				{
					frame = sample.stack[0];
					info = info + (" at " + frame.name + ", file: " + frame.file + ", line: " + frame.line);
				}
				info = info + "\n";
			}
			
			return info;
		}
		
		public function Process() : Number
        {
			pauseSampling();
			
            var sampleData:RxSampleData;
            var type:String;
            
			// 返回收集的样本数
            var sCount:Number = getSampleCount();			
			// 从上次采样会话中返回内存使用 Sample实例的对象
            var samples:Object = getSamples();
			
            for each (var sample:Sample in samples)
            {
				// NewObjectSample 类表示在 getSamples() 流中创建的对象
                if (sample is NewObjectSample)
                {
                    if (this.m_processMemorySamples)
                    {
						var newSample:NewObjectSample = NewObjectSample(sample);
                        this.m_newSampleData.AddSampleData(newSample.size);
						//与 getSamples() 流中创建的对象相对应的 Class 对象
                        type = String(newSample.type);
                        sampleData = this.m_newSamples[type];
                        if (sampleData == null)
                        {
                            sampleData = new RxSampleData(type);
                            this.m_newSamples[type] = sampleData;
                        }
                        sampleData.AddSampleData(newSample.size);
						
						// 是否追踪分配资源
                        if (this.m_trackAllocs)
                        {
                            this.m_allocs[newSample.id] = newSample;
							this.m_numAllocs = this.m_numAllocs + 1;
                            this.m_totalAllocSize = this.m_totalAllocSize + newSample.size;
                        }
                    }
                }
				// DeleteObjectSample 类表示在 getSamples() 流中创建的对象；每个 DeleteObjectSample 对象与一个 NewObjectSample 对象相对应
                else if (sample is DeleteObjectSample)
                {
                    if (this.m_processMemorySamples)
                    {
						var deleteSample:DeleteObjectSample = DeleteObjectSample(sample);
                        this.m_delSampleData.AddSampleData(deleteSample.size);
						
						// 释放分配资源
                        if (this.m_trackAllocs && this.m_allocs[deleteSample.id] != null)
                        {
                            this.m_allocs[deleteSample.id] = null;
                            delete this.m_allocs[deleteSample.id];
							this.m_numAllocs = this.m_numAllocs - 1;
                            this.m_totalAllocSize = this.m_totalAllocSize - deleteSample.size;
                        }
                    }
                }
				// Sample 类创建一些对象，它们保存不同时段的内存分析信息
                else if (sample is Sample)
                {
                    if (this.m_processTimingSamples && sample.stack.length != 0)
                    {
						// 通过 StackFrame 类可以访问包含函数的数据块的属性
						var sf:StackFrame = sample.stack[0];
                        type = sf.name;
						
                        sampleData = this.m_timingSamples[type];
                        if (sampleData == null)
                        {
                            sampleData = new RxSampleData(type);
                            this.m_timingSamples[type] = sampleData;
                        }
						
						var add:Number = this.m_lastSampleTime == 0 ? 0 : (sample.time - this.m_lastSampleTime);
                        sampleData.AddSampleData(add);
                    }
                }
				
                this.m_lastSampleTime = sample.time;
            }
			
			// 清除当前的 Sample 对象集合。通常在调用 getSamples() 并遍历 Sample 对象后调用此方法
            clearSamples();
			
            m_lastSampleTime = 0;
			
            return sCount;
        }
		
		/**
		 * 清除内存抽样 
		 * 
		 */		
		public function ClearMemorySamples() : void
		{
			Utilities.DeleteObject(this.m_newSamples);
			
			this.m_newSampleData.Clear();
			this.m_delSampleData.Clear();
		}
		
		/**
		 * 清除追踪分配 
		 * 
		 */		
		public function ClearTrackedAllocs() : void
		{
			Utilities.DeleteObject(this.m_allocs);
			
			this.m_numAllocs = 0;
			this.m_totalAllocSize = 0;
		}		
		
		public function ProcessSampleTypes(processTimingSamples:Boolean, processMemorySamples:Boolean) : void
		{
			this.m_processTimingSamples = processTimingSamples;
			this.m_processMemorySamples = processMemorySamples;
		}
		
		/**
		 * 启动采样过程 
		 * 
		 */		
		public function Start() : void
		{
			clearSamples();
			startSampling();
		}
		
		/**
		 *  结束采样
		 * 
		 */		
		public function Stop() : void
		{
			stopSampling();
		}
		
		/**
		 * 立即停止采样过程 
		 * 
		 */		
		public function Pause() : void
		{
			pauseSampling();
		}
		
		/**
		 * 开始采样过程 
		 * 
		 */		
		public function Resume() : void
		{
			startSampling();
		}
		
		/**
		 * 清除时间采样 
		 * 
		 */		
		public function ClearTimingSamples() : void
		{
			Utilities.DeleteObject(this.m_timingSamples);
		}
		
		// 如果应该为来自 Flash Player 的内部分配创建 NewObjectSamples，则告知取样器。如果设置为 true，
		// 则各个分配都将生成一个 NewObjectSample。这些内部分配将不包含类型或对对象的引用。它们将包含触发分配的 ActionScript 堆栈。
		// 默认值为 false，这将只收集对 ActionScript 对象的分配。
		public function SampleInternalAllocs(bol:Boolean) : void
		{
			sampleInternalAllocs(bol);
		}
		
		public function IsCapturing() : Boolean
		{
			return this.m_framesCaptured < this.m_framesToCapture;
		}
		
		public function GetNewSamples() : Object
		{
			return this.m_newSamples;
		}
		
		public function GetNewSampleData() : RxSampleData
		{
			return this.m_newSampleData;
		}
		
		public function GetDelSampleData() : RxSampleData
		{
			return this.m_delSampleData;
		}
		
		public function GetTimingSamples() : Object
		{
			return this.m_timingSamples;
		}
		
		public function GetAllocs() : Dictionary
		{
			return this.m_allocs;
		}
		
		public function GetNumAllocs() : uint
		{
			return this.m_numAllocs;
		}
		
		public function GetTotalAllocSize() : Number
		{
			return this.m_totalAllocSize;
		}
	}
}
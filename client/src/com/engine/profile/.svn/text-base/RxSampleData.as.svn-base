package com.engine.profile
{
	public class RxSampleData
	{
		private var m_name:String;
		// 数目
		private var m_numSamples:uint;
		// 对象总大小
		private var m_sumValues:Number;
		
		public function RxSampleData(name:String)
		{
			this.m_name = name;
			this.m_numSamples = 0;
			this.m_sumValues = 0;
		}
		
		public function Clear() : void
		{
			this.m_numSamples = 0;
			this.m_sumValues = 0;
		}
		
		/**
		 * 添加取样数据
		 * @param add
		 * 
		 */		
		public function AddSampleData(add:Number) : void
		{
			m_numSamples++;
			m_sumValues = m_sumValues + add;
		}
		
		public function GetName() : String
		{
			return this.m_name;
		}
		
		public function GetNumSamples() : uint
		{
			return this.m_numSamples;
		}
		
		public function GetSumValues() : Number
		{
			return this.m_sumValues;
		}
	}
}
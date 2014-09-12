package com.engine.profile
{
	public class RxMemoryProfiler extends RxProfiler
	{
		protected var m_profileDataBuffer:Vector.<RxMemoryProfileData>;
		
		public function RxMemoryProfiler()
		{
			super();
			
			this.m_profileDataBuffer = new Vector.<RxMemoryProfileData>;
		}
		
		override protected function GetOrCreateProfileData(count:uint) : RxProfileData
		{
			var profiledata:RxProfileData = null;
			if (count >= this.m_profileDataBuffer.length)
			{
				profiledata = new RxMemoryProfileData();
				this.m_profileDataBuffer.push(profiledata);
			}
			else
			{
				profiledata = this.m_profileDataBuffer[count];
			}
			
			return profiledata;
		}
		
		override public function GetProfileData(index:uint) : RxProfileData
		{
			return this.m_profileDataBuffer[index];
		}
	}
}
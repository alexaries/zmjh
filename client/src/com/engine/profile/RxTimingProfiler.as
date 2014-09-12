package com.engine.profile
{
	public class RxTimingProfiler extends RxProfiler
	{
		protected var m_profileDataBuffer:Vector.<RxTimingProfileData>;
		
		public function RxTimingProfiler()
		{
			super();
			
			this.m_profileDataBuffer = new Vector.<RxTimingProfileData>;
		}
		
		override protected function GetOrCreateProfileData(count:uint) : RxProfileData
		{
			var profiledata:RxProfileData;
			
			if (count >= this.m_profileDataBuffer.length)
			{
				profiledata = new RxTimingProfileData();
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
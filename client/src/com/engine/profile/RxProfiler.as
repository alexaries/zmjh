package com.engine.profile
{
	import com.engine.core.RxTextField;
	
	import flash.display.*;
	
	public class RxProfiler
	{
		protected var m_enabled:Boolean;
		protected var m_textField:RxTextField;
		protected var m_profileDataCount:uint;
		protected var m_profileDataStack:Vector.<int>;
		
		public function RxProfiler()
		{
			this.m_enabled = false;
			this.m_textField = new RxTextField(true, false);
			this.m_profileDataCount = 0;
			this.m_profileDataStack = new Vector.<int>;
		}
		
		public function GetTextField() : RxTextField
		{
			return this.m_textField;
		}
		
		public function Enable(enabled:Boolean) : void
		{
			this.m_enabled = enabled;
		}
		
		public function IsEnabled() : Boolean
        {
            return this.m_enabled;
        }
		
		public function IsChildOfStage(stage:Stage) : Boolean
		{
			return this.m_textField.GetTextField().parent == stage;
		}
		
		public function AddToStage(stage:Stage) : void
		{
			stage.addChild(m_textField.GetTextField());
		}
		
		public function RemoveFromStage(stage:Stage) : void
		{
			stage.removeChild(this.m_textField.GetTextField());
		}
		
		public function Start(type:String) : RxProfileData
		{
			if (!this.m_enabled) { return null;}
			
			var data:RxProfileData = GetOrCreateProfileData(this.m_profileDataCount);
			data.Start(type, this.m_profileDataStack.length);			
			this.m_profileDataStack.push(m_profileDataCount);			
			this.m_profileDataCount = this.m_profileDataCount + 1;
			
			return data;
		}
		
		public function  Pop() : RxProfileData
		{
			return this.GetProfileData(this.m_profileDataStack.pop());
		}
		
		public function End() : RxProfileData
		{
			if (!this.m_enabled)
			{
				return null;
			}
			var profileData:RxProfileData = this.GetProfileData(this.m_profileDataStack.pop());
			profileData.End();
			return profileData;
		}
		
		protected function GetOrCreateProfileData(count:uint) : RxProfileData
		{
			return null;
		}
		
		public function GetProfileData(param1:uint) : RxProfileData
		{
			return null;
		}
		
		public function Snapshot(name:String) : RxProfileData
		{
			if (!this.m_enabled)
			{
				return null;
			}
			var data:RxProfileData = this.GetOrCreateProfileData(this.m_profileDataCount);
			data.Snapshot(name);
			m_profileDataCount = this.m_profileDataCount + 1;
			return data;
		}
		
		public function ClearTextField() : void
		{
			this.m_textField.ClearText();
		}
		
		public function DumpStats(param1:String, param2:Boolean, param3:Boolean, param4:uint) : String
		{
			var data:RxProfileData = null;
			var i:int = 0;
			var stats:String = "";
			if (!this.m_enabled)
			{
				return stats;
			}
			if (this.m_profileDataStack.length > 0)
			{
				i = 0;
				while (i < this.m_profileDataCount)
				{
					
					data = this.GetProfileData(i);
					if (data.m_valueCount == 0)
					{
						return stats;
					}
					i++;
				}
			}
			if (this.m_profileDataCount)
			{
				if (param1 != null)
				{
					stats = stats + param1;
				}
				i = 0;
				while (i < this.m_profileDataCount)
				{
					
					data = this.GetProfileData(i);
					stats = stats + (data.ConvertToString(param2, param3, param4) + "\n");
					i++;
				}
			}
			this.m_profileDataCount = 0;
			return stats;
		}
		
		public function UpdateTextField(param1:String, param2:Boolean, param3:Boolean, param4:uint) : void
		{
			if (!this.m_enabled)
			{
				return;
			}
			var stats:String = this.DumpStats(param1, param2, param3, param4);
			this.m_textField.AddText(stats);
		}
	}
}
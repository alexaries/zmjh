package com.game
{
	public class ClassProxy extends Object
	{
		public function write(data:Object) : void
		{
			for (var key : Object in data)
			{
				
				if (this.hasOwnProperty(key))
				{
					this[key] = data[key];
				}
			}
		}
	}
}
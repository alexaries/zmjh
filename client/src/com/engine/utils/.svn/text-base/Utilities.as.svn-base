package com.engine.utils
{
	import flash.net.registerClassAlias;
	import flash.system.System;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class Utilities
	{
		public function Utilities()
		{
		}
		
		/**
		 * 获取对象 
		 * @param obj
		 * @param key
		 * @return 
		 * 
		 */		
		public static function searchObject(obj:Object, key:String) : Object
		{
			var obj:Object;
			
			for (var item:String in obj)
			{
				if (item == key)
				{
					obj = item;
					break;
				}
			}
			
			return obj;
		}
		
		
		/**
		 * 删除对象 
		 * @param obj
		 * 
		 */		
		public static function DeleteObject(obj:Object) : void
		{
			while (!IsObjectEmpty(obj))
			{
				
				for (var key:String in obj)
				{
					obj[key] = null;
					delete obj[key];
				}
			}
		}
		
		/**
		 * 检测对象是否为空 
		 * @param obj
		 * @return 
		 * 
		 */		
		public static function IsObjectEmpty(obj:Object) : Boolean
		{
			var IsEmpty:Boolean = true;
			for (var key:String in obj)
			{
				
				IsEmpty = false;
				break;
			}
			
			return IsEmpty;
		}
		
		/**
		 * 强制内存回收 
		 * imminence:Number (default = 0.75) — 一个介于 0 和 1 之间的数字，其中 0 表示不紧急，1 表示最紧急。小于 0 的值默认为 0.25。大于 1.0 的值默认为 1.0。NaN 默认为 0.75
		 */		
		public static function ForceGarbageCollection() : void
		{
			System.pauseForGCIfCollectionImminent(0);
		}
		
		/**
		 * 统计对象数组长度 
		 * @param obj
		 * @return 
		 * 
		 */		
		public static function CountObjectElements(obj:Object) : uint
		{
			var index:uint = 0;
			for each(var item:* in obj)
			{
				
				index = index + 1;
			}
			
			return index;
		}
		
		/**
		 * 获取一定区间的随机值 
		 * @param startIndex
		 * @param endIndex
		 * @return 
		 * 
		 */		
		public static function GetRandomIntegerInRange(startIndex:int, endIndex:int) : int
		{
			return Math.floor(startIndex + Math.random() * (endIndex - startIndex + 1));
		}
		
		public static function GetBalanceInRange(startIndex:int, endIndex:int) : int
		{
			return Math.floor((startIndex+endIndex) * .5);
		}
		
		public static function getRandomNumberInRange(startIndex:Number, endIndex:Number) : Number
		{
			var value:Number;
			if(startIndex >= 0)
			{
				value = Math.floor(startIndex + Math.pow(Math.random(), 2) * (endIndex - startIndex + 1));
			}
			else
			{
				value = Math.floor(Math.abs(startIndex) + Math.pow(Math.random(), 2) * (Math.abs(endIndex) - Math.abs(startIndex) + 1));
				value = -value;
			}
			return value
		}
		
		/**
		 * 除法的余浮点数 
		 * @param N1
		 * @param N2
		 * @return 
		 * 
		 */		
		public static function Fmod(N1:Number, N2:Number) : Number
		{
			return N1 - N2 * Math.floor(N1 / N2);
		}
		
		/**
		 * 格式化UTC时间s 
		 * @param time
		 * @return 
		 * 
		 */		
		public static function ConvertToReadableUTCDate(time:Date) : String
		{
			var year:String = time.getUTCFullYear().toString();
			var month:String = (time.getUTCMonth() + 1).toString();
			var date:String = time.getUTCDate().toString();
			var hours:String = time.getUTCHours().toString();
			var minutes:String = time.getUTCMinutes().toString();
			var seconds:String = time.getUTCSeconds().toString();
			var mseconds:String = time.getUTCMilliseconds().toString();
			if (month.length < 2)
			{
				month = "0" + month;
			}
			if (date.length < 2)
			{
				date = "0" + date;
			}
			if (hours.length < 2)
			{
				hours = "0" + hours;
			}
			if (minutes.length < 2)
			{
				minutes = "0" + minutes;
			}
			if (seconds.length < 2)
			{
				seconds = "0" + seconds;
			}
			if (mseconds.length < 3)
			{
				mseconds = "0" + mseconds;
			}
			if (mseconds.length < 3)
			{
				mseconds = "0" + mseconds;
			}
			
			return year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds + "." + mseconds;
		}
		
		/**
		 * 计算对象大小 
		 * @param size
		 * @param p
		 * @return 
		 * 
		 */		
		public static function scvt(size:Number, p:uint) : String
		{
			var unit:String;
			size = Math.abs(size);
			if (Math.abs(size) < 1024)
			{
				unit = "B";
			}
			else if (size < 1024 * 1024)
			{
				unit = "KB";
				size = size * (1 / 1024);
			}
			else if (size < 1024 * 1024 * 1024)
			{
				unit = "MB";
				size = size * (1 / (1024 * 1024));
			}
			else
			{
				unit = "GB";
				size = size * (1 / (1024 * 1024 * 1024));
			}

			return size.toFixed(p) + " " + unit;
		}
		
		/**
		 * 格式化时间成可读形式 
		 * @param time
		 * @return 
		 * 
		 */		
		public static function ConvertToReadableTime(time:int) : String
		{
			var result:String;
			
			var h:int = time / (60 * 60 * 1000);
			time = time - h * (60 * 60 * 1000);
			var m:int = time / (60 * 1000);
			time = time - m * (60 * 1000);
			var s:int = time / 1000;
			time = time - s * 1000;
			
			var info:String;
			
			info = time.toString();
			if (info.length < 3)
			{
				info = "0" + info;
			}
			result = info + "ms";
			
			info = s.toString();
			if (info.length < 2)
			{
				info = "0" + info;
			}
			result = info + "s " + result;
			
			info = m.toString();
			if (m > 0 || h > 0)
			{
				if (info.length < 2)
				{
					info = "0" + info;
				}
				
				result = info + "m " + result;
			}
			
			if (h > 0)
			{
				info = h.toString();
				result = info + "h " + result;
			}
			
			return result;
		}
		
		/**
		 * 清除Vector 
		 * @param vector
		 * 
		 */		
		public static function DeleteVector(vector:Object) : void
		{
			if (vector != null)
			{
				var i:int = 0;
				while (i < vector.length)
				{
					
					vector[i] = null;
					i++;
				}
				
				vector.length = 0;
			}
		}
		
		/**
		 * 获取文件类型 
		 * @param fileName
		 * @return
		 * 
		 */		
		public static function getLoadType(fileName:String) : String
		{
			var type:String = "";
			type = fileName.split(".")[1];
			return type;
		}
		
		/**
		 * 对象赋值
		 * @param obj
		 * @param value
		 * @return 
		 * 
		 */		
		public static function assignObj(obj:*, value:Object) : *
		{
			for (var key:String in value)
			{
				if (obj.hasOwnProperty(key))
				{
					obj[key] = value[key];
				}
			}
			
			return obj;
		}
		
		/*
		*   深度拷贝，最好用于普通对象上，不要用于自定义类上
		*   obj: 要拷贝的对象
		*   return ：返回obj的深度拷贝
		*/
		public static function clone(obj:Object) : *
		{  
			var copier:ByteArray = new ByteArray();
			copier.writeObject(obj);
			copier.position = 0;
			return copier.readObject();
		}
		
		/**
		 * 是否命中概率 
		 * @param rate
		 * @return 
		 * 
		 */		
		public static function hitProbability(rate:Number) : Boolean
		{
			rate = Math.abs(rate);
			
			var isHit:Boolean = false;
			
			var random:Number = Math.random();
			isHit = random > rate ? false : true;
			
			return isHit;
		}
		
		/**
		 *输入一个整形数字，分解该数字各个位数上的值，返回一个数组记录该数字从高位到低位的数值。 
		 * @param num
		 * 
		 */		
		public static function seperate(num:int) : Array
		{
			var str:String=num.toString();
			var count:uint=str.length;
			var arr:Array=new Array();
			for(var i:uint=0;i<count;i++)
			{
				var bitStr:String=str.substring(i , i+1);
				var bitNum:uint=parseInt(bitStr);
				arr.push(bitNum);
			}
			
			return arr;
		}
		
		/**
		 * 注册类对象 
		 * @param source
		 * 
		 */		
		public static function overrideRegisterClassAlias(source:Object) : void
		{
			var typeName:String = getQualifiedClassName(source);//获取全名  
			//return;  
			var packageName:String = typeName.split("::")[0];//切出包名  
			var type:Class = getDefinitionByName(typeName) as Class;//获取Class  
			registerClassAlias(packageName, type);//注册Class 
		}
	}
}
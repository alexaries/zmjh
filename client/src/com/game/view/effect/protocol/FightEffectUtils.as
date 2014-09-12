package com.game.view.effect.protocol
{
	public class FightEffectUtils
	{
		
		public static function parseXML(configXML:XML) : Vector.<FightEffectConfigData>
		{
			var data:Vector.<FightEffectConfigData> = new Vector.<FightEffectConfigData>();
			
			var configData:FightEffectConfigData;
			for each(var item:XML in configXML.item)
			{
				configData = new FightEffectConfigData();
				configData.init(item);
				data.push(configData);
			}
			
			return data;
		}
		
		public static function parseFrameXML(frameXML:XML) : Vector.<FightEffectFrameData>
		{
			var data:Vector.<FightEffectFrameData> = new Vector.<FightEffectFrameData>();
			
			var frameData:FightEffectFrameData;
			for each(var item:XML in frameXML.frame)
			{
				frameData = new FightEffectFrameData();
				frameData.init(item);
				data.push(frameData);
			}
			
			return data;
		}
	}
}
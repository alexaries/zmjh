package com.game.view.fight.begin
{
	import com.game.view.effect.protocol.FightEffectFrameData;
	import com.game.view.effect.protocol.FightEffectUtils;

	public class AMEffect extends BaseBeginEffect
	{
		public var frameDatas:Vector.<FightEffectFrameData>;
		
		public function AMEffect()
		{
			super();
			
			frameDatas = new Vector.<FightEffectFrameData>();
		}
		
		override protected function parseConfig() : void
		{
			super.parseConfig();
			
			frameDatas =  FightEffectUtils.parseFrameXML(_config);
		}
	}
}
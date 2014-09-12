package com.game.view.fight.begin
{
	import com.game.controller.Base;

	public class FightBeginEffectItemData
	{
		private var _config:XML;

		public var name:String;
		
		public var item_type:String;
		
		public var texture_name:String;
		
		public var layer:int;
		
		public var begin_frame:int;
		
		private var _effects:Vector.<BaseBeginEffect>;
		public function get effects() : Vector.<BaseBeginEffect>
		{
			return _effects;
		}
		
		public function FightBeginEffectItemData()
		{
			_effects = new Vector.<BaseBeginEffect>();
		}
		
		public function initData(config:XML) : void
		{
			_config = config;
			
			parseConfig();
		}
		
		private function parseConfig() : void
		{
			name = _config.@name;
			item_type = _config.@item_type;
			texture_name = _config.@texture_name;
			layer = _config.@layer;
			begin_frame = _config.@begin_frame;
			
			var type:String;
			var baseBeginEffect:BaseBeginEffect;
			for each(var effectXML:XML in _config.effect)
			{
				type = effectXML.@type;
				
				switch (type)
				{
					// 静止
					case "Stand":
						baseBeginEffect = new StandEffect();
						break;
					// 缓动
					case "TL":
						baseBeginEffect = new TLEffect();
						break;
					// 运动
					case "AM":
						baseBeginEffect = new AMEffect();
						break;
				}
				
				baseBeginEffect.initData(effectXML);
				_effects.push(baseBeginEffect);
			}
		}
	}
}
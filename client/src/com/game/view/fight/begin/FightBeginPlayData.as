package com.game.view.fight.begin
{
	public class FightBeginPlayData
	{
		private var _config:XML;
		
		private var _total_frame:int;
		public function get total_frame() : int
		{
			return _total_frame;
		}
		
		private var _items:Vector.<FightBeginEffectItemData>;
		public function get items() : Vector.<FightBeginEffectItemData>
		{
			return _items;
		}
		
		public function FightBeginPlayData()
		{
			_items = new Vector.<FightBeginEffectItemData>();
		}
		
		public function initData(config:XML) : void
		{
			_config = config;
			
			parseConfig();
		}
		
		private function parseConfig() : void
		{
			_total_frame = _config.effects[0].@total_frame;
			
			var effectItem:FightBeginEffectItemData;
			for each(var item:XML in _config.effects[0].item)
			{
				effectItem = parseItem(item);
				_items.push(effectItem);
			}
		}
		
		private function parseItem(data:XML) : FightBeginEffectItemData
		{
			var effectItem:FightBeginEffectItemData = new FightBeginEffectItemData();
			effectItem.initData(data);
			
			return effectItem;
		}
	}
}
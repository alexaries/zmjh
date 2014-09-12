package com.game.data.player
{
	import com.game.Data;
	import com.game.data.Base;
	import com.game.data.player.structure.Player;

	public class GlowingInfo extends Base
	{
		public function get player() : Player
		{
			return _data.player.player;
		}
		
		private var _glowingDetail:Vector.<GlowingDetail>;
		public function get glowingDetail() : Vector.<GlowingDetail>
		{
			return  _glowingDetail;
		}
		
		public function set glowingDetail(value:Vector.<GlowingDetail>) : void
		{
			_glowingDetail = value;
		}
		
		public function GlowingInfo()
		{
			_glowingDetail = new Vector.<GlowingDetail>();
		}
		
		public function init(data:XML) : void
		{
			var info:GlowingDetail;
			for each(var item:XML in data.item)
			{
				info = new GlowingDetail();
				info.glowingTime = item.@glowingTime;
				info.startName = item.@startName;
				info.endName = item.@endName;
				
				_glowingDetail.push(info);
			}
		}
		
		public function getXML() : XML
		{
			var item:XML;
			var info:XML = <glowing></glowing>;
			
			for (var i:int = 0; i < _glowingDetail.length; i++)
			{
				item = <item glowingTime={_glowingDetail[i].glowingTime} startName={_glowingDetail[i].startName} endName={_glowingDetail[i].endName}/>
				info.appendChild(item);
			}
			
			return info;
		}
		
		public function addGlowing(startName:String, endName:String) : void
		{
			var info:GlowingDetail = new GlowingDetail();
			
			info.glowingTime = Data.instance.time.curTimeStr;
			info.startName = startName;
			info.endName = endName;
			
			_glowingDetail.push(info);
		}
	}
}
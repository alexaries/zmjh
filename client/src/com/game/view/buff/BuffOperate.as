package com.game.view.buff
{
	import com.game.Data;
	import com.game.View;
	import com.game.data.db.protocal.Prop;
	import com.game.data.player.structure.Player;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.equip.PropTip;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class BuffOperate
	{
		private static function get player() :Player
		{
			return Data.instance.player.player;
		}
		
		public function BuffOperate()
		{
		}
		
		public static function createBuffImage(image:Image, buffType:int, propID:int, panel:Sprite) : Image
		{
			var props:Prop = Data.instance.db.interfaces(InterfaceTypes.GET_PROP_BY_ID, propID);
			var texture:Texture = View.instance.icon.interfaces(InterfaceTypes.GetTexture, "props_" + propID);
			image = new Image(texture);
			image.name = props.name;
			image.data = new Object();
			image.data[0] = buffType;
			image.data[1] = propID;
			panel.addChild(image);
			image.visible = false;
			
			return image;
		}
		
		/**
		 * Buff图标显示
		 * 
		 */		
		public static function checkBuff(_propBuff:Vector.<Image>, _propTip:PropTip) : void
		{
			var buff:Image;
			if(!View.instance.map.isClose)
			{
				var showBuff:Vector.<Image> = new Vector.<Image>();
				for each(buff in _propBuff)
				{
					if(player.multiRewardInfo.checkOver(buff.data[0]))
					{
						showBuff.push(buff);
						var index:int = showBuff.indexOf(buff);
						buff.y = int(index / 2) * 50 + 80;
						buff.x = -index % 2 * 50 + 885;
						buff.visible = true;
						var info:String;
						if(buff.data[1] != 43)
							info = "还剩余" + player.multiRewardInfo.returnLastTime(buff.data[0]) + "场战斗";
						else
							info = "还剩余" + player.roleFashionInfo.returnLastTime(V.MAIN_ROLE_NAME, "NewDress") + "天";
						_propTip.removeProp(buff.name);
						_propTip.add({o:buff,m:{name:buff.name, message:info}});
					}
					else
						buff.visible = false;
				}
			}
			else
			{
				for each(buff in _propBuff)
				{
					buff.visible = false;
				}
			}
		}
	}
}
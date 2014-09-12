package com.game.view.dailyWork
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.db.protocal.Daily_work;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.effect.GlowAnimationEffect;
	import com.game.view.equip.PropTip;
	import com.game.view.ui.UIConfig;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class DailyWorkComponent extends Component
	{
		public function DailyWorkComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
		}
		
		private var _dailyImage:Image;
		private var _dailyWorkName:TextField;
		private var _dailyWorkComplete:TextField;
		private var _dailyWorkReward1:TextField;
		private var _dailyWorkReward2:TextField;
		private var _dailyWorkCompleteImage:Image;
		private var _glowEffect:GlowAnimationEffect;
		
		private function getUI() : void
		{
			_dailyWorkName = this.searchOf("DailyWorkName");
			_dailyWorkComplete = this.searchOf("DailyWorkComplete");
			_dailyWorkReward1 = this.searchOf("DailyReward1");
			_dailyWorkReward2 = this.searchOf("DailyReward2");
			_dailyWorkCompleteImage = (this.searchOf("DailyWorkCompleteImage") as Image);
			_dailyWorkCompleteImage.visible = false;
			
			_glowEffect = new GlowAnimationEffect(panel, 0xFF0000);
		}
		
		private function renderImage():void
		{
			var texture:Texture = getTexture("DailyWorkImage_" + _nowData.id, "");
			_dailyImage = new Image(texture);
			_dailyImage.pivotX = int(_dailyImage.width * .5);
			_dailyImage.pivotY = int(_dailyImage.height * .5);
			_dailyImage.x = 50;
			_dailyImage.y = 50;
			_dailyImage.readjustSize();
			panel.addChild(_dailyImage);
			_dailyImage.addEventListener(TouchEvent.TOUCH, onGetReward);
		}
		
		private var _nowData:Daily_work;
		private var _propTip:PropTip;
		override public function setGridData(data:*) : void
		{
			_nowData = data as Daily_work;
			
			renderImage();
			render();
 		}
		
		private function render() : void
		{
			_dailyWorkName.text = _nowData.name;
			_dailyWorkReward1.text = "骰子X" + _nowData.prop_number;
			_dailyWorkReward2.text = "金币X" + _nowData.gold;
			renderTF();
			if(player.dailyThingInfo.completeStatus[_nowData.id - 1] == 1)
			{
				if(player.dailyThingInfo.getRewardStatus[_nowData.id - 1] == 1)
				{
					_dailyWorkCompleteImage.visible = true;
					_dailyImage.useHandCursor = false;
					_dailyImage.removeEventListener(TouchEvent.TOUCH, onGetReward);
					_glowEffect.stop();
					panel.filter = new GrayscaleFilter();
				}
				else
				{
					_dailyWorkCompleteImage.visible = false;
					_dailyImage.useHandCursor = true;
					_dailyImage.touchable = true;
					_glowEffect.play();
				}
			}
			else
				_dailyImage.useHandCursor = true;
			
			if(_propTip == null)
			{
				_propTip = _view.ui.interfaces(UIConfig.PROP_TIP);
				_propTip.add({o:panel,m:{name:_nowData.name, message:_nowData.infomation}});
			}
		}
		
		private function renderTF():void
		{
			if(player.dailyThingInfo.completeStatus[_nowData.id - 1] == 1)
			{
				if(_nowData.id == 6)
				{
					if(player.mainRoleModel.model.lv < 5)
						_dailyWorkComplete.text = player.dailyThingInfo.littleCompleteTime[_nowData.id - 1] + "/" + player.dailyThingInfo.littleCompleteTime[_nowData.id - 1];
					else 
						_dailyWorkComplete.text = player.dailyThingInfo.completeTime[_nowData.id - 1] + "/" + player.dailyThingInfo.completeTime[_nowData.id - 1];
				}
				else
					_dailyWorkComplete.text = player.dailyThingInfo.completeTime[_nowData.id - 1] + "/" + player.dailyThingInfo.completeTime[_nowData.id - 1];
			}
			else
			{
				if(_nowData.id == 6)
				{
					if(player.mainRoleModel.model.lv < 5)
						_dailyWorkComplete.text = player.dailyThingInfo.checkPlugin() + "/" + player.dailyThingInfo.littleCompleteTime[_nowData.id - 1];
					else 
						_dailyWorkComplete.text = player.dailyThingInfo.checkPlugin() + "/" + player.dailyThingInfo.completeTime[_nowData.id - 1];
				}
				else if(_nowData.id == 10)
					_dailyWorkComplete.text = (player.playerFightInfo.fightTime>4?4:player.playerFightInfo.fightTime) + "/" + player.dailyThingInfo.completeTime[_nowData.id - 1];
				else if(_nowData.id == 11)
					_dailyWorkComplete.text = player.dailyThingInfo.checkDailyTask() + "/" + player.dailyThingInfo.completeTime[_nowData.id - 1];
				else
					_dailyWorkComplete.text = "0/1";
			}
			
		}
		
		private function onGetReward(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_dailyImage);
			if(!touch) return;
			if(touch && touch.phase == TouchPhase.ENDED)
			{
				if(player.dailyThingInfo.completeStatus[_nowData.id - 1] == 1)
				{
					if(player.dailyThingInfo.getRewardStatus[_nowData.id - 1] == 0)
					{
						Log.Trace("获得奖励");
						if((player.dice + int(_nowData.prop_number)) > V.DICE_MAX_NUM)
						{
							_view.tip.interfaces(InterfaceTypes.Show,
								"骰子数量达到最大值，建议消耗之后再领取！是否继续领取？",
								function () : void{Starling.juggler.delayCall(getComplete, .1);}, null, false);
						}
						else
							getComplete();
					}
				}
				else
				{
					gotoInterface();
				}
				
			}
		}
		
		/**
		 * 根据不同事件去向不同界面
		 * 
		 */		
		private function gotoInterface():void
		{
			_view.daily_work.hide();
			switch(_nowData.id)
			{
				case 1:
					_view.toolbar.unStretchButton();
					_view.signIn.interfaces();
					break;
				case 2:
					_view.toolbar.unStretchButton();
					_view.prompEffect.play("请选择一个关卡！");
					break;
				case 3:
					_view.equip_strengthen.interfaces(InterfaceTypes.REFRESH_PART, "StrengthLabel");
					break;
				case 4:
					_view.equip_strengthen.interfaces(InterfaceTypes.REFRESH_PART, "DecomposeLabel");
					break;
				case 5:
					_view.equip_strengthen.interfaces(InterfaceTypes.REFRESH_PART, "ComposeLabel");
					break;
				case 6:
					_view.toolbar.unStretchButton();
					_view.pluginGame.interfaces();
					break;
				case 7:
					_view.toolbar.unStretchButton();
					_view.endless_battle.interfaces();
					break;
				case 8:
					_view.world_boss.interfaces();
					break;
				case 9:
					_view.double_level.interfaces();
					break;
				case 10:
					_view.player_fight.interfaces();
					break;
				case 11:
					_view.toolbar.unStretchButton();
					_view.task.interfaces();
					break;
			}
		}
		
		private function getComplete() : void
		{
			_view.tip.interfaces(InterfaceTypes.Show,
				"获得：骰子X" + _nowData.prop_number + "、金币X" + _nowData.gold,
				null, null, false, true, false);
			
			player.dice += int(_nowData.prop_number);
			player.money += int(_nowData.gold);
			player.dailyThingInfo.setRewardComplete(_nowData.id);
			render();
			_view.daily_work.interfaces(InterfaceTypes.REFRESH);
		}
		
		public function clearOwn() : void
		{
			_dailyWorkName.dispose();
			_dailyWorkComplete.dispose();
			_dailyWorkReward1.dispose();
			_dailyWorkReward2.dispose();
			_dailyWorkCompleteImage.texture.dispose();
			_dailyWorkCompleteImage.dispose();
			if(panel.parent) panel.parent.removeChild(panel);
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new DailyWorkComponent(_configXML, _titleTxAtlas);
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else
			{
				textures = _titleTxAtlas.getTextures(name);
			}
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			if (type == "public")
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			
			return texture;
		}
		
		override public function clear() : void
		{
			
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			super.destroy();
		}
	}
}
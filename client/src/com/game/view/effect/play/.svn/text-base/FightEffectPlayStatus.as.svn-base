package com.game.view.effect.play
{
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.structure.FightRound;
	import com.game.manager.FontManager;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.effect.FightEffectConfig;
	import com.game.view.effect.FightEffectView;
	import com.game.view.effect.protocol.FightEffectConfigData;
	import com.game.view.effect.protocol.FightEffectPlayer;
	import com.game.view.fight.FightRoleComponent;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class FightEffectPlayStatus extends BasePlay implements IPlay
	{
		public static const PLAY_DELAY_TIME:int = 10;
		public static const SKILL_START_DELAY_TIME:Number = 0.2;
		public static const SKILL_END_DELAY_TIME:Number = 0.5;
		
		public var playDelayTime:int = 10;
		public var skillStartDelayTime:Number = 0.2;
		public var skillEndDelayTime:Number = 0.5;
		
		public function FightEffectPlayStatus()
		{
			super();
		}
		
		private var _callback:Function;
		private var _statesNum:int;
		public function onPlay(callback:Function) : void
		{
			_callback = callback;
			
			_statesNum = _fightEffectView.fightRound.attack.states.length;
			
			// 没有状态
			if (_statesNum <= 0)
			{
				_callback();
				return;
			}
			
			playEffect();
		}
		
		private function playEffect() : void
		{
			var state:String;
			state = _fightEffectView.fightRound.attack.states[_statesNum - 1];
			stateShow();
			switch (state)
			{
				// 中毒
				case FightConfig.POISON:
					play(_fightEffectView.attackTarget, FightEffectConfig.POSION);
					break;
				// 晕阙状态
				case FightConfig.SYNCOPE:
					play(_fightEffectView.attackTarget, FightEffectConfig.SYNCOPE);
					break;
				// 睡眠
				case FightConfig.ASLEEP:
					play(_fightEffectView.attackTarget, FightEffectConfig.ASLEEP);
					break;
				// 混乱
				case FightConfig.CONFUSION:
					play(_fightEffectView.attackTarget, FightEffectConfig.CONFUSION);
					break;
				// 醉酒
				case FightConfig.DRUNK:
					play(_fightEffectView.attackTarget, FightEffectConfig.DRUNK);
					break;
				// 石灰
				case FightConfig.LINE:
					play(_fightEffectView.attackTarget, FightEffectConfig.LINE);
					break;
			}
		}
		
		private function stateShow() : void
		{
			if(_fightEffectView.fightRound.attack.remainHP <= 0)  return;
			var str:String = getBuffColor(_fightEffectView.fightRound.attack.states[_statesNum - 1]);
			if(_fightEffectView.fightRound.attack.buffs.length >= _statesNum)
			{
				var count:int = (_fightEffectView.fightRound.attack.buffs[_statesNum - 1].lastTime - _fightEffectView.fightRound.attack.buffs[_statesNum - 1].time);
				str += "第" + count + "回合！";
			}
			else
			{
				str += "回合结束！";
			}
			
			onSkillName(str, 0xffffff);
		}
		
		private function getBuffColor(str:String) : String
		{
			var result:String = "";
			switch(str)
			{
				case FightConfig.SYNCOPE:
					result = "晕";
					break;
				case FightConfig.POISON:
					result = "毒";
					break;
				case FightConfig.ASLEEP:
					result = "睡";
					break;
				case FightConfig.DRUNK:
					result = "醉";
					break;
				case FightConfig.LINE:
					result = "灰";
					break;
				case FightConfig.CONFUSION:
					result = "乱";
					break;
			}
			return result;
		}
		
		private function onSkillName(str:String, color:uint) : void
		{
			var skillName:TextField = createSkillTF(color);
			skillName.text = str;
			
			var tween:Tween = new Tween(skillName, skillStartDelayTime);
			tween.moveTo(skillName.x, -skillName.height);
			tween.onComplete = function () : void
			{
				tween = new Tween(skillName, 0);
				tween.delay = skillEndDelayTime;
				tween.onComplete = function () : void
				{
					if (skillName.parent) skillName.parent.removeChild(skillName);
					skillName.dispose();
					skillName = null;
				}
				_view.fightEffect.addAnimatable(tween);
			};
			_view.fightEffect.addAnimatable(tween);
		}
		
		private function createSkillTF(color:uint) : TextField
		{
			var skillName:TextField;
			skillName = new TextField(130, 40, "");
			skillName.fontName = FontManager.instance.font ? FontManager.instance.font.fontName : "宋体";
			skillName.vAlign = VAlign.CENTER;
			skillName.hAlign = HAlign.CENTER;
			skillName.color = color;
			skillName.fontSize = 20;
			
			_fightEffectView.attackTarget.panel.addChild(skillName);
			skillName.x  = 22;
			skillName.y = 5;
			
			return skillName;
		}
		
		private function checkStatesComplete() : void
		{
			_statesNum -= 1;
			
			// 特效全部播放完
			if (_statesNum <= 0)
			{
				_callback();
			}
			else
			{
				playEffect();
			}
		}
		
		private function play(component:Component, type:String) : void
		{
			var texture_index:int = FightEffectConfig.TEXTURE_INDEX[type];
			var atlas:TextureAtlas = (texture_index == 2 ? _fightEffectView.titleTxAtlas2 : _fightEffectView.titleTxAtlas1);
			
			var itemData:FightEffectConfigData = _fightEffectView.getFightEffectData(type);
			var play:FightEffectPlayer = new FightEffectPlayer();
			play.type = type;
			play.initData(itemData, atlas, playDelayTime);
			play.addEventListener(Event.COMPLETE, onPlayComplete);
			component.panel.addChild(play);
			
			play.x = itemData.X;
			play.y = itemData.Y;
		}
		
		private function onPlayComplete(e:Event) : void
		{
			var target:FightEffectPlayer = e.currentTarget as FightEffectPlayer;
			target.parent.removeChild(target);
			target.removeEventListeners();
			target.dispose();
			
			if (target.type == FightEffectConfig.POSION)
			{
				_fightEffectView.attackTarget.setHPAndMP(_fightEffectView.fightRound.attack, checkStatesComplete);
			}
			else
			{
				checkStatesComplete();
			}
			
			target = null;
		}
	}
}
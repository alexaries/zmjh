package com.game.view.effect.play
{
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.structure.DefendRoundData;
	import com.game.data.fight.structure.SkillBuff;
	import com.game.manager.FontManager;
	import com.game.view.Component;
	import com.game.view.effect.FightEffectConfig;
	import com.game.view.effect.protocol.FightEffectConfigData;
	import com.game.view.effect.protocol.FightEffectPlayer;
	import com.game.view.fight.FightRoleComponent;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class FightEffectPlaySkillBuff extends BasePlay implements IPlay
	{
		public static const PLAY_DELAY_TIME:int = 10;
		public static const SKILL_START_DELAY_TIME:Number = 0.2;
		public static const SKILL_END_DELAY_TIME:Number = 0.5;
		
		public var playDelayTime:int = 10;
		public var skillStartDelayTime:Number = 0.2;
		public var skillEndDelayTime:Number = 0.5;
		public function FightEffectPlaySkillBuff()
		{
			super();
		}
		
		private var _callback:Function;
		public function onPlay(callback:Function) : void
		{
			_callback = callback;
			
			_attackComplete = false;
			_defendComplete = false;
			
			onPlayAttack();
			onPlayDefend();
		}
		
		private function checkStatesComplete() : void
		{
			if (_attackComplete && _defendComplete)
			{
				_callback();
			}
		}
		
		private var _attackComplete:Boolean;
		private var _attackNewBuffNum:int;
		private function onPlayAttack() : void
		{
			_fightEffectView.attackTarget.setBuffs(_fightEffectView.fightRound.attack.buffs);
			
			_attackNewBuffNum = _fightEffectView.fightRound.attack.newBuffs.length;
			
			if (_attackNewBuffNum == 0)
			{
				_attackComplete = true;
				checkStatesComplete();
				return;
			}
			
			for each(var buff:SkillBuff in _fightEffectView.fightRound.attack.newBuffs)
			{
				playBuff(_fightEffectView.attackTarget, _fightEffectView.fightRound.attack.newBuffs, FightEffectConfig.ATTACK);
			}
		}
		
		private function checkAttackPlayComplete() : void
		{
			_attackNewBuffNum -= 1;
			
			if (_attackNewBuffNum == 0)
			{
				_attackComplete = true;
				checkStatesComplete();
			}
		}
		
		private var _defendComplete:Boolean;
		private var _defendNewBuffNum:int;
		private function onPlayDefend() : void
		{
			// 被攻击者（有可能没有如攻击者处于晕阙 睡眠）
			if (!_fightEffectView.fightRound.defend || _fightEffectView.fightRound.defend.length == 0)
			{
				_defendComplete = true;
				checkStatesComplete();
				return;
			}
			
			var roleComponent:FightRoleComponent;
			var defendData:DefendRoundData;
			
			_defendNewBuffNum = 0;
			
			for (var i:int = 0; i <　_fightEffectView.fightRound.defend.length; i++)
			{
				roleComponent = _fightEffectView.defends[i];
				defendData = _fightEffectView.fightRound.defend[i];
				// buff状态
				roleComponent.setBuffs(defendData.buffs);
				playBuff(roleComponent, defendData.newBuffs, FightEffectConfig.DEFEND);
			}
			
			if (_defendNewBuffNum <= 0)
			{
				_defendComplete = true;
				checkStatesComplete();
			}
		}
		
		/*private function stateShow(defendData:DefendRoundData) : void
		{
			var str:String = "";
			if(_defendNewBuffNum > 0 && _fightEffectView.fightRound.attack.newBuffs.length >= _defendNewBuffNum)
			{
				var count:int = (_fightEffectView.fightRound.attack.newBuffs[_defendNewBuffNum - 1].lastTime - _fightEffectView.fightRound.attack.newBuffs[_defendNewBuffNum - 1].time);
				
			}
			trace(str);
			//onSkillName(str);
		}*/
		
		private function checkDefendBuffComplete() : void
		{
			_defendNewBuffNum -= 1;
			if (_defendNewBuffNum <= 0)
			{
				_defendComplete = true;
				checkStatesComplete();
			}
		}
		
		private function playBuff(component:FightRoleComponent, newBuffs:Vector.<SkillBuff>, position:String) : void
		{			
			var buffPlayName:String;
			for each(var buff:SkillBuff in newBuffs)
			{
				switch (buff.buff_name)
				{
					case FightConfig.POISON:
						buffPlayName = FightEffectConfig.POSION;
						_defendNewBuffNum += 1;
						break;
					case FightConfig.SYNCOPE:
						buffPlayName = FightEffectConfig.SYNCOPE;
						_defendNewBuffNum += 1;
						break;
					case FightConfig.DRUNK:
						buffPlayName = FightEffectConfig.DRUNK;
						_defendNewBuffNum += 1;
						break;
					case FightConfig.LINE:
						buffPlayName = FightEffectConfig.LINE;
						_defendNewBuffNum += 1;
						break;
					case FightConfig.ASLEEP:
						buffPlayName = FightEffectConfig.ASLEEP;
						_defendNewBuffNum += 1;
						break;
					case FightConfig.CONFUSION:
						buffPlayName = FightEffectConfig.CONFUSION;
						_defendNewBuffNum += 1;
						break;
					default:
						throw new Error(buff.buff_name);
				}
				
				if (newBuffs.length != 0)
				{
					play(component, buffPlayName, position);
					if(buffPlayName == FightEffectConfig.SYNCOPE || buffPlayName == FightEffectConfig.ASLEEP)
					{
						var str:String = getBuffColor(buffPlayName);
						onSkillName((str + "第1回合！"), component);
					}
				}
			}
		}
		
		private function getBuffColor(str:String) : String
		{
			var result:String = "";
			switch(str)
			{
				case "中眩晕":
					result = "晕";
					break;
				case "中睡眠":
					result = "睡";
					break;
			}
			return result;
		}
		
		private function play(component:FightRoleComponent, type:String, position:String) : void
		{
			var texture_index:int = FightEffectConfig.TEXTURE_INDEX[type];
			var atlas:TextureAtlas = (texture_index == 2 ? _fightEffectView.titleTxAtlas2 : _fightEffectView.titleTxAtlas1);
			
			var itemData:FightEffectConfigData = _fightEffectView.getFightEffectData(type);
			var play:FightEffectPlayer = new FightEffectPlayer();
			play.position = position;
			play.initData(itemData, atlas, playDelayTime);
			play.addEventListener(Event.COMPLETE, onPlayComplete);
			component.panel.addChild(play);
			
			play.x = itemData.X;
			play.y = itemData.Y;
		}
		
		private function onSkillName(str:String, component:FightRoleComponent) : void
		{
			var skillName:TextField = createSkillTF(component);
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
		
		private function createSkillTF(component:FightRoleComponent) : TextField
		{
			var skillName:TextField;
			skillName = new TextField(130, 40, "");
			skillName.fontName = FontManager.instance.font ? FontManager.instance.font.fontName : "宋体";
			skillName.vAlign = VAlign.CENTER;
			skillName.hAlign = HAlign.CENTER;
			skillName.color = 0xffffff;
			skillName.fontSize = 20;
			
			component.panel.addChild(skillName);
			skillName.x  = 22;
			skillName.y = 5;
			
			return skillName;
		}
		
		private function onPlayComplete(e:Event) : void
		{
			var target:FightEffectPlayer = e.currentTarget as FightEffectPlayer;
			var position:String = target.position;
			target.parent.removeChild(target);
			target.removeEventListeners();
			target.dispose();
			target = null;
			
			switch (position)
			{
				case FightEffectConfig.DEFEND:
					checkDefendBuffComplete();
					break;
				case FightEffectConfig.ATTACK:
					checkAttackPlayComplete();
					break;
			}
		}
	}
}
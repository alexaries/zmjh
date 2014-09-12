package com.game.view.fight
{
	import com.game.data.db.protocal.BaseRole;
	import com.game.data.db.protocal.Characters;
	import com.game.data.fight.FightConfig;
	import com.game.data.fight.FightModelStructure;
	import com.game.data.fight.structure.AttackRoundData;
	import com.game.data.fight.structure.BaseModel;
	import com.game.data.fight.structure.BaseRoundData;
	import com.game.data.fight.structure.Battle_EnemyModel;
	import com.game.data.fight.structure.Battle_WeModel;
	import com.game.data.fight.structure.DefendRoundData;
	import com.game.data.fight.structure.Hurt;
	import com.game.template.V;
	import com.game.view.Component;
	
	import flash.events.Event;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.filters.BlurFilter;
	import starling.filters.GrayscaleFilter;
	import starling.filters.IdentityFilter;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class PlayerComponent extends Component
	{
		// 初始数据
		private var _initData:BaseModel;
		public function get initData() : BaseModel
		{
			return _initData;
		}
		
		// 立场（敌人还是我方）
		private var _stand:String;
		public function get stand() : String
		{
			return _stand;
		}
		
		// 当前角色维护数值
		private var _modelRole:BaseRole;
		
		public function PlayerComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
		}
		
		/**
		 * 开始 
		 * 
		 */		
		override public function initRender(model:BaseModel, stand:String) : void
		{
			_initData = model;
			_stand = stand;
			
			switch (_stand)
			{
				case V.ME:
					_modelRole = (_initData as Battle_WeModel).characterModel;
					break;
				case V.ENEMY:
					_modelRole = (_initData as Battle_EnemyModel).enemyModel;
					break;
			}
			
			initUI();
			render();
		}

		protected function render() : void
		{
			_nameTf.text = _modelRole.name;
			_LVTF.text = "LV." + _modelRole.lv;
			_HPTF.text = _modelRole.hp.toString() + "/" + _modelRole.hp.toString();
			_MPTF.text = _modelRole.mp.toString() + "/" + _modelRole.mp.toString();
		}
		
		protected function setHPAndMP(model:BaseRoundData) : void
		{
			var hpPer:Number = model.remainHP / _modelRole.hp;
			_HPTF.text = model.remainHP + "/" + _modelRole.hp;
			// 死亡变灰
			if (hpPer == 0) 
			{
				_roleImage.filter = new GrayscaleFilter();
			}
			
			var mpPer:Number = model.remainMP / _modelRole.mp;
			_MPTF.text = model.remainMP + "/" + _modelRole.mp;
			
			// 进度条
			_hpBar.width = Math.floor(hpPer * _hpWidth);
			_mpBar.width = Math.floor(mpPer * _mpWidth);
		}
		
		/**
		 * 防御
		 * @param model
		 * 
		 */
		public function defend(model:BaseRoundData) : void
		{
			setHPAndMP(model);
			
			// buff状态
			_roleState.text = model.getBuffInfo();
			
			commonEffect(model);
		}
		
		// 被攻击效果
		private function commonEffect(model:BaseRoundData) : void
		{
			switch ((model as DefendRoundData).hurtType)
			{
				case FightConfig.DODGE:
					_SpecialHarm.text = "闪避";
					_SpecialHarm.color = 0xf000ff;
					FightEffect.injuredNumEffect(_view, _SpecialHarm, 143);
					break;
				case FightConfig.SKILL_ATTACK:
					_SpecialHarm.text = (model as DefendRoundData).skill.skill_name;
					_SpecialHarm.color = 0x5ff44;
					FightEffect.injuredNumEffect(_view, _SpecialHarm, 143);
					break;
			}
			
			_NormalHarm.text = "-" + (model as DefendRoundData).hurtHPValue.toString();
			_NormalHarm.color = 0xffffff;
			
			FightEffect.injuredNumEffect(_view, _NormalHarm, 53);
		}
		
		/**
		 * 攻击 
		 * @param model
		 * 
		 */
		private var _tween:Tween;
		private var dis:int;
		public function attack(model:BaseRoundData) : void
		{
			setHPAndMP(model);
			_roleState.text = model.getBuffInfo();
			
			// 多种伤害
			var totalHurt:int = 0;
			for each( var hurt:Hurt in  (model as AttackRoundData).hurts)
			{
				totalHurt += hurt.value;
			}
			
			if (totalHurt > 0)
			{
				_NormalHarm.text = "-" + totalHurt;
				_NormalHarm.color = 0xffffff;
				FightEffect.injuredNumEffect(_view, _NormalHarm, 53);
			}
			
			// 攻击状态（晕眩 与睡眠状态不能进行对外攻击）
			if ((model as AttackRoundData).attackType != FightConfig.SYNCOPE && (model as AttackRoundData).attackType != FightConfig.ASLEEP)
			{
				FightEffect.attackEffect(_view, _roleImage, _stand);
			}
		}
		
		
		// 获取元件
		private var _nameTf:TextField;
		private var _LVTF:TextField;
		private var _HPTF:TextField;
		private var _MPTF:TextField;
		private var _roleImage:Image;
		private var _hpBar:Image;
		private var _mpBar:Image;
		private var _hpWidth:int;
		private var _mpWidth:int;
		private var _NormalHarm:TextField;
		private var _SpecialHarm:TextField;
		private var _roleState:TextField;
		protected function initUI() : void
		{
			if (!_nameTf) 
			{
				_nameTf = this.searchOf("Tx_RoleName");
				_nameTf.color = 0xffff33;
			}
			
			if (!_LVTF)
			{
				_LVTF = this.searchOf("Tx_RoleLevel");
				_LVTF.color = 0xffffff;
			}
			
			if (!_HPTF) _HPTF = this.searchOf("Tx_Hp");
			if (!_MPTF) _MPTF = this.searchOf("Tx_Mp");
			if (!_roleImage) 
			{
				_roleImage = this.searchOf("RoleImage");
			}
			_roleImage.filter = null;
			
			if (!_hpBar) 
			{
				_hpBar = this.searchOf("RoleHpBar");
				_hpWidth = _hpBar.width;
			}
			_hpBar.width = _hpWidth;
			
			if (!_mpBar)
			{
				_mpBar = this.searchOf("RoleMpBar");
				_mpWidth = 	_mpBar.width;
			}
			_mpBar.width = _mpWidth;
			
			if (!_NormalHarm)
			{
				_NormalHarm = this.searchOf("NormalHarm");
				_NormalHarm.color = 0xB00000;
				_NormalHarm.fontSize = 25;
			}
			
			if (!_SpecialHarm)
			{
				_SpecialHarm = this.searchOf("SpecialHarm");
				_SpecialHarm.color = 0xB0ff00;
				_SpecialHarm.fontSize = 25;
			}
			
			if (!_roleState)
			{
				_roleState = this.searchOf("RoleState");
				_roleState.color = 0xB00000;
				_roleState.fontSize = 10;
			}
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new PlayerComponent(_configXML, _titleTxAtlas);
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
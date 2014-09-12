package com.game.data.fight.structure
{
	import com.engine.core.Log;
	import com.game.data.db.protocal.Battle_we;
	import com.game.data.db.protocal.Characters;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.db.protocal.Equipment_strengthen;
	import com.game.data.db.protocal.Fight_soul;
	import com.game.data.db.protocal.Level_up;
	import com.game.data.db.protocal.Quality_up;
	import com.game.data.db.protocal.Skill;
	import com.game.data.fight.FightConfig;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;

	public class Battle_WeModel extends BaseModel
	{
		// 最终数值
		protected var _characterModel:Characters;
		public function get characterModel() : Characters
		{
			return _characterModel;
		}
		
		// 基础属性值
		private var _characterConfig:Characters;
		public function get characterConfig() : Characters
		{
			return _characterConfig;
		}
		
		private var _config:Battle_we;
		public function get config() : Battle_we
		{
			return _config;
		}
		
		private var _roleModel:RoleModel;
		public function get roleModel() : RoleModel
		{
			return _roleModel;
		}
		
		private var _position:String;
		
		/**
		 * 开始初始化计算用的 
		 */		
		private var _countCharacterModel:Characters;
		public function get countCharacterModel() : Characters
		{
			return _countCharacterModel;
		}
		
		public function beginInitCountModel() : void
		{
			_countCharacterModel = new Characters();
			_countCharacterModel.name = _characterModel.name;
			
			//　维护数据
			_countCharacterModel.hp = _roleModel.hp;
			_countCharacterModel.mp = _roleModel.mp;
		}
		
		public function Battle_WeModel()
		{
			super();
		}
		
		/**
		 *当前角色步法值 （含buff）
		 * @return 
		 * 
		 */		
		public function get spd() : int
		{
			var spd:int = this._characterModel.spd;
			
			return spd;
		}
		
		/**
		 * 基础值解析
		 * @param config
		 * @param position
		 * 
		 */		
		public function parse(model:RoleModel, position:String) : void
		{
			_roleModel = model;
			_config = model.battleWe;
			_position = position;
			
			_characterConfig = model.configData;
			_skills = WeCharacterUtitiles.getSkillDatas(_config);		
			_characterModel = model.model;
		}
	}
}
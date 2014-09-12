package com.game.data.formation
{
	import com.game.View;
	import com.game.data.Base;
	import com.game.data.db.protocal.Adventures;
	import com.game.data.fight.FightConfig;
	import com.game.data.player.structure.Player;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;

	public class FormationData extends Base
	{
		private var _player:Player;
		
		public function FormationData()
		{
		}
		
		public function initFormation() : void
		{
			_player = _data.player.player;
		}
		
		public function setRoleHPChange(rateCount:Number) : void
		{
			var formationData:Object = getFormationData();
			if (formationData["front"])
			{
				setRoleHPData(formationData["front"], rateCount);
			}
			
			if (formationData["middle"])
			{
				setRoleHPData(formationData["middle"], rateCount);
			}
			
			if (formationData["back"])
			{
				setRoleHPData(formationData["back"], rateCount);
			}
		}
			
		private function setRoleHPData(roleData:RoleModel, rateCount:Number) : void
		{
			if (roleData.hp <= 0) return;
			
			if (rateCount != 0)
			{
				roleData.hp -= rateCount * roleData.model.hp;
				
				// 打雷事件扣血不能导致死亡，故最低保留hp=1；
				if (roleData.hp <= 0) roleData.hp = 1;
			}
		}
		
		/**
		 *设置由于奇遇事件造成的buff 
		 * @param adventures
		 * 
		 */		
		public function setRoleModelDataByAdventures(adventures:Adventures) : void
		{
			var formationData:Object = getFormationData();
			
			if (formationData["front"])
			{
				setRoleData(formationData["front"], adventures);
			}
			
			if (formationData["middle"])
			{
				setRoleData(formationData["middle"], adventures);
			}
			
			if (formationData["back"])
			{
				setRoleData(formationData["back"], adventures);
			}
		}
		
		protected function setRoleData(roleData:RoleModel, adventures:Adventures) : void
		{
			// 角色死完
			if (roleData.hp <= 0) return;
			
			if (adventures.hp_up != 0)
			{
				roleData.hp += adventures.hp_up * roleData.model.hp;
			}
			
			if (adventures.hp_down != 0)
			{
				roleData.hp -= adventures.hp_down * roleData.model.hp;
				
				// 奇遇事件扣血不能导致死亡，故最低保留hp=1；
				if (roleData.hp <= 0) roleData.hp = 1;
			}
			
			if (adventures.mp_up != 0)
			{
				roleData.mp += adventures.mp_up * roleData.model.mp;
			}
			
			if (adventures.mp_down != 0)
			{
				roleData.mp -= adventures.mp_down * roleData.model.mp;
			}
		}
		
		/**
		 * 设置默认的战附位置 
		 * @param roleName
		 * 
		 */		
		public function setDefaultPosition(roleName:String) : void
		{
			var roleModel:RoleModel = _player.getRoleModel(roleName);
			
			if (!_player.formation.front || _player.formation.front == "")
			{
				_player.formation.front = roleName;
				if(roleModel) roleModel.position = FightConfig.FRONT_POS;
			}
			else if (!_player.formation.middle || _player.formation.middle == "")
			{
				_player.formation.middle = roleName;
				if(roleModel) roleModel.position = FightConfig.MIDDLE_POS;
			}
			else if (!_player.formation.back || _player.formation.back == "")
			{
				_player.formation.back = roleName;
				if(roleModel) roleModel.position = FightConfig.BACK_POS;
			}
			else if (_player.formation.front != V.MAIN_ROLE_NAME)
			{
				removeTransposition(_player.formation.front, FightConfig.FRONT_POS);
				// 要替换的角色
				_player.formation.front = roleName;
				if(roleModel) roleModel.position = FightConfig.FRONT_POS;
			}
			else if (_player.formation.middle != V.MAIN_ROLE_NAME)
			{
				removeTransposition(_player.formation.middle, FightConfig.MIDDLE_POS);
				// 要替换的角色
				_player.formation.middle = roleName;
				if(roleModel) roleModel.position = FightConfig.MIDDLE_POS;
			}
			else if (_player.formation.back != V.MAIN_ROLE_NAME)
			{
				removeTransposition(_player.formation.back, FightConfig.BACK_POS);
				// 要替换的角色
				_player.formation.back = roleName;
				if(roleModel) roleModel.position = FightConfig.BACK_POS;
			}
			
			roleModel.countFightAttack();
		}
		
		/**
		 * 移除 
		 * @param roleName
		 * @param position
		 * 
		 */		
		public function removeTransposition(roleName:String, position:String) : void
		{
			switch (position)
			{
				case FightConfig.FRONT_POS:
					_player.formation.front = "";
					break;
				case FightConfig.MIDDLE_POS:
					_player.formation.middle = "";
					break;
				case FightConfig.BACK_POS:
					_player.formation.back = "";
					break;
			}
			
			var roleModel:RoleModel = _player.getRoleModel(roleName);
			roleModel.position = '';
			roleModel.countFightAttack();
			
			View.instance.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
		
		/**
		 * 获得战附信息 
		 * @return 
		 * 
		 */		
		public function getFormationData() : Object
		{
			var data:Object = {"front":null, "middle":null, "back":null};
			
			if (_player.formation.front && _player.formation.front != "")
			{
				data["front"] = _player.getRoleModel(_player.formation.front);
			}
			
			if (_player.formation.middle && _player.formation.middle != "")
			{
				data["middle"] = _player.getRoleModel(_player.formation.middle);
			}
			
			if (_player.formation.back && _player.formation.back != "")
			{
				data["back"] = _player.getRoleModel(_player.formation.back);
			}
			
			return data;
		}
		
		/**
		 * 设置阵型 
		 * @param sIndex
		 * @param eIndex
		 * 
		 */		
		public function setTransposition(sIndex:int, eIndex:int, refreshDetailView:Boolean) : void
		{
			var sName:String = getPosName(sIndex);
			var eName:String = getPosName(eIndex);
			
			setPosName(sIndex, eName);
			setPosName(eIndex, sName);
			
			if(refreshDetailView) View.instance.role.interfaces(InterfaceTypes.REFRESH);
			View.instance.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
		}
		
		private function setPosName(index:int, value:String) : void
		{
			var roleModel:RoleModel = _player.getRoleModel(value);
			
			switch (index)
			{
				case 0:
					_player.formation.front = value;
					if(roleModel) roleModel.position = FightConfig.FRONT_POS;
					break;
				case 1:
					_player.formation.middle = value;
					if(roleModel) roleModel.position = FightConfig.MIDDLE_POS;
					break;
				case 2:
					_player.formation.back = value;
					if(roleModel) roleModel.position = FightConfig.BACK_POS;
					break;
			}	
			
			if(roleModel) roleModel.countFightAttack();
		}
		
		/**
		 * 获得当前位置上的信息 
		 * @param index
		 * @return 
		 * 
		 */		
		private function getPosName(index:int) : String
		{
			var name:String;
			
			switch (index)
			{
				case 0:
					name = _player.formation.front;
					break;
				case 1:
					name = _player.formation.middle;
					break;
				case 2:
					name = _player.formation.back;
					break;
			}
			
			return name;
		}
	}
}
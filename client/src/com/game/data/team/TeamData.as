package com.game.data.team
{
	import com.game.data.Base;
	import com.game.data.player.structure.Player;

	public class TeamData extends Base
	{
		private var _player:Player;
		
		public function initTeam() : void
		{
			_player = _data.player.player;
		}
		
		public function setTeam(roleName:String) : void
		{
			var team:Array = [];//_player.team;
			
			if (team.indexOf(roleName) != -1) return;
			
			if (team.length >= 3) team[team.length - 1] = roleName;
			else team.push(roleName);
		}
		
		public function removeTeam(roleName:String) : void
		{
			var index:int = 0;//_player.team.indexOf(roleName);
			if (index == -1) throw new Error("错误的角色");
			
			//_player.team.splice(index, 1);
		} 
	}
}
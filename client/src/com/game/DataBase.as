package com.game
{
	import com.game.data.Activity.ActivityData;
	import com.game.data.Activity.ActivityMidAutumnData;
	import com.game.data.Activity.ActivityNationalData;
	import com.game.data.LevelSelect.AutoFightData;
	import com.game.data.LevelSelect.LVSelectData;
	import com.game.data.daily.DailyData;
	import com.game.data.daily.DailyThingData;
	import com.game.data.daily.MissonData;
	import com.game.data.db.DBData;
	import com.game.data.douleLevel.DoubleLevelData;
	import com.game.data.equip.EquipData;
	import com.game.data.equip.EquipStrengthenData;
	import com.game.data.fight.FightData;
	import com.game.data.formation.FormationData;
	import com.game.data.guide.GuideData;
	import com.game.data.martial.MartialData;
	import com.game.data.online.OnlineTimeData;
	import com.game.data.pack.PackData;
	import com.game.data.pack.PlayerKillingPackData;
	import com.game.data.player.PlayerData;
	import com.game.data.player.structure.GuideInfo;
	import com.game.data.playerFight.playerFightData;
	import com.game.data.playerKilling.PlayerKillingData;
	import com.game.data.playerKilling.PlayerKillingPlayerData;
	import com.game.data.plugin.PluginGameData;
	import com.game.data.prop.PropData;
	import com.game.data.role.RoleSelectData;
	import com.game.data.save.PayData;
	import com.game.data.save.RankData;
	import com.game.data.save.SaveData;
	import com.game.data.shop.ShopData;
	import com.game.data.shop.VIPInfo;
	import com.game.data.shop.VipData;
	import com.game.data.skill.SkillData;
	import com.game.data.start.StartData;
	import com.game.data.time.TimeData;
	import com.game.data.union.UnionData;
	import com.game.data.worldBoss.WorldBossData;
	import com.game.manager.DebugManager;
	import com.game.manager.ResCacheManager;

	public class DataBase extends DataSuperBase implements IBase
	{
		public function get db() : DBData
		{
			return this.createObject(DBData) as DBData;
		}
		
		public function get fight() : FightData
		{
			return this.createObject(FightData) as FightData;
		}
		
		public function get playerKillingFight() : PlayerKillingData
		{
			return this.createObject(PlayerKillingData) as PlayerKillingData;
		}
		
		public function get player() : PlayerData
		{
			return this.createObject(PlayerData) as PlayerData;
		}
		
		public function get playerKillingPlayer() : PlayerKillingPlayerData
		{
			return this.createObject(PlayerKillingPlayerData) as PlayerKillingPlayerData;
		}
		
		public function get equip() : EquipData
		{
			return this.createObject(EquipData) as EquipData; 
		}
		
		public function get pack() : PackData
		{
			return this.createObject(PackData) as PackData; 
		}
		
		public function get playerKillingPack() : PlayerKillingPackData
		{
			return this.createObject(PlayerKillingPackData) as PlayerKillingPackData; 
		}
		
		public function get skill() : SkillData
		{
			return this.createObject(SkillData) as SkillData; 
		}
		
		public function get formation() : FormationData
		{
			return this.createObject(FormationData) as FormationData; 
		}
		
		public function get lvSelect() : LVSelectData
		{
			return this.createObject(LVSelectData) as LVSelectData; 
		}
		
		public function get start() : StartData
		{
			return this.createObject(StartData) as StartData;
		}
		
		public function get time() : TimeData
		{
			return this.createObject(TimeData) as TimeData;
		}
		
		public function get save() : SaveData
		{
			return this.createObject(SaveData) as SaveData;
		}
		
		public function get daily() : DailyData
		{
			return this.createObject(DailyData) as DailyData;
		}
		
		public function get plugin() : PluginGameData
		{
			return this.createObject(PluginGameData) as PluginGameData;
		}
		
		public function get misson() : MissonData
		{
			return this.createObject(MissonData) as MissonData;
		}
		
		public function get onlineTime() : OnlineTimeData
		{
			return this.createObject(OnlineTimeData) as OnlineTimeData;
		}
		
		public function get pay() : PayData
		{
			return this.createObject(PayData) as PayData;
		}
		
		public function get rank() : RankData
		{
			return this.createObject(RankData) as RankData;
		}
		
		public function get shop() : ShopData
		{
			return this.createObject(ShopData) as ShopData;
		}
		
		public function get guide() : GuideData
		{
			return this.createObject(GuideData) as GuideData;
		}
		
		public function get martial() : MartialData
		{
			return this.createObject(MartialData) as MartialData;
		}
		
		public function get equip_strengthen() : EquipStrengthenData
		{
			return this.createObject(EquipStrengthenData) as EquipStrengthenData;
		}
		
		public function get role_select() : RoleSelectData
		{
			return this.createObject(RoleSelectData) as RoleSelectData;
		}
		
		public function get double_level() : DoubleLevelData
		{
			return this.createObject(DoubleLevelData) as DoubleLevelData;
		}
		
		public function get world_boss() : WorldBossData
		{
			return this.createObject(WorldBossData) as WorldBossData;
		}
		
		public function get activity() : ActivityData
		{
			return this.createObject(ActivityData) as ActivityData;
		}
		
		public function get player_fight() : playerFightData
		{
			return this.createObject(playerFightData) as playerFightData;
		}
		
		public function get activity_main() : ActivityMidAutumnData
		{
			return this.createObject(ActivityMidAutumnData) as ActivityMidAutumnData;
		}
		
		public function get activity_national() : ActivityNationalData
		{
			return this.createObject(ActivityNationalData) as ActivityNationalData;
		}
		
		public function get prop_data() : PropData
		{
			return this.createObject(PropData) as PropData;
		}
		
		public function get union() : UnionData
		{
			return this.createObject(UnionData) as UnionData;
		}
		
		public function get vip() : VipData
		{
			return this.createObject(VipData) as VipData;
		}
		
		public function get daily_thing() : DailyThingData
		{
			return this.createObject(DailyThingData) as DailyThingData;
		}
		
		public function get auto_fight() : AutoFightData
		{
			return this.createObject(AutoFightData) as AutoFightData;
		}
		
		public function DataBase()
		{
			super();
		}
		
		public function init(controller:Controller) : void
		{
			_control = controller;
			this._res = ResCacheManager.instance;
			this._debug = DebugManager.instance;
			
			preInitModel();
		}
		
		public function preInitModel() : void
		{
			time.reqTime();
		}
	}
}
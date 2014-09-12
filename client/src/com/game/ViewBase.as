package com.game
{
	import com.game.data.player.structure.Player;
	import com.game.manager.DebugManager;
	import com.game.manager.FontManager;
	import com.game.manager.LayerManager;
	import com.game.manager.ResCacheManager;
	import com.game.manager.SoundPlayerManager;
	import com.game.view.AppendAttribute.AppendAttributeView;
	import com.game.view.LevelEvent.AdventuresView;
	import com.game.view.LevelEvent.OpenItemBoxView;
	import com.game.view.LevelSelect.LevelSelectView;
	import com.game.view.PublicRes.NewActivityView;
	import com.game.view.PublicRes.PublicResView;
	import com.game.view.Role.GlowingInstructionView;
	import com.game.view.Role.MartialInstructionView;
	import com.game.view.Role.RoleBigView;
	import com.game.view.Role.RoleDetailView;
	import com.game.view.Role.RoleGainSkillView;
	import com.game.view.Role.RoleGainView;
	import com.game.view.Role.RoleImageView;
	import com.game.view.Role.RoleLVUpView;
	import com.game.view.Role.RoleResView;
	import com.game.view.Role.RoleSelectView;
	import com.game.view.Role.TransferInstructionView;
	import com.game.view.Role.TransferRoleTypeView;
	import com.game.view.Role.WeatherPropView;
	import com.game.view.Role.WeatherSelectView;
	import com.game.view.activity.ActivityNationalPassView;
	import com.game.view.activity.ActivityView;
	import com.game.view.activity.AutumnFestivalView;
	import com.game.view.activity.GlowingView;
	import com.game.view.activity.IntegrationView;
	import com.game.view.activity.MoonCakeView;
	import com.game.view.activity.NationalDayView;
	import com.game.view.activity.TanabataView;
	import com.game.view.activity.TwoFestivalView;
	import com.game.view.cartoon.CartoonView;
	import com.game.view.daily.DailyView;
	import com.game.view.daily.SignInView;
	import com.game.view.daily.TaskItemBoxView;
	import com.game.view.daily.TaskView;
	import com.game.view.dailyWork.DailyWorkView;
	import com.game.view.dialog.DialogView;
	import com.game.view.dice.BuyDiceView;
	import com.game.view.dice.DiceView;
	import com.game.view.dice.FreeDiceView;
	import com.game.view.doubleLevel.DoubleLevelView;
	import com.game.view.effect.EventEffectView;
	import com.game.view.effect.FightEffectView;
	import com.game.view.effect.OtherEffectView;
	import com.game.view.effect.PrompEffectView;
	import com.game.view.endless.EndlessBattlesView;
	import com.game.view.endless.EndlessFightView;
	import com.game.view.endless.EndlessInstructionView;
	import com.game.view.endless.EndlessPropBoxView;
	import com.game.view.equip.ComposeInstructionView;
	import com.game.view.equip.DecomposeInstructionView;
	import com.game.view.equip.EquipStrengthenView;
	import com.game.view.equip.EquipView;
	import com.game.view.equip.StrengthenInstructionView;
	import com.game.view.fight.AutoFightView;
	import com.game.view.fight.FightBeginView;
	import com.game.view.fight.FightEffect;
	import com.game.view.fight.FightView;
	import com.game.view.fight.SpeedChangeView;
	import com.game.view.guide.FirstGuideView;
	import com.game.view.guide.GetRoleGuideView;
	import com.game.view.guide.GuideView;
	import com.game.view.icon.IconView;
	import com.game.view.instruction.InstructionView;
	import com.game.view.load.LoadDataView;
	import com.game.view.load.LoadView;
	import com.game.view.load.PreLoadView;
	import com.game.view.map.MapView;
	import com.game.view.map.PassLVView;
	import com.game.view.map.TowerDefenceView;
	import com.game.view.map.WeatherPassView;
	import com.game.view.midAutumn.ContributeMoonCakeView;
	import com.game.view.midAutumn.MidAutumnInstructionView;
	import com.game.view.midAutumn.MidAutumnView;
	import com.game.view.playerFight.PlayerFightRankView;
	import com.game.view.playerFight.PlayerFightView;
	import com.game.view.playerKilling.PlayerKillingFightView;
	import com.game.view.plugin.FlipGameView;
	import com.game.view.plugin.IntroducePluginGameView;
	import com.game.view.plugin.LinkGameView;
	import com.game.view.plugin.MoveGameView;
	import com.game.view.plugin.PluginGameView;
	import com.game.view.plugin.RunGameView;
	import com.game.view.prop.PropsView;
	import com.game.view.save.SaveView;
	import com.game.view.shop.ShopView;
	import com.game.view.skill.SkillView;
	import com.game.view.start.StartView;
	import com.game.view.talk.TalkView;
	import com.game.view.tip.AccelerateView;
	import com.game.view.tip.BuyView;
	import com.game.view.tip.TipView;
	import com.game.view.toolbar.ToolBarView;
	import com.game.view.ui.UIView;
	import com.game.view.union.MatchGameView;
	import com.game.view.union.StrengthInstructionView;
	import com.game.view.union.StrengthView;
	import com.game.view.union.TdhPrepareView;
	import com.game.view.union.UnionInstructionView;
	import com.game.view.union.UnionView;
	import com.game.view.upgrade.UpgradeSkillInstructionView;
	import com.game.view.upgrade.UpgradeView;
	import com.game.view.vip.VIPView;
	import com.game.view.vip.VipShopView;
	import com.game.view.weather.WeatherView;
	import com.game.view.world.WorldView;
	import com.game.view.worldBoss.RankListView;
	import com.game.view.worldBoss.WorldBossFightView;
	import com.game.view.worldBoss.WorldBossView;
	
	import org.osmf.logging.Log;

	public class ViewBase extends ViewSuperBase implements IBase
	{
		public function get start() : StartView
		{
			return this.createObject(StartView) as StartView;
		}
		
		public function get map() : MapView
		{
			return this.createObject(MapView) as MapView;
		}
		
		public function get towerDefence() : TowerDefenceView
		{
			return this.createObject(TowerDefenceView) as TowerDefenceView;
		}
		
		public function get world() : WorldView
		{
			return this.createObject(WorldView) as WorldView;
		}
		
		public function get publicRes() : PublicResView
		{
			return this.createObject(PublicResView) as PublicResView;
		}
		
		public function get dice() : DiceView
		{
			return this.createObject(DiceView) as DiceView;
		}
		
		public function get freeDice() : FreeDiceView
		{
			return this.createObject(FreeDiceView) as FreeDiceView;
		}
		
		public function get toolbar() : ToolBarView
		{
			return this.createObject(ToolBarView) as ToolBarView;
		}
		
		public function get role() : RoleDetailView
		{
			return this.createObject(RoleDetailView) as RoleDetailView;
		}
		
		public function get role_big() : RoleBigView
		{
			return this.createObject(RoleBigView) as RoleBigView;
		}
		
		public function get roleImage() : RoleImageView
		{
			return this.createObject(RoleImageView) as RoleImageView;
		}
		
		public function get levelSelect() : LevelSelectView
		{
			return this.createObject(LevelSelectView) as LevelSelectView;
		}
		
		public function get fight() : FightView
		{
			return this.createObject(FightView) as FightView;
		}
		
		public function get load() : LoadView
		{
			return this.createObject(LoadView) as LoadView;
		}
		
		public function get openItemBox() : OpenItemBoxView
		{
			return this.createObject(OpenItemBoxView) as OpenItemBoxView;
		}
		
		public function get skill() : SkillView
		{
			return this.createObject(SkillView) as SkillView;
		}
		
		public function get equip() : EquipView
		{
			return this.createObject(EquipView) as EquipView;
		}
		
		public function get props() : PropsView
		{
			return this.createObject(PropsView) as PropsView;
		}
		
		public function get ui() : UIView
		{
			return this.createObject(UIView) as UIView;
		}
		
		public function get roleSelect() : RoleSelectView
		{
			return this.createObject(RoleSelectView) as RoleSelectView;
		}
		
		public function get fightEffect() : FightEffectView
		{
			return this.createObject(FightEffectView) as FightEffectView;
		}
		
		public function get fightBegin() : FightBeginView
		{
			return this.createObject(FightBeginView) as FightBeginView;
		}
		
		public function get adventures() : AdventuresView
		{
			return this.createObject(AdventuresView) as AdventuresView;
		}
		
		public function get eventEffect() : EventEffectView
		{
			return this.createObject(EventEffectView) as EventEffectView;
		}
		
		public function get save() : SaveView
		{
			return this.createObject(SaveView) as SaveView;
		}
		
		public function get cartoon() : CartoonView
		{
			return this.createObject(CartoonView) as CartoonView;
		}
		
		public function get dialog() : DialogView
		{
			return this.createObject(DialogView) as DialogView;
		}
		
		public function get talk() : TalkView
		{
			return this.createObject(TalkView) as TalkView;
		}
		
		public function get icon() : IconView
		{
			return this.createObject(IconView) as IconView;
		}
		
		public function get instruction() : InstructionView
		{
			return this.createObject(InstructionView) as InstructionView;
		}
		
		public function get tip() : TipView
		{
			return this.createObject(TipView) as TipView;
		}
		
		public function get buy() : BuyView
		{
			return this.createObject(BuyView) as BuyView;
		}
		
		public function get roleLVUp() : RoleLVUpView
		{
			return this.createObject(RoleLVUpView) as RoleLVUpView;
		}
		
		public function get loadData() : LoadDataView
		{
			return this.createObject(LoadDataView) as LoadDataView;
		}
		
		public function get prompEffect() : PrompEffectView
		{
			return this.createObject(PrompEffectView) as PrompEffectView;
		}
		
		public function get roleRes() : RoleResView
		{
			return this.createObject(RoleResView) as RoleResView;
		}
		
		public function get roleGain() : RoleGainView
		{
			return this.createObject(RoleGainView) as RoleGainView;
		}
		
		public function get passLV() : PassLVView			
		{
			return this.createObject(PassLVView) as PassLVView;
		}
		
		public function get append_attribute() : AppendAttributeView
		{
			return this.createObject(AppendAttributeView) as AppendAttributeView;
		}
		
		public function get buy_dice() : BuyDiceView
		{
			return this.createObject(BuyDiceView) as BuyDiceView;
		}
		
		public function get preload() : PreLoadView
		{
			return this.createObject(PreLoadView) as PreLoadView;
		}
		
		public function get daily() : DailyView
		{
			return this.createObject(DailyView) as DailyView;
		}
		
		public function get move_game() : MoveGameView
		{
			return this.createObject(MoveGameView) as MoveGameView;
		}
		
		public function get signIn() : SignInView
		{
			return this.createObject(SignInView) as SignInView;
		}
		
		public function get tdhPrepare() : TdhPrepareView
		{
			return this.createObject(TdhPrepareView) as TdhPrepareView;
		}
		
		public function get pluginGame() : PluginGameView
		{
			return this.createObject(PluginGameView) as PluginGameView;
		}
		
		public function get introducePluginGame() : IntroducePluginGameView
		{
			return this.createObject(IntroducePluginGameView) as IntroducePluginGameView;
		}
		
		public function get flip_Game() : FlipGameView
		{
			return this.createObject(FlipGameView) as FlipGameView;
		}
		
		public function get run_game() : RunGameView
		{
			return this.createObject(RunGameView) as RunGameView;
		}
		
		public function get task() : TaskView
		{
			return this.createObject(TaskView) as TaskView;
		}
		
		public function get link_game() : LinkGameView
		{
			return this.createObject(LinkGameView) as LinkGameView;
		}
		
		public function get match_game() : MatchGameView
		{
			return this.createObject(MatchGameView) as MatchGameView;
		}
		
		public function get equip_strengthen() : EquipStrengthenView
		{
			return this.createObject(EquipStrengthenView) as EquipStrengthenView;
		}
		
		public function get instruction_strengthen() : StrengthenInstructionView
		{
			return this.createObject(StrengthenInstructionView) as StrengthenInstructionView;
		}
		
		public function get instruction_compose() : ComposeInstructionView
		{
			return this.createObject(ComposeInstructionView) as ComposeInstructionView;
		}
		
		public function get instruction_decompose() : DecomposeInstructionView
		{
			return this.createObject(DecomposeInstructionView) as DecomposeInstructionView;
		}
		
		public function get shop() : ShopView
		{
			return this.createObject(ShopView) as ShopView;
		}
		
		public function get auto_fight() : AutoFightView
		{
			return this.createObject(AutoFightView) as AutoFightView;
		}
		
		public function get speed_change() : SpeedChangeView
		{
			return this.createObject(SpeedChangeView) as SpeedChangeView;
		}
		
		public function get guide() : GuideView
		{
			return this.createObject(GuideView) as GuideView;
		}
		
		public function get first_guide() : FirstGuideView
		{
			return this.createObject(FirstGuideView) as FirstGuideView;
		}
		
		public function get get_role_guide() : GetRoleGuideView
		{
			return this.createObject(GetRoleGuideView) as GetRoleGuideView;
		}
		
		public function get weather() : WeatherView
		{
			return this.createObject(WeatherView) as WeatherView;
		}
		
		public function get accelerate() :AccelerateView
		{
			return this.createObject(AccelerateView) as AccelerateView;
		}
		
		public function get weather_pass() : WeatherPassView
		{
			return this.createObject(WeatherPassView) as WeatherPassView;
		}
		
		public function get other_effect() : OtherEffectView
		{
			return this.createObject(OtherEffectView) as OtherEffectView;
		}
		
		public function get task_box() : TaskItemBoxView
		{
			return this.createObject(TaskItemBoxView) as TaskItemBoxView;
		}
		
		public function get newActivity() : NewActivityView
		{
			return this.createObject(NewActivityView) as NewActivityView;
		}
		
		public function get activity() : ActivityView
		{
			return this.createObject(ActivityView) as ActivityView;
		}
		
		public function get integration() : IntegrationView
		{
			return this.createObject(IntegrationView) as IntegrationView;
		}
		
		public function get glowing() : GlowingView
		{
			return this.createObject(GlowingView) as GlowingView;
		}
		
		public function get tanabata() : TanabataView
		{
			return this.createObject(TanabataView) as TanabataView;
		}
		
		public function get gain_skill() : RoleGainSkillView
		{
			return this.createObject(RoleGainSkillView) as RoleGainSkillView;
		}
		
		public function get instruction_martial() : MartialInstructionView
		{
			return this.createObject(MartialInstructionView) as MartialInstructionView;
		}
		
		public function get instruction_transfer() : TransferInstructionView
		{
			return this.createObject(TransferInstructionView) as TransferInstructionView;
		}
		
		public function get instruction_glowing() : GlowingInstructionView
		{
			return this.createObject(GlowingInstructionView) as GlowingInstructionView;
		}
		
		public function get endless_battle() : EndlessBattlesView
		{
			return this.createObject(EndlessBattlesView) as EndlessBattlesView;
		}
		
		public function get instruction_endless() : EndlessInstructionView
		{
			return this.createObject(EndlessInstructionView) as EndlessInstructionView;
		}
		
		public function get weather_prop() : WeatherPropView
		{
			return this.createObject(WeatherPropView) as WeatherPropView;
		}
		
		public function get endless_fight() : EndlessFightView
		{
			return this.createObject(EndlessFightView) as EndlessFightView;
		}
		
		public function get endless_prop_box() : EndlessPropBoxView
		{
			return this.createObject(EndlessPropBoxView) as EndlessPropBoxView;
		}
		
		public function get player_killing_fight() : PlayerKillingFightView
		{
			return this.createObject(PlayerKillingFightView) as PlayerKillingFightView;
		}
		
		public function get double_level() : DoubleLevelView
		{
			return this.createObject(DoubleLevelView) as DoubleLevelView;
		}
		
		public function get world_boss() : WorldBossView
		{
			return this.createObject(WorldBossView) as WorldBossView;
		}
		
		public function get boss_fight() : WorldBossFightView
		{
			return this.createObject(WorldBossFightView) as WorldBossFightView;
		}
		
		public function get rank_list() : RankListView
		{
			return this.createObject(RankListView) as RankListView;
		}
		
/*		public function get achievement() : AchievementView
		{
			return this.createObject(AchievementView) as AchievementView;
		}*/
		
		public function get player_fight() : PlayerFightView
		{
			return this.createObject(PlayerFightView) as PlayerFightView;
		}
		
		public function get player_fight_list() : PlayerFightRankView
		{
			return this.createObject(PlayerFightRankView) as PlayerFightRankView;
		}
		
		public function get transfer_role_type() : TransferRoleTypeView
		{
			return this.createObject(TransferRoleTypeView) as TransferRoleTypeView;
		}
		
		public function get upgrade() : UpgradeView
		{
			return this.createObject(UpgradeView) as UpgradeView;
		}
		
		public function get weather_select() : WeatherSelectView
		{
			return this.createObject(WeatherSelectView) as WeatherSelectView;
		}
		
		public function get instruction_upgrade_skill() : UpgradeSkillInstructionView
		{
			return this.createObject(UpgradeSkillInstructionView) as UpgradeSkillInstructionView;
		}
		
		public function get moon_cake() : MoonCakeView
		{
			return this.createObject(MoonCakeView) as MoonCakeView;
		}
		
		public function get strength() : StrengthView
		{
			return this.createObject(StrengthView) as StrengthView;
		}
		
		public function get autumn_festival() : AutumnFestivalView
		{
			return this.createObject(AutumnFestivalView) as AutumnFestivalView;
		}
		
		public function get two_festival() : TwoFestivalView
		{
			return this.createObject(TwoFestivalView) as TwoFestivalView;
		}
		
		public function get national_day() : NationalDayView
		{
			return this.createObject(NationalDayView) as NationalDayView;
		}
		
		public function get mid_autumn() : MidAutumnView
		{
			return this.createObject(MidAutumnView) as MidAutumnView;
		}
		
		public function get contribute_mooncake() : ContributeMoonCakeView
		{
			return this.createObject(ContributeMoonCakeView) as ContributeMoonCakeView;
		}
		
		public function get instruction_mid_autumn() : MidAutumnInstructionView
		{
			return this.createObject(MidAutumnInstructionView) as MidAutumnInstructionView;
		}
		
		public function get vip() : VIPView
		{
			return this.createObject(VIPView) as VIPView;
		}
		
		public function get union() : UnionView
		{
			return this.createObject(UnionView) as UnionView;
		}
		
		public function get daily_work() : DailyWorkView
		{
			return this.createObject(DailyWorkView) as DailyWorkView;
		}
		
		public function get vip_shop() : VipShopView
		{
			return this.createObject(VipShopView) as VipShopView;
		}
		
		public function get activity_national_pass() : ActivityNationalPassView
		{
			return this.createObject(ActivityNationalPassView) as ActivityNationalPassView;
		}
		
		public function get instruction_strength() : StrengthInstructionView
		{
			return this.createObject(StrengthInstructionView) as StrengthInstructionView;
		}
		
		public function get instruction_union() : UnionInstructionView
		{
			return this.createObject(UnionInstructionView) as UnionInstructionView;
		}
		
		public function ViewBase()
		{
			super();
		}
		
		public function init(controller:Controller, lang:Lang) : void
		{
			_controller = controller;
			_lang = lang;
			
			_res   = com.game.manager.ResCacheManager.instance;
			_layer = LayerManager.instance;
			_font = FontManager.instance;
			_debug = DebugManager.instance;
			_sound = SoundPlayerManager.getIns();
			
			preInitModel();
		}
		
		public function preInitModel() : void
		{
		}
	}
}
package com.game.view.worldBoss
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.fight.FightModelStructure;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class WorldBossResultComponent extends Component
	{
		private var _mainRoleModel:RoleModel;
		private var _data:Data = Data.instance;
		
		public function WorldBossResultComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
		}
		
		private var _money:TextField;
		private var _exp:TextField;
		private var _soul:TextField;
		public function initUI() : void
		{
			if (!_money) _money = searchOf("Tx_Money");
			_money.fontName = "宋体";
			_money.bold = true;
			if (!_exp) _exp = searchOf("Tx_Experience");
			_exp.fontName = "宋体";
			_exp.bold = true;
			if (!_soul) _soul = searchOf("Tx_FihgtSoul");
			_soul.fontName = "宋体";
			_soul.bold = true;
			
			_view.layer.setCenter(panel);
		}
		
		private var _modelStructure:FightModelStructure;
		private var _info:String;
		public function showResult(modelStructure:FightModelStructure, info:String) : void
		{
			_modelStructure = modelStructure;
			_info = info;
			
			initUI();
			initEvent();
			display();
			
			render();
		}
		
		private function render() : void
		{
			_exp.text = "+ " + int(_modelStructure.allHurt * .35);
			_money.text = "+ " + int(_modelStructure.allHurt * .125);
			_soul.text = "+ " + int(_modelStructure.allHurt * .125);
		}
		
		override protected function onClickeHandle(e:ViewEventBind) : void
		{
			var name:String = e.target.name;
			
			switch (name)
			{
				case "OkButton":
					closeView();
					break;
			}
		}
		
		private function closeView() : void
		{
			_view.tip.interfaces(InterfaceTypes.Show, _info, null, null, false, true, false);
			_view.world_boss.useCount = 0;
			_view.boss_fight.hide();
			_view.world.interfaces(InterfaceTypes.REFRESH);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.checkWorldBoss();
			_mainRoleModel = player.getRoleModel(V.MAIN_ROLE_NAME);
			_mainRoleModel.checkGrade(rewardAfter, rewardAfter);
		}
		
		private function rewardAfter() : void
		{
			_view.world_boss.interfaces();
			_view.controller.save.onSaveFighting();
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new WorldBossResultComponent(_configXML, _titleTxAtlas);
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
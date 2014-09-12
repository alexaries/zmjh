package com.game.data.playerKilling
{
	import com.engine.ui.core.BaseSprite;
	import com.game.View;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.fight.begin.FightBeginEffectItem;
	import com.game.view.fight.begin.FightBeginEffectItemData;
	import com.game.view.fight.begin.FightBeginPlayData;
	
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class PlayerKillingFightBeginPlayer extends BaseSprite implements IAnimatable
	{
		public static const COMPLETE:String = "complete";
		
		private var _playData:FightBeginPlayData;
		private var _fightData:Object;
		private var _curFrame:int;
		private var _totalFrame:int;
		private var _uiPools:Vector.<Sprite>;
		
		private var _view:View = View.instance;
		
		public function PlayerKillingFightBeginPlayer()
		{
			super();
			
			_uiPools = new Vector.<Sprite>();
		}
		
		public function initData(data:FightBeginPlayData) : void
		{
			_playData = data;
			_totalFrame = _playData.total_frame;
			
			initUI();
			getUI();
		}
		
		private var _meItem:FightBeginEffectItem;
		private var _enemyItem:FightBeginEffectItem;
		private function getUI() : void
		{
			if (!_meItem)
			{
				_meItem = this.searchUI("WeRole");
				_meItem.image.scaleX = -1;
				_meItem.image.pivotX = 108;
				_meItem.image.pivotY = 256;
			}
			
			if (!_enemyItem)
			{
				_enemyItem = this.searchUI("EnemyRole");
			}
		}
		
		private function initUI() : void
		{
			for (var i:int = 0; i < _playData.items.length; i++)
			{
				createCurFrameItem(_playData.items[i]);
			}
			
			checkItemLayer();
		}
		
		private function checkItemLayer() : void
		{
			for each(var item:FightBeginEffectItem in _uiPools)
			{
				this.addChildAt(item, item.data.layer);
			}
		}
		
		public function start(fightData:Object) : void
		{
			show();
			_fightData = fightData;
			
			renderRoleImage();
			
			_curFrame = 0;
			Starling.juggler.add(this);
		}
		
		private function renderRoleImage() : void
		{
			var roleName:String = "RoleImage_Big_" + V.MAIN_ROLE_NAME.split("（")[0];
			var texture:Texture = _view.role_big.interfaces(InterfaceTypes.GetTexture, roleName);
			_meItem.image.texture = texture;
			_meItem.image.readjustSize();
			
			var enemyName:String = getEnemeyName();
			enemyName = "RoleImage_Big_" + enemyName;
			texture = _view.role_big.interfaces(InterfaceTypes.GetTexture, enemyName);
			_enemyItem.image.texture = texture;
			_enemyItem.image.pivotX = texture.width/2;
			_enemyItem.image.pivotY = texture.height;
			_enemyItem.image.readjustSize();
		}
		
		private function getEnemeyName() : String
		{
			var enemyName:String;
			var fightModelData:PlayerKillingFightModelStructure = _fightData["model"];
			
			for (var i:int = 3; i > 0; i--)
			{
				if (fightModelData.Enemy[i] && fightModelData.Enemy[i] is Battle_PlayerKillingModel)
				{
					enemyName = (fightModelData.Enemy[i] as Battle_PlayerKillingModel).countCharacterModel.name;
					break;
				}
			}
			
			if (!enemyName)
			{
				throw new Error("error");
			}
			//天气模式下获得角色名称
			if(enemyName.indexOf("（") != -1) enemyName = enemyName.substring(0, enemyName.indexOf("（"));
			
			return enemyName;
		}
		
		private function checkCurFrame() : void
		{
			for (var i:int = 0; i < _playData.items.length; i++)
			{
				if (_playData.items[i].begin_frame == _curFrame)
				{
					createCurFrameItem(_playData.items[i]);
				}
			}
		}
		
		private function createCurFrameItem(itemData:FightBeginEffectItemData) : void
		{	
			var item:FightBeginEffectItem = searchUI(itemData.name);
			
			if (!item)
			{
				item = new FightBeginEffectItem();
				item.setData(itemData);
				addChild(item);
				_uiPools.push(item);
			}
			
			item.start();
		}
		
		public function advanceTime(passedTime:Number) : void
		{
			_curFrame += 1;
			
			if (_curFrame > _totalFrame)
			{
				this.dispatchEventWith(COMPLETE);
				hide();
			}
			else
			{
				checkCurFrame();
			}
		}
		
		protected function searchUI(name:String) : FightBeginEffectItem
		{
			var obj:FightBeginEffectItem;
			
			for each(var item:FightBeginEffectItem in _uiPools)
			{
				if (item.name == name)
				{
					obj = item;
					break;
				}
			}
			
			return obj;
		}
		
		public function hide() : void
		{
			Starling.juggler.remove(this);
			this.visible = false;
		}
		
		public function show() : void
		{
			this.visible = true;
		}
		
		override public function destroy() : void
		{
			super.destroy();
		}
	}
}
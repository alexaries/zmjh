package com.game.view.dice
{
	import com.engine.event.EventTypes;
	import com.game.Data;
	import com.game.data.db.protocal.Level_up_exp;
	import com.game.data.player.structure.RoleModel;
	import com.game.manager.FontManager;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.Base;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class BuyDiceView extends BaseView implements IView
	{
		private var _mainRoleModel:RoleModel;
		private var _curLVUPInfo:Level_up_exp;
		
		private var _diceRun:DiceEntity;
		
		public function BuyDiceView()
		{
			_moduleName = V.BUY_DICE;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch (type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
			}
		}
		
		override protected function init() : void
		{
			if (!isInit)
			{
				isInit = true;
				super.init();
				
				initData();
				initXML();
				initTexture();
				initUI();
				getUI();
				initEvent();
			}
			
			render();
		}
		
		private function render() : void
		{
			this.display();
			
			for each(var item:Level_up_exp in _lvUPDice)
			{
				if (item.lv == _mainRoleModel.model.lv)
				{
					_curLVUPInfo = item;
					break;
				}
			}
			
			_needMoney.text = "消耗金币:" + _curLVUPInfo.Dice_value.toString();
			_diceNum.text = player.dice.toString();
		}
		
		
		private var _lvUPDice:Object;
		private function initData() : void
		{
			_lvUPDice = Data.instance.db.interfaces(InterfaceTypes.GET_LEVEL_UP_EXP);
			player = _view.controller.player.getPlayerData();
			_mainRoleModel = player.mainRoleModel;
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(V.PUBLIC, GameConfig.PUBLIC_RES, "AddDicePosition");
		}
		
		private var _diceRunTextures:Vector.<Texture>;
		private var _diceStandTextures:Vector.<Texture>;
		private function initTexture() : void
		{
			_diceRunTextures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, "dice_run_");
			_diceStandTextures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, "dice_");
		}
		
		private function initUI() : void
		{
			var name:String;
			var obj:*;
			var layerName:String;
			for each(var items:XML in _positionXML.layer)
			{
				layerName = items.@layerName;
				for each(var element:XML in items.item)
				{
					name = element.@name;
					
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						obj["layerName"] = layerName;
						_uiLibrary.push(obj);
					}
				}
			}
			
			_diceRun = new DiceEntity(_diceRunTextures, _diceStandTextures, 245, 155);
			this.add(_diceRun);
			panel.addChild(_diceRun);
			
			_view.layer.setCenter(panel);
		}
		
		private var _needMoney:TextField;
		private var _diceNum:TextField;
		private var _buyBtn:Button;
		private function getUI() : void
		{
			_needMoney = this.searchOf("Tx_Money");
			_buyBtn = this.searchOf("BuyButton");
			_diceNum = this.searchOf("Tx_DiceNum");
			
			_diceNum.fontName = V.SONG_TI;
		}
		
		override protected function initEvent():void
		{
			super.initEvent();
			
			_diceRun.addEventListener(EventTypes.DICE_STOP, onDiceStop);
		}
		
		private function onDiceStop(e:Event) : void
		{
			player.dice += e.data;
			
			var info:String = "恭喜你获得骰子 X" + e.data;
			
			_view.prompEffect.play(info);
			_buyBtn.touchable = true;
			
			_diceNum.text = player.dice.toString();
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
					/*if(_view.map.autoLevel)		_view.map.skipLevel();*/
					break;
				case "BuyButton":
					onBuyButton();
					break;
			}
		}
		
		/**
		 * 购买色子 
		 * 
		 */		
		protected function onBuyButton() : void
		{
			var info:String;
			// 检测金币是否足够
			if (_curLVUPInfo.Dice_value > player.money)
			{
				info = "金币不足！";
				_view.prompEffect.play(info);
			}
			// 当骰子数接近上限值时，不能购买
			else if (player.dice > (V.DICE_MAX_NUM - 6))
			{
				info = "骰子数接近上限值！";
				_view.prompEffect.play(info);
			}
			else
			{
				player.money -= _curLVUPInfo.Dice_value;
				_diceRun.curRandomPoint = Math.random() * 6;
				_diceRun.isPlay = true;
				_buyBtn.touchable = false;
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);

			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			
			return texture;
		}
		
		override public function update() : void
		{
			super.update();
		}
		
		override public function close() : void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
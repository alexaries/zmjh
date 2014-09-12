package com.game.view.Role
{
	import com.game.Data;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import starling.display.Button;
	import starling.display.MovieClip;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class TransferRoleTypeView extends BaseView implements IView
	{
		private static const COST_PROP:int = 15;
		private static const COST_MONEY:int = 500000;
		
		public function TransferRoleTypeView()
		{
			_layer = LayerTypes.TOP;
			_moduleName = V.TRANSFER_ROLE_TYPE;
			_loaderModuleName = V.PUBLIC;
			
			super();
		}
		
		private var _showRole:GlowingComponent;
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch (type)
			{
				case InterfaceTypes.Show:
					_showRole = args[0];
					this.show();
					break;
			}
		}
		
		override protected function init():void
		{
			if (!isInit)
			{
				super.init();
				isInit = true;
				
				initData();
				initComponent();
				initUI();
				getUI();
				initEvent();
			}
			
			render();
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					break;
				case "TransferType":
					startTransferRoleType();
					break;
			}
		}
		
		override public function hide():void
		{
			_transferType = "";
			super.hide();
		}
		
		private function startTransferRoleType() : void
		{
			if(checkTransferRole())
			{
				switch(_changeRoleType)
				{
					case 1:
						Data.instance.role_select.translateRoleType(_startRole.roleModel.info.roleName);
						Data.instance.pack.changePropNum(_propType, -COST_PROP);
						break;
					case 2:
						Data.instance.role_select.reduceRoleType(_startRole.roleModel.info.roleName);
						break;
				}
				
				player.money -= _costMoneyNum;
				
				_view.prompEffect.play(_startRole.roleModel.info.roleName + "属性转换成功！");
				_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
				_view.roleSelect.interfaces(InterfaceTypes.REFRESH);
				Data.instance.player.player.upgradeRole.addRole(_startRole.roleModel.info.roleName);
				this.hide();
			}
		}
		
		private var _changeRoleType:int;
		private var _propType:int;
		private function checkTransferRole() : Boolean
		{
			var result:Boolean = true;
			var info:String = "";
			var roleType:String = _startRole.roleModel.info.roleName.split("（")[1];
			if(_transferType == "夜" || _transferType == "雨")
			{
				if(roleType == "夜）" || roleType == "雨）")
					_changeRoleType = 1;
				else if(roleType == "风）" || roleType == "雷）")
					_changeRoleType = 2;
			}
			else if(_transferType == "风" || _transferType == "雷")
				_changeRoleType = 1;
			
			
			if(player.money < _costMoneyNum)
			{
				result = false;
				info = "金币不足！";
			}
			
			var str:String = "";
			if(_changeRoleType == 1)
			{
				switch(_transferType)
				{
					case "夜":
						_propType = 35;
						str = "夜神";
						break;
					case "雨":
						_propType = 36;
						str = "雨神";
						break;
					case "风":
						_propType = 37;
						str = "风神";
						break;
					case "雷":
						_propType = 38;
						str = "雷神";
						break;
				}
				if(player.pack.getPropNumById(_propType) < COST_PROP)
				{
					result = false;
					info += str + "令牌不足！";
				}
			}
			if(info != "")
				_view.prompEffect.play(info);
			
			return result;
		}
		
		/**
		 * UI位置文件 
		 */		
		private var _positionXML:XML;
		protected function initData() : void
		{
			if (!_positionXML)
			{
				_positionXML = getXMLData(V.ROLE, GameConfig.ROLE_RES, "TransferRoleTypePosition");
			}
		}
		
		protected function initUI() : void
		{
			initLayout();
			
			display();
			_view.layer.setCenter(panel);
		}
		
		private function initComponent() : void
		{
			var name:String;
			var cp:Component;
			var layerName:String;
			for each(var items:XML in _positionXML.component.Items)
			{
				name = items.@name;
				if (!this.checkInComponent(name))
				{
					switch (name)
					{
						case "GlowingComponent":
							cp = new GlowingComponent(items, _view.roleRes.titleTxAtlas);
							_components.push(cp);
							break
					}
				}	
			}
		}
		
		private function initLayout() : void
		{
			var name:String;
			var obj:*;			
			for each(var items:XML in _positionXML.layer)
			{
				for each(var element:XML in items.item)
				{
					name = element.@name;
					
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						_uiLibrary.push(obj);
					}
				}
			}
		}
		
		private var _startRole:GlowingComponent;
		private var _startTransferBtn:Button;
		private var _nightBtn:MovieClip;
		private var _rainBtn:MovieClip;
		private var _windBtn:MovieClip;
		private var _thunderBtn:MovieClip;
		private var _transferType:String;
		private var _costMoneyTF:TextField;
		private var _costMoneyNum:int;
		private var _costPropTF:TextField;
		private var _costPropNum:int;
		private var _propImage:MovieClip;
		private function getUI() : void
		{
			_startRole = this.searchOf("GlowingStart");
			_startTransferBtn = this.searchOf("TransferType");
			_nightBtn = this.searchOf("RoleNightSelect");
			_rainBtn = this.searchOf("RoleRainSelect");
			_windBtn = this.searchOf("RoleWindSelect");
			_thunderBtn = this.searchOf("RoleThunderSelect");
			_nightBtn.useHandCursor = true;
			_rainBtn.useHandCursor = true;
			_windBtn.useHandCursor = true;
			_thunderBtn.useHandCursor = true;
			
			_costMoneyTF = this.searchOf("CostGold");
			_costPropTF = this.searchOf("CostProp");
			_propImage = this.searchOf("GlowingProp");
			_costPropNum = 0;
			_costMoneyNum = 0;
		}
		
		private function render() : void
		{
			renderRole();
			renderButton();
		}
		
		private function renderRole() : void
		{
			if(_showRole.roleModel != null)
			{
				_startRole.setImage(_showRole.roleModel);
				_startRole.unDoubleClick = false;
			}
		}
		
		private function renderButton() : void
		{
			removeClick();
			var type:String = _startRole.roleModel.info.roleName.split("（")[1];
			switch(type)
			{
				case null:
					_nightBtn.currentFrame = 2;
					_rainBtn.currentFrame = 2;
					_windBtn.currentFrame = 2;
					_thunderBtn.currentFrame = 2;
					_transferType = "";
					break;
				case "夜）":
					_nightBtn.currentFrame = 2;
					_rainBtn.currentFrame = 0;
					_windBtn.currentFrame = 2;
					_thunderBtn.currentFrame = 2;
					_transferType = "雨";
					break;
				case "雨）":
					_nightBtn.currentFrame = 0;
					_rainBtn.currentFrame = 2;
					_windBtn.currentFrame = 2;
					_thunderBtn.currentFrame = 2;
					_transferType = "夜";
					break
				case "风）":
					_nightBtn.currentFrame = 1;
					_rainBtn.currentFrame = 2;
					_windBtn.currentFrame = 2;
					_thunderBtn.currentFrame = 1;
					_nightBtn.addEventListener(TouchEvent.TOUCH, selectNight);
					_thunderBtn.addEventListener(TouchEvent.TOUCH, selectThunder);
					_transferType = "";
					break;
				case "雷）":
					_nightBtn.currentFrame = 2;
					_rainBtn.currentFrame = 1;
					_windBtn.currentFrame = 1;
					_thunderBtn.currentFrame = 2;
					_rainBtn.addEventListener(TouchEvent.TOUCH, selectRain);
					_windBtn.addEventListener(TouchEvent.TOUCH, selectWind);
					_transferType = "";
					break;
			}
			changeState();
		}
		
		private function changeState() : void
		{
			renderTransferBtn();
			renderPropImage();
		}
		
		private function renderTransferBtn() : void
		{
			if(_transferType == "")
				removeTouchable(_startTransferBtn);
			else
				addTouchable(_startTransferBtn);
		}
		
		private function renderPropImage() : void
		{
			var roleName:String = _startRole.roleModel.info.roleName.split("（")[1];
			if(roleName == null || _transferType == "")
			{
				_propImage.visible = false;
				_costMoneyNum = 0;
				_costMoneyTF.text = "";
				_costPropNum = 0;
				_costPropTF.text = "";
			}
			else
			{
				_costMoneyNum = COST_MONEY;
				_costMoneyTF.text = _costMoneyNum.toString();
				_propImage.visible = true;
				_costPropNum = COST_PROP;
				_costPropTF.text = "X" + _costPropNum;
				if(roleName == "夜）" && _transferType == "雨")
				{
					_propImage.currentFrame = 1;
				}
				else if(roleName == "雨）" && _transferType == "夜")
				{
					_propImage.currentFrame = 0;
				}
				else if(roleName == "风）" && _transferType == "雷")
				{
					_propImage.currentFrame = 3;
				}
				else if(roleName == "雷）" && _transferType == "风")
				{
					_propImage.currentFrame = 2;
				}
				else
				{
					_propImage.visible = false;
					_costPropNum = 0;
					_costPropTF.text = "";
				}
			}
		}
		
		
		private function removeClick() : void
		{
			_nightBtn.removeEventListener(TouchEvent.TOUCH, selectNight);
			_rainBtn.removeEventListener(TouchEvent.TOUCH, selectRain);
			_windBtn.removeEventListener(TouchEvent.TOUCH, selectWind);
			_thunderBtn.removeEventListener(TouchEvent.TOUCH, selectThunder);
		}
		
		private function selectNight(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_nightBtn);
			if(!touch)	return;
			if(touch.phase == TouchPhase.ENDED)
			{
				_thunderBtn.currentFrame = 1;
				_nightBtn.currentFrame = 0;
				_transferType = "夜";
				changeState();
			}
		}
		
		private function selectRain(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_rainBtn);
			if(!touch)	return;
			if(touch.phase == TouchPhase.ENDED)
			{
				_windBtn.currentFrame = 1;
				_rainBtn.currentFrame = 0;
				_transferType = "雨";
				changeState();
			}
		}
		
		private function selectWind(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_windBtn);
			if(!touch)	return;
			if(touch.phase == TouchPhase.ENDED)
			{
				_rainBtn.currentFrame = 1;
				_windBtn.currentFrame = 0;
				_transferType = "风";
				changeState();
			}
		}
		
		private function selectThunder(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_thunderBtn);
			if(!touch)	return;
			if(touch.phase == TouchPhase.ENDED)
			{
				_nightBtn.currentFrame = 1;
				_thunderBtn.currentFrame = 0;
				_transferType = "雷";
				changeState();
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else
			{
				textures = _view.roleRes.titleTxAtlas.getTextures(name);
			}
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			if (type == "public")
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else if(type == "instruction")
			{
				texture = _view.instruction.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _view.roleRes.titleTxAtlas.getTexture(name);
			}
			
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
	}
}
package com.game.view.Role
{
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	
	import starling.textures.Texture;

	public class MartialInstructionView extends BaseView implements IView
	{
		private var _positionXML:XML;
		
		public function MartialInstructionView()
		{
			_moduleName = V.INSTRUCTION_MARTIAL;
			_layer = LayerTypes.TOP;
			_loaderModuleName = V.ROLE_SELECT;
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch (type)
			{
				case InterfaceTypes.Show:
					_positionXML = args[0];
					_view.instruction.interfaces(InterfaceTypes.Show, show);
					break;
			}
		}
		
		override protected function init():void
		{
			if (!isInit)
			{
				super.init();
				isInit = true;
				
				initUI();
				initEvent();
			}
			
		}
		
		protected function initUI() : void
		{
			initLayout();
			
			display();
			_view.layer.setCenter(panel);
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
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					break;
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else if(type == "instruction")
			{
				textures = _view.instruction.interfaces(InterfaceTypes.GetTextures, name);
			}
			else
			{
				textures = _view.equip_strengthen.titleTxAtlas.getTextures(name);
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
				texture = _view.equip_strengthen.titleTxAtlas.getTexture(name);
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
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
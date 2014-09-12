package com.game.view.plugin
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.template.InterfaceTypes;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class RunGameOverInfoComponent extends Component
	{
		private var _anti:Antiwear;
		
		//private var _coinCount:int;
		private function get coinCount() : int
		{
			return _anti["coinCount"];
		}
		private function set coinCount(value:int) : void
		{
			_anti["coinCount"] = value;
		}
		//private var _time:int;
		private function get time() : int
		{
			return _anti["time"];
		}
		private function set time(value:int) : void
		{
			_anti["time"] = value;
		}
		
		public function RunGameOverInfoComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["coinCount"] = 0;
			_anti["time"] = 0;
			
			
			getUI();
			initEvent();
		}
		
		private function getUI() : void
		{
			
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "OkBt":
					onOk();
					break;
			}
		}
		
		private function onOk() : void
		{
			if(time == 0 && coinCount >= 0)
				Data.instance.pack.addUpgradeProp(3);
			else
				Data.instance.pack.addUpgradeProp(1);
			
			_view.run_game.hide();
			
			_view.run_game.close();
			_view.run_game.destroy();
			_view.world.interfaces(InterfaceTypes.REFRESH);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.checkPluginGame();
			
			_titleTxAtlas.dispose();
			_titleTxAtlas = null;
		}
		
		
		
		/**
		 * 显示 
		 * 
		 */		
		public function showing(coinCountInput:int, timeInput:int) : void
		{
			coinCount = coinCountInput;
			time = timeInput;
			
			this.show();			
			panel.parent.addChild(panel);
			
			Data.instance.plugin.getMoney(this.coinCount);
			
			(searchOf("Coin") as TextField).text = "+" + coinCount;
			
			//Data.instance.plugin.getStrengthen(11);
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.pluginGame.interfaces(InterfaceTypes.GetTextures, name);
			}
			else
			{
				textures = _titleTxAtlas.getTextures(name);
			}
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			if (type == "public")
			{
				texture = _view.pluginGame.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _titleTxAtlas.getTexture(name);
			}
			return texture;
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new RunGameOverInfoComponent(_configXML, _titleTxAtlas);
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
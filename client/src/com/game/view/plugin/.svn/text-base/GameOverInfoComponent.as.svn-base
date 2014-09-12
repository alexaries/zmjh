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

	public class GameOverInfoComponent extends Component
	{
		private var _anti:Antiwear;
		//private var _legsCount:int;
		private function get legsCount() : int
		{
			return _anti["legsCount"];
		}
		private function set legsCount(value:int) : void
		{
			_anti["legsCount"] = value;
		}
		//private var _ginsengCount:int;
		private function get ginsengCount() : int
		{
			return _anti["ginsengCount"];
		}
		private function set ginsengCount(value:int) : void
		{
			_anti["ginsengCount"] = value;
		}
		//private var _freedomCount:int;
		private function get freedomCount() : int
		{
			return _anti["freedomCount"];
		}
		private function set freedomCount(value:int) : void
		{
			_anti["freedomCount"] = value;
		}
		//private var _diceCount:int;
		private function get diceCount() : int
		{
			return _anti["diceCount"];
		}
		private function set diceCount(value:int) : void
		{
			_anti["diceCount"] = value;
		}
		
		public function GameOverInfoComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["legsCount"] = 0;
			_anti["ginsengCount"] = 0;
			_anti["freedomCount"] = 0;
			_anti["diceCount"] = 0;
			
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
			if(diceCount >= 20 && legsCount >= 4 && ginsengCount >= 4 && freedomCount >= 4)
				Data.instance.pack.addUpgradeProp(3);
			else
				Data.instance.pack.addUpgradeProp(1);
			
			_view.move_game.hide();
			
			_view.move_game.close();
			_view.move_game.destroy();
			_view.world.interfaces(InterfaceTypes.REFRESH);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.checkPluginGame();
			
			//this.close();
			//this.destroy();
			_titleTxAtlas.dispose();
			_titleTxAtlas = null;
		}
		
		/**
		 * 显示 
		 * 
		 */		
		public function showing(legsCountInput:int, ginsengCountInput:int, freedomCountInput:int, diceCountInput:int) : void
		{
			legsCount = legsCountInput;
			ginsengCount = ginsengCountInput;
			freedomCount = freedomCountInput;
			diceCount = diceCountInput;
			
			this.show();			
			panel.parent.addChild(panel);
			
			(searchOf("lastLegs") as TextField).text = "+" + legsCount;
			(searchOf("lastGinseng") as TextField).text = "+" + ginsengCount;
			(searchOf("lastFreedom") as TextField).text = "+" + freedomCount;
			(searchOf("lastDice") as TextField).text = "+" + diceCount;
			
			Data.instance.plugin.getThingInWine(legsCount, ginsengCount, freedomCount, diceCount);
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
			return new GameOverInfoComponent(_configXML, _titleTxAtlas);
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
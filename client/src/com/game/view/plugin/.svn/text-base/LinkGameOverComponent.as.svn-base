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

	public class LinkGameOverComponent extends Component
	{
		private var _anti:Antiwear;
		private var _soulTxt:TextField;
		private var _destroy:TextField;
		//private var _totalSoulExp:int;
		private function get totalSoulExp() : int
		{
			return _anti["totalSoulExp"];
		}
		private function set totalSoulExp(value:int) : void
		{
			_anti["totalSoulExp"] = value;
		}
		//private var _destroyCount:int;
		private function get destroyCount() : int
		{
			return _anti["destroyCount"];
		}
		private function set destroyCount(value:int) : void
		{
			_anti["destroyCount"] = value;
		}
		
		public function LinkGameOverComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["totalSoulExp"] = 0;
			_anti["destroyCount"] = 0;
			
			initEvent();
			getUI();
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
		
		/**
		 * 返回主页面
		 * 
		 */		
		private function onOk() : void
		{
			if(destroyCount >= 50)
				Data.instance.pack.addUpgradeProp(3);
			else
				Data.instance.pack.addUpgradeProp(1);
			
			_view.link_game.hide();
			
			_view.link_game.close();
			_view.link_game.destroy();
			_view.world.interfaces(InterfaceTypes.REFRESH);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.checkPluginGame();
			
			_titleTxAtlas.dispose();
			_titleTxAtlas = null;
		}
		
		private function getUI() : void
		{
			_soulTxt = this.searchOf("Soul");
			_destroy = this.searchOf("Destroy");
		}
		
		/**
		 * 显示游戏结束窗口
		 * @param exp
		 * 
		 */		
		public function showing(soulExp:int, destroy:int) : void
		{
			totalSoulExp = soulExp;
			destroyCount = destroy;
			this.show();
			_soulTxt.text = "+" + totalSoulExp.toString();
			_destroy.text = "总共摧毁" + destroy.toString() + "对";
			panel.parent.addChild(panel);
			
			Data.instance.plugin.getBreath(totalSoulExp, destroy);
			//Data.instance.plugin.getStrengthen(13);
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
			return new LinkGameOverComponent(_configXML, _titleTxAtlas);
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
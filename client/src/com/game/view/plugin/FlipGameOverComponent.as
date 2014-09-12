package com.game.view.plugin
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.Data;
	import com.game.template.InterfaceTypes;
	import com.game.view.Component;
	import com.game.view.ViewEventBind;
	
	import starling.core.Starling;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class FlipGameOverComponent extends Component
	{
		private var _anti:Antiwear;
		
		//private var _exp:int;
		private function get exp() : int
		{
			return _anti["exp"];
		}
		private function set exp(value:int) : void
		{
			_anti["exp"] = value;
		}
		//private var _flip:int;
		private function get flip() : int
		{
			return _anti["flip"];
		}
		private function set flip(value:int) : void
		{
			_anti["flip"] = value;
		}
		//private var _totalExp:int;
		private function get totalExp() : int
		{
			return _anti["totalExp"];
		}
		private function set totalExp(value:int) : void
		{
			_anti["totalExp"] = value;
		}
		private var _expText:TextField;
		private var _flipText:TextField;
		private var _totalExpText:TextField;
		
		public function FlipGameOverComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["exp"] = 0;
			_anti["flip"] = 0;
			_anti["totalExp"] = 0;
			
			initEvent();
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
		 * 点击确定退出游戏
		 * 
		 */		
		private function onOk() : void
		{
			
			if(flip >= 8)
				Data.instance.pack.addUpgradeProp(3);
			else
				Data.instance.pack.addUpgradeProp(1);
			
			_view.flip_Game.hide();
			
			_view.flip_Game.close();
			_view.flip_Game.destroy();
			_view.world.interfaces(InterfaceTypes.REFRESH);
			_view.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
			_view.toolbar.checkPluginGame();
			
			_titleTxAtlas.dispose();
			_titleTxAtlas = null;
		}
		
		/**
		 * 显示游戏结束窗口
		 * @param exp
		 * 
		 */		
		public function showing(expInput:int, flipInput:int) : void
		{
			exp = expInput;
			flip = flipInput;
			totalExp = exp * flip;
			this.show();
			panel.parent.addChild(panel);
			
			_expText = searchOf("expNum") as TextField;
			_expText.text = exp.toString();
			_flipText = searchOf("flip") as TextField;
			_flipText.text = "X" + flip.toString();
			_totalExpText = searchOf("totalExp") as TextField;
			_totalExpText.text = "=" + totalExp.toString();
			
			//var expStr:String = (_exp + "X" + _flip).toString();
			//Starling.juggler.delayCall(delayShow, 1, expStr, expStr.length, delayExp);
			Data.instance.plugin.getlechery(totalExp, flip);
			//Data.instance.plugin.getStrengthen(12);
		}
		
		private function delayShow(str:String, len:int, callback:Function) : void
		{
			len--;
			_expText.text = str.substr(0, str.length - len);
			if(len != 0)
			{
				Starling.juggler.delayCall(delayShow, .2, str, len, callback);
			}
			else
			{
				if(callback == null) return;
				Starling.juggler.delayCall(callback, 1);
			}
		}
		
		private function delayExp() : void
		{
			_expText.text = "";
			var expStr:String = "+" + totalExp.toString(); 
			Starling.juggler.delayCall(delayShow, .2, expStr, expStr.length, null);
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
			return new FlipGameOverComponent(_configXML, _titleTxAtlas);
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
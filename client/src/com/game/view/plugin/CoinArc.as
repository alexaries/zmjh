package com.game.view.plugin
{
	import com.game.template.InterfaceTypes;
	import com.game.view.Component;
	import com.game.view.map.player.PlayerEntity;
	import com.greensock.TweenMax;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class CoinArc extends Component
	{
		public function CoinArc(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			getUI();
		}
		
		public var coinValue:int;
		private var _coinArcArr:Array = [];
		private var _score:int=0;
		
		private function getUI() : void
		{
			for(var i:int=1 ; i<=9 ; i++){
				var coinMc:MovieClip = this.searchOf("coin"+i);
				Starling.juggler.add(coinMc);
				_coinArcArr.push(coinMc);
			}
		}
		
		public function hitTest(player:PlayerRun):int{
			//人物的坐标为底部中点
			var _score:int=0;
			for each(var coin:MovieClip in _coinArcArr){
				if(Math.abs(this.panel.x + coin.x + coin.width * .5 - player.x) < (coin.width * .5 + player.width * .5 ) 
					&& Math.abs(this.panel.y + coin.y + coin.height * .5 - player.y + player.height * .5) < (coin.height * .5 + player.height * .5)){
					coin.alpha=0;
					_coinArcArr.splice(_coinArcArr.indexOf(coin),1);
					_score+=coinValue;
					
					var tf:TextField = new TextField(150, 30,"+"+coinValue.toString());	
					tf.fontName ="HKHB";
					tf.hAlign = HAlign.LEFT;
					tf.vAlign = VAlign.CENTER;
					tf.fontSize=18;
					//tf.color=0Xffff00;
					tf.x = coin.x+25;
					tf.y = coin.y+40;
					panel.addChild(tf);
					TweenMax.to(tf,2,{alpha:0,y:tf.y-50,onComplete: removeTF,onCompleteParams:[tf]});
				}
			}
			return _score;
		}
		
		
		/**
		 * 文本删除自身
		 * @param tf
		 * 
		 */	
		private function removeTF(tf:TextField):void{
			panel.removeChild(tf);
			tf.dispose();
			tf=null;
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
			return new CoinArc(_configXML, _titleTxAtlas);
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
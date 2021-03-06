
package
{
	import com.engine.error.ClientError;
	import com.engine.net.GamePayFor4399;
	import com.engine.net.GameRankListFor4399;
	import com.engine.net.GameServerFor4399;
	import com.game.manager.DebugManager;
	import com.game.manager.LayerManager;
	import com.game.manager.ResCacheManager;
	import com.game.manager.SoundPlayerManager;
	import com.game.template.V;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import starling.core.Starling;
	
	[SWF(width="940", height="590", backgroundColor="#000000", frameRate="24")]
	public class Main extends Sprite
	{
		//======此代码为存档功能专用代码========/
		public const _4399_function_store_id:String = '3885799f65acec467d97b4923caebaae';
		//======此代码为支付功能专用代码========/ 
		public const _4399_function_payMoney_id:String = '10f73c09b41d9f41e761232f5f322f38'; 
		
		//======此代码为商城功能专用代码========/ 
		public const _4399_function_shop_id:String = '30ea6b51a23275df624b781c3eb43ac6';
		
		//======此代码为多排行榜功能专用代码========/
		public const _4399_function_rankList_id:String = '69f52ab6eb1061853a761ee8c26324ae';
		
		//======此代码为api通用代码，在所有api里面只需加一次========/
		public static var serviceHold:* = null;
		
		public function setHold(hold:*):void
		{
			serviceHold = hold;
		}
		
		public function Main()
		{
			if (stage) init();
			else this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function set debug(obj:Object) : void
		{
			DebugManager.instance.debug = obj;
		}
		
		private function init(e:Event = null) : void
		{
			if (e) this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, ClientError.OnUncaughtError);
			
			/*Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			stage.showDefaultContextMenu = false;
			stage.tabChildren = false;*/
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.MEDIUM;
			
			GamePayFor4399.instance.stage = this.stage;
			GameServerFor4399.instance.stage = this.stage;
			GameRankListFor4399.instance.stage = this.stage;
			LayerManager.instance.cpu_stage = this.stage;
			
			// 设置当前是开发版本还是发布版本

			DebugManager.instance.gameMode = V.DEVELOP;//开发版本
			//DebugManager.instance.gameMode = V.RELEASE;//发布版本

			
			// 版本号
			ResCacheManager.instance.version = "1.45";
			
			if (DebugManager.instance.gameMode == V.RELEASE)
			{
				// test修改
				SoundPlayerManager.getIns().mute = false;
			}
			else
			{
				// 关闭声音
				SoundPlayerManager.getIns().mute = true;
			}
			
			if (this.stage.stageWidth > 0 && this.stage.stageHeight > 0)
			{
				startUp();
			}
			else
			{
				this.stage.addEventListener(Event.RESIZE, onResize);
			}
		}
		
		private function onResize(e:Event) : void
		{
			if (this.stage.stageWidth > 0 && this.stage.stageHeight > 0)
			{
				this.stage.removeEventListener(Event.RESIZE, onResize);
				startUp();
			}
		}
		
		private function startUp() : void
		{
			DebugManager.instance.inOutputPanel("startUp");
			
			// context 丢失
			Multitouch.inputMode = MultitouchInputMode.NONE;
			Starling.multitouchEnabled = false;
			Starling.handleLostContext = true;
			var mStarling:Starling = new Starling(GameEngine, this.stage, null, null, "auto", "baseline");
			mStarling.antiAliasing = 0;
			mStarling.showStats = (DebugManager.instance.gameMode != V.RELEASE);
			mStarling.simulateMultitouch = false;
			mStarling.enableErrorChecking = true;
			mStarling.antiAliasing = 0;
			mStarling.start();
		}
	}
}
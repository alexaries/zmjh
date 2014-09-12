package
{
	import com.game.GameManager;
	import com.game.View;
	import com.game.data.time.HackChecker;
	import com.game.manager.DebugManager;
	import com.game.manager.LayerManager;
	import com.game.template.InterfaceTypes;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	public class GameEngine extends Sprite
	{
		private var _game:GameManager;
		
		public function GameEngine()
		{
			DebugManager.instance.inOutputPanel("GameEngine");
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			DebugManager.instance.inOutputPanel("init");
			initApp();
		}
		
		protected function initApp() : void
		{
			LayerManager.instance.gpu_stage = this.stage;
			
			HackChecker.enabledCheckSpeedUp(1000, 50);
			HackChecker.hackHandler = cheatFunction;
			HackChecker.resetHandler = resetFunction;
			
			_game = new GameManager();
			_game.init();
			
			counter();
		}
		
		private function cheatFunction() : void
		{
			View.instance.accelerate.interfaces(InterfaceTypes.Show, "请不要使用加速工具，关闭加速工具后才能继续游戏！");
			Starling.juggler.delayCall(function () : void {LayerManager.instance.cpu_stage.frameRate = 0;}, 1);
		}
		
		private function resetFunction() : void
		{
			LayerManager.instance.cpu_stage.frameRate = 24;
			View.instance.accelerate.interfaces(InterfaceTypes.HIDE);
		}
		
		private var _timer:Timer;
		private function counter() : void
		{
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, timeProcess);
			_timer.start();
			
			this.addEventListener(Event.ENTER_FRAME, frameProcess);
		}
		
		private function timeProcess(e:TimerEvent) : void
		{
			_game.timeProcess();
		}
		
		private function frameProcess(e:Event) : void
		{
			_game.frameProcess();
		}
		
	}
}
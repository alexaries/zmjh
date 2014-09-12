package com.game.view.Role
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.data.DataList;
	import com.game.view.Component;
	
	import starling.display.Button;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class TransferChangeCount extends Component
	{
		private static const MAXCOUNT:int = DataList.list[10];
		private var _anti:Antiwear;
		public function TransferChangeCount(item:XML, titleTxAtlas:TextureAtlas)
		{
			_anti = new Antiwear(new binaryEncrypt());
			_anti["useLuck"] = 0;
			_anti["luckCount"] = 0;
			
			super(item, titleTxAtlas);
			init();
		}
		
		override protected function init() : void
		{
			super.init();
			
			getUI();
			initEvent();
		}
		
		public function get luckCount() : int
		{
			return _anti["luckCount"];
		}
		public function set luckCount(value:int) : void
		{
			_anti["luckCount"] = value;
		}
		public function get useLuck() : int
		{
			return _anti["useLuck"];
		}
		public function set useLuck(value:int) : void
		{
			_anti["useLuck"] = value;
		}
		private var _callback:Function
		public function setData(count:int, callback:Function = null) : void
		{
			luckCount = count;
			_callback = callback;
			setButtonState();
		}
		
		private var _luckyNum:TextField;
		private var _luckyLeftBtn:Button;
		private var _luckyRightBtn:Button;
		private function getUI() : void
		{
			_luckyNum = searchOf("LuckyNum") as TextField;
			_luckyLeftBtn = searchOf("LuckyLeft") as Button;
			_luckyRightBtn = searchOf("LuckyRight") as Button;
			_luckyLeftBtn.addEventListener(TouchEvent.TOUCH, onReduceNum);
			_luckyRightBtn.addEventListener(TouchEvent.TOUCH, onAddNum);
			
			removeTouchable(_luckyLeftBtn);
			removeTouchable(_luckyRightBtn);
			
			useLuck = 0;
		}
		
		private function onReduceNum(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_luckyLeftBtn);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				useLuck--;
				setButtonState();
			}
		}
		
		private function onAddNum(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_luckyRightBtn);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				useLuck++;
				setButtonState();
			}
		}
		
		private function setButtonState() : void
		{
			_luckyNum.text = useLuck.toString();
			addTouchable(_luckyLeftBtn);
			addTouchable(_luckyRightBtn);
			if(luckCount > 0)
			{
				if(useLuck <= 0)
				{
					removeTouchable(_luckyLeftBtn);
				}
				else if(useLuck >= luckCount || useLuck >= MAXCOUNT)
				{
					removeTouchable(_luckyRightBtn);
				}
			}
			else 
			{
				removeTouchable(_luckyLeftBtn);
				removeTouchable(_luckyRightBtn);
			}
			if(_callback != null) _callback();
		}
		
		public function resetButton() : void
		{
			useLuck = 0;
			_luckyNum.text = useLuck.toString();
			removeTouchable(_luckyLeftBtn);
			removeTouchable(_luckyRightBtn);
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new TransferChangeCount(_configXML, _titleTxAtlas);
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
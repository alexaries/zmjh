package com.game.view.equip
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.game.data.db.protocal.Equipment_strengthen;
	import com.game.data.db.protocal.Fragment;
	import com.game.template.InterfaceTypes;
	import com.game.view.Component;
	
	import starling.display.Button;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class ChangeCountComponent extends Component
	{
		private var _anti:Antiwear;
		public function get nowCount() : int
		{
			return _anti["nowCount"];
		}
		public function set nowCount(value:int) : void
		{
			_anti["nowCount"] = value;
		}
		//private var _nowComposeCount:int;
		private function get nowComposeCount() : int
		{
			return _anti["nowComposeCount"];
		}
		private function set nowComposeCount(value:int) : void
		{
			_anti["nowComposeCount"] = value;
		}
		//private var _maxCount:int;
		private function get maxCount() : int
		{
			return _anti["maxCount"];
		}
		private function set maxCount(value:int) : void
		{
			_anti["maxCount"] = value;
		}
		private var _callback:Function;
		public function ChangeCountComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["nowCount"] = 0;
			_anti["nowComposeCount"] = 0;
			_anti["maxCount"] = 0;
			
			getUI();
			initEvent();
		}
		
		/**
		 * 充灵数据
		 */		
		private var _fragment:Fragment;
		/**
		 * 当前充灵值
		 */		
		private var _nowComposeData:Equipment_strengthen;
		public function setData(count:int, fragment:Fragment, composeCount:int, callback:Function = null) : void
		{
			nowCount = 0;
			maxCount = count;
			_fragment = fragment;
			nowComposeCount = composeCount;
			_nowComposeData = _view.equip_strengthen.nowComposeData;
			_callback = callback;
			_luckyNum.text = nowCount.toString();
			renderButton();
			if(_callback != null) _callback();
		}
		
		private var _luckyNum:TextField;
		private var _luckyLeftBtn:Button;
		private var _luckyRightBtn:Button;
		private function getUI() : void
		{
			nowCount = 0;
			_luckyNum = searchOf("LuckyNum") as TextField;
			_luckyNum.text = "0";
			_luckyLeftBtn = searchOf("LuckyLeft") as Button;
			_luckyRightBtn = searchOf("LuckyRight") as Button;
			_luckyLeftBtn.addEventListener(TouchEvent.TOUCH, onReduceNum);
			_luckyRightBtn.addEventListener(TouchEvent.TOUCH, onAddNum);
			
			removeTouchable(_luckyLeftBtn);
			removeTouchable(_luckyRightBtn);
		}
		
		private function onReduceNum(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_luckyLeftBtn);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				if(nowCount > 0)
				{
					nowCount--;
					_luckyNum.text = (nowCount * _fragment.use_value).toString();
					renderButton();
					if(_callback != null) _callback();
				}
			}
		}
		
		private function onAddNum(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(_luckyRightBtn);
			if(!touch) return;
			if(touch.phase == TouchPhase.ENDED)
			{
				if(nowCount < Math.floor(maxCount / _fragment.use_value))
				{
					nowCount++;
					_luckyNum.text = (nowCount * _fragment.use_value).toString();
					renderButton();
					if(_callback != null) _callback();
				}
			}
		}
		
		public function renderButton() : void
		{
			if(_callback == null) return;
			addTouchable(_luckyLeftBtn);
			addTouchable(_luckyRightBtn);
			if(nowCount == 0)
			{
				removeTouchable(_luckyLeftBtn);
			}
			if(Math.floor(maxCount / _fragment.use_value) == nowCount || nowComposeCount >= _nowComposeData.total_value)
			{
				removeTouchable(_luckyRightBtn);
			}
		}
		
		public function resetButton() : void
		{
			nowCount = 0;
			_callback = null;
			_luckyNum.text = "0";
			removeTouchable(_luckyLeftBtn);
			removeTouchable(_luckyRightBtn)
		}
		
		public function setRightUnTouch() : void
		{
			removeTouchable(_luckyRightBtn);
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
			return new ChangeCountComponent(_configXML, _titleTxAtlas);
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
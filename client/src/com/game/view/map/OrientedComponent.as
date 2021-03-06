package com.game.view.map
{
	import com.game.manager.LayerManager;
	import com.game.view.ViewEventBind;
	
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	
	public class OrientedComponent extends Sprite
	{
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const UP:String = "up";
		public static const DOWN:String = "down";
		
		private var _view:MapView;
		private var _panel:Sprite;		
		private var _texture:Texture;
		
		public const dis:uint = 20;
		
		public function OrientedComponent(view:MapView, texture:Texture) : void
		{
			_view = view;
			_panel = view.mapLayers.playerLayer;
			_texture = texture;
			_pools = new Vector.<Button>();

			init();
		}
		
		private var _btnRight:Button;
		private var _btnLeft:Button;
		private var _btnUp:Button;
		private var _btnDown:Button;
		private function init() : void
		{
			if (_btnRight) clearBtn(_btnRight);
			_btnRight = getButton(RIGHT);
			_btnRight.x = _btnRight.width + dis;
			
			if (_btnLeft) clearBtn(_btnLeft);
			_btnLeft = getButton(LEFT);
			_btnLeft.scaleX = -1;
			_btnLeft.x = -_btnLeft.width - dis;
			
			if (_btnDown) clearBtn(_btnDown);
			_btnDown = getButton(DOWN);
			_btnDown.rotation = deg2rad(90);		
			_btnDown.y = _btnDown.height + dis;
			
			if (_btnUp) clearBtn(_btnUp);
			_btnUp = getButton(UP);
			_btnUp.rotation = deg2rad(270);					
			_btnUp.y = -_btnUp.height - dis;
			
			initEvent();
		}
		
		private function clearBtn(target:Button) : void
		{
			if (target.parent) target.parent.removeChild(target);
			target.removeEventListeners();
			target.dispose();
			target = null;
		}
		
		private var _pools:Vector.<Button>;
		private function getButton(name:String) : Button
		{
			var btn:Button = new Button(_texture);
			btn.touchable = true;
			btn.pivotX = _texture.width/2;
			btn.pivotY = _texture.height/2;
			btn.name = name;
			btn.useHandCursor = true;
			addChild(btn);			
			_pools.push(btn);
			return btn;
		}
		
		public function initEvent() : void
		{
			for each(var btn:Button in _pools)
			{
				btn.touchable = true;
				btn.useHandCursor = true;
				btn.addEventListener(TouchEvent.TOUCH, onClick);
			}
		}
		
		private function onClick(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(e.currentTarget as DisplayObject);
			
			if (touch && touch.phase == TouchPhase.BEGAN)
			{
				_btnLeft.touchable = _btnRight.touchable = _btnUp.touchable = _btnDown.touchable = false;
			}
			else if (touch && touch.phase == TouchPhase.ENDED)
			{
				_btnLeft.visible = _btnRight.visible = _btnUp.visible = _btnDown.visible = false;
				
				var name:String = (e.currentTarget as Button).name;
				var node:Node = _curNodes[name];
				_callback(node);
				LayerManager.instance.gpu_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
				
			}
		}
		
		/**
		 * 自动点击方向
		 * @param name
		 * 
		 */		
		private function autoClick(name:String) : void
		{
			_btnLeft.visible = _btnRight.visible = _btnUp.visible = _btnDown.visible = false;
			var node:Node = _curNodes[name];
			_callback(node);
		}
		
		private var _callback:Function;
		private var _curNodes:Object;
		public function setPosition(curNode:Node, RoadNode:Vector.<Node>, curPoint:Point, callback:Function) : void
		{
			init();
			LayerManager.instance.gpu_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
			_callback = callback;
			_curNodes = {};
			
			_panel.addChild(this);
			
			this.x = curPoint.x;
			this.y = curPoint.y;
			
			_btnLeft.visible = _btnRight.visible = _btnUp.visible = _btnDown.visible = false;
			for each(var item:Node in RoadNode)
			{
				// 左
				if (item.curIndex.x < curNode.curIndex.x)
				{
					_btnLeft.visible = true;
					_curNodes[LEFT] = item;
					/*if(_view.autoLevel) 
					{
						autoClick(LEFT);
						break;
					}*/
				}
				// 右
				else if (item.curIndex.x > curNode.curIndex.x)
				{
					_btnRight.visible = true;
					_curNodes[RIGHT] = item;
					/*if(_view.autoLevel) 
					{
						autoClick(RIGHT);
						break;
					}*/
				}
				// 上
				else if (item.curIndex.y < curNode.curIndex.y)
				{
					_btnUp.visible = true;
					_curNodes[UP] = item;
					/*if(_view.autoLevel) 
					{
						autoClick(UP);
						break;
					}*/
				}
				// 下
				else if (item.curIndex.y > curNode.curIndex.y)
				{
					_btnDown.visible = true;
					_curNodes[DOWN] = item;
					/*if(_view.autoLevel)
					{
						autoClick(DOWN);
						break;
					}*/
				}
			}
		}
		
		private function pressBtn(btnName:String):void{
			_btnLeft.visible = _btnRight.visible = _btnUp.visible = _btnDown.visible = false;
			var name:String = btnName;
			var node:Node = _curNodes[name];
			_callback(node);
			_btnLeft.touchable = _btnRight.touchable = _btnUp.touchable = _btnDown.touchable = true;
			LayerManager.instance.gpu_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDowns);
			
		}
		
		private function onKeyDowns(e:KeyboardEvent) : void
		{
			if(_btnUp.visible && _btnUp.touchable && e.keyCode==Keyboard.UP){
				pressBtn(UP);
			}
			
			if(_btnDown.visible &&  _btnDown.touchable && e.keyCode==Keyboard.DOWN){
				pressBtn(DOWN);
			}
			
			if(_btnLeft.visible &&  _btnLeft.touchable && e.keyCode==Keyboard.LEFT){
				pressBtn(LEFT);
			}
			
			if(_btnRight.visible &&  _btnRight.touchable && e.keyCode==Keyboard.RIGHT){
				pressBtn(RIGHT);
			}	
			
		}
		
		public function clear() : void
		{
			
		}
	}
}
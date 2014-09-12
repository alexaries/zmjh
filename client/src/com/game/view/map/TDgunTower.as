package com.game.view.map
{
	import com.game.template.GameConfig;
	import com.game.view.map.player.PlayerEntity;
	import com.game.view.map.player.TDPlayerEntity;
	import com.greensock.TweenMax;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class TDgunTower extends Sprite
	{
		/**
		 * 文件名 
		 */		
		public var file:String;
		/**
		 * 类型 
		 */		
		public var type:String;
		/**
		 * 格子索引X 
		 * 
		 */
		public var ix:int;
		/**
		 * 格子索引Y
		 * 
		 */	
		public var iy:int;
		
		/**
		 * 参数 
		 */		
		public var args:Object;
		
		
		/**
		 *射击频率
		 */		
		private const frequency:Number =0.2;
		
		/**
		 *射击半径
		 */		
		private const radius:int= 200;
		
		public function TDgunTower(view:TowerDefenceView)
		{
			_view = view;
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected var _imageTexture:Texture;
		public function setTexture(image:Texture,bullet:Texture) : void
		{
			_imageTexture = image;
			_bulletTexture = bullet;
			initImage();
		}
		
		private var _bulletTexture:Texture;
		
		private var _view:TowerDefenceView;
		
		private var _circleImage:Image;
		
		private function onAdded(e:Event) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			/*			this.x = ix * _view.mapInfo.titleWidth ;
			this.y = iy * _view.mapInfo.titleHeight ;*/
			
			
			this.x = ix * _view.mapInfo.titleWidth + _view.mapInfo.titleWidth/2 + _view.mapInfo.mpx - _image.width/2;
			this.y = iy * _view.mapInfo.titleHeight + _view.mapInfo.titleHeight/2 + _view.mapInfo.mpy - _image.height/2;
		}
		
		protected var _image:Image;
		
		
		private function initImage() : void
		{
			_image = new Image(_imageTexture);
			//_image.addEventListener(TouchEvent.TOUCH, onTouchEvent);
			this.addChild(_image);
			
			var _circle:Shape = new Shape;
			_circle.graphics.clear();  
			_circle.graphics.lineStyle(2, 0xFFFFFF); 
			_circle.graphics.drawCircle(250, 250, radius);
			_circle.graphics.endFill(); 
			_circle.cacheAsBitmap = true;
			var _bmpData:BitmapData = new BitmapData(500, 500, true, 0);
			_bmpData.draw(_circle);
			var _cutTexture:Texture = Texture.fromBitmapData(_bmpData);
			_circleImage = new Image(_cutTexture);
			_circleImage.pivotX=_circleImage.width/2;
			_circleImage.pivotY=_circleImage.height/2;
			_circleImage.x=this.width/2;
			_circleImage.y=this.height/2;
			this.addChild(_circleImage);
			_circleImage.visible=false;
			this.addEventListener(TouchEvent.TOUCH, onTouchEvent);
			
		}
		
		private function onTouchEvent(e:TouchEvent) : void
		{
			var touch:Touch = e.getTouch(this);
			if (touch&&touch.phase==TouchPhase.ENDED) 
			{
				
			}
			
			if (touch&&touch.phase==TouchPhase.HOVER) 
			{
				
				_circleImage.visible=true;
				(this.parent as Sprite).flatten();
				
			}else
			{
				_circleImage.visible=false;
			}
		}
		
		private var _timer:Timer;
		private var _target:TDPlayerEntity;
		private var _shoot:Boolean=false;
		public function TowerAttack(target:TDPlayerEntity):void{
			if(!target){
				return;
			}
			
			var pos1:Point = new Point(target.x+_view.mapLayers.mapLayer.x, target.y+_view.mapLayers.mapLayer.y); 
			var pos2:Point = new Point(this.x +_view.mapLayers.mapLayer.x + _image.width/2, this.y+_view.mapLayers.mapLayer.y+ _image.height/2); 
			var dis:Number = Point.distance(pos1, pos2);
			
			if( dis<radius && !_shoot){
				_shoot=true;
				_target=target;
				shootBullet(null);
				_timer = new Timer(frequency*1000);
				_timer.addEventListener(TimerEvent.TIMER, shootBullet);
				_timer.start();
			}else if(dis>radius && _shoot){
				_timer.stop();
				_shoot=false;
			}
		}
		
		
		private function shootBullet(e:TimerEvent):void{
			
			var _bullet:Image = new Image(_bulletTexture);
			_bullet.pivotX=_bullet.width/2;
			_bullet.pivotY=_bullet.height/2;
			_bullet.x=this.x + _image.width/2;
			_bullet.y=this.y+ _image.height/2
			_view.mapLayers.bulletLayer.addChild(_bullet);
			Starling.juggler.delayCall(removeBullet,0.2,_bullet);
			_view.playerRole.getHurt(1);
			TweenMax.to(_bullet, 0.2, {bezier:[{x:_target.x, y:_target.y-50}]});
			
			/*			var _line:Shape = new Shape;
			_line.graphics.clear();  
			_line.graphics.lineStyle(4, 0x0000FF);
			_line.graphics.moveTo(this.x + _image.width/2 , this.y+ _image.height/2);
			_line.graphics.lineTo(_target.x-10, _target.y-30);
			//_line.graphics.endFill(); 
			_line.cacheAsBitmap = true;
			var _bmpData:BitmapData = new BitmapData(1000, 1000,true,0);
			_bmpData.draw(_line);
			var _cutTexture:Texture = Texture.fromBitmapData(_bmpData);
			var _lineImage:Image = new Image(_cutTexture);
			_lineArr.push(_lineImage);
			//_view.panel.addChild(_dotImage);
			//.panel.flatten();
			_view.mapLayers.propLayer.addChild(_lineImage);
			_view.mapLayers.propLayer.flatten();
			Starling.juggler.delayCall(removeLine,0.2,_lineImage);
			_view.playerRole.getHurt(1);*/
		}
		
		private function removeBullet(...args):void{
			_view.mapLayers.bulletLayer.removeChild(args[0]);
			args[0].texture.dispose();
			args[0].dispose();
			args[0]=null;
		}
		
		
		/*		override public function set x(value:Number):void
		{
		var rx:int = value - this.width/2;
		super.x = rx;
		}
		
		override public function set y(value:Number):void
		{
		var ry:int = value - this.height/2;
		super.y = ry;
		}*/
		
		public function destroy() : void
		{
			_timer.stop();
			
			_imageTexture.dispose();
			_imageTexture = null;
			
			_circleImage.texture.dispose();
			_circleImage.dispose();
			
			_bulletTexture.dispose();
			_bulletTexture=null;
			
			_image.texture.dispose();
			_image.dispose();
			
			super.dispose();
		}
		
		
		
	}
}
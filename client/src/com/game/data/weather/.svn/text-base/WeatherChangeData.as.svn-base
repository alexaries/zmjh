package com.game.data.weather
{
	import com.game.Data;
	import com.game.View;
	import com.game.data.DataList;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.map.MapUtils;
	import com.game.view.map.MapView;
	import com.game.view.map.Prop;
	import com.game.view.map.player.PlayerEntity;
	import com.game.view.map.player.PlayerStatus;
	import com.game.view.weather.WeatherEffect;
	
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	public class WeatherChangeData
	{
		private static var _curState:String;
		private static var _curCallback:Function;
		private static function get map() : MapView
		{
			return View.instance.map;
		}
		
		public function WeatherChangeData()
		{
			
		}
		
		private static var _windState:Boolean;
		private static var _windCount:int;
		private static var windFrontEffect:Vector.<MovieClip>;
		private static var windBackEffect:Vector.<MovieClip>;
		public static function onAddWindEffect(curState:String, curCallback:Function) : void
		{
			_curState = curState;
			_curCallback = curCallback;
			windFrontEffect = new Vector.<MovieClip>();
			windBackEffect = new Vector.<MovieClip>();
			if(Data.instance.player.player.roleFashionInfo.checkFashionUse(V.MAIN_ROLE_NAME))
			{
				windFrontEffect = map.weatherEffect._windFrontFashionEffect;
				windBackEffect = map.weatherEffect._windBackFashionEffect;
			}
			else
			{
				windFrontEffect = map.weatherEffect._windFrontEffect;
				windBackEffect = map.weatherEffect._windBackEffect;
			}
			_windState = false;
			_windCount = 0;
			for(var j:int = 0; j < windFrontEffect.length; j++)
			{
				var randomCount:int = Math.floor(Math.random() * map.hitRoad.length);
				var point:Point = MapUtils.getRoadPoint(map.hitRoad[randomCount].ix, map.hitRoad[randomCount].iy);
				map.hitRoad.splice(map.hitRoad.indexOf(map.hitRoad[randomCount]), 1);
				//var point:Point = new Point(map.playerRole.x, map.playerRole.y);
				windFrontEffect[j].x = point.x;
				windFrontEffect[j].y = point.y;
				windBackEffect[j].x = point.x;
				windBackEffect[j].y = point.y;
				if(point.x == map.playerRole.x && point.y == map.playerRole.y)
				{
					_windState = true;
					_windCount = j;
					map.playerRole.State = PlayerStatus.FEI;
					map.mapLayers.playerLayer.addChild(windFrontEffect[j]);
					map.mapLayers.playerLayer.addChildAt(windBackEffect[j], 0);
					map.mapLayers.playerLayer.addEventListener(Event.ENTER_FRAME, nearPlayer);
				}
				else
				{
					map.mapLayers.playerLayer.addChildAt(windFrontEffect[j], 0);
					map.mapLayers.playerLayer.addChildAt(windBackEffect[j], 0);
				}
				windFrontEffect[j].play();
				windBackEffect[j].play();
				Starling.juggler.add(windFrontEffect[j]);
				Starling.juggler.add(windBackEffect[j]);
			}
			Starling.juggler.delayCall(onWindContinue, .7, map.mapInfo.roadItems[Math.floor(map.mapInfo.roadItems.length * Math.random())]);
		}
		
		private static function nearPlayer(e:Event) : void
		{
			windFrontEffect[_windCount].x = map.playerRole.x;
			windFrontEffect[_windCount].y = map.playerRole.y;
			windBackEffect[_windCount].x = map.playerRole.x;
			windBackEffect[_windCount].y = map.playerRole.y;
		}
		
		private static function onWindContinue(prop:Prop) : void
		{
			if(_windState)
			{
				onFly(prop);
			}
			else
			{
				map.weatherEffect.removeWindFly();
				//_view.toolbar.panel.touchable = true;
				map.playerRole.State = _curState;
				if(_curCallback != null) _curCallback();
			}
		}
		
		private static function onFly(prop:Prop) : void
		{
			var ix:int = prop.ix;
			var iy:int = prop.iy;
			
			var point:Point = MapUtils.getRoadPoint(ix, iy);
			
			map.playerRole.flyTransmit(point.x,
				point.y,
				function () : void
				{
					Starling.juggler.delayCall(getWindEquip, .5, prop);
				}
			);
			map.mapInfo.playerPosition.gx = ix;
			map.mapInfo.playerPosition.gy = iy;
		}
		
		private static function getWindEquip(prop:Prop) : void
		{
			map.playerRole.reset();
			map.weatherEffect.removeWindFly();
			View.instance.weather_pass.pass(
				map.curLevel,
				map.kind,
				V.WIND_TYPE,
				function () : void
				{
					//_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
					map.mapLayers.playerLayer.removeEventListener(Event.ENTER_FRAME, nearPlayer);
					map.alreadyFly(prop);
				});
		}
		
		
		private static var _thunderCount:int;
		private static var _thunderState:Boolean;
		public static function onAddThunderEffect(curState:String, curCallback:Function) : void
		{
			_curState = curState;
			_curCallback = curCallback;
			var thunderList:Vector.<MovieClip> = map.weatherEffect._thunderList;
			_thunderCount = thunderList.length;
			_thunderState = false;
			for(var j:int = 0; j < thunderList.length; j++)
			{
				var randomCount:int = Math.floor(Math.random() * map.hitRoad.length);
				var point:Point = MapUtils.getRoadPoint(map.hitRoad[randomCount].ix, map.hitRoad[randomCount].iy);
				map.hitRoad.splice(map.hitRoad.indexOf(map.hitRoad[randomCount]), 1);
				//var point:Point = new Point(playerRole.x, playerRole.y);
				thunderList[j].x = point.x;
				thunderList[j].y = point.y;
				if(point.y <= map.playerRole.y)	 	map.mapLayers.playerLayer.addChildAt(thunderList[j], 0);
				else	map.mapLayers.playerLayer.addChild(thunderList[j]);
				thunderList[j].visible = true;
				thunderList[j].currentFrame = 0;
				thunderList[j].play();
				Starling.juggler.add(thunderList[j]);
				thunderList[j].addEventListener(Event.COMPLETE, onContinue);
				if(point.x == map.playerRole.x && point.y == map.playerRole.y)
				{
					_thunderState = true;
					map.playerRole.State = PlayerStatus.ZMBP;
					View.instance.controller.data.formation.setRoleHPChange(DataList.littleList[25]);
					View.instance.toolbar.interfaces(InterfaceTypes.REFRESH_PART);
					View.instance.prompEffect.play("所有角色体力减少25%");
				}
			}
		}
		
		private static function onContinue(e:Event) : void
		{
			var mc:MovieClip = e.target as MovieClip;
			if(mc != null && mc.parent) mc.parent.removeChild(mc);
			mc.visible = false;
			mc.stop();
			Starling.juggler.remove(mc);
			_thunderCount--;
			if(_thunderCount == 0)
			{
				if(_thunderState)
				{
					Starling.juggler.delayCall(
						function () : void
						{
							//_view.toolbar.panel.touchable = true;
							View.instance.weather_pass.pass(
								map.curLevel,
								map.kind,
								V.THUNDER_TYPE,
								function () : void
								{
									map.playerRole.setPlay();
									map.playerRole.State = _curState;
									if(_curCallback != null) _curCallback();
								});
						},
						.6);
				}
				else
				{
					Starling.juggler.delayCall(
						function () : void
						{
							//_view.toolbar.panel.touchable = true;
							map.playerRole.setPlay();
							map.playerRole.State = _curState;
							if(_curCallback != null) _curCallback();
						},
						.6);
				}
			}
		}
	}
}
package com.game.data.map
{
	import com.engine.core.Log;
	import com.game.View;
	import com.game.data.Base;
	import com.game.view.map.Prop;

	public class AutoFightData extends Base
	{
		private var _view:View;
		public function AutoFightData()
		{
			_view = View.instance;
		}
		
		/**
		 * 扫荡模式下是第几波
		 */
		private var _fightCount:int;
		
		public function get fightCount() : int
		{
			return _fightCount;
		}
		public function set fightCount(value:int) : void
		{
			_fightCount = value;
		}
		private var _pointList:Vector.<int>;
		private var _pointLength:Vector.<int>;
		private var _pointCount:int;
		private var _pointChange:int;
		/**
		 * 扫荡模式初始化
		 * 
		 */		
		public function startCount() : void
		{
			_pointList = new Vector.<int>(20);
			_pointLength = new Vector.<int>(20);
			_roadCorner = new Vector.<Prop>();
			_pointChange = 0;
			_fightCount = 0;
			countRoad();
			//_view.auto_fight.interfaces(InterfaceTypes.Show, countRoad);
		}
		
		private var _autoRoad:Vector.<Prop>;
		public function get autoRoad() : Vector.<Prop>
		{
			return _autoRoad;
		}
		private var _oneRoadX:Vector.<Prop>;
		private var _oneRoadInit:Vector.<Prop>;
		private var _roadCorner:Vector.<Prop>;
		private var _nowProp:Prop;
		private var _lastProp:Prop;
		private var _cornerProp:Prop;
		/**
		 * 开始计算扫荡模式的路径
		 * 
		 */		
		private function countRoad() : void
		{
			_autoRoad = new Vector.<Prop>();
			_oneRoadX = new Vector.<Prop>();
			_oneRoadInit = new Vector.<Prop>();
			_pointCount = 0;
			for(var j:int = 0; j < _view.map.mapInfo.roadItems.length; j++)
			{
				_oneRoadInit.push(_view.map.mapInfo.roadItems[j]);
			}
			for(var i:int = 0; i < _oneRoadInit.length; i++)
			{
				//boss点坐标
				if(_oneRoadInit[i].type == "Boss")
				{
					_autoRoad.push(_oneRoadInit[i]);
					_lastProp = _oneRoadInit[i];
				}
					//起点坐标
				else if(_oneRoadInit[i].type == "路点" && _oneRoadInit[i].ix == _view.map.mapInfo.playerPosition.gx && _oneRoadInit[i].iy == _view.map.mapInfo.playerPosition.gy)
				{
					_autoRoad.push(_oneRoadInit[i]);
					_nowProp = _oneRoadInit[i];
					_oneRoadInit.splice(_oneRoadInit.indexOf(_oneRoadInit[i]), 1);
				}
			}
			//开始计算
			getRoad();
		}
		
		/**
		 * 获得自动路径
		 * 
		 */		
		private function getRoad() : void
		{
			//获得当前相邻的坐标点
			for(var i:int = _oneRoadInit.length - 1; i >= 0; i--)
			{
				if((_oneRoadInit[i].ix == _nowProp.ix + 1 && _oneRoadInit[i].iy == _nowProp.iy)|| (_oneRoadInit[i].ix == _nowProp.ix - 1  && _oneRoadInit[i].iy == _nowProp.iy) || (_oneRoadInit[i].ix == _nowProp.ix && _oneRoadInit[i].iy == _nowProp.iy + 1) || (_oneRoadInit[i].ix == _nowProp.ix && _oneRoadInit[i].iy == _nowProp.iy - 1))
				{
					_oneRoadX.push(_oneRoadInit[i]);
				}
			}
			//只有一个相邻的坐标，直接放入
			if(_oneRoadX.length == 1)
			{
				_autoRoad.push(_oneRoadX[0]);
				_nowProp = _oneRoadX[0];
				_oneRoadInit.splice(_oneRoadInit.indexOf(_oneRoadX[0]), 1);
				//trace(_nowProp.ix, _nowProp.iy);
			}
				//不止一个相邻的坐标
			else if(_oneRoadX.length > 1)
			{
				var count:int = _pointList[_pointCount];
				_cornerProp = _nowProp;
				
				if(_roadCorner.indexOf(_cornerProp) == -1)
				{
					_roadCorner.push(_cornerProp);
					_pointLength[_pointCount] = _oneRoadX.length;
				}
				
				Log.Trace("分叉点：x:" + _cornerProp.ix.toString() + ",y:" + _cornerProp.iy.toString() + "；第" + (count+1).toString() + "次进入该分叉点");
				
				_autoRoad.push(_oneRoadX[count]);
				_nowProp = _oneRoadX[count];
				_oneRoadInit.splice(_oneRoadInit.indexOf(_oneRoadX[count]), 1);
				
				_pointCount++;
			}
				//没有能继续的坐标，返回到前一个分叉坐标
			else
			{
				//trace(false);
				while(_autoRoad[_autoRoad.length - 1] != _cornerProp)
				{
					_oneRoadInit.push(_autoRoad.pop());
				}
				_nowProp = _cornerProp;
				_pointCount--;
				_pointList[_pointCount]++;
				//前一个分叉坐标的所有分叉都不能继续，继续返回再上一个分叉坐标，直到有分叉坐标可以走
				while(_pointList[_pointCount] >= _pointLength[_pointCount])
				{
					_pointList[_pointCount] = 0;
					_roadCorner.pop();
					_nowProp = _cornerProp = _roadCorner.pop();
					while(_autoRoad[_autoRoad.length - 1] != _cornerProp)
					{
						_oneRoadInit.push(_autoRoad.pop());
					}
					_pointCount--;
					_pointList[_pointCount]++;
				}
				getRoad();
				return;
			}
			
			while(_oneRoadX.length > 0)
			{
				_oneRoadX.pop();
			}
			//已经到达Boss点坐标
			if(_nowProp.ix == _lastProp.ix && _nowProp.iy == _lastProp.iy)
			{
				trace(_autoRoad.length, _autoRoad[_autoRoad.length - 1].type);
				_view.map.skipLevel();
			}
				//继续增加坐标
			else
			{
				getRoad();
			}
			
		}
	}
}
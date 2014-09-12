package com.game.view.map
{
	import com.game.View;
	
	import flash.geom.Point;
	
	public class TDMapUtils
	{
		/**
		 * 获取路点 
		 * @param ix
		 * @param iy
		 * @return 
		 * 
		 */		
		public static function getRoadPoint(ix:int, iy:int) : Point
		{
			var point:Point = new Point();
			
			point.x = ix * View.instance.map.mapInfo.titleWidth + View.instance.map.mapInfo.titleWidth/2 + View.instance.map.mapInfo.mpx,
				point.y = iy * View.instance.map.mapInfo.titleHeight + View.instance.map.mapInfo.titleHeight/2 + View.instance.map.mapInfo.mpy
			return point;
		}
		
		
		/**
		 * 获取路点信息 
		 * @return 
		 * 
		 */		
		public static function getRoadInfo(startNode:Node, step:uint, roads:Vector.<TDprop>) : SingleLineInfo
		{
			var roadInfo:SingleLineInfo = new SingleLineInfo();
			
			var info:SingleLineInfo;
			var curPoint:Point;
			
			var node:Vector.<Node>;
			var curNodes:Vector.<Node>;
			var preNodes:Vector.<Node> = new Vector.<Node>();
			while (step > 0)
			{
				curNodes = new Vector.<Node>();
				if (preNodes.length == 0)
				{
					node = getCurNode(roads, startNode);
					curNodes = curNodes.concat(node);
				}
				else
				{
					for each(var item:Node in preNodes)
					{
						node = getCurNode(roads, item);
						curNodes = curNodes.concat(node);
					}
				}
				
				if (curNodes.length == 0) break;
				
				roadInfo.pushNewRoad(curNodes);
				
				preNodes = curNodes;
				step --;
			}
			
			return roadInfo;
		}
		
		private static function getCurNode(roads:Vector.<TDprop>, curNode:Node) : Vector.<Node>
		{
			var nodes:Vector.<Node> = new Vector.<Node>();
			
			var node:Node;
			for each(var prop:TDprop in roads)
			{
				if (judge(curNode, prop.ix, prop.iy))
				{
					node = new Node();
					node.preIndex = curNode.curIndex;
					node.curIndex = new Point(prop.ix, prop.iy);
					nodes.push(node);
				}
			}
			
			// 到尽头
			if (!node)
			{
				node = new Node();
				node.curIndex = curNode.preIndex;
				node.preIndex = curNode.curIndex;
				nodes.push(node);
			}
			
			return nodes;
		}
		
		private static function judge(curNode:Node, ix:int, iy:int) : Boolean
		{
			var ableMove:Boolean = false;
			
			// 是否是相邻格子且不是之前刚走的格子
			
			if (curNode.curIndex.x == ix)
			{
				if (Math.abs(curNode.curIndex.y - iy) == 1 && (!curNode.preIndex || !(ix == curNode.preIndex.x && iy == curNode.preIndex.y)))
				{
					ableMove = true;
				}
				else
				{
					ableMove = false;
				}
			}
			
			if (curNode.curIndex.y == iy)
			{
				if (Math.abs(curNode.curIndex.x - ix) == 1 && (!curNode.preIndex || !(ix == curNode.preIndex.x && iy == curNode.preIndex.y)))
				{
					ableMove = true;
				}
				else
				{
					ableMove = false;
				}
			}
			
			return ableMove;
		}
	}
}
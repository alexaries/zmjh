package com.game.view
{
	public interface IView
	{
		// 接口
		function interfaces(type:String = "", ...args) : *;
		
		// 清理
		function close() : void;
		
		function hide() : void;
	}
}
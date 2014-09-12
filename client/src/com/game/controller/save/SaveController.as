package com.game.controller.save
{
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.View;
	import com.game.controller.Base;
	import com.game.data.player.structure.Player;
	import com.game.data.save.RankSaveData;
	import com.game.data.save.SubmitData;
	import com.game.manager.DebugManager;
	import com.game.manager.LayerManager;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	
	import starling.core.Starling;

	public class SaveController extends Base
	{
		// 玩家
		private var _player:Player;
		
		/**
		 * 是否能发送保存 
		 */		
		private var _isCanSend:Boolean;
		public function set isCanSend(value:Boolean) : void
		{
			_isCanSend = value;
		}
		public function get isCanSend() : Boolean
		{
			return _isCanSend;
		}
		
		public function SaveController()
		{
			_isCanSend = true;
		}
		
		
		public var isMultiple:Boolean = false;
		public function onNewGame(callback:Function, index:int) : void
		{
			_controller.data.save.newPlayerSetData(callback, index);
		}
		
		/**
		 * 取数据列表 
		 * @param callback
		 * 
		 */		
		public function getSaveList(callback:Function) : void
		{
			_controller.data.save.getSaveList(callback);
		}
		
		public function getLogged() : void
		{
			_controller.data.save.getLogged();
		}
		
		/**
		 * 存数据 
		 * @param data
		 * @param title
		 * 
		 */		
		public function saveSet(callback:Function, data:XML, index:int, ui:Boolean = false) : void
		{
			var title:String = "造梦小宝 LV." + _player.getRoleModel(V.MAIN_ROLE_NAME).model.lv;
			_controller.data.save.saveSet(callback, data, index, title, ui);
		}
		
		public function saveError(callback:Function) : void
		{
			_controller.data.save.saveError(callback);
		}
		
		/**
		 * 存档 
		 * @param isShowLoadDataView	
		 * @param highLV
		 * 
		 */		
		/**
		 * 
		 * @param isShowLoadDataView	是否显示加载动画
		 * @param highLV				-1——判断是否在存档CD中， 1——不判断是否在存档CD中
		 * @param saveType				是否显示保存成功文字
		 * @param callback				回调函数
		 * 
		 */		
		public function onCommonSave(isShowLoadDataView:Boolean = true, highLV:int = -1, showSaveWord:Boolean = true, callback:Function = null) : Boolean
		{
			if (DebugManager.instance.gameMode == V.DEVELOP) {
				return true;
			}
			
			if (!_isCanSend && highLV == -1){
				_controller.view.prompEffect.play("当前处于存档CD中");
				Log.Trace("当前处于存档CD");
				return false;
			}
			
			// 是否显示加载数据动画
			if (isShowLoadDataView) _controller.view.loadData.loadDataPlay();
			
			_player = _controller.data.player.player;
			var data:XML = _player.getPlayerOfXML();
			var index:int = _controller.data.save.saveIndex;
			
			_isCanSend = false;
			saveSet(
				function (result:*) : void {
					
					if (isShowLoadDataView)
					{
						_controller.view.loadData.hide();
						_controller.view.save.hide();
					}
					
					//多开提示
					if(isMultiple)
					{
						View.instance.tip.interfaces(InterfaceTypes.Show, 
							"游戏多开了，无法保存游戏存档，请关闭该页面！", 
							null,
							null,
							true);
						Starling.juggler.delayCall(
							function () : void 
							{
								LayerManager.instance.cpu_stage.frameRate = 0;
							},
							1);
					}
					//没有多开，正常保存
					else
					{
						if(result == true)
						{
							_controller.view.toolbar.onSaveCD();
							//显示保存成功文字
							if(showSaveWord)
								_controller.view.prompEffect.play("保存成功!");
							if(callback != null)
								callback();
						}
						else
						{
							Starling.juggler.delayCall(
								function () : void
								{
									View.instance.tip.interfaces(InterfaceTypes.Show,
										"当前游戏帐号不是最新的游戏帐号，请重新登录",
										null,
										null,
										true);
									View.instance.prompEffect.removeText();
								},
								.01);
							View.instance.equip_strengthen.removeDelayFun();
						}
					}
				},
				data,
				index);
			return true;
		}
		
		/**
		 * 战力排行榜提交数据
		 * 
		 */		
		public function onSaveFighting() : void
		{
			if (DebugManager.instance.gameMode == V.DEVELOP) return;
			
			var result:uint = _player.fightingNum;
			Data.instance.rank.submitCallback = null;
			RankSaveData.RankSave(Data.instance.rank.fightingID, result, _player.mainRoleModel.info.lv.toString());
		}
		
		/**
		 * 取数据 
		 * @param callback
		 * @param index
		 * @param ui
		 * 
		 */		
		public function getSaveData(callback:Function, index:int = 0, ui:Boolean = false) : void
		{
			_controller.data.save.getSaveGet(callback, index, ui);
		}
		
		public function quitGame(callback:Function) : void
		{
			_controller.data.save.quitGame(callback);
		}
		
		public function multipleState(callback:Function) : void
		{
			_controller.data.save.multipleState(callback);
		}
		
		public function onlineStatus(callback:Function, reCallback:Function = null) : void
		{
			if(DebugManager.instance.gameMode == V.DEVELOP)
			{
				callback();
				View.instance.tip.hide();
				return;
			}
			
			multipleState(continueFun);
			
			Starling.juggler.delayCall(
				function () : void
				{
					View.instance.tip.interfaces(InterfaceTypes.Show, 
						"请稍等...", 
						null,
						null,
						false,
						false,
						false);
				}, 
				.01);
			function continueFun(e:*) : void
			{
				if(e == "1")
				{
					callback();
					View.instance.tip.hide();
				}
				else if(e == "0")
				{
					View.instance.tip.interfaces(InterfaceTypes.Show, 
					"游戏多开了，无法保存游戏存档，请关闭该页面！", 
					null,
					null,
					true);
				Starling.juggler.delayCall(
					function () : void 
					{
						LayerManager.instance.cpu_stage.frameRate = 0;
					},
					1);
				}
				else
				{
					View.instance.tip.interfaces(InterfaceTypes.Show, 
						"网络异常，请检测网络连接是否正常。如一直无法操作请刷新网页。", 
						null,
						null,
						false,
						true,
						false);
					if(reCallback != null)
						reCallback();
				}
			}
		}
	}
}
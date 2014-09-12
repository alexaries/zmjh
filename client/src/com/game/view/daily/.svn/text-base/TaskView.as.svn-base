package com.game.view.daily
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.engine.ui.controls.Grid;
	import com.engine.ui.controls.TabBar;
	import com.game.Data;
	import com.game.data.db.protocal.Equipment;
	import com.game.data.db.protocal.Mission;
	import com.game.data.db.protocal.Prop;
	import com.game.data.equip.EquipUtilies;
	import com.game.data.player.structure.EquipModel;
	import com.game.data.player.structure.MissonInfo;
	import com.game.data.player.structure.PropModel;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.Role.ChangePageComponent;
	import com.game.view.ViewEventBind;
	
	import starling.display.Button;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.GrayscaleFilter;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class TaskView extends BaseView implements IView
	{
		private var _anti:Antiwear;
		private var _positionXML:XML;
		private var _taskPageComponent:ChangePageComponent;
		private var _taskGrid:Grid;
		private var _taskNameData:Vector.<String>;
		private var _taskDetail:TextField;
		private var _taskRequest:TextField;
		private var _reward_1:RewardComponent;
		private var _reward_2:RewardComponent;
		private var _reward_3:RewardComponent;
		private var _reward_4:RewardComponent;
		private var _dailyTaskBtn:MovieClip;
		private var _activityTaskBtn:MovieClip;
		private var _submitBtn:MovieClip;
		private var _dailyComfire:Boolean;
		private var _dataSelect:*;
		private var _taskData:MissonInfo;
		
		private var _tabBar:TabBar;
		/**
		 * 是否达到任务要求
		 */		
		private var isTrue:Boolean = false;
		/**
		 * 当前任务需要打怪的怪物ID
		 */		
		private var enemyID:Vector.<int>;
		
		/**
		 * 获得的金币
		 * @param value
		 * 
		 */		
		//public var rewardMoney:int;
		public function get rewardMoney() : int
		{
			return _anti["rewardMoney"];
		}
		public function set rewardMoney(value:int) : void
		{
			_anti["rewardMoney"] = value;
		}
		/**
		 * 获得的战魂
		 * @param value
		 * 
		 */		
		//public var rewardSoul:int;
		public function get rewardSoul() : int
		{
			return _anti["rewardSoul"];
		}
		public function set rewardSoul(value:int) : void
		{
			_anti["rewardSoul"] = value;
		}
		/**
		 * 任务资料
		 * @param value
		 * 
		 */		
		private var missionData:Vector.<Object>;
		
		private var _hideTask:Boolean;
		
		public function TaskView()
		{
			_layer = LayerTypes.TIP;
			_moduleName = V.DAILY_TASK;
			_loaderModuleName = V.PUBLIC;
		
			_hideTask = false;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["rewardMoney"] = 0;
			_anti["rewardSoul"] = 0;
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch (type)
			{
				case InterfaceTypes.Show:
					this.show();
					break;
				//创建任务条
				case InterfaceTypes.GET_TASKBAR_COMPONENT:
					return this.createTaskBar();
					break;
				//获得当前点击的任务的详细信息
				case InterfaceTypes.GET_TASKDETAIL:
					taskDetailRender(args[0]);
					break;
				case InterfaceTypes.HIDE:
					this.show();
					_hideTask = true;
					break;
				case InterfaceTypes.CHECK_TASK:
					return checkALlTask();
					break;
			}
		}
		
		override protected function init() : void
		{
			if (!isInit)
			{
				super.init();
				isInit = true;
				initData();
				initComponent();
				initUI();
				getUI();
				initTask();
				initEvent();
			}
			
			checkALlTask();
			setAllTaskBarState();
			_view.toolbar.interfaces(InterfaceTypes.CHECK_TASK);
			
			initSelect();
			requestRender();
			_view.layer.setCenter(panel);
			
			if(_hideTask)
			{
				this.hide();
				_hideTask = false;
			}
			else this.display();
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					_view.toolbar.interfaces(InterfaceTypes.UNLOCK);
					break;
			}
		}
		
		/**
		 * 初始化数据
		 * 
		 */		
		protected function initData() : void
		{
			if (!_positionXML)
				_positionXML = getXMLData(V.DAILY, GameConfig.DAILY_RES, "TaskPosition");
			missionData = new Vector.<Object>();
			missionData = Data.instance.db.interfaces(InterfaceTypes.GET_MISSION_DATA);
			missionData = missionData.sort(sortTask);
			_taskData = player.missonInfo;
		}
		
		/**
		 * 重新排列任务顺序
		 * 
		 */	
		public function sortTask(x:Object, y:Object) : Number
		{
			if(x.order < y.order)
				return -1;
			else if(x.order > y.order)
				return 1;
			else
				return 0;
		}
		
		private function initUI() : void
		{
			var name:String;
			var obj:*;
			var layerName:String;
			for each(var items:XML in _positionXML.layer)
			{
				layerName = items.@layerName;
				for each(var element:XML in items.item)
				{
					name = element.@name;
					
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						obj["layerName"] = layerName;
						_uiLibrary.push(obj);
					}
				}
			}
		}
		
		private function getUI() : void
		{
			_taskPageComponent = this.searchOf("TaskChangePageList");
			_taskDetail = this.searchOf("TaskDetail");
			_taskRequest = this.searchOf("TaskRequest");
			_reward_1 = this.searchOf("Reward1");
			_reward_2 = this.searchOf("Reward2");
			_reward_3 = this.searchOf("Reward3");
			_reward_4 = this.searchOf("Reward4");
			
			//提交按钮
			_submitBtn = this.searchOf("Submit");
			_submitBtn.useHandCursor = true;
			_submitBtn.addEventListener(TouchEvent.TOUCH, submitTouch);
			
			//每日任务|活动任务
			var arr:Array = [searchOf("DailyTask"), searchOf("ActivityTask")];
			_tabBar = new TabBar(arr);
			_tabBar.addEventListener(TabBar.TYPE_SELECT_CHANGE, onTabChange);
			_tabBar.selectIndex = 0;
		}
		
		/**
		 * 每日任务|活动任务
		 * @param e
		 * 
		 */		
		private function onTabChange(e:Event) : void
		{
			if ((e.data as int) == 1)
			{
				_view.tip.interfaces(
					InterfaceTypes.Show,
					"该功能未开启！",
					null, null, false, true, false);
				_tabBar.selectIndex = 0;
			}
		}
		
		/**
		 * 提交任务
		 * @param e
		 * 
		 */		
		private function submitTouch(e:TouchEvent) : void
		{
			if(!_dataSelect) return;
			var touch:Touch = e.getTouch(_submitBtn);
			if(touch && touch.phase == TouchPhase.ENDED)
			{
				_view.task_box.interfaces(InterfaceTypes.Show, _dataSelect, _reward_1, _reward_2, _reward_3, _reward_4);
			}
		}
		
		/**
		 * 提交任务获得奖励判断
		 * 
		 */		
		public function submitTask(type:String) : void
		{
			_taskData.setTaskComplete(_dataSelect.id);
			
			requestRender();
			
			var info:String = "恭喜你获得";
			switch(type)
			{
				case "dice":
					//骰子
					player.dice += _dataSelect.dice;
					info += " 骰子X" + _dataSelect.dice;
					break;
				case "equip":
					//装备
					var equip:EquipModel = new EquipModel();
					equip.id = _taskData.returnEquipmentID(_dataSelect.id);
					Data.instance.pack.initEquipment(equip);			
					Data.instance.pack.addEquipment(equip);
					info += " 装备" + equip.config.name;
					break;
				case "prop":
					//道具
					var propArr:Array = _dataSelect.prop.toString().split("|");
					var prop:PropModel = new PropModel();
					prop.id = propArr[0];
					prop.num = propArr[1];
					Data.instance.pack.addNoneProp(propArr[0], propArr[1]);
					Data.instance.db.interfaces(
						InterfaceTypes.GET_PROP_BASE_DATA, 
						prop.id, 
						function (prop:Prop) : void
						{
							info += prop.name;
						});
					info += "X" + prop.num;
					break;
				case "money":
					//金币
					player.money += rewardMoney;
					info += " 金币X" + rewardMoney;
					break;
				case "war":
					//战魂
					player.fight_soul += rewardSoul;
					info += " 战魂X" + rewardSoul;
					break;
			}
			
			//任务完成后减去已计算过的怪物数量
			//除去已计算过的怪物数量
			var reduce:Array = _dataSelect.mission_rules_number.toString().split("|");
			for(var i:uint = 0; i < enemyID.length; i++)
			{
				Data.instance.misson.countKillEnemy(enemyID[i], -reduce[i]);
			}
			//显示获得奖励的信息
			_view.prompEffect.play(info);
			
			setAllTaskBarState();
			
			_view.toolbar.checkTask();
			_view.toolbar.checkDaily();
			player.dailyThingInfo.checkDailyTask();
			
			Log.Trace("领取任务奖励保存");
			_view.controller.save.onCommonSave(false, 1, false);
			
		}
		
		private function initComponent() : void
		{
			var name:String;
			var cp:Component;
			var layerName:String;
			for each(var items:XML in _positionXML.component.Items)
			{
				name = items.@name;
				if (!this.checkInComponent(name))
				{
					switch (name)
					{
						case "Reward":
							cp = new RewardComponent(items, _view.daily.titleTxAtlas);
							_components.push(cp);
							break;
						case "ChangePage":
							cp = new ChangePageComponent(items, _view.daily.titleTxAtlas);
							_components.push(cp);
							break;
						case "TaskBar":
							cp = new TaskBarComponent(items, _view.daily.titleTxAtlas);
							_components.push(cp);
							break;
					}
				}
			}
		}
		
		/**
		 * 创建任务条
		 * @return 
		 * 
		 */		
		public function createTaskBar() : TaskBarComponent
		{
			var taskBar:TaskBarComponent;
			var Recover:TaskBarComponent = this.searchOfCompoent("TaskBar") as TaskBarComponent;
			taskBar = Recover.copy() as TaskBarComponent;
			_uiLibrary.push(taskBar);
			return taskBar;
		}
		
		/**
		 * 任务条组合
		 * 
		 */		
		private function initTask() : void
		{
			if(!_taskGrid)
			{
				_taskGrid = new Grid(TaskItemRender, 5, 1, 170, 40, 0, 4);
				_taskGrid["layerName"] = "TaskBar";
				_taskGrid.x = 65;
				_taskGrid.y = 110;
				panel.addChild(_taskGrid);
				_uiLibrary.push(_taskGrid);
			}
			
			_taskGrid.setData(missionData, _taskPageComponent);
			//默认显示第一个任务条
			_dataSelect = missionData[0];
		}
		
		private function setAllTaskBarState() : void
		{
			for(var i:int = 0; i < _completeTaskList.length; i++)
			{
				if(_taskData.returnTaskComplete(missionData[_completeTaskList[i]].id) != 1)
				{
					TaskItemRender(_taskGrid.getChildAt(missionData[_completeTaskList[i]].order - 1)).play();
				}
				else 
				{
					TaskItemRender(_taskGrid.getChildAt(missionData[_completeTaskList[i]].order - 1)).stop();
				}
				
				
			}
			checkTaskComplete();
			for(var k:int = 0; k < _taskGrid.numChildren; k++)
			{
				TaskItemRender(_taskGrid.getChildAt(k)).removeAlready();
			}
			for(var j:int = 0; j < _alreadyGetTaskList.length; j++)
			{
				TaskItemRender(_taskGrid.getChildAt(missionData[_alreadyGetTaskList[j]].order - 1)).addAlready();
			}
		}
		
		/**
		 * 点击任务条修改显示内容
		 * @param data
		 * 
		 */		
		private function taskDetailRender(data:*) : void
		{
			_dataSelect = data;
			requestRender();
			taskBarReset();
			setAllTaskBarState();
		}
		
		/**
		 * 所有任务条显示改变
		 * 
		 */		
		private function taskBarReset() : void
		{
			for(var i:uint = 0; i < _taskGrid.numChildren; i++)
			{
				TaskItemRender(_taskGrid.getChildAt(i)).resetTouch();
				TaskItemRender(_taskGrid.getChildAt(i)).stop();
			}
		}
		
		/**
		 * 初始化翻页触发事件
		 * 
		 */		
		private function initSelect() : void
		{
			_taskPageComponent.resetState(setTaskBarState);
		}
		
		/**
		 * 翻页后设置任务条的状态
		 * @param pageNum
		 * 
		 */		
		private function setTaskBarState(pageNum:int) : void
		{
			_dataSelect = missionData[(pageNum - 1) * 5];
			taskDetailRender(_dataSelect);
			//setAllTaskBarState();
			TaskItemRender(_taskGrid.getChildAt(_dataSelect.order - 1)).setState();
		}
		
		/**
		 * 任务内容和任务奖励显示
		 * @param data
		 * 
		 */		
		private function requestRender() : void
		{
			//任务要求
			_taskDetail.text = _dataSelect.mission_description.toString();
			//任务完成情况
			_taskRequest.text = "";
			//任务需求的怪物名称和数量
			var enemyName:Array = _dataSelect.mission_rules_enemy.toString().split("|");
			var enemyRequestNum:Array = _dataSelect.mission_rules_number.toString().split("|");
			//var rewardData:Array = [_dataSelect.dice, _dataSelect.equipment, _dataSelect.prop, _dataSelect.gold, _dataSelect.soul]
			//任务奖励显示
			_reward_1.showing(_dataSelect, _taskData.returnEquipmentID(_dataSelect.id), 1);
			_reward_2.showing(_dataSelect, _taskData.returnEquipmentID(_dataSelect.id), 2);
			_reward_3.showing(_dataSelect, _taskData.returnEquipmentID(_dataSelect.id), 3);
			_reward_4.showing(_dataSelect, _taskData.returnEquipmentID(_dataSelect.id), 4);
			
			var result:Array = _taskData.checkComplete(enemyName, enemyRequestNum);
			isTrue = result[0];
			enemyID = result[1];
			//checkComplete(enemyName, enemyRequestNum);
			
			//详细显示任务完成情况
			for(var i:uint = 0; i < enemyName.length; i++)
			{
				//完成任务并且领取
				if(_taskData.returnTaskComplete(_dataSelect.id) == 1 || isTrue)
				{
					_taskRequest.text += enemyName[i] + "：" +  enemyRequestNum[i] +"/" + enemyRequestNum[i] + "     ";
				}
				else
				{
					//未完成任务，其中某一条件已达到要求
					if(_taskData.getEnemyNum(enemyID[i]) >= enemyRequestNum[i])
					{
						_taskRequest.text += enemyName[i] + "：" +  enemyRequestNum[i] +"/" + enemyRequestNum[i] + "     ";
					}
					//未完成任务，其中某一条件未达到要求
					else
					{
						_taskRequest.text += enemyName[i] + "：" +  _taskData.getEnemyNum(enemyID[i]) +"/" + enemyRequestNum[i] + "     ";
					}
				}
				if((i+1)%2 == 0) _taskRequest.text += "\n";
			}
			
			//提交按钮显示
			//完成任务并且未领取
			if(_taskData.returnTaskComplete(_dataSelect.id) == -1 && isTrue)
			{
				_submitBtn.currentFrame = 0;
				_submitBtn.touchable = true;
				_submitBtn.filter = undefined;
			}
			//完成任务并且已领取
			else if(_taskData.returnTaskComplete(_dataSelect.id) == 1)
			{
				_submitBtn.currentFrame = 1;
				_submitBtn.touchable = false;
				_submitBtn.filter = new GrayscaleFilter();
			}
			//未完成任务
			else if(!isTrue)
			{
				_submitBtn.currentFrame = 0;
				_submitBtn.touchable = false;
				_submitBtn.filter = new GrayscaleFilter();
			}
		}
		
		//任务完成列表
		private var _completeTaskList:Vector.<int>;
		private var _alreadyGetTaskList:Vector.<int>;
		/**
		 * 检测所有任务的完成情况
		 * @return 
		 * 
		 */		
		private function checkALlTask() : Boolean
		{
			var result:Array = new Array();
			var resultBol:Boolean;
			_completeTaskList = new Vector.<int>();
			_alreadyGetTaskList = new Vector.<int>();
			
			result = player.missonInfo.checkTaskComplete();
			isTrue = result[0];
			enemyID = result[1];
			resultBol = result[2];
			_completeTaskList = result[3];
			
			return resultBol;
		}
		
		private function checkTaskComplete() : void
		{
			_alreadyGetTaskList = new Vector.<int>();
			for(var j:int = 0; j < missionData.length; j++)
			{
				if(_taskData.returnTaskComplete(missionData[j].id) == 1)
				{
					_alreadyGetTaskList.push(j);
				}
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else
			{
				textures = _view.daily.titleTxAtlas.getTextures(name);
			}
			return textures;
		}
		
		override protected function getTexture(name:String, type:String) : Texture
		{
			var texture:Texture;
			if (type == "public")
			{
				texture = _view.publicRes.interfaces(InterfaceTypes.GetTexture, name);
			}
			else
			{
				texture = _view.daily.titleTxAtlas.getTexture(name);
			}
			
			return texture;
		}
	}
}
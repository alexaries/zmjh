package com.game.view.activity
{
	import com.edgarcai.encrypt.binaryEncrypt;
	import com.edgarcai.gamelogic.Antiwear;
	import com.engine.core.Log;
	import com.game.Data;
	import com.game.data.Activity.ActivityDetail;
	import com.game.data.time.ActivityTimeData;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.ViewEventBind;
	import com.game.view.equip.PropTip;
	import com.game.view.ui.UIConfig;
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.filters.GrayscaleFilter;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class ActivityView extends BaseView implements IView
	{
		private var _anti:Antiwear;
		private function get nationalTime() : String
		{
			if(_anti["nationalTime"] == "")
				_anti["nationalTime"] = "2013-09-30";
			return _anti["nationalTime"];
		}
		private function get twoFestivalTime() : String
		{
			if(_anti["twoFestivalTime"] == "")
				_anti["twoFestivalTime"] = "2013-09-16";
			return _anti["twoFestivalTime"];
		}
		
		private var _preLoad:Boolean;
		
		public function ActivityView()
		{
			_moduleName = V.ACTIVITY;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.ACTIVITY;
			
			_anti = new Antiwear(new binaryEncrypt());
			_anti["nationalTime"] = "";
			_anti["twoFestivalTime"] = "";
			
			super();
		}
		
		public function interfaces(type:String = "", ...args) : *
		{
			if (type == "") type = InterfaceTypes.Show;
			switch(type)
			{
				case InterfaceTypes.Show:
					_preLoad = false;
					this.show();
					break;
				case InterfaceTypes.HIDE:
					_preLoad = true;
					this.show();
					break;
				case InterfaceTypes.CHECK_DEFORM:
					return checkSummer();
					break;
			}
		}
		
		override protected function init() : void
		{
			if(!this.isInit)
			{
				super.init();
				isInit = true;
				initXML();
				initTexture();
				initComponent();
				initUI();
				getUI();
				initEvent();
			}
			
			//renderSummerButton();
			//renderButton();
			//renderTanabataBtn();
			//renderNationalBtn();
			//renderTwoBtn();
			_view.layer.setCenter(panel);
		}
		
		private var _canClick:Boolean;
		private function renderTwoBtn():void
		{
			_canClick = false;
			var date:Date = Data.instance.time.returnTimeNow();
			var intervalTime:int = Data.instance.time.disDayNum(twoFestivalTime, Data.instance.time.curTimeStr.split(" ")[0]);
			if(intervalTime <= 23 && intervalTime >=0)
			{
				if(intervalTime == 0 && date.hours < 10)
				{
					_twoFestivalBtn.filter = new GrayscaleFilter();
					_canClick = false;
				}
				else
				{
					_twoFestivalBtn.filter = null;
					_canClick = true;
				}
			}
			else if(intervalTime < 0)
			{	
				_twoFestivalBtn.filter = new GrayscaleFilter();
				_canClick = false;
			}
			else 
			{
				removeTouchable(_twoFestivalBtn);
			}
		}
		
		private var _nationalClick:Boolean;
		private function renderNationalBtn():void
		{
			_nationalClick = false;
			var date:Date = Data.instance.time.returnTimeNow();
			var intervalTime:int = Data.instance.time.disDayNum(nationalTime, Data.instance.time.curTimeStr.split(" ")[0]);
			if( intervalTime <= 9 && intervalTime >= 0)
			{
				if(intervalTime == 0 && date.hours < 16)
				{
					_nationalBtn.filter = new GrayscaleFilter();
					_nationalClick = false;
				}
				else
				{
					_nationalBtn.filter = null;
					_nationalClick = true;
				}
			}
			else if(intervalTime < 0)
			{
				_nationalBtn.filter = new GrayscaleFilter();
				_nationalClick = false;
			}
			else
				removeTouchable(_nationalBtn);
			
			if(player.activityInfo.checkNationalActivity(52))
			{
				removeTouchable(_nationalBtn);
				_alreadyGet.visible = true;
			}
			else
			{
				_alreadyGet.visible = false;
			}
		}
		
		/**
		 * 暑假礼包
		 * 
		 */		
		private function renderSummerButton():void
		{
			/*var strList:Array = (Data.instance.time.curTimeStr.slice(0, 10)).split("-");
			if(strList[1] == "08")
				addTouchable(_summerBtn);
			else
				removeTouchable(_summerBtn);*/
		}
		
		/**
		 * 暑假礼包按钮状态
		 * 
		 */		
		private function renderButton() : void
		{
			/*var activities:Vector.<ActivityDetail> = Data.instance.player.player.activityInfo.activities;
			for(var i:int = 0; i < activities.length; i++)
			{
				if(activities[i].id == 40)
				{
					if(!Data.instance.time.checkEveryDayPlay(activities[i].time))
					{
						//removeTouchable(this.searchOf("SummerBtn") as Button);
						//_summerBtn.filter = new GrayscaleFilter();
						//_alreadyGet.visible = true;
						break;
					}
				}
			}*/
		}
		
		/**
		 * 七夕礼包
		 * 
		 */		
		private function renderTanabataBtn() : void
		{
			/*var strList:Array = (Data.instance.time.curTimeStr.slice(0, 10)).split("-");
			if(strList[0] == "2013" && strList[1] == "08" && (strList[2] == "08" || strList[2] == "09" || strList[2] == "10" || strList[2] == "11" || strList[2] == "12" || strList[2] == "13" || strList[2] == "14"))
				addTouchable(_tanabataBtn);
			else
				removeTouchable(_tanabataBtn);*/
		}
		
		private var _positionXML:XML;
		private function initXML() : void
		{
			_positionXML = getXMLData(_loaderModuleName, GameConfig.ACTIVITY_RES, "ActivityPosition");
		}
		
		private var _titleTxAtlas:TextureAtlas;
		private function initTexture() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				var textureXML:XML = getXMLData(_loaderModuleName, GameConfig.ACTIVITY_RES, "Activity");
				obj = getAssetsObject(_loaderModuleName, GameConfig.ACTIVITY_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
			}
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
					if(name == "PassGame")
					{
						/*cp = new FlipGameOverComponent(items, _titleTxAtlas);
						_components.push(cp);*/
					}
				}
			}
		}
		
		private var _nationalBtn:Button;
		private var _twoFestivalBtn:Button;
		private var _propTip:PropTip;
		private var _alreadyGet:Image;
		private function getUI() : void
		{
			/*_nationalBtn = this.searchOf("NationalBtn");
			_twoFestivalBtn = this.searchOf("TwoFestivalBtn");
			_alreadyGet = this.searchOf("AlreadyGet");
			
			var date:Date = Data.instance.time.returnTimeNow();
			var intervalTime:int = Data.instance.time.disDayNum(twoFestivalTime, Data.instance.time.curTimeStr.slice(0, 10));
			
			_propTip = _view.ui.interfaces(UIConfig.PROP_TIP);
			if(intervalTime <= 23 && intervalTime >=0)
			{
				if(intervalTime == 0 && date.hours < 10)
				{
					_propTip.add({o:_twoFestivalBtn,m:{name:"", 
						message:"双节礼包将于9月16日10点开放"}}); 
				}
			}
			else if(intervalTime < 0)
			{
				_propTip.add({o:_twoFestivalBtn,m:{name:"", 
					message:"双节礼包将于9月16日10点开放"}}); 
			}
				
			intervalTime = Data.instance.time.disDayNum(nationalTime, Data.instance.time.curTimeStr.slice(0, 10));
			
			if(intervalTime <= 9 && intervalTime >=0)
			{
				if(intervalTime == 0 && date.hours < 16)
				{
					_propTip.add({o:_nationalBtn,m:{name:"", 
						message:"国庆礼包将于9月30日16点开放"}}); 
				}
			}
			else if(intervalTime < 0)
			{
				_propTip.add({o:_nationalBtn,m:{name:"", 
					message:"国庆礼包将于9月30日16点开放"}}); 
			}*/
		}
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					break;
				case "IntegrationBtn":
					integrationShow();
					break;
				case "GlowingBtn":
					glowingShow();
					break;
				case "SummerBtn":
					summerShow();
					break;
				/*case "TanabataBtn":
					tanabataShow();
					break;*/
				case "NationalBtn":
					nationalDayShow();
					break;
				case "TwoFestivalBtn":
					twoFestivalShow();
					break;
			}
		}
		
		private function twoFestivalShow():void
		{
			if(!_canClick) return;
			this.hide();
			_view.two_festival.interfaces();
		}
		
		private function nationalDayShow():void
		{
			if(!_nationalClick) return;
			this.hide();
			_view.national_day.interfaces();
		}
		
		/**
		 * 暑假礼包
		 * 
		 */		
		private function summerShow() : void
		{
			var useDragon:Boolean = false;
			var activities:Vector.<ActivityDetail> = player.activityInfo.activities;
			for(var i:int = 0; i < activities.length; i++)
			{
				if(activities[i].id == 40)
				{
					if(!Data.instance.time.checkEveryDayPlay(activities[i].time))
					{
						_view.prompEffect.play("今天已经领取过暑假礼包！");
						useDragon = true;
						break;
					}
				}
			}
			
			if(!useDragon)
			{
				Data.instance.pack.addNoneProp(40, 1);
				player.activityInfo.setActivity(40);
				
				Log.Trace("暑假礼包领取保存");
				_view.controller.save.onCommonSave(false, 1, false);
				_view.prompEffect.play("领取成功，请到道具栏打开礼包哦！");
			}
			renderButton();
			_view.toolbar.checkActivity();
		}
		
		private function checkSummer() : Boolean
		{
			var result:Boolean = false;
			var activities:Vector.<ActivityDetail> = Data.instance.player.player.activityInfo.activities;
			for each(var activity:ActivityDetail in activities)
			{
				if(activity.id == 40)
				{
					if(!Data.instance.time.checkEveryDayPlay(activity.time))
					{
						result = true;
					}
				}
			}
			return result;
		}
		
		private function integrationShow() : void
		{
			this.hide();
			_view.integration.interfaces();
		}
		
		private function glowingShow() : void
		{
			this.hide();
			_view.glowing.interfaces();
		}
		
		private function tanabataShow() : void
		{
			this.hide();
			_view.tanabata.interfaces();
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
				textures = _titleTxAtlas.getTextures(name);
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
				texture = _titleTxAtlas.getTexture(name);
			}
			
			return texture;
		}
	}
}
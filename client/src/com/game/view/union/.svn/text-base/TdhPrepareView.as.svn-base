package com.game.view.union
{
	import com.engine.ui.controls.Grid;
	import com.game.Data;
	import com.game.data.db.protocal.Skill;
	import com.game.data.db.protocal.SkyEarth;
	import com.game.data.player.SkillUtitiles;
	import com.game.data.player.structure.RoleModel;
	import com.game.data.player.structure.SkillModel;
	import com.game.template.GameConfig;
	import com.game.template.InterfaceTypes;
	import com.game.template.LayerTypes;
	import com.game.template.V;
	import com.game.view.BaseView;
	import com.game.view.Component;
	import com.game.view.IView;
	import com.game.view.Role.ChangePageComponent;
	import com.game.view.ViewEventBind;
	import com.game.view.skill.SkillItemRender;
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class TdhPrepareView extends BaseView implements IView
	{
		public function TdhPrepareView()
		{
			_moduleName = V.TDH_PREPARE;
			_layer = LayerTypes.TIP;
			_loaderModuleName = V.TDH_PREPARE;
			
			super();
		}
		
		private var _skyEarthEnemy:SkyEarth;
		private var _monsterLv:int;
		private var _mosterReward:int;
		private var _callBack:Function;
		
		
		public function interfaces(type:String="", ...args):*
		{
			if (type == "") type = InterfaceTypes.Show;
			switch (type)
			{
				case InterfaceTypes.Show:
					this.show();
					_skyEarthEnemy=args[0];
					_callBack=args[1];
					break;
				case InterfaceTypes.GetTexture:
					return getTexture(args[0], "");
					break;
				case InterfaceTypes.GetTextures:
					return getTextures(args[0], "");
					break;
			}
		}
		
		private var _mainRole:RoleModel;
		
		/**
		 * UI位置文件 
		 */		
		private var _positionXML:XML;
		/**
		 * 纹理 
		 */		
		private var _titleTxAtlas:TextureAtlas;
		public function get titleTxAtlas() : TextureAtlas
		{
			return _titleTxAtlas;
		}
		
		/**
		 * 开始挑战按钮
		 */		
		private var _beginChallengeBtn:Button;
		
		
		
		override protected function onClickeHandle(e:ViewEventBind):void
		{
			switch (e.target.name)
			{
				case "Close":
					this.hide();
					break;
				case "beginChallengeBtn":
					onBeginChallenge();
					break;
			}
		}
		
		private function onBeginChallenge():void
		{
			if(_equippedSkills.length>0){
				this.hide();
				_view.match_game.interfaces("",_skyEarthEnemy,_callBack);	
			}else{
				_view.tip.interfaces(InterfaceTypes.Show,
					"请至少选择一个技能！",
					null, null, false, true, false);
			}

		}
		
		override protected function init():void
		{
			if (!isInit)
			{
				super.init();
				isInit = true;
				initData();
				initTextures();
				initComponent();
				initUI();
				getUI();
				initEvent();
			}
			
			renderSkill();
			renderProperty();
			
		}
		


		
		
		
		/**
		 * 获取模板数据 
		 * 
		 */		
		private function initData() : void
		{
			_mainRole = player.getRoleModel(V.MAIN_ROLE_NAME);
			if (!_positionXML)
			{
				_positionXML = getXMLData(_loadBaseName, GameConfig.TDH_PREPARE_RES, "TdhPreparePosition");
			}
		}
		
		/**
		 * 纹理 
		 * 
		 */		
		private function initTextures() : void
		{
			if (!_titleTxAtlas)
			{
				var obj:*;
				
				var textureXML:XML = getXMLData(_loadBaseName, GameConfig.TDH_PREPARE_RES, "TdhPrepare");			
				obj = getAssetsObject(_loadBaseName, GameConfig.TDH_PREPARE_RES, "Textures");
				var textureTitle:Texture = Texture.fromBitmap(obj as Bitmap);
				
				_titleTxAtlas = new TextureAtlas(textureTitle, textureXML);
				(obj as Bitmap).bitmapData.dispose();
				obj = null;
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
					switch (name)
					{
						case "ChangePage":
							cp = new ChangePageComponent(items, _titleTxAtlas);
							_components.push(cp);
							break;
					}
				}
			}
		}
		
		private function initUI() : void
		{
			var name:String;
			var obj:*;			
			for each(var items:XML in _positionXML.layer)
			{
				for each(var element:XML in items.item)
				{
					name = element.@name;
					
					if (!checkIndexof(name))
					{
						obj = createDisplayObject(element);
						_uiLibrary.push(obj);
					}
				}
			}
			
			display();
			_view.layer.setCenter(panel);
		}
		
		private var _packPageComponent:ChangePageComponent;
		private var _skillPageComponent:ChangePageComponent;
		private var _propsPageComponent:ChangePageComponent;
		
		private var _HPtxt:TextField;
		private var _ATKtxt:TextField;
		private var _DEFtxt:TextField;
		
		private function getUI() : void
		{
			
			_packPageComponent = searchOf("PackChangePageList") as ChangePageComponent;
			_skillPageComponent = searchOf("SkillChangePageList") as ChangePageComponent;
			_propsPageComponent = searchOf("PropChangePageList") as ChangePageComponent;
			
			_HPtxt = searchOf("HP");
			_ATKtxt = searchOf("ATK");
			_DEFtxt = searchOf("DEF");
			
			_beginChallengeBtn = this.searchOf("beginChallengeBtn");
			
			_skillPageComponent._callbackFunc = resetSkillList;
			
		}
		
		
		
		/**
		 * 技能 
		 * 
		 */
		private var _skillGrid:Grid;
		private var _equippedSkillGrid:Grid;
		private var _equippedSkills:Vector.<SkillModel>;
		
		private var _skillData:Vector.<Object>;
		private var _skills:Vector.<SkillModel>;
		
		private function renderSkill() : void
		{		
			_skills =  new Vector.<SkillModel>;
			_skillData = Data.instance.db.interfaces(InterfaceTypes.GET_ALL_SKILL_DATA);
			for each(var skill:Skill in _skillData){
				var tempSkillModel:SkillModel = new SkillModel;
				tempSkillModel.skill=skill;
				if(tempSkillModel.skill.type == 0 || tempSkillModel.skill.type == 1){
					_skills.push(tempSkillModel);
				}
				
			}
			
			if (!_skillGrid)
			{
				_skillGrid = new Grid(TdhSkillItemRender, 6, 5, 42, 42, 3, 5);
				_skillGrid.x = 73;
				_skillGrid.y = 52;
				panel.addChild(_skillGrid);
				_uiLibrary.push(_skillGrid);
			}
			
			_equippedSkills = new Vector.<SkillModel>
			
			if (!_equippedSkillGrid)
			{
				_equippedSkillGrid = new Grid(TdhSkillItemRender, 1, 5, 42, 42, 3, 0);
				_equippedSkillGrid.x = 329;
				_equippedSkillGrid.y = 113;
				panel.addChild(_equippedSkillGrid);
				_uiLibrary.push(_equippedSkillGrid);
			}
			
			_equippedSkillGrid.setData(_equippedSkills);
			_skillGrid.setData(_skills, _skillPageComponent);
			resetSkillList();
		}
		
		private function resetSkillList(params:uint = 0) : void
		{
			var item:TdhSkillItemRender;
			var isHave:Boolean;
			for(var i:uint = 0; i < _skillGrid.numChildren; i++)
			{
				item = (_skillGrid.getChildAt(i) as TdhSkillItemRender);
				
				isHave = false;
				for each(var skill:String in player.upgradeSkill.learnSkillList)
				{
					if(item.skillModel.skill.skill_name == skill)
					{
						isHave = true;
						break;
					}
				}
				if(!isHave)
				{
					item.touchable= false;
					removeOnlyTouchable(item);
				}
			}
		}
		
		private function renderProperty():void
		{
			_HPtxt.text = _mainRole.model.hp.toString();
			_ATKtxt.text = _mainRole.model.atk.toString();
			_DEFtxt.text = _mainRole.model.def.toString();
			
		}		
		
		
		
		/// 技能
		public function equipSkill(skill:SkillModel) : void
		{
			if(_equippedSkills.length<5){
				_equippedSkills.push(skill);
				_equippedSkillGrid.setData(_equippedSkills);
				skill.isTdhEquiped=true;
			}
		}
		
		public function downSkill(skill:SkillModel) : void
		{
			_equippedSkills.splice(_equippedSkills.indexOf(skill),1);
			_equippedSkillGrid.setData(_equippedSkills);
			skill.isTdhEquiped=false;
		}
		
		public function get equippedSkills():Vector.<SkillModel>{
			return _equippedSkills;
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
		
		override public function update() : void
		{
			super.update();
		}
		
		override public function close() : void
		{
			super.close();
		}
		
		override public function hide() : void
		{
			super.hide();
		}
	}
}
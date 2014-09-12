package com.game.view.upgrade
{
	import com.game.Data;
	import com.game.data.db.protocal.Characters;
	import com.game.data.player.structure.RoleModel;
	import com.game.template.InterfaceTypes;
	import com.game.template.V;
	import com.game.view.Component;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class RoleDetailComponent extends Component
	{
		public function RoleDetailComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			init();
		}
		
		override protected function init() : void
		{
			super.init();
			getUI();
			initEvent();
		}
		
		private var _alreadyGet:Image;
		private var _qualityTF:TextField;
		private var _locationTF:TextField;
		private var _qualityTF_1:TextField;
		private var _skillTF:TextField;
		private var _getLocationTF:TextField;
		private var _roleNameTF:TextField;
		private var _roleDescribeTF:TextField;
		private var _ungetRoleTF:TextField;
		private var _roleImage:Image;
		
		private var _night:MovieClip;
		private var _rain:MovieClip;
		private var _wind:MovieClip;
		private var _thunder:MovieClip;
		private function getUI():void
		{
			_alreadyGet = this.searchOf("AlreadyGet");
			_alreadyGet.rotation = -.3;
			_qualityTF = this.searchOf("QualityDetail");
			_locationTF = this.searchOf("LocationDetail");
			_qualityTF_1 = this.searchOf("QualityDetail_1");
			_skillTF = this.searchOf("SkillDetail");
			_getLocationTF = this.searchOf("GetLocationDetail");
			_roleNameTF = this.searchOf("RoleNameDetail");
			_roleDescribeTF = this.searchOf("RoleDescribeDetail");
			_roleDescribeTF.vAlign = VAlign.TOP;
			_ungetRoleTF = this.searchOf("UngetRole");
			_roleImage = this.searchOf("RoleImage");
			
			_night = this.searchOf("NightSelect");
			_rain = this.searchOf("RainSelect");
			_wind = this.searchOf("WindSelect");
			_thunder = this.searchOf("ThunderSelect");
		}
		
		public function setNull() : void
		{
			_qualityTF.text = "";
			_locationTF.text = "";
			_qualityTF_1.text = "";
			_skillTF.text = "";
			_getLocationTF.text = "";
			_roleNameTF.text = "";
			_roleDescribeTF.text = "";
			_ungetRoleTF.visible = false;
			_roleImage.visible = false;
			_alreadyGet.visible = false;
			_night.visible = false;
			_rain.visible = false;
			_wind.visible = false;
			_thunder.visible = false;
		}
		
		private var _roleName:String;
		public function setRole(roleName:String) : void
		{
			_roleName = roleName;
			var result:Boolean = Data.instance.player.player.upgradeRole.checkRole(_roleName);
			if(result == false)
			{
				_alreadyGet.visible = false;
				_ungetRoleTF.visible = true;
			}
			else
			{
				_alreadyGet.visible = true;
				_ungetRoleTF.visible = false;
			}
			
			var item:Characters = Data.instance.db.interfaces(InterfaceTypes.GET_ROLE_DATA_BY_NAME, _roleName);
			checkRoleType(item);
			
			_qualityTF.text = item.grade;
			_locationTF.text = item.location;
			_qualityTF_1.text = item.qualifications;
			_skillTF.text = item.fixedskill_name;
			_getLocationTF.text = item.get_place;
			_roleNameTF.text = _roleName;
			_roleDescribeTF.text = "   " + item.info;
			
			var texture:Texture = _view.role_big.interfaces(InterfaceTypes.GetTexture, "RoleImage_Big_" + _roleName);
			_roleImage.texture = texture;
			_roleImage.width = -int(texture.width * V.FIGHT_SCALE);
			_roleImage.height = int(texture.height * V.FIGHT_SCALE);
			_roleImage.visible = true; 
			//_roleImage.readjustSize();
		}
		
		private function checkRoleType(item:Characters) : void
		{
			if(item.type == 0)
			{
				_night.visible = false;
				_rain.visible = false;
				_wind.visible = false;
				_thunder.visible = false;
			}
			else
			{
				if(item.type == 1)
				{
					_night.visible = true;
					_rain.visible = false;
					_wind.visible = true;
					_thunder.visible = false;
				}
				else if(item.type == 2)
				{
					_night.visible = false;
					_rain.visible = true;
					_wind.visible = false;
					_thunder.visible = true;
				}
				else if(item.type == 3)
				{
					_night.visible = true;
					_rain.visible = true;
					_wind.visible = true;
					_thunder.visible = true;
				}
				
				if(Data.instance.player.player.upgradeRole.checkRole(item.name + "（夜）"))
					_night.currentFrame = 0;
				else
					_night.currentFrame = 1;
				
				if(Data.instance.player.player.upgradeRole.checkRole(item.name + "（雨）"))
					_rain.currentFrame = 0;
				else
					_rain.currentFrame = 1;
				
				if(Data.instance.player.player.upgradeRole.checkRole(item.name + "（风）"))
					_wind.currentFrame = 0;
				else
					_wind.currentFrame = 1;
				
				if(Data.instance.player.player.upgradeRole.checkRole(item.name + "（雷）"))
					_thunder.currentFrame = 0;
				else
					_thunder.currentFrame = 1;
			}
		}
		
		override protected function getTextures(name:String, type:String) : Vector.<Texture>
		{
			var textures:Vector.<Texture>;
			if (type == "public")
			{
				textures = _view.publicRes.interfaces(InterfaceTypes.GetTextures, name);
			}
			else if(type == "role")
			{
				textures = _view.roleRes.interfaces(InterfaceTypes.GetTextures, name);
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
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new RoleDetailComponent(_configXML, _titleTxAtlas);
		}
		
		/**
		 * 清除 
		 * 
		 */		
		override public function destroy():void
		{
			super.destroy();
		}
	}
}
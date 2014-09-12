package com.game.view.toolbar
{
	import com.game.view.Component;
	import com.game.view.effect.CloseShowEffect;
	import com.game.view.effect.FlyEffect;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class NewFunctionComponent extends Component
	{
		public function NewFunctionComponent(item:XML, titleTxAtlas:TextureAtlas)
		{
			super(item, titleTxAtlas);
			
			getUI();
			initEvent();
		}
		
		private var _detail:TextField;
		private function getUI() : void
		{
			_detail = this.searchOf("DetailText") as TextField;
		}
		
		public function setDetail(str:String) : void
		{
			_detail.text = str;
		}
		
		public function startFly(obj:DisplayObject, positionXML_1:XML, positionXML_2:XML, info:String, type:String) : void
		{
			_view.toolbar.deformTip.removeDeform(type);
			_view.toolbar.panel.touchable = false;
			_view.world.panel.touchable = false;
			var flyEffect:FlyEffect = new FlyEffect(positionXML_1, positionXML_2);
			flyEffect.viewNow = _view.toolbar;
			panel.visible = true;
			panel.alpha = 1;
			setDetail(info);
			Starling.juggler.delayCall(
				function() : void
				{
					flyEffect.starts();
					var closeShow:CloseShowEffect = new CloseShowEffect(this, 1.5, 0, false);
					Starling.juggler.delayCall(
						function () : void
						{
							_view.toolbar.panel.touchable = true;
							_view.world.panel.touchable = true;
							panel.visible = false;
							_view.toolbar.deformTip.addNewDeform(obj, type); 
							checkGuideType(type);
						},
						1.5);
				},
				2);
		}
		
		
		private function checkGuideType(type:String) : void
		{
			switch(type)
			{
				case "role":
					//角色向导
					if(_view.get_role_guide.isGuide)
						_view.get_role_guide.setFunc();
					break;
				case "roleDetail":
					//1级向导
					if(_view.first_guide.isGuide)
						_view.first_guide.setFunc();
					break;
			}
		}
		
		/**
		 * 组件拷贝 
		 * @return 
		 * 
		 */		
		override public function copy() : Component
		{
			return new NewFunctionComponent(_configXML, _titleTxAtlas);
		}
	}
}
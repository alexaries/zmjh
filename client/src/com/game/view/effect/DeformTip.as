package com.game.view.effect
{
	import starling.display.DisplayObject;

	public class DeformTip
	{
		public function DeformTip()
		{
			_deformList = new Vector.<DeformEffect>();
		}
		
		
		private var _deformList:Vector.<DeformEffect>;
		public function addNewDeform(obj:DisplayObject, name:String) : void
		{
			removeDeform(name);
			if(!checkDeform(name))
			{
				var deform:DeformEffect = new DeformEffect(obj, name);
				deform.play();
				_deformList.push(deform);
			}
		}
		
		public function removeDeform(name:String) : void
		{
			for(var i:int = _deformList.length - 1; i >=0; i--)
			{
				if(_deformList[i].name == name)
				{
					var deform:DeformEffect = _deformList[i];
					deform.stop();
					_deformList.splice(i, 1);
					deform.destroy();
					break;
				}
			}
		}
		
		private function checkDeform(name:String) : Boolean
		{
			var result:Boolean = false;
			for each(var deform:DeformEffect in _deformList)
			{
				if(deform.name == name)
				{
					result = true;
					break;
				}
			}
			return result;
		}
	}
}
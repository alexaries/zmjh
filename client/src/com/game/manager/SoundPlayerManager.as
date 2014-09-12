package  com.game.manager
{
	import com.game.manager.sound.SoundPlayer;
	
	import flash.system.ApplicationDomain;
	
	/**
	 * ...
	 * 当前只支持单个swf声音文件
	 * @author wdc
	 */
	public class SoundPlayerManager
	{
		private var _mute:Boolean;
		private var _volume:Number=1;
		private static var _ins:SoundPlayerManager

		private var _soundPlayer:SoundPlayer;
		
		/**
		 * 当前播放的音乐类型 
		 */		
		private var _curSoundName:String;
		
		public function SoundPlayerManager() 
		{	
			_soundPlayer=new SoundPlayer();
			
			
		}
		
		public static function getIns():SoundPlayerManager
		{
			if (!_ins) 
			{
				_ins=new SoundPlayerManager();
			}
			return _ins;
		}

		
		/**
		 * 播放
		 * @param name  库中的链接
		 * @param loop  是否循环
		 * */
		public function playSound(sound:*, name:String, loop:Boolean=false):void
		{
			if (_curSoundName == name)
			{
				return;
			}
			else
			{
				if (_curSoundName != '') stopSound(_curSoundName);
			}
			
			_curSoundName = name;
			_soundPlayer.playSound(sound,loop,_volume,name);
		}
		
		/**
		 * 停止
		 * @param name 库中的链接
		 * 
		 */		
		public function stopSound(name:String):void 
		{
			_soundPlayer.removeSoundByName(name);
		}
		
		
		public function muteSound():void 
		{
			_mute = !_mute;
			if (_mute) 
			{
				_volume = 0;
			}else 
			{
				_volume = 1;
			}
			_soundPlayer.mute(_mute);
		}
		
		
		public function get mute():Boolean 
		{
			return _mute;
		}
		
		public function set mute(value:Boolean) : void
		{
			_soundPlayer.isMute = value;
		}
	}

}
package dyzm.data.level
{
	import flash.events.Event;
	
	import dyzm.data.BgData;
	import dyzm.data.attr.foe.XiaoGuai;
	import dyzm.data.role.RoleVo;
	import dyzm.manager.EventManager;

	public class LevelTest extends BaseLevel
	{
		public function LevelTest()
		{
			foeList = [];
			boss = new XiaoGuai;
			bgBg = BgData.bg1bg;
			bgFront = BgData.bg1Front;
			time = 0;
			drop = [];
			firstDrop = [];
		}
		
		override public function special(mainRole:RoleVo):void
		{
			super.special(mainRole);
			EventManager.addEvent(Event.ENTER_FRAME, loop);
		}
		
		private function loop():void
		{
			
		}
	}
}
package dyzm.data.level
{
	import flash.events.Event;
	
	import dyzm.data.BgData;
	import dyzm.data.role.RoleVo;
	import dyzm.data.role.foe.BaseAiControl;
	import dyzm.data.role.foe.XiaoGuai;
	import dyzm.manager.EventManager;

	public class LevelTest extends BaseLevel
	{
		public function LevelTest()
		{
			foeList = new Vector.<BaseAiControl>();
			foeList[0] = new XiaoGuai();
			foeList[1] = new XiaoGuai();
			foeList[2] = new XiaoGuai();
			foeList[3] = new XiaoGuai();
			foeList[4] = new XiaoGuai();
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
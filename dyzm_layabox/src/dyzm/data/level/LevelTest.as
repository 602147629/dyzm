package dyzm.data.level
{
	import dyzm.data.role.RoleVo;
	import dyzm.data.role.foe.BaseAiControl;
	import dyzm.data.role.foe.XiaoGuai;

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
			bg = new Bg1();
			time = 0;
			drop = [];
			firstDrop = [];
		}
		
		override public function special(mainRole:RoleVo):void
		{
			super.special(mainRole);
		}
		
	}
}
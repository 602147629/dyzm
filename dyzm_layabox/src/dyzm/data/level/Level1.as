package dyzm.data.level
{
	import dyzm.data.role.foe.BaseAiControl;
	import dyzm.data.role.foe.XiaoGuai;

	public class Level1 extends BaseLevel
	{
		public function Level1()
		{
			foeList = new Vector.<BaseAiControl>();
			foeList[0] = new XiaoGuai();
			foeList[1] = new XiaoGuai();
			foeList[2] = new XiaoGuai();
			foeList[3] = new XiaoGuai();
			foeList[4] = new XiaoGuai();
			
			boss = new XiaoGuai;
			bg = new Bg1();
			topY = 500;
			bottomY = 800;
			time = 0;
			drop = [];
			firstDrop = [];
			
			minFoe = 1;
			maxFoe = 1;
		}
	}
}
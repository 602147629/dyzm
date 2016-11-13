package dyzm.data.level
{
	import dyzm.data.BgData;
	import dyzm.data.role.foe.BaseAiControl;
	import dyzm.data.role.foe.XiaoGuai;

	public class Level1 extends BaseLevel
	{
		public function Level1()
		{
			foeList = new Vector.<BaseAiControl>();
			foeList[0] = new XiaoGuai();
			foeList[1] = new XiaoGuai();
			
			boss = new XiaoGuai;
			bgBg = BgData.bg1bg;
			bgFront = BgData.bg1Front;
			topY = 480;
			bottomY = 800;
			time = 0;
			drop = [];
			firstDrop = [];
			
			minFoe = 1;
			maxFoe = 2;
		}
	}
}
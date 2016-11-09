package dyzm.data.level
{
	import dyzm.data.BgData;
	import dyzm.data.attr.foe.XiaoGuai;

	public class Level1 extends BaseLevel
	{
		public function Level1()
		{
			foeList = [new XiaoGuai, new XiaoGuai, new XiaoGuai, new XiaoGuai];
			boss = new XiaoGuai;
			bgBg = BgData.bg1bg;
			bgFront = BgData.bg1Front;
			topY = 480;
			bottomY = 800;
			time = 0;
			drop = [];
			firstDrop = [];
		}
	}
}
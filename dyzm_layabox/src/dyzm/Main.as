package dyzm
{
	import dyzm.manager.Cfg;
	
	import laya.display.Stage;
	import laya.webgl.WebGL;

	public class Main
	{
		public function Main()
		{
			Laya.init(Cfg.w, Cfg.h, WebGL);
			Laya.stage.alignV = Stage.ALIGN_MIDDLE;
			Laya.stage.alignH = Stage.ALIGN_CENTER;
			
			Laya.stage.scaleMode = "showall";
//			Laya.stage.bgColor = "#454545";
			Laya.stage.bgColor = "#ffffff";
			
			Laya.stage.addChild(new MainScene);
		}
	}
}
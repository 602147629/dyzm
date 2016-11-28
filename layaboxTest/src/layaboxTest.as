package
{
	import flash.display.Sprite;
	import flash.system.Capabilities;
	import flash.system.IME;
	
	import dyzm.Main;
	import dyzm.manager.Cfg;
	
	import laya.flash.Window;

	[SWF( width = "1280", height = "720", frameRate = "60", backgroundColor = "0x000000" )]
	public class layaboxTest extends Sprite
	{
		public function layaboxTest()
		{
			Cfg.stage = this.stage;
			Cfg.h = Cfg.dh;
			Cfg.scale = Cfg.stage.stageHeight / Cfg.dh;
			Cfg.w = Cfg.stage.stageWidth / Cfg.scale;
			
			Cfg.stageHeight = Cfg.stage.stageHeight;
			Cfg.stageWidth = Cfg.stage.stageWidth;
			
			// 关闭输入法
			if (Capabilities.hasIME) 
			{
				IME.enabled = false;
			}
			
			Window.start(this, Main);
		}
	}
}
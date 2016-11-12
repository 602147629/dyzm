package
{
	import flash.display.Sprite;
	import dyzm.MainScene;
	
	[SWF( width = "1280", height = "720", frameRate = "60", backgroundColor = "0x000000" )]
	public class dyzm_start extends Sprite
	{
		public var mainScene:MainScene; 
		public function dyzm_start()
		{
			mainScene = new MainScene();
			this.addChild(mainScene);
		}
	}
}
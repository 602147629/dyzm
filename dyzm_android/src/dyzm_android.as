package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import dyzm.MainScene;
	
	[SWF( width = "1280", height = "720", frameRate = "60", backgroundColor = "0x000000" )]
	public class dyzm_android extends Sprite
	{
		public var mainScene:MainScene; 
		public function dyzm_android()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			mainScene = new MainScene();
			this.addChild(mainScene);
		}
	}
}
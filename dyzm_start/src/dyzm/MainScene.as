package dyzm
{
	import com.bit101.components.FPSMeter;
	import com.bit101.components.Style;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import dyzm.data.DataManager;
	import dyzm.manager.EventManager;
	import dyzm.manager.GameConfig;
	import dyzm.view.base.BaseLayer;
	import dyzm.view.baseUi.UiTest;
	import dyzm.view.layer.fight.FightLayer;
	
	public class MainScene extends Sprite
	{
		public var curLayer:BaseLayer;
		public function MainScene()
		{
			DataManager.init();
			this.addEventListener(Event.ENTER_FRAME, loop);
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		public function onAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			GameConfig.stage = this.stage;
			GameConfig.h = GameConfig.dh;
			GameConfig.scale = GameConfig.stage.stageHeight / GameConfig.dh;
			GameConfig.w = GameConfig.stage.stageWidth / GameConfig.scale;
			GameConfig.mainScene = this;
			
			this.scaleX = GameConfig.scale;
			this.scaleY = GameConfig.scale;
			
			curLayer = new FightLayer();
			this.addChild(curLayer);
			
			// UI框架初始化
			Style.fontSize = 12;
			Style.embedFonts = false;
			Style.fontName = 'Microsoft YaHei';
			Style.setStyle(Style.LIGHT);
			
			var fps:FPSMeter = new FPSMeter(this);
			this.addChild(fps);
			
//			var uiTest:UiTest = new UiTest();
//			this.addChild(uiTest);
//			uiTest.testProgressBar();
		}
		
		
		public function gotoLayer(layer:BaseLayer):void
		{
			
		}
		
		private function loop(e:Event):void
		{
			EventManager.dispatchEvent(Event.ENTER_FRAME);
			
			curLayer.frameUpdate();
			
			EventManager.dispatchEvent(Event.EXIT_FRAME);
		}
	}
}
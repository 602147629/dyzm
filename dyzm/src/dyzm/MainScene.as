package dyzm
{
	import com.bit101.components.FPSMeter;
	import com.bit101.components.Style;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.system.IME;
	
	import dyzm.data.DataManager;
	import dyzm.manager.EventManager;
	import dyzm.manager.GameConfig;
	import dyzm.view.base.BaseLayer;
	import dyzm.view.layer.index.IndexLayer;
	
	public class MainScene extends Sprite
	{
		public var curLayer:BaseLayer;
		public static var me:MainScene;
		public function MainScene()
		{
			me = this;
			DataManager.init();
			this.addEventListener(Event.ENTER_FRAME, loop);
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
			// 关闭输入法
			if (Capabilities.hasIME) 
			{
				IME.enabled = false;
			}
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
			
			
			// UI框架初始化
			Style.fontSize = 12;
			Style.embedFonts = false;
			Style.fontName = 'Microsoft YaHei';
			Style.setStyle(Style.LIGHT);
			
			var fps:FPSMeter = new FPSMeter(this);
			this.addChild(fps);
			
//			var uiTest:UiTest = new UiTest();
//			this.addChild(uiTest);
//			uiTest.testBtn();
			
			curLayer = new IndexLayer();
			this.addChild(curLayer);
		}
		
		
		public function gotoLayer(layer:BaseLayer):void
		{
			if (curLayer != null){
				this.removeChild(curLayer);
			}
			curLayer = layer;
			this.addChild(curLayer);
		}
		
		private function loop(e:Event):void
		{
			EventManager.dispatchEvent(Event.ENTER_FRAME);
			
			curLayer.frameUpdate();
			
			EventManager.dispatchEvent(Event.EXIT_FRAME);
		}
	}
}
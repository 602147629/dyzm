package dyzm
{
	import dyzm.data.DataManager;
	import dyzm.manager.Asset;
	import dyzm.manager.Cfg;
	import dyzm.manager.Evt;
	import dyzm.view.base.BaseLayer;
	import dyzm.view.layer.index.IndexLayer;
	
	import laya.display.Sprite;
	
	public class MainScene extends Sprite
	{
		public var curLayer:BaseLayer;
		public static var me:MainScene;
		public function MainScene()
		{
			super();
			me = this;
			
			DataManager.init();
			
			DataManager.newGame();
			
			this.scaleX = Cfg.scale;
			this.scaleY = Cfg.scale;
			
			// 加载ui图集
			Asset.loadAtlas(Res.uiAtlas);
			
			if (Asset.needLoad == 0){
				onLoadComplete();
			}else{
				Evt.once(Asset.COMPLETE, this, onLoadComplete);
			}
		}
		
		
		private function onLoadComplete():void
		{
			curLayer = new IndexLayer();
			this.addChild(curLayer);
			
			Laya.timer.frameLoop(1, this, loop);
		}
		
		
		public function gotoLayer(layer:BaseLayer):void
		{
			if (curLayer != null){
				this.removeChild(curLayer);
			}
			curLayer = layer;
			this.addChild(curLayer);
		}
		
		private function loop():void
		{
			Evt.event(Evt.ENTER_FRAME);
			
			curLayer.frameUpdate();
			
			Evt.event(Evt.EXIT_FRAME);
		}
	}
}
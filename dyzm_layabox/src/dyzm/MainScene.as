package dyzm
{
	import dyzm.data.DataManager;
	import dyzm.manager.Asset;
	import dyzm.manager.Cfg;
	import dyzm.manager.Dbg;
	import dyzm.manager.Evt;
	import dyzm.view.base.BaseLayer;
	import dyzm.view.layer.index.IndexLayer;
	import dyzm.view.manager.BlackBg;
	import dyzm.view.manager.MovingTimeLayer;
	
	import laya.display.Sprite;
	import laya.utils.Stat;
	
	public class MainScene extends Sprite
	{
		public var curLayer:BaseLayer;
		/**
		 * 基本层级
		 */
		public var layer1:Sprite;
		/**
		 * 全局层级,比如过时间等
		 */
		public var layer2:Sprite;
		/**
		 * 错误层级,弹出警告框等
		 */
		public var layer3:Sprite;
		/**
		 * 提示层级
		 */
		public var layer4:Sprite;
		
		public static var me:MainScene;
		public function MainScene()
		{
			super();
			me = this;
			
			DataManager.init();
			
			DataManager.newGame();
			
			// 层级初始化
			layer1 = new Sprite;
			layer1.mouseEnabled = true;
			layer1.mouseThrough = true;
			
			layer2 = new Sprite;
			layer2.mouseEnabled = true;
			layer2.mouseThrough = true;
			
			layer3 = new Sprite;
			layer3.mouseEnabled = true;
			layer3.mouseThrough = true;
			
			layer4 = new Sprite;
			layer4.mouseEnabled = true;
			layer4.mouseThrough = true;
			
			
			
			this.addChild(layer1);
			this.addChild(layer2);
			this.addChild(layer3);
			this.addChild(layer4);
			
			this.scaleX = Cfg.scale;
			this.scaleY = Cfg.scale;
			
			// 加载ui图集
			Asset.loadAtlas(Res.uiAtlas);
			
			if (Asset.needLoad == 0){
				onLoadComplete();
			}else{
				Evt.once(Asset.COMPLETE, this, onLoadComplete);
			}
			
			Stat.show(0,0);
			
			Dbg.init();
		}
		
		
		private function onLoadComplete():void
		{
			//初始化基础UI
			new BlackBg();
			new MovingTimeLayer();
			
			curLayer = new IndexLayer();
			layer1.addChild(curLayer);
			
			Laya.timer.frameLoop(1, this, loop);
		}
		
		public function gotoLayer(layer:BaseLayer):void
		{
			if (curLayer != null){
				layer1.removeChild(curLayer);
			}
			curLayer = layer;
			layer1.addChild(curLayer);
		}
		
		private function loop():void
		{
			Evt.event(Evt.ENTER_FRAME);
			
			curLayer.frameUpdate();
			
			Evt.event(Evt.EXIT_FRAME);
		}
	}
}
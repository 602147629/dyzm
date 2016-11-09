package dyzm.view.layer.fight
{
	import dyzm.data.BgData;
	import dyzm.data.FightData;
	import dyzm.manager.AssetManager;
	import dyzm.manager.EventManager;
	import dyzm.view.base.BaseLayer;
	import dyzm.view.layer.fight.childLayer.BgLayer;
	import dyzm.view.layer.fight.childLayer.MainLayer;
	import dyzm.view.layer.fight.childLayer.UiLayer;
	
	public class FightLayer extends BaseLayer
	{
		public var bgLayer:BgLayer;
		public var bgFrontLayer:BgLayer;
		public var mainLayer:MainLayer;
		public var uiLayer:UiLayer;
		public var isLoadOver:Boolean = false;
		public function FightLayer()
		{
			super();
			
			FightData.start(1);
			
			bgLayer = new BgLayer(FightData.level.bgBg);
			bgFrontLayer = new BgLayer(FightData.level.bgFront);
			mainLayer = new MainLayer;
			uiLayer = new UiLayer;
			
			this.addChild(bgLayer);
			this.addChild(mainLayer);
			this.addChild(bgFrontLayer);
			this.addChild(uiLayer);
			
			load();
		}
		
		private function load():void
		{
			isLoadOver = false;
			// 加载背景
			for (var i:int = 0; i < bgLayer.bgInfo.length; i++) 
			{
				var a:Array = bgLayer.bgInfo[i];
				var url:String = a[0];
				AssetManager.loadImg(url);
			}
			
			// 加载前景
			for (i = 0; i < bgFrontLayer.bgInfo.length; i++) 
			{
				a = bgFrontLayer.bgInfo[i];
				url = a[0];
				AssetManager.loadImg(url);
			}
			
			
			if (AssetManager.needLoad > 0){
				EventManager.addEvent(AssetManager.COMPLETE, onLoadOver);
			}else{
				onLoadOver();
			}
		}
		
		private function onLoadOver():void
		{
			bgLayer.start();
			bgFrontLayer.start();
			isLoadOver = true;
		}
		
		override public function frameUpdate():void
		{
			super.frameUpdate();
			if (!isLoadOver) return;
			
			FightData.frameUpdate();
			
			mainLayer.frameUpdate();
			uiLayer.frameUpdate();
			bgLayer.frameUpdate();
			bgFrontLayer.frameUpdate();
		}
	}
}
package dyzm.view.layer.fight
{
	import flash.display.Sprite;
	
	import dyzm.data.FightData;
	import dyzm.data.role.RoleVo;
	import dyzm.manager.AssetManager;
	import dyzm.manager.EventManager;
	import dyzm.view.base.BaseLayer;
	import dyzm.view.layer.fight.childLayer.bgLayer.BgLayer;
	import dyzm.view.layer.fight.childLayer.mainLayer.MainLayer;
	import dyzm.view.layer.fight.childLayer.uiLayer.UiLayer;
	
	public class FightLayer extends BaseLayer
	{
		public var bgLayer:BgLayer;
		public var bgFrontLayer:BgLayer;
		public var mainLayer:MainLayer;
		public var uiLayer:UiLayer;
		public var isLoadOver:Boolean = false;
		
		public var fightContainer:Sprite;
		/**
		 * 振幅
		 */
		public var curRange:int;
		/**
		 * 是否暴击
		 */
		public var isCrit:Boolean;
		public function FightLayer()
		{
			super();
			
			FightData.start(1);
			
			bgLayer = new BgLayer(FightData.level.bgBg);
			bgFrontLayer = new BgLayer(FightData.level.bgFront);
			mainLayer = new MainLayer;
			uiLayer = new UiLayer;
			
			fightContainer = new Sprite();
			
			this.addChild(fightContainer);
			
			fightContainer.addChild(bgLayer);
			fightContainer.addChild(mainLayer);
			fightContainer.addChild(bgFrontLayer);
			
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
			EventManager.addEvent(RoleVo.RANGE_EVENT, onHit);
		}
		
		private function onHit(range:int, isCrit:Boolean):void
		{
			this.isCrit = isCrit;
			if (isCrit){
				curRange = range*2;
			}else{
				curRange = range;
			}
		}
		
		override public function frameUpdate():void
		{
			super.frameUpdate();
			if (!isLoadOver) return;
			if (curRange == 0){
				curRange --;
				fightContainer.x = fightContainer.y = 0;
			}else if (curRange > 0){
				curRange --;
				var i:int = 3;
				if (isCrit){
					i *= 2;
				}
				switch(curRange % 4)
				{
					case 0:
					{
						fightContainer.x = i;
						fightContainer.y = i;
						break;
					}
					case 1:
					{
						fightContainer.x = i;
						fightContainer.y = -i;
						break;
					}
					case 2:
					{
						fightContainer.x = -i;
						fightContainer.y = -i;
						break;
					}
					case 3:
					{
						fightContainer.x = -i;
						fightContainer.y = i;
						break;
					}
					default:
					{
						break;
					}
				}
			}else{
				FightData.frameUpdate();
				
				mainLayer.frameUpdate();
				uiLayer.frameUpdate();
				bgLayer.frameUpdate();
				bgFrontLayer.frameUpdate();
			}
		}
	}
}
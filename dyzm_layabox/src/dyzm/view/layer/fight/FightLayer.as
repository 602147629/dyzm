package dyzm.view.layer.fight
{
	import dyzm.Res;
	import dyzm.data.FightData;
	import dyzm.data.level.BaseLevel;
	import dyzm.data.role.RoleVo;
	import dyzm.manager.Asset;
	import dyzm.manager.Evt;
	import dyzm.view.base.BaseLayer;
	import dyzm.view.layer.fight.childLayer.bgLayer.BgLayer;
	import dyzm.view.layer.fight.childLayer.mainLayer.MainLayer;
	import dyzm.view.layer.fight.childLayer.mainLayer.RoleView;
	import dyzm.view.layer.fight.childLayer.uiLayer.UiLayer;
	
	import laya.display.Animation;
	import laya.display.Sprite;
	
	public class FightLayer extends BaseLayer
	{
		/**
		 * 暂停游戏
		 */
		public static const STOP_FIGHT_EVENT:String = "STOP_FIGHT_EVENT";
		/**
		 * 恢复游戏
		 */
		public static const RE_FIGHT_EVENT:String = "RE_FIGHT_EVENT";
		
		public var bgLayer:BgLayer;
		public var bgFrontLayer:BgLayer;
		public var mainLayer:MainLayer;
		public var uiLayer:UiLayer;
		public var isLoadOver:Boolean = false;
		
		public var fightContainer:Sprite;
		/**
		 * 振幅
		 */
		public var curRange:int = -1;
		/**
		 * 是否暴击
		 */
		public var isCrit:Boolean;
		
		/**
		 * 是否暂停
		 */
		public var isStop:Boolean = false;
		public function FightLayer(levelId:int)
		{
			super();
			
			FightData.start(levelId);
			
			load();
		}
		
		private function load():void
		{
			isLoadOver = false;
			var i:int, j:int, k:int, level:BaseLevel = FightData.level;
			// 加载背景
			for (i = 0; i < level.bg.bg.length; i++) 
			{
				Asset.loadImg(level.bg.bg[i][0]);
			}
			for (i = 0; i < level.bg.front.length; i++) 
			{
				Asset.loadImg(level.bg.front[i][0]);
			}
			
			// 加载怪物
			for (i = 0; i < level.foeList; i++) 
			{
				loadRole(level.foeList[i]);
			}
			
			// 加载主角
			loadRole(FightData.mainRole);
			
			// 加载UI, 主程序已经加载
			
			// 加载火花
			if (!Animation.framesMap[Res.knifeFireAtlas]){
				Asset.loadAtlas(Res.knifeFireAtlas);
			}
			
			if (Asset.needLoad > 0){
				Evt.once(Asset.COMPLETE, this, onLoadOver);
			}else{
				onLoadOver();
			}
		}
		
		/**
		 * 人物加载器
		 * @param r
		 */
		private function loadRole(r:RoleVo):void
		{
			var strList:Array = RoleView.strList;
			// 加载怪物模型
			Asset.loadJson(r.style);
			// 加载怪物皮肤图集
			for (var j:int = 0; j < r.skin.atlas.length; j++) 
			{
				Asset.loadAtlas(r.skin.atlas[j]);
			}
			// 加载怪物装备图集,目前只有武器
			Asset.loadAtlas(r.attr.equip.weapon.imgAtlas);
		}
		
		private function onLoadOver():void
		{
			Animation.createFrames(Res.knifeFireAtlas, Res.knifeFireAtlas);
			
			bgLayer = new BgLayer(FightData.level.bg.bg);
			bgFrontLayer = new BgLayer(FightData.level.bg.front);
			
			mainLayer = new MainLayer;
			uiLayer = new UiLayer;
			
			fightContainer = new Sprite();
			
			this.addChild(fightContainer);
			
			fightContainer.addChild(bgLayer);
			fightContainer.addChild(mainLayer);
			fightContainer.addChild(bgFrontLayer);
			
			this.addChild(uiLayer);
			
			isLoadOver = true;
			Evt.on(RoleVo.RANGE_EVENT, this, onHit);
			Evt.on(STOP_FIGHT_EVENT, this, stopFight);
			Evt.on(RE_FIGHT_EVENT, this, reFight);
		}
		
		private function stopFight():void
		{
			isStop = true;
		}
		
		private function reFight():void
		{
			isStop = false;
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
				if (!isStop){
					FightData.frameUpdate();
					mainLayer.frameUpdate();
					bgLayer.frameUpdate();
					bgFrontLayer.frameUpdate();
				}
				uiLayer.frameUpdate();
			}
		}
	}
}
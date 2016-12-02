package dyzm.view.manager
{
	import dyzm.MainScene;
	import dyzm.Res;
	import dyzm.data.WorldData;
	import dyzm.manager.Cfg;
	import dyzm.manager.Evt;
	
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ui.ProgressBar;

	/**
	 * 过时间时显示该界面
	 * @author dj
	 */
	public class MovingTimeLayer extends Sprite
	{
		public var dayProgress:ProgressBar;
		public static var me:MovingTimeLayer;
		public function MovingTimeLayer()
		{
			super();
			me = this;
			this.mouseEnabled = true;
			dayProgress = new ProgressBar(Res.dayProgress);
			dayProgress.sizeGrid = "3,3,3,3";
			dayProgress.width = 500;
			dayProgress.height = 50;
			dayProgress.pivotX = dayProgress.width >> 1;
			dayProgress.pivotY = dayProgress.height >> 1;
			this.addChild(dayProgress);
			
			Evt.on(WorldData.START_MOVING_DAY, null, show);
			
			Evt.on(WorldData.STOP_MOVING_DAY, null, hide);
			
			align();
		}
		
		public static function show():void
		{
			Laya.timer.frameLoop(1, me, me.loop);
			
			MainScene.me.layer2.addChild(me);
			
			me.addChildAt(BlackBg.me, 0);
			
			Evt.once(WorldData.STOP_MOVING_DAY, me, me.loop);
			me.once(Event.CLICK, me, me.onClick);
		}
		
		public static function hide():void
		{
			Evt.off(WorldData.STOP_MOVING_DAY, me, me.loop);
			me.off(Event.CLICK, me, me.onClick);
			
			me.parent.removeChild(me);
			Laya.timer.clear(me, me.loop);
		}
		
		public function loop():void
		{
			dayProgress.value = WorldData.curFrame / WorldData.allFrame;
		}
		
		public function stop():void
		{
			hide();
		}
		
		public function onClick(e:Event):void
		{
			WorldData.stopTimeMove();
		}
		
		public function align():void
		{
			dayProgress.x = Cfg.w >> 1;
			dayProgress.y = Cfg.h >> 1;
		}
	}
}